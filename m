Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when
 safe
To: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>
Cc: linux-block@vger.kernel.org, Linux-Kernal <linux-kernel@vger.kernel.org>,
 ulf.hansson@linaro.org, broonie@kernel.org
References: <20170605081115.3402-1-paolo.valente@linaro.org>
 <20847C23-6D7A-4D24-ADBF-51849612FEDA@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cd8f0234-f33f-d13b-34eb-f574f546d8ae@kernel.dk>
Date: Thu, 8 Jun 2017 09:52:14 -0600
MIME-Version: 1.0
In-Reply-To: <20847C23-6D7A-4D24-ADBF-51849612FEDA@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 06/08/2017 09:30 AM, Paolo Valente wrote:
> 
>> Il giorno 05 giu 2017, alle ore 10:11, Paolo Valente <paolo.valente@linaro.org> ha scritto:
>>
>> In blk-cgroup, operations on blkg objects are protected with the
>> request_queue lock. This is no more the lock that protects
>> I/O-scheduler operations in blk-mq. In fact, the latter are now
>> protected with a finer-grained per-scheduler-instance lock. As a
>> consequence, although blkg lookups are also rcu-protected, blk-mq I/O
>> schedulers may see inconsistent data when they access blkg and
>> blkg-related objects. BFQ does access these objects, and does incur
>> this problem, in the following case.
>>
>> The blkg_lookup performed in bfq_get_queue, being protected (only)
>> through rcu, may happen to return the address of a copy of the
>> original blkg. If this is the case, then the blkg_get performed in
>> bfq_get_queue, to pin down the blkg, is useless: it does not prevent
>> blk-cgroup code from destroying both the original blkg and all objects
>> directly or indirectly referred by the copy of the blkg. BFQ accesses
>> these objects, which typically causes a crash for NULL-pointer
>> dereference of memory-protection violation.
>>
>> Some additional protection mechanism should be added to blk-cgroup to
>> address this issue. In the meantime, this commit provides a quick
>> temporary fix for BFQ: cache (when safe) blkg data that might
>> disappear right after a blkg_lookup.
>>
>> In particular, this commit exploits the following facts to achieve its
>> goal without introducing further locks.  Destroy operations on a blkg
>> invoke, as a first step, hooks of the scheduler associated with the
>> blkg. And these hooks are executed with bfqd->lock held for BFQ. As a
>> consequence, for any blkg associated with the request queue an
>> instance of BFQ is attached to, we are guaranteed that such a blkg is
>> not destroyed, and that all the pointers it contains are consistent,
>> while that instance is holding its bfqd->lock. A blkg_lookup performed
>> with bfqd->lock held then returns a fully consistent blkg, which
>> remains consistent until this lock is held. In more detail, this holds
>> even if the returned blkg is a copy of the original one.
>>
>> Finally, also the object describing a group inside BFQ needs to be
>> protected from destruction on the blkg_free of the original blkg
>> (which invokes bfq_pd_free). This commit adds private refcounting for
>> this object, to let it disappear only after no bfq_queue refers to it
>> any longer.
>>
>> This commit also removes or updates some stale comments on locking
>> issues related to blk-cgroup operations.
>>
>> Reported-by: Tomas Konir <tomas.konir@gmail.com>
>> Reported-by: Lee Tibbert <lee.tibbert@gmail.com>
>> Reported-by: Marco Piazza <mpiazza@gmail.com>
>> Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
>> Tested-by: Tomas Konir <tomas.konir@gmail.com>
>> Tested-by: Lee Tibbert <lee.tibbert@gmail.com>
>> Tested-by: Marco Piazza <mpiazza@gmail.com>
> 
> Hi Jens,
> are you waiting for some further review/ack on this, or is it just in
> your queue of patches to check?  Sorry for bothering you, but this bug
> is causing problems to users.

I'll pull it in, it'll make the next -rc. I'll often let patches sit
for a few days even if I agree with them, to give others a chance to
either further review, comment, or disagree with them.

-- 
Jens Axboe
