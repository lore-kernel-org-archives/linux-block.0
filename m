Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
From: Paolo <paolo.valente@linaro.org>
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
To: Tejun Heo <tj@kernel.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org> <57174CA7.5000706@linaro.org>
 <20160422181321.GV7822@mtj.duckdns.org>
 <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org>
 <20160422184110.GX7822@mtj.duckdns.org>
 <C1A89D63-CBC4-4C92-8D5A-9FB55A53FBCF@linaro.org>
 <20160422193221.GY7822@mtj.duckdns.org>
 <57F65679-CD8E-43BA-8C46-C165B4C20677@linaro.org>
 <20160425192436.GE7822@mtj.duckdns.org> <571E7E63.6010103@linaro.org>
 <2D83ACA0-2513-4019-9A0D-3166FDDE7485@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
 Arianna Avanzini <avanzini.arianna@gmail.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
 linus.walleij@linaro.org, broonie@kernel.org, Jeff Moyer <jmoyer@redhat.com>
Message-ID: <5734810E.3060001@linaro.org>
Date: Thu, 12 May 2016 15:11:42 +0200
MIME-Version: 1.0
In-Reply-To: <2D83ACA0-2513-4019-9A0D-3166FDDE7485@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

Il 06/05/2016 22:20, Paolo Valente ha scritto:
>
> ...
>
> I can now confirm that, because of a little bug, a fraction ranging
> from one third to half of the writeback bios for the writer is wrongly
> associated with the root group. I'm sending a bugfix.
>
> I'm retesting BFQ after this blk fix. If I understand correctly, now
> you agree that BFQ is well suited for cgroups too, at least in
> principle. So I will apply all your suggestions and corrections, and
> submit a fresh patchset.
>

Hi,
this is just to report another apparently important blkio malfunction
(unless what I describe below is, for some reason, normal). This time
the malfunction is related to CFQ.

Even after applying my fix for bio cloning, CFQ may fail to guarantee
the expected resource-time sharing. It happens, for example, in the
following simple scenario with one sequential writer, in a group, and
one sequential reader, in another group. Both groups have the same
weight (and are memory.high limited to 16MB). Yet the writer is served
for only about 4% of the time, instead of 50%. Its bw is consequently
very low. Being this an unwanted accident, this percentage probably
varies with the characteristics of the system at hand.

The causes of the problem seem to be buried in CFQ logic, and do not
seem trivial. So I guess that solving this problem is not worth the
effort, as BFQ seems to have hope to replace CFQ altogether. I'm then
focusing on BFQ: it suffers from a similar problem, but because of a
rather simple reason.

Thanks,
Paolo

> Thanks,
> Paolo
>
>> Ok (if there is some quick way to get this information without
>> instrumenting the code, then any suggestion or pointer is welcome).
>>
>> Thanks,
>> Paolo
>>
>>> Thanks.
>
