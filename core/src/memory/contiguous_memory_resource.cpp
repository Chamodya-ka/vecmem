/**
 * VecMem project, part of the ACTS project (R&D line)
 *
 * (c) 2021 CERN for the benefit of the ACTS project
 *
 * Mozilla Public License Version 2.0
 */

// Local include(s).
#include "vecmem/memory/contiguous_memory_resource.hpp"

#include "vecmem/utils/debug.hpp"

// System include(s).
#include <memory>
#include <stdexcept>

namespace vecmem {

contiguous_memory_resource::contiguous_memory_resource(
    memory_resource &upstream, std::size_t size)
    : m_upstream(upstream),
      m_size(size),
      m_begin(m_upstream.allocate(m_size)),
      m_next(m_begin) {

    VECMEM_DEBUG_MSG(
        2, "Allocated %lu bytes at %p from the upstream memory resource",
        m_size, m_begin);
}

contiguous_memory_resource::~contiguous_memory_resource() {
    /*
     * Deallocate our memory arena upstream.
     */
    m_upstream.deallocate(m_begin, m_size);
    VECMEM_DEBUG_MSG(
        2, "De-allocated %lu bytes at %p using the upstream memory resource",
        m_size, m_begin);
}

void *contiguous_memory_resource::do_allocate(std::size_t size,
                                              std::size_t alignment) {
    /*
     * Compute the remaining space, which needs to be an lvalue for standard
     * library-related reasons.
     */
    std::size_t rem =
        m_size - (static_cast<char *>(m_next) - static_cast<char *>(m_begin));

    /*
     * Employ std::align to find the next properly aligned address.
     */
    if (std::align(alignment, size, m_next, rem)) {
        /*
         * Store the return pointer, update the stored next pointer, then
         * return.
         */
        void *res = m_next;
        m_next = static_cast<char *>(m_next) + size;

        VECMEM_DEBUG_MSG(4, "Allocated %lu bytes at %p", size, res);

        return res;
    } else {
        /*
         * If std::align returns a false-like value, the allocation has failed
         * and we throw an exception.
         */
        throw std::bad_alloc();
    }
}

void contiguous_memory_resource::do_deallocate(void *, std::size_t,
                                               std::size_t) {
    /*
     * Deallocation is a no-op for this memory resource, so we do nothing.
     */
    return;
}

}  // namespace vecmem
