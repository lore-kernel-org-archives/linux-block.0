Return-Path: <prvs=807716777=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Artem Bityutskiy <dedekind1@gmail.com>, Paolo Valente
	<paolo.valente@linaro.org>, Jens Axboe <axboe@kernel.dk>, linux-block
	<linux-block@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Pavel Machek
	<pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger
	<richard@nod.at>, Adrian Hunter <adrian.hunter@intel.com>, Jan Kara
	<jack@suse.cz>, "aherrmann@suse.com" <aherrmann@suse.com>, "mgorman@suse.com"
	<mgorman@suse.com>, Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bfq-iosched@googlegroups.com" <bfq-iosched@googlegroups.com>,
	"oleksandr@natalenko.name" <oleksandr@natalenko.name>, Mark Brown
	<broonie@kernel.org>
Subject: Re: [PATCH] block: BFQ default for single queue devices
Date: Wed, 3 Oct 2018 08:53:03 +0000
Message-ID: 
 <BN3PR0401MB1640A32A9464999E7E28689EE7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Linus,=0A=
=0A=
On 2018/10/03 17:28, Linus Walleij wrote:=0A=
> On Wed, Oct 3, 2018 at 9:42 AM Damien Le Moal <Damien.LeMoal@wdc.com> wro=
te:=0A=
> =0A=
>> There is another class of outliers: host-managed SMR disks (SATA and SCS=
I,=0A=
>> definitely single hw queue). For these, using mq-deadline is mandatory i=
n many=0A=
>> cases in order to guarantee sequential write command delivery to the dev=
ice=0A=
>> driver. Having the default changed to bfq, which as far as I know is not=
 SMR=0A=
>> friendly (can sequential writes within a single zone be reordered ?) is =
asking=0A=
>> for troubles (unaligned write errors showing up).=0A=
> =0A=
> Ah, that is interesting.=0A=
> =0A=
> Which device driver files are we talking about here, specifically?=0A=
> I'd like to take a look.=0A=
=0A=
Currently, sd.c (SCSI disk) as well as null_blk can expose host-managed zon=
ed=0A=
block devices.=0A=
=0A=
> I guess what you say is not that you are looking for the deadline=0A=
> scheduling per se (as in deadline scheduling is nice), what you want is=
=0A=
> the zone locking semantics in that scheduler, is that right?=0A=
=0A=
Yes, correct. The scheduling policy in itself does not really matter, but s=
hould=0A=
not deviate from the mandatory HM write policy: "within a sequential write=
=0A=
required zone, writes must be issued sequentially". That could somewhat imp=
acts=0A=
the scheduler code itself if said scheduler think that not dispatching=0A=
sequential writes in sequence is a good idea :) No sane scheduler would tha=
t=0A=
though (at least on HDDs) so the impact on the scheduler code itself is red=
uced.=0A=
=0A=
> I.e. this business:=0A=
> blk_queue_is_zoned(q)=0A=
> blk_req_zone_write_lock(rq);=0A=
> blk_req_zone_write_unlock(rq);=0A=
> and mq-deadline solves this with a spinlock.=0A=
=0A=
Yes. These are the helper functions handling the zone write locking to simp=
lify=0A=
the task of the scheduler to limit the number of in-flight write request to=
 one=0A=
per zone at most at any time. This is the trick to avoid write reordering=
=0A=
stack-wide, since most of the time, reordering happens not because of the=
=0A=
scheduler itself, but the blk-mq (or legacy path) around it (e.g. requeue d=
ue to=0A=
resource shortage, multiple contexts running the queues, etc).=0A=
=0A=
> I will augment the patch to enforce mq-deadline=0A=
> if blk_queue_is_zoned(q) is true, as it is clear that=0A=
> any device with that characteristic must use mq-deadline.=0A=
> =0A=
> Paoly might be interested in looking into whether BFQ could=0A=
> also handle zoned devices in the future, I have no idea of how=0A=
> hard that would be.=0A=
=0A=
It was rather easy with deadline, but the scheduler code was simple to star=
t=0A=
with. Basically, the only thing needed is on dispatch to skip any write req=
uest=0A=
to a zone that is already locked (i.e. a write is already ongoing). For rea=
ds,=0A=
there are no constraints so nothing needs to be changed. Zone unlocking mus=
t be=0A=
done on completion of the write request so the scheduler completion method =
needs=0A=
to change a little too.=0A=
=0A=
> The zoned business seems a bit fragile. Should it even be=0A=
> allowed to select any other scheduler than deadline on these=0A=
> devices? Presenting all compiled in schedulers in=0A=
> /sysblock/device/queue/scheduler sounds like just giving=0A=
> sysadmins too much rope.=0A=
=0A=
Yes, that is debatable. But the above "one write per zone" trick can be als=
o=0A=
handled by an application, which makes using any other scheduler OK. Look a=
t the=0A=
recent SMR support code in fio from Bart. Some of the tests (in t/zbd) for =
some=0A=
I/O patterns are just fine with any scheduler. In fact any pattern is OK be=
cause=0A=
fio is SMR aware and never issues more than one write per zone. That is how=
ever=0A=
true only and only for I/O sizes that are small enough as to not cause the=
=0A=
kernel to generate multiple BIOs for each I/O call. Otherwise, deadline &=
=0A=
mq-deadline become necessary.=0A=
=0A=
But I agree, it is a little fragile. Application developer and sysadmins re=
ally=0A=
need to know what will be running on the disk to make the right choice. And=
=0A=
knowing that is not necessarily straightforward.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
