Return-Path: <prvs=807716777=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Linus Walleij <linus.walleij@linaro.org>, Artem Bityutskiy
	<dedekind1@gmail.com>
CC: Paolo Valente <paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>, linux-mmc
	<linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson
	<ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, Adrian Hunter
	<adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>, "aherrmann@suse.com"
	<aherrmann@suse.com>, "mgorman@suse.com" <mgorman@suse.com>, Chunyan Zhang
	<zhang.chunyan@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bfq-iosched@googlegroups.com"
	<bfq-iosched@googlegroups.com>, "oleksandr@natalenko.name"
	<oleksandr@natalenko.name>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Date: Wed, 3 Oct 2018 07:42:15 +0000
Message-ID: 
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 2018/10/03 16:18, Linus Walleij wrote:=0A=
> On Wed, Oct 3, 2018 at 9:05 AM Artem Bityutskiy <dedekind1@gmail.com> wro=
te:=0A=
>> On Wed, 2018-10-03 at 08:29 +0200, Paolo Valente wrote:=0A=
>>> So, I do understand your need for conservativeness, but, after so much=
=0A=
>>> evidence on single-queue devices, and so many years! :), what's the=0A=
>>> point in keeping Linux worse for virtually everybody, by default?=0A=
>>=0A=
>> Sounds like what we just need a mechanism for the device (ubi block in=
=0A=
>> this case) to select the I/O scheduler. I doubt enhancing the default=0A=
>> scheduler selection logic in 'elevator.c' is the right answer. Just=0A=
>> give the driver authority to override the defaults.=0A=
> =0A=
> This might be true in the wider sense (like for what scheduler to=0A=
> select for an NVME device with N channels) but $SUBJECT is just=0A=
> trying to select BFQ (if available) for devices with one and only one=0A=
> hardware queue.=0A=
> =0A=
> That is AFAICT the only reasonable choice for anything with just=0A=
> one hardware queue as things stand right now.=0A=
> =0A=
> I have a slight reservation for the weird outliers like loopdev, which=0A=
> has "one hardware queue" (.nr_hw_queues =3D=3D 1) though this=0A=
> makes no sense at all. So I would like to know what people think=0A=
> about that. Maybe we should have .nr_queues and .nr_hw_queues=0A=
> where the former is the number of logical queues and the latter=0A=
> the actual number of hardware queues.=0A=
=0A=
There is another class of outliers: host-managed SMR disks (SATA and SCSI,=
=0A=
definitely single hw queue). For these, using mq-deadline is mandatory in m=
any=0A=
cases in order to guarantee sequential write command delivery to the device=
=0A=
driver. Having the default changed to bfq, which as far as I know is not SM=
R=0A=
friendly (can sequential writes within a single zone be reordered ?) is ask=
ing=0A=
for troubles (unaligned write errors showing up).=0A=
=0A=
A while back, we already had this discussion with Jens and Christoph on the=
 list=0A=
to allow device drivers to set a sensible default I/O scheduler for devices=
 with=0A=
"special needs" (e.g. host-managed SMR). At the time, the conclusion was th=
at=0A=
udev (or something alike in userland) is better suited to set a correct sch=
eduler.=0A=
=0A=
Of note also is that host-managed like sequential zone devices are also lik=
ely=0A=
to show up soon with the work being done in the NVMe standard on the new "Z=
oned=0A=
namespace" feature proposal. These devices will also require a scheduler li=
ke=0A=
mq-deadline guaranteeing per-zone in-order delivery of sequential write=0A=
requests. Looking only at the number of queues of the device is not enough =
to=0A=
choose the best (most reasonnable/appropriate) scheduler.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
