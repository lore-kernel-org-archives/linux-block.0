Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 19 May 2017 10:54:42 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
	linus.walleij@linaro.org, broonie@kernel.org
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when
 safe
Message-ID: <20170519145442.GA7174@wtj.duckdns.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170519083908.2588-1-paolo.valente@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Paolo.

On Fri, May 19, 2017 at 10:39:08AM +0200, Paolo Valente wrote:
> Operations on blkg objects in blk-cgroup are protected with the
> request_queue lock, which is no more the lock that protects
> I/O-scheduler operations in blk-mq. The latter are now protected with
> finer-grained per-scheduler-instance locks. As a consequence, if blkg
> and blkg-related objects are accessed in a blk-mq I/O scheduler, it is
> possible to have races, unless proper care is taken for these
> accesses. BFQ does access these objects, and does incur these races.
> 
> This commit addresses this issue without introducing further locks, by
> exploiting the following facts.  Destroy operations on a blkg invoke,
> as a first step, hooks of the scheduler associated with the blkg. And
> these hooks are executed with bfqd->lock held for BFQ. As a
> consequence, for any blkg associated with the request queue an
> instance of BFQ is attached to, we are guaranteed that such a blkg is
> not destroyed and that all the pointers it contains are consistent,
> (only) while that instance is holding its bfqd->lock. A blkg_lookup
> performed with bfqd->lock held then returns a fully consistent blkg,
> which remains consistent until this lock is held.
> 
> In view of these facts, this commit caches any needed blkg data (only)
> when it (safely) detects a parent-blkg change for an internal entity,
> and, to cache these data safely, it gets the new blkg, through a
> blkg_lookup, and copies data while keeping the bfqd->lock held. As of
> now, BFQ needs to cache only the path of the blkg, which is used in
> the bfq_log_* functions.
> 
> This commit also removes or updates some stale comments on locking
> issues related to blk-cgroup operations.

For a quick fix, this is fine but I think it'd be much better to
update blkcg core so that we protect lookups with rcu and refcnt the
blkg with percpu refs so that we can use blkcg correctly for all
purposes with blk-mq.  There's no reason to hold up the immediate fix
for that but it'd be nice to at least note what we should be doing in
the longer term in a comment.

Thanks.

-- 
tejun
