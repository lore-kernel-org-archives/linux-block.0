Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
Date: Wed, 3 Oct 2018 17:52:57 +0200
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>,
 "aherrmann@suse.com" <aherrmann@suse.com>,
 "mgorman@suse.com" <mgorman@suse.com>,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
 "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
 Mark Brown <broonie@kernel.org>
Message-Id: <44614924-FF19-4C99-B04F-93C032B74395@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 03 ott 2018, alle ore 09:42, Damien Le Moal =
<damien.lemoal@wdc.com> ha scritto:
>=20
> On 2018/10/03 16:18, Linus Walleij wrote:
>> On Wed, Oct 3, 2018 at 9:05 AM Artem Bityutskiy <dedekind1@gmail.com> =
wrote:
>>> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:
>>>> So, I do understand your need for conservativeness, but, after so =
much
>>>> evidence on single-queue devices, and so many years! :), what's the
>>>> point in keeping Linux worse for virtually everybody, by default?
>>>=20
>>> Sounds like what we just need a mechanism for the device (ubi block =
in
>>> this case) to select the I/O scheduler. I doubt enhancing the =
default
>>> scheduler selection logic in 'elevator.c' is the right answer. Just
>>> give the driver authority to override the defaults.
>>=20
>> This might be true in the wider sense (like for what scheduler to
>> select for an NVME device with N channels) but $SUBJECT is just
>> trying to select BFQ (if available) for devices with one and only one
>> hardware queue.
>>=20
>> That is AFAICT the only reasonable choice for anything with just
>> one hardware queue as things stand right now.
>>=20
>> I have a slight reservation for the weird outliers like loopdev, =
which
>> has "one hardware queue" (.nr_hw_queues =3D=3D 1) though this
>> makes no sense at all. So I would like to know what people think
>> about that. Maybe we should have .nr_queues and .nr_hw_queues
>> where the former is the number of logical queues and the latter
>> the actual number of hardware queues.
>=20
> There is another class of outliers: host-managed SMR disks (SATA and =
SCSI,
> definitely single hw queue). For these, using mq-deadline is mandatory =
in many
> cases in order to guarantee sequential write command delivery to the =
device
> driver. Having the default changed to bfq, which as far as I know is =
not SMR
> friendly (can sequential writes within a single zone be reordered ?) =
is asking
> for troubles (unaligned write errors showing up).
>=20

Hi Damien,
actually I have followed threads on SMR device, and have already looked
into this.  I'm sorry for not having mentioned it in my first reply.

My plan is to simply port this feature from mq-deadline to bfq.  It
should be really straightforward, especially after the testing you did
through mq-deadline.  Even if I'm missing some less trivial hidden
issue, I guess it won't be impossible to address.

If it may be useful for the outcome of this thread, I'm willing to
raise the priority of this change to bfq.

> A while back, we already had this discussion with Jens and Christoph =
on the list
> to allow device drivers to set a sensible default I/O scheduler for =
devices with
> "special needs" (e.g. host-managed SMR). At the time, the conclusion =
was that
> udev (or something alike in userland) is better suited to set a =
correct scheduler.
>=20
> Of note also is that host-managed like sequential zone devices are =
also likely
> to show up soon with the work being done in the NVMe standard on the =
new "Zoned
> namespace" feature proposal. These devices will also require a =
scheduler like
> mq-deadline guaranteeing per-zone in-order delivery of sequential =
write
> requests. Looking only at the number of queues of the device is not =
enough to
> choose the best (most reasonnable/appropriate) scheduler.
>=20

Until bfq simply handles SMR devices too.

Thanks,
Paolo

> --=20
> Damien Le Moal
> Western Digital Research
