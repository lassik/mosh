/*
 * MultiVMProcedures.h - 
 *
 *   Copyright (c) 2009  Higepon(Taro Minowa)  <higepon@users.sourceforge.jp>
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
 *  $Id: MultiVMProcedures.h 261 2008-07-25 06:16:44Z higepon $
 */

#ifndef SCHEME_MULTI_VM_PROCEDURES_
#define SCHEME_MULTI_VM_PROCEDURES_

#include "scheme.h"
#include "OSCompatThread.h"

#ifdef MONA

extern scheme::VM* theVM;

namespace scheme {

    inline VM* currentVM()
    {
        return theVM;
    }

    inline bool setCurrentVM(VM* vm)
    {
        theVM = vm;
        return true;
    }

    Object whereisEx(VM* theVM, int argc, const Object* argv);
    Object registerEx(VM* theVM, int argc, const Object* argv);
    Object vmSelfEx(VM* theVM, int argc, const Object* argv);
    Object mainVmPEx(VM* theVM, int argc, const Object* argv);
    Object vmPEx(VM* theVM, int argc, const Object* argv);
    Object makeVmEx(VM* theVM, int argc, const Object* argv);
    Object vmStartDEx(VM* theVM, int argc, const Object* argv);
    Object vmSetValueDEx(VM* theVM, int argc, const Object* argv);
    Object vmJoinDEx(VM* theVM, int argc, const Object* argv);
    Object vmEvalEx(VM* theVM, int argc, const Object* argv);

    Object makeConditionVariableEx(VM* theVM, int argc, const Object* argv);
    Object conditionVariableNotifyAllDEx(VM* theVM, int argc, const Object* argv);
    Object conditionVariableNotifyDEx(VM* theVM, int argc, const Object* argv);
    Object conditionVariableWaitDEx(VM* theVM, int argc, const Object* argv);
    Object mutexPEx(VM* theVM, int argc, const Object* argv);
    Object mutexUnlockDEx(VM* theVM, int argc, const Object* argv);
    Object mutexTryLockDEx(VM* theVM, int argc, const Object* argv);
    Object mutexLockDEx(VM* theVM, int argc, const Object* argv);
    Object makeMutexEx(VM* theVM, int argc, const Object* argv);

};

#else

namespace scheme {

    Object whereisEx(VM* theVM, int argc, const Object* argv);
    Object registerEx(VM* theVM, int argc, const Object* argv);
    Object vmSelfEx(VM* theVM, int argc, const Object* argv);
    Object mainVmPEx(VM* theVM, int argc, const Object* argv);
    Object vmPEx(VM* theVM, int argc, const Object* argv);
    Object makeVmEx(VM* theVM, int argc, const Object* argv);
    Object vmStartDEx(VM* theVM, int argc, const Object* argv);
    Object vmSetValueDEx(VM* theVM, int argc, const Object* argv);
    Object vmJoinDEx(VM* theVM, int argc, const Object* argv);
    Object vmEvalEx(VM* theVM, int argc, const Object* argv);

    Object makeConditionVariableEx(VM* theVM, int argc, const Object* argv);
    Object conditionVariableNotifyAllDEx(VM* theVM, int argc, const Object* argv);
    Object conditionVariableNotifyDEx(VM* theVM, int argc, const Object* argv);
    Object conditionVariableWaitDEx(VM* theVM, int argc, const Object* argv);
    Object mutexPEx(VM* theVM, int argc, const Object* argv);
    Object mutexUnlockDEx(VM* theVM, int argc, const Object* argv);
    Object mutexTryLockDEx(VM* theVM, int argc, const Object* argv);
    Object mutexLockDEx(VM* theVM, int argc, const Object* argv);
    Object makeMutexEx(VM* theVM, int argc, const Object* argv);

    extern ThreadSpecificKey* vmKey;
    inline VM* currentVM()
    {
        MOSH_ASSERT(vmKey != NULL);
        VM* vm = (VM*)Thread::getSpecific(vmKey);
        MOSH_ASSERT(vm != NULL);
        return vm;
    }

    inline bool setCurrentVM(VM* vm)
    {
        if (nullptr == vmKey) {
            vmKey = new ThreadSpecificKey;
        }
        return Thread::setSpecific(vmKey, vm);
    }

}; // namespace scheme

#endif // MONA

#endif // SCHEME_MULTI_VM_PROCEDURES_
