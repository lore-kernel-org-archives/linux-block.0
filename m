Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when safe
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170519145442.GA7174@wtj.duckdns.org>
Date: Sat, 20 May 2017 09:27:33 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <F79460BD-95A4-424B-8E3A-EC765745C447@linaro.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org> <20170519145442.GA7174@wtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 19 mag 2017, alle ore 16:54, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Fri, May 19, 2017 at 10:39:08AM +0200, Paolo Valente wrote:
>> Operations on blkg objects in blk-cgroup are protected with the
>> request_queue lock, which is no more the lock that protects
>> I/O-scheduler operations in blk-mq. The latter are now protected with
>> finer-grained per-scheduler-instance locks. As a consequence, if blkg
>> and blkg-related objects are accessed in a blk-mq I/O scheduler, it =
is
>> possible to have races, unless proper care is taken for these
>> accesses. BFQ does access these objects, and does incur these races.
>>=20
>> This commit addresses this issue without introducing further locks, =
by
>> exploiting the following facts.  Destroy operations on a blkg invoke,
>> as a first step, hooks of the scheduler associated with the blkg. And
>> these hooks are executed with bfqd->lock held for BFQ. As a
>> consequence, for any blkg associated with the request queue an
>> instance of BFQ is attached to, we are guaranteed that such a blkg is
>> not destroyed and that all the pointers it contains are consistent,
>> (only) while that instance is holding its bfqd->lock. A blkg_lookup
>> performed with bfqd->lock held then returns a fully consistent blkg,
>> which remains consistent until this lock is held.
>>=20
>> In view of these facts, this commit caches any needed blkg data =
(only)
>> when it (safely) detects a parent-blkg change for an internal entity,
>> and, to cache these data safely, it gets the new blkg, through a
>> blkg_lookup, and copies data while keeping the bfqd->lock held. As of
>> now, BFQ needs to cache only the path of the blkg, which is used in
>> the bfq_log_* functions.
>>=20
>> This commit also removes or updates some stale comments on locking
>> issues related to blk-cgroup operations.
>=20
> For a quick fix, this is fine but I think it'd be much better to
> update blkcg core so that we protect lookups with rcu and refcnt the
> blkg with percpu refs so that we can use blkcg correctly for all
> purposes with blk-mq.  There's no reason to hold up the immediate fix
> for that but it'd be nice to at least note what we should be doing in
> the longer term in a comment.
>=20

Ok.

I have started thinking of a blk-cgroup-wide solution, but, Tejun and
Jens, the more I think about it, the more I see a more structural bug
:( The bug seems to affect CFQ too, even if CFQ still uses the
request_queue lock.  Hoping that the bug is only in my mind, here is
first my understanding of how the data structures related to the bug
are performed, and, second, why handling them this way apparently
leads to the bug.

For a given instance of [B|C]FQ (i.e., of BFQ or CFQ), a [b|c]fq_group
(descriptor of a group in [B|C]FQ) is created on the creation of each
blkg associated with the same request queue that instance of [B|C]FQ
is attached to.  The schedulable entities that belong to this blkg
(only queues in CFQ, or both queues and generic entities in BFQ), are
then associated with this [b|c]fq_group on the arrival on new I/O
requests for them: these entities contain a pointer to a
[b|c]fq_group, and the pointer is assigned the address of this new
[b|c]fq_group.  The functions where the association occurs are
bfq_get_rq_private for BFQ and cfq_set_request for CFQ.  Both hooks
are executed before the hook for actually enqueueing the request.  Any
access to group information is performed through this [b|c]fq_group
field.  The associated blkg is accessed through the policy_data
pointer in the bfq_group (the policy data in its turn contains a
pointer to the blkg)

Consider a process or a group that is moved from a given source group
to a different group, or simply removed from a group (although I
didn't yet succeed in just removing a process from a group :) ).  The
pointer to the [b|c]fq_group contained in the schedulable entity
belonging to the source group *is not* updated, in BFQ, if the entity
is idle, and *is not* updated *unconditionally* in CFQ.  The update
will happen in bfq_get_rq_private or cfq_set_request, on the arrival
of a new request.  But, if the move happens right after the arrival of
a request, then all the scheduler functions executed until a new
request arrives for that entity will see a stale [b|c]fq_group.  Much
worse, if also a blkcg_deactivate_policy or a blkg_destroy are
executed right after the move, then both the policy data pointed by
the [b|c]fq_group and the [b|c]fq_group itself may be deallocated.
So, all the functions of the scheduler invoked before next request
arrival may use dangling references!

The symptom reported by BFQ users has been actually the dereference of
dangling bfq_group or policy data pointers in a request_insert

What do you think, have I been mistaken in some step?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
