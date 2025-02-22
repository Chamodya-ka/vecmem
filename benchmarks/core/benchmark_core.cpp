/** VecMem project, part of the ACTS project (R&D line)
 *
 * (c) 2021 CERN for the benefit of the ACTS project
 *
 * Mozilla Public License Version 2.0
 */

// VecMem include(s).
#include <vecmem/memory/binary_page_memory_resource.hpp>
#include <vecmem/memory/host_memory_resource.hpp>

// Google benchmark include(s).
#include <benchmark/benchmark.h>

/// The (host) memory resource to use in the benchmark(s)
static vecmem::host_memory_resource host_mr;

void BenchmarkHost(benchmark::State& state) {
    for (auto _ : state) {
        void* p = host_mr.allocate(state.range(0));
        host_mr.deallocate(p, state.range(0));
    }
}

BENCHMARK(BenchmarkHost)->RangeMultiplier(2)->Range(1, 2UL << 31);

void BenchmarkBinaryPage(benchmark::State& state) {
    std::size_t size = state.range(0);

    vecmem::binary_page_memory_resource mr(host_mr);

    for (auto _ : state) {
        void* p = mr.allocate(size);
        mr.deallocate(p, size);
    }
}

BENCHMARK(BenchmarkBinaryPage)->RangeMultiplier(2)->Range(1, 2UL << 31);
