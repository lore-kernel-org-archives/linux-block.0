Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when safe
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <6E15A7C4-398F-4A93-A717-C499B3900EF0@linaro.org>
Date: Wed, 24 May 2017 15:24:23 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <80432EEF-9EA0-4070-A761-938B57FF588D@linaro.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org> <20170519145442.GA7174@wtj.duckdns.org> <F79460BD-95A4-424B-8E3A-EC765745C447@linaro.org> <20170523204239.GI13222@htj.duckdns.org> <6E15A7C4-398F-4A93-A717-C499B3900EF0@linaro.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 24 mag 2017, alle ore 12:53, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>>=20
>> Il giorno 23 mag 2017, alle ore 21:42, Tejun Heo <tj@kernel.org> ha =
scritto:
>>=20
>> Hello, Paolo.
>>=20
>> On Sat, May 20, 2017 at 09:27:33AM +0200, Paolo Valente wrote:
>>> Consider a process or a group that is moved from a given source =
group
>>> to a different group, or simply removed from a group (although I
>>> didn't yet succeed in just removing a process from a group :) ).  =
The
>>> pointer to the [b|c]fq_group contained in the schedulable entity
>>> belonging to the source group *is not* updated, in BFQ, if the =
entity
>>> is idle, and *is not* updated *unconditionally* in CFQ.  The update
>>> will happen in bfq_get_rq_private or cfq_set_request, on the arrival
>>> of a new request.  But, if the move happens right after the arrival =
of
>>> a request, then all the scheduler functions executed until a new
>>> request arrives for that entity will see a stale [b|c]fq_group.  =
Much
>>=20
>> Limited staleness is fine.  Especially in this case, it isn't too
>> weird to claim that the order between the two operations isn't =
clearly
>> defined.
>>=20
>=20
> ok
>=20
>>> worse, if also a blkcg_deactivate_policy or a blkg_destroy are
>>> executed right after the move, then both the policy data pointed by
>>> the [b|c]fq_group and the [b|c]fq_group itself may be deallocated.
>>> So, all the functions of the scheduler invoked before next request
>>> arrival may use dangling references!
>>=20
>> Hmm... but cfq_group is allocated along with blkcg and blkcg always
>> ensures that there are no blkg left before freeing the pd area in
>> blkcg_css_offline().
>>=20
>=20
> Exact, but even after all blkgs, as well as the cfq_group and pd, are
> gone, the children cfq_queues of the gone cfq_group continue to point
> to unexisting objects, until new cfq_set_requests are executed for
> those cfq_queues.  To try to make this statement clearer, here is the
> critical sequence for a cfq_queue, say cfqq, belonging to a cfq_group,
> say cfqg:
>=20
> 1 cfq_set_request for a request rq of cfqq

Sorry, this first event is irrelevant for the problem to occur.  What
matters is just that some scheduler hooks are invoked *after* the
deallocation of a cfq_group, and *before* a new cfq_set_request.

Paolo

> 2 removal of (the process associated with cfqq) from bfqg
> 3 destruction of the blkg that bfqg is associated with
> 4 destruction of the blkcg the above blkg belongs to
> 5 destruction of the pd pointed to by cfqg, and of cfqg itself
> !!!-> from now on cfqq->cfqg is a dangling reference <-!!!
> 6 execution of cfq functions, different from cfq_set_request, on cfqq
> 	. cfq_insert, cfq_dispatch, cfq_completed_rq, ...
> 7 execution of a new cfq_set_request for cfqq
> -> now cfqq->cfqg is again a sane pointer <-
>=20
> Every function executed at step 6 sees a dangling reference for
> cfqq->cfqg.
>=20
> My fix for caching data doesn't solve this more serious problem.
>=20
> Where have I been mistaken?
>=20
> Thanks,
> Paolo
>=20
>> Thanks.
>>=20
>> --=20
>> tejun
