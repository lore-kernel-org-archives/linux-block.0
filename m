Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v2] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
Date: Mon, 15 Oct 2018 20:26:50 +0200
Cc: Linus Walleij <linus.walleij@linaro.org>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Bart Van Assche <bvanassche@acm.org>,
 Jan Kara <jack@suse.cz>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
 Mark Brown <broonie@kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Jonathan Corbet <corbet@lwn.net>
Message-Id: <307F6078-0A77-4AAA-BE1A-55C2ACC328CC@linaro.org>
References: <20181015141059.26579-1-linus.walleij@linaro.org>
 <d25e02de-e1be-0fb7-237b-3e53d56c6f64@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 15 ott 2018, alle ore 17:39, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 10/15/18 8:10 AM, Linus Walleij wrote:
>> This sets BFQ as the default scheduler for single queue
>> block devices (nr_hw_queues =3D=3D 1) if it is available. This
>> affects notably MMC/SD-cards but also UBI and the loopback
>> device.
>>=20
>> I have been running it for a while without any negative
>> effects on my pet systems and I want some wider testing
>> so let's throw it out there and see what people say.
>> Admittedly my use cases are limited. I need to keep this
>> patch around for my personal needs anyway.
>>=20
>> We take special care to avoid using BFQ on zoned devices
>> (in particular SMR, shingled magnetic recording devices)
>> as these currently require mq-deadline to group writes
>> together.
>>=20
>> I have opted against introducing any default scheduler
>> through Kconfig as the mq-deadline enforcement for
>> zoned devices has to be done at runtime anyways and
>> too many config options will make things confusing.
>>=20
>> My argument for setting a default policy in the kernel
>> as opposed to user space is the "reasonable defaults"
>> type, analogous to how we have one default CPU scheduling
>> policy (CFS) that make most sense for most tasks, and
>> how automatic process group scheduling happens in most
>> distributions without userspace involvement. The BFQ
>> scheduling policy makes most sense for single hardware
>> queue devices and many embedded systems will not have
>> the clever userspace tools (such as udev) to make an
>> educated choice of scheduling policy. Defaults should be
>> those that make most sense for the hardware.
>=20
> I still don't like this. There are going to be tons of
> cases where the single queue device is some hw raid setup
> or similar, where performance is going to be much worse with
> BFQ than it is with mq-deadline, for instance. That's just
> one case.
>=20

Hi Jens,
in my RAID tests bfq performed as well as in non-RAID tests.  Probably
you refer to the fact that, in a RAID configuration, IOPS can become
very high.  But, if that is the case, then the response to your
objections already emerged in the previous thread.  Let me sum it up
again.

I tested bfq on virtually every device in the range from few hundred
of IOPS to 50-100KIOPS.  Then, through the public script I already
mentioned, I found the maximum number of IOPS that bfq can handle:
about 400K with a commodity CPU.

In particular, in all my tests with real hardware, bfq
- is not even comparable to that of any of the other scheduler, in
  terms of responsiveness, latency for real-time applications, ability
  to provide strong bandwidth guarantees, ability to boost throughput
  while guaranteeing bandwidths;
- is a little worse than the other scheduler for only one test, on
  only some hardware: total throughput with random reads, were it may
  lose up to 10-15% of throughput.  Of course, the scheduler that reach
  a higher throughput leave the machine unusable during the test.

So I really cannot see a reason why bfq could do worse than any of
these other schedulers for some single-queue device (conservatively)
below 300KIOPS.

Finally, since, AFAICT, single-queue devices doing 400+ KIOPS are
probably less than 1% of all the single-queue storage around (USB
drives, HDDs, eMMC, standard SSDs, ...), by sticking to mq-deadline we
are sacrificing 99% of the hardware, to help 1% of the hardware, for
one kind of test cases.

> This kind of policy does not belong in the kernel, at least
> not in the current form. If we had some sort of "enable best
> options for a desktop" then it could fall under that umbrella.
>=20

I don't think bfq can be considered a scheduler for only desktops any
longer.

Thanks,
Paolo

> --=20
> Jens Axboe
