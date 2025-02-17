/*
 * GenericMap.h
 *
 *   Copyright (c) 2008  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
 *
 *   Redistribution and use in source and binary forms, with or without
 *   modification, are permitted provided that the following conditions
 *   are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in the
 *      documentation and/or other materials provided with the distribution.
 *
 *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *   TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *   PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  $Id: EqHashTable.h 251 2008-07-22 05:12:58Z higepon $
 */

#ifndef SCHEME_GENERIC_MAP_
#define SCHEME_GENERIC_MAP_

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif

#if defined(__APPLE__) && HAVE_EXT_HASHES
#include <ext/hash_map>
#else
#include <unordered_map>
#endif

extern scheme::Object genericHashFunction;
extern scheme::Object genericEquivalenceFunction;

extern int callHashFunction(scheme::Object hashFunction, scheme::Object key);
extern bool callEquivalenceFunction(scheme::Object equivalenceFunction, scheme::Object o1, scheme::Object o2);

struct generic_hash_func
{
    size_t operator()(scheme::Object key) const
    {
        return callHashFunction(genericHashFunction, key);
    }
};

struct generic_equal_to
{
    bool operator()(scheme::Object const& o1, scheme::Object const& o2) const
    {
        return callEquivalenceFunction(genericEquivalenceFunction, o1, o2);
    }
};

// 2022/8/28
// std::unordred_map + gc_allocator + custom equal doesn't compile on macOS Monterey.
#if defined(__APPLE__) && HAVE_EXT_HASHES
typedef __gnu_cxx::hash_map<scheme::Object,
                            scheme::Object,
                            generic_hash_func,
                            generic_equal_to,
                            gc_allocator<std::pair<const scheme::Object, scheme::Object> > > GenericMap;
#else
typedef std::unordered_map<scheme::Object,
                                scheme::Object,
                                generic_hash_func,
                                generic_equal_to,
                                gc_allocator<std::pair<const scheme::Object, scheme::Object> > > GenericMap;

#endif

#endif // SCHEME_GENERIC_MAP_
