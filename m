Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: races between blk-cgroup operations and I/O scheds in blk-mq (?)
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20170517191212.GA942@htj.duckdns.org>
Date: Thu, 18 May 2017 09:35:17 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>
Message-Id: <6B3070AF-7F98-4325-BA7F-B2C4489C1A5D@linaro.org>
References: <C61C6E23-7A98-452A-A449-FE03552BE8E3@linaro.org> <20170517191212.GA942@htj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 mag 2017, alle ore 21:12, Tejun Heo <tj@kernel.org> ha =
scritto:
>=20
> Hello,
>=20
> On Mon, May 15, 2017 at 09:49:13PM +0200, Paolo Valente wrote:
>> So, unless you tell me that there are other races I haven't seen, or,
>> even worse, that I'm just talking nonsense, I have thought of a =
simple
>> solution to address this issue without resorting to the request_queue
>> lock: further caching, on blkg lookups, the only policy or blkg data
>> the scheduler may use, and access this data directly when needed.  By
>> doing so, the issue is reduced to the occasional use of stale data.
>> And apparently this already happens, e.g., in cfq when it uses the
>> weight of a cfq_queue associated with a process whose group has just
>> been changed (and for which a blkg_lookup has not yet been invoked).
>> The same should happen when cfq invokes cfq_log_cfqq for such a
>> cfq_queue, as this function prints the path of the group the =
bfq_queue
>> belongs to.
>=20
> I haven't studied the code but the problem sounds correct to me.  All
> of blkcg code assumes the use of rq lock.  And, yeah, none of the hot
> paths requires strong synchornization.  All the actual management
> operations can be synchronized separately and the hot lookup path can
> be protected with rcu and maybe percpu reference counters.
>=20

Great, thanks for this ack.  User reports do confirm the problem, and,
so far, the effectiveness of a solution I have implemented.  I'm
finalizing the patch for submission.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
