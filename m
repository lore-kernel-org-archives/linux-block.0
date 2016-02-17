Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling and cgroups support
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20160211222824.GD3741@mtj.duckdns.org>
Date: Wed, 17 Feb 2016 10:07:16 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 linus.walleij@linaro.org,
 broonie@kernel.org
Message-Id: <87934440-FAA0-4B2D-897F-AD78EAF5F54E@linaro.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org> <1454364778-25179-11-git-send-email-paolo.valente@linaro.org> <20160211222824.GD3741@mtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


Il giorno 11/feb/2016, alle ore 23:28, Tejun Heo <tj@kernel.org> ha =
scritto:

> Hello,
>=20
> On Mon, Feb 01, 2016 at 11:12:46PM +0100, Paolo Valente wrote:
>> From: Arianna Avanzini <avanzini.arianna@gmail.com>
>>=20
>> Complete support for full hierarchical scheduling, with a cgroups
>> interface. The name of the added policy is bfq.
>>=20
>> Weights can be assigned explicitly to groups and processes through =
the
>> cgroups interface, differently from what happens, for single
>> processes, if the cgroups interface is not used (as explained in the
>> description of the previous patch). In particular, since each node =
has
>> a full scheduler, each group can be assigned its own weight.
>=20
> * It'd be great if how cgroup support is achieved is better
>  documented.
>=20

ok, I will do it.

> * How's writeback handled?
>=20

If I understood correctly your question, then the answer is that there =
is no special/automatic handling of writeback queues. Thus, unless the =
user explicitly inserts flushing threads in some groups and plays with =
the weights of these groups, these threads will just get the default =
weight, and thus the default treatment for queues in the root group. =
IOW, no privileges. The motivation is that these threads serve =
asynchronous requests, i.e., requests that do not cause any delay to the =
processes that issue them. Therefore, apart from higher-level =
considerations on vm page-flushing pressure, there is basically no point =
in privileging writeback I/O with respect to other types of possibly =
time-sensitive I/O.


> * After all patches are applied, both CONFIG_BFQ_GROUP_IOSCHED and
>  CONFIG_CFQ_GROUP_IOSCHED exist.
>=20

Sorry, thanks.

> * The default weight and weight range don't seem to follow the defined
>  interface on the v2 hierarchy.  The default value should be 100.
>=20

Sorry again, I will fix it.

> * With all patches applied, booting triggers a RCU context warning.
>  Please build with lockdep and RCU debugging turned on and fix the
>  issue.
>=20

Ok, I will do it.

> * I was testing on the v2 hierarchy with two top-level cgroups one
>  hosting sequential workload and the other completely random.  While
>  they eventually converged to a reasonable state, starting up the
>  sequential workload while the random workload was running was
>  extremely slow.  It crawled for quite a while.
>=20

This is definitely a bug. Could you please (maybe privately?) send me =
the exact commands/script you have used?

> * And "echo 100 > io.weight" hung the writing process.
>=20

I=92m not sure I understood exactly which process you are referring to, =
but I guess I will probably understand it from the commands I have asked =
you to share.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
