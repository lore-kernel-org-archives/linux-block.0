Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling and cgroups support
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20160422193221.GY7822@mtj.duckdns.org>
Date: Sat, 23 Apr 2016 09:07:47 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 linus.walleij@linaro.org,
 broonie@kernel.org
Message-Id: <57F65679-CD8E-43BA-8C46-C165B4C20677@linaro.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org> <1454364778-25179-11-git-send-email-paolo.valente@linaro.org> <20160211222824.GD3741@mtj.duckdns.org> <57174CA7.5000706@linaro.org> <20160422181321.GV7822@mtj.duckdns.org> <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org> <20160422184110.GX7822@mtj.duckdns.org> <C1A89D63-CBC4-4C92-8D5A-9FB55A53FBCF@linaro.org> <20160422193221.GY7822@mtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


Il giorno 22/apr/2016, alle ore 21:32, Tejun Heo <tj@kernel.org> ha =
scritto:

> Hello, Paolo.
>=20
> On Fri, Apr 22, 2016 at 09:05:14PM +0200, Paolo Valente wrote:
>>> Ah, right, I was confused.  cic is always associated with the task =
and
>>> yes a writeback worker can trigger blkcg changed events frequently =
as
>>> it walks through different cgroups.  Is this an issue?
>>=20
>> That=92s exactly the source of my confusion: why does the worker walk
>> through different cgroups all the time if the I/O is originated by
>> the same process, which never changes group?
>=20
> Because the workqueue workers aren't tied to individual workqueues,
> they wander around serving different workqueues.

There is certainly something I don=92t know here, because I don=92t =
understand why there is also a workqueue containing root-group I/O all =
the time, if the only process doing I/O belongs to a different =
(sub)group.

Anyway, if this is expected, then there is no reason to bother you =
further on it. In contrast, the actual problem I see is the following. =
If one third or half of the bios belong to a different group than the =
writer that one wants to isolate, then, whatever weight is assigned to =
the writer group, we will never be able to let the writer get the =
desired share of the time (or of the bandwidth with bfq and all =
quasi-sequential workloads). For instance, in the scenario that you told =
me to try, the writer will never get 50% of the time, with any =
scheduler. Am I missing something also on this?

Thanks,
Paolo

>  This might change if
> we eventually update workqueues to be cgroup aware but for now it's
> expected to happen.
>=20
> Thanks.
>=20
> --=20
> tejun
