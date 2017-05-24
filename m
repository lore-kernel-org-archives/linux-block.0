Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH BUGFIX] block, bfq: access and cache blkg data only when safe
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170524145023.GA24798@htj.duckdns.org>
Date: Wed, 24 May 2017 17:43:18 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 broonie@kernel.org
Message-Id: <C9B2B7D3-1E92-4E22-80FA-8A606643B536@linaro.org>
References: <20170519083908.2588-1-paolo.valente@linaro.org> <20170519145442.GA7174@wtj.duckdns.org> <F79460BD-95A4-424B-8E3A-EC765745C447@linaro.org> <20170523204239.GI13222@htj.duckdns.org> <6E15A7C4-398F-4A93-A717-C499B3900EF0@linaro.org> <20170524145023.GA24798@htj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 24 mag 2017, alle ore 15:50, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello, Paolo.
>=20
> On Wed, May 24, 2017 at 12:53:26PM +0100, Paolo Valente wrote:
>> Exact, but even after all blkgs, as well as the cfq_group and pd, are
>> gone, the children cfq_queues of the gone cfq_group continue to point
>> to unexisting objects, until new cfq_set_requests are executed for
>> those cfq_queues.  To try to make this statement clearer, here is the
>> critical sequence for a cfq_queue, say cfqq, belonging to a =
cfq_group,
>> say cfqg:
>>=20
>> 1 cfq_set_request for a request rq of cfqq
>> 2 removal of (the process associated with cfqq) from bfqg
>> 3 destruction of the blkg that bfqg is associated with
>> 4 destruction of the blkcg the above blkg belongs to
>> 5 destruction of the pd pointed to by cfqg, and of cfqg itself
>> !!!-> from now on cfqq->cfqg is a dangling reference <-!!!
>> 6 execution of cfq functions, different from cfq_set_request, on cfqq
>> 	. cfq_insert, cfq_dispatch, cfq_completed_rq, ...
>> 7 execution of a new cfq_set_request for cfqq
>> -> now cfqq->cfqg is again a sane pointer <-
>>=20
>> Every function executed at step 6 sees a dangling reference for
>> cfqq->cfqg.
>>=20
>> My fix for caching data doesn't solve this more serious problem.
>>=20
>> Where have I been mistaken?
>=20
> Hmmm... cfq_set_request() invokes cfqg_get() which increases refcnt on
> the blkg, which should pin everything down till the request is done,

Yes, I missed that step, sorry. Still ...

> so none of the above objects can be destroyed before the request is
> done.
>=20

... the issue seems just to move to a more subtle position: cfq is ok,
because it protects itself with rq lock, but blk-mq schedulers don't.
So, the race that leads to the (real) crashes reported by people may
actually be:
1 blkg_lookup executed on a blkg being destroyed: the scheduler gets a
copy of the content of the blkg, but the rcu mechanism doesn't prevent
destruction from going on
2 blkg_get gets executed on the copy of the original blkg
3 subsequent scheduler operations involving that stale blkg lead to
the dangling-pointer accesses we have already discussed

Could you patiently tell me whether I'm still wrong?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
