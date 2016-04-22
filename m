Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling and cgroups support
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20160422184110.GX7822@mtj.duckdns.org>
Date: Fri, 22 Apr 2016 21:05:14 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 linus.walleij@linaro.org,
 broonie@kernel.org
Message-Id: <C1A89D63-CBC4-4C92-8D5A-9FB55A53FBCF@linaro.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org> <1454364778-25179-11-git-send-email-paolo.valente@linaro.org> <20160211222824.GD3741@mtj.duckdns.org> <57174CA7.5000706@linaro.org> <20160422181321.GV7822@mtj.duckdns.org> <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org> <20160422184110.GX7822@mtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


Il giorno 22/apr/2016, alle ore 20:41, Tejun Heo <tj@kernel.org> ha =
scritto:

> Hello, Paolo.
>=20
> On Fri, Apr 22, 2016 at 08:19:47PM +0200, Paolo Valente wrote:
>>> So, a kworker would jump through different workqueues and issue IOs
>>> for different writeback domains and the context can't be tied to the
>>> issuing task.  The cgroup membership should be determined directly
>>> from the bio.
>>=20
>> Yes. My doubt arises from the fact that the only source of intense =
I/O
>> is the dd (I have executed it alone). In contrast, group changes =
occur
>> at a high frequency during all the execution of the dd. Apparently I
>> cannot see any other I/O induced by the dd. Journaling issues sync
>> requests.
>>=20
>>> cfq uses per-cgroup async queue.  I'm not sure how this
>>> would map to bfq tho.
>>=20
>> It=92s the same. But this is the part I=92m checking.
>=20
> Ah, right, I was confused.  cic is always associated with the task and
> yes a writeback worker can trigger blkcg changed events frequently as
> it walks through different cgroups.  Is this an issue?
>=20

That=92s exactly the source of my confusion: why does the worker walk =
through different cgroups all the time if the I/O is originated by the =
same process, which never changes group?

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
