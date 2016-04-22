Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling and cgroups support
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20160422181321.GV7822@mtj.duckdns.org>
Date: Fri, 22 Apr 2016 20:19:47 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>,
 linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 ulf.hansson@linaro.org,
 linus.walleij@linaro.org,
 broonie@kernel.org
Message-Id: <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org> <1454364778-25179-11-git-send-email-paolo.valente@linaro.org> <20160211222824.GD3741@mtj.duckdns.org> <57174CA7.5000706@linaro.org> <20160422181321.GV7822@mtj.duckdns.org>
To: Tejun Heo <tj@kernel.org>
List-ID: <linux-block@vger.kernel.org>


Il giorno 22/apr/2016, alle ore 20:13, Tejun Heo <tj@kernel.org> ha =
scritto:

> Hello, Paolo.
>=20
> On Wed, Apr 20, 2016 at 11:32:23AM +0200, Paolo wrote:
>> This malfunction seems related to a blkcg behavior that I did not
>> expect: the sequential writer changes group continuously. It moves
>> from the root group to its correct group, and back. Here is the
>> output of
>>=20
>> egrep 'insert_request|changed cgroup' trace
>>=20
>> over a trace taken with the original version of cfq (seq_write is of
>> course the group of the writer):
> ...
>> For reasons that I don't yet know, group changes are much more
>> frequent with bfq, which ultimately causes bfq to fail to isolate the
>> writer from the reader.
>>=20
>> While I go on trying to understand why, could you please tell me
>> whether this fluctuation is normal, and/or point me to documentation =
from
>> which I can better understand this behavior, without bothering you
>> further?
>=20
> So, a kworker would jump through different workqueues and issue IOs
> for different writeback domains and the context can't be tied to the
> issuing task.  The cgroup membership should be determined directly
> from the bio.

Yes. My doubt arises from the fact that the only source of intense I/O
is the dd (I have executed it alone). In contrast, group changes occur
at a high frequency during all the execution of the dd. Apparently I
cannot see any other I/O induced by the dd. Journaling issues sync
requests.

>  cfq uses per-cgroup async queue.  I'm not sure how this
> would map to bfq tho.
>=20

It=92s the same. But this is the part I=92m checking.

Thanks,
Paolo

> Thanks.
>=20
> --=20
> tejun
