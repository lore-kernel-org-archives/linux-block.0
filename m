Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <B1F49414-FD49-49EE-877A-B4C2913ED072@linaro.org>
Date: Wed, 17 Oct 2018 07:18:44 +0200
Cc: Bart Van Assche <bvanassche@acm.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Mark Brown <broonie@kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
Message-Id: <B5BB8BC7-F999-4D32-BED2-02C560752B28@linaro.org>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <1539615735.129692.3.camel@acm.org>
 <B1F49414-FD49-49EE-877A-B4C2913ED072@linaro.org>
To: 'Paolo Valente' via bfq-iosched <bfq-iosched@googlegroups.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 15 ott 2018, alle ore 20:34, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
>=20
>=20
>> Il giorno 15 ott 2018, alle ore 17:02, Bart Van Assche =
<bvanassche@acm.org> ha scritto:
>>=20
>> On Mon, 2018-10-15 at 16:10 +0200, Linus Walleij wrote:
>>> + * For blk-mq devices, we default to using:
>>> + * - "none" for multiqueue devices (nr_hw_queues !=3D 1)
>>> + * - "bfq", if available, for single queue devices
>>> + * - "mq-deadline" if "bfq" is not available for single queue =
devices
>>> + * - "none" for single queue devices as well as last resort
>>=20
>> For SATA SSDs nr_hw_queues =3D=3D 1 so this patch will also affect =
these SSDs.
>> Since this patch is an attempt to improve performance, I'd like to =
see
>> measurement data for one or more recent SATA SSDs before a decision =
is
>> taken about what to do with this patch.=20
>>=20
>=20
> Hi Bart,
> as I just wrote to Jens I don't think we need this test any longer.
> To save you one hope, I'll paste my reply to Jens below.
>=20
> Anyway, it is very easy to do the tests you ask:
> - take a kernel containing the last bfq commits, such as for-next
> - do, e.g.,
> git clone https://github.com/Algodev-github/S.git
> cd S/run_multiple_benchmarks
> sudo ./run_main_benchmarks.sh "throughput replayed-startup" "bfq none"
> - compare results
>=20

Two things:

1) By mistake, I put 'none' in the last command line above, but it =
should be mq-deadline:

sudo ./run_main_benchmarks.sh "throughput replayed-startup" "bfq =
mq-deadline"

2) If you are worried about wearing your device with writes, then just =
append 'raw' to the last command line. So:

sudo ./run_main_benchmarks.sh "throughput replayed-startup" "bfq =
mq-deadline" raw

'raw' means: "don't even create files for the background traffic, but =
just read raw sectors".

Thanks,
Paolo

> Of course, do not do it for multi-queue devices or single-queues
> devices, on steroids, that do 400-500 KIOPS.
>=20
> I'll see if I can convince someone to repeat these tests with a recent
> SSD.
>=20
> And here is again my reply to Jens, which I think holds for your =
repeated
> objection too.
>=20
> I tested bfq on virtually every device in the range from few hundred
> of IOPS to 50-100KIOPS.  Then, through the public script I already
> mentioned, I found the maximum number of IOPS that bfq can handle:
> about 400K with a commodity CPU.
>=20
> In particular, in all my tests with real hardware, bfq performance
> - is not even comparable to that of any of the other scheduler, in
> terms of responsiveness, latency for real-time applications, ability
> to provide strong bandwidth guarantees, ability to boost throughput
> while guaranteeing bandwidths;
> - is a little worse than the other schedulers for only one test, on
> only some hardware: total throughput with random reads, were it may
> lose up to 10-15% of throughput.  Of course, the schedulers that reach
> a higher throughput leave the machine unusable during the test.
>=20
> So I really cannot see a reason why bfq could do worse than any of
> these other schedulers for some single-queue device (conservatively)
> below 300KIOPS.
>=20
> Finally, since, AFAICT, single-queue devices doing 400+ KIOPS are
> probably less than 1% of all the single-queue storage around (USB
> drives, HDDs, eMMC, standard SSDs, ...), by sticking to mq-deadline we
> are sacrificing 99% of the hardware, to help 1% of the hardware for
> one kind of test cases.
>=20
> Thanks,
> Paolo
>=20
>> Thanks,
>>=20
>> Bart.
>>=20
>=20
> --=20
> You received this message because you are subscribed to the Google =
Groups "bfq-iosched" group.
> To unsubscribe from this group and stop receiving emails from it, send =
an email to bfq-iosched+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
