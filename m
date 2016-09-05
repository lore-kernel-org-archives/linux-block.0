Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Subject: Re: [PATCH V2 00/22] Replace the CFQ I/O Scheduler with BFQ
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <17539224.xnQ9OR2lcz@amdc1976>
Date: Mon, 5 Sep 2016 22:29:25 +0200
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 Tejun Heo <tj@kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Omar Sandoval <osandov@fb.com>
Message-Id: <5CC62643-A46B-4BD5-B6ED-AD767926643B@linaro.org>
References: <1470654917-4280-1-git-send-email-paolo.valente@linaro.org> <20160831220949.GD5967@sirena.org.uk> <CACRpkdZjMcOyn6C-xV3yLsQM0hxZ1JUMGmmS8VqaDpx1xiL1ZA@mail.gmail.com> <17539224.xnQ9OR2lcz@amdc1976>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-ID: <linux-block@vger.kernel.org>


Il giorno 05/set/2016, alle ore 17:56, Bartlomiej Zolnierkiewicz =
<b.zolnierkie@samsung.com> ha scritto:

>=20
> Hi,
>=20
> On Thursday, September 01, 2016 10:39:46 AM Linus Walleij wrote:
>> On Thu, Sep 1, 2016 at 12:09 AM, Mark Brown <broonie@kernel.org> =
wrote:
>>=20
>>> - Do some benchmarks on the current status of the various branches =
on
>>>   relevant hardware (including trying to convert some of these =
slower
>>>   devices to blk-mq and seeing what happens).  Linus has been =
working
>>>   on this already in the context of MMC.
>>=20
>> I'm trying to do a patch switching MMC to use blk-mq, so I can
>> benchmark performance before/after this.
>>=20
>> While we expect mq to perform worse on single-hardware-queue
>> devices like these, we don't know until we tried, so I'm trying.
>=20
> I did this (switched MMC to blk-mq) some time ago.  Patches are
> extremely ugly and hacky (basically the whole MMC block layer
> glue code needs to be re-done) so I'm rather reluctant to
> sharing them yet (to be honest I would like to rewrite them
> completely before posting).
>=20
> I only did linear read tests (using dd) so far and results that
> I got were mixed (BTW the hardware I'm doing this work on is
> Odroid-XU3).  Pure block performance under maximum CPU frequency
> was slightly worse (5-12%) but the CPU consumption was reduced so
> when CPU was scaled down manually (or ondemand CPUfreq governor
> was used) blk-mq mode results were better then vanilla ones (up
> to 10% when CPU was scaled down to minimum frequency and even
> up to 50% when using ondemand governor - this finding is very
> interesting and needs to be investigated further).
>=20

IMO, another important figure of merit is application- and
system-level latency (e.g., application/system responsiveness or frame
drop rate with audio/video playback/streaming, while the device
happens to be busy with furhter I/O). Scripts to measure it can be
found, e.g., here [1] for desktop systems. If I can, I'm willing to
help in any respect.

Thanks,
Paolo

[1] https://github.com/Algodev-github/S

> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
