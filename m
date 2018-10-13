Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block, bfq: improve asymmetric scenarios detection
To: Paolo Valente <paolo.valente@linaro.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org, linus.walleij@linaro.org, broonie@kernel.org,
 bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
 Federico Motta <federico@willer.it>
References: <20181012095557.13744-1-paolo.valente@linaro.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5aea7d49-440c-e090-d12c-74db346fb93e@kernel.dk>
Date: Sat, 13 Oct 2018 15:40:31 -0600
MIME-Version: 1.0
In-Reply-To: <20181012095557.13744-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/12/18 3:55 AM, Paolo Valente wrote:
> From: Federico Motta <federico@willer.it>
> 
> bfq defines as asymmetric a scenario where an active entity, say E
> (representing either a single bfq_queue or a group of other entities),
> has a higher weight than some other entities.  If the entity E does sync
> I/O in such a scenario, then bfq plugs the dispatch of the I/O of the
> other entities in the following situation: E is in service but
> temporarily has no pending I/O request.  In fact, without this plugging,
> all the times that E stops being temporarily idle, it may find the
> internal queues of the storage device already filled with an
> out-of-control number of extra requests, from other entities. So E may
> have to wait for the service of these extra requests, before finally
> having its own requests served. This may easily break service
> guarantees, with E getting less than its fair share of the device
> throughput.  Usually, the end result is that E gets the same fraction of
> the throughput as the other entities, instead of getting more, according
> to its higher weight.
> 
> Yet there are two other more subtle cases where E, even if its weight is
> actually equal to or even lower than the weight of any other active
> entities, may get less than its fair share of the throughput in case the
> above I/O plugging is not performed:
> 1. other entities issue larger requests than E;
> 2. other entities contain more active child entities than E (or in
>    general tend to have more backlog than E).
> 
> In the first case, other entities may get more service than E because
> they get larger requests, than those of E, served during the temporary
> idle periods of E.  In the second case, other entities get more service
> because, by having many child entities, they have many requests ready
> for dispatching while E is temporarily idle.
> 
> This commit addresses this issue by extending the definition of
> asymmetric scenario: a scenario is asymmetric when
> - active entities representing bfq_queues have differentiated weights,
>   as in the original definition
> or (inclusive)
> - one or more entities representing groups of entities are active.
> 
> This broader definition makes sure that I/O plugging will be performed
> in all the above cases, provided that there is at least one active
> group.  Of course, this definition is very coarse, so it will trigger
> I/O plugging also in cases where it is not needed, such as, e.g.,
> multiple active entities with just one child each, and all with the same
> I/O-request size.  The reason for this coarse definition is just that a
> finer-grained definition would be rather heavy to compute.
> 
> On the opposite end, even this new definition does not trigger I/O
> plugging in all cases where there is no active group, and all bfq_queues
> have the same weight.  So, in these cases some unfairness may occur if
> there are asymmetries in I/O-request sizes.  We made this choice because
> I/O plugging may lower throughput, and probably a user that has not
> created any group cares more about throughput than about perfect
> fairness.  At any rate, as for possible applications that may care about
> service guarantees, bfq already guarantees a high responsiveness and a
> low latency to soft real-time applications automatically.

Thanks, applied.

-- 
Jens Axboe
