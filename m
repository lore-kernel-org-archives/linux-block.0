Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk> <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com> <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
In-Reply-To: <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 3 Oct 2018 10:28:03 +0200
Message-ID: <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
Subject: Re: [PATCH] block: BFQ default for single queue devices
To: Damien.LeMoal@wdc.com
Cc: Artem Bityutskiy <dedekind1@gmail.com>, Paolo Valente <paolo.valente@linaro.org>,
	Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	linux-mmc <linux-mmc@vger.kernel.org>, linux-mtd@lists.infradead.org,
	Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>,
	Richard Weinberger <richard@nod.at>, Adrian Hunter <adrian.hunter@intel.com>, Jan Kara <jack@suse.cz>,
	aherrmann@suse.com, mgorman@suse.com,
	Chunyan Zhang <zhang.chunyan@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, bfq-iosched@googlegroups.com,
	oleksandr@natalenko.name, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 3, 2018 at 9:42 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:

> There is another class of outliers: host-managed SMR disks (SATA and SCSI,
> definitely single hw queue). For these, using mq-deadline is mandatory in many
> cases in order to guarantee sequential write command delivery to the device
> driver. Having the default changed to bfq, which as far as I know is not SMR
> friendly (can sequential writes within a single zone be reordered ?) is asking
> for troubles (unaligned write errors showing up).

Ah, that is interesting.

Which device driver files are we talking about here, specifically?
I'd like to take a look.

I guess what you say is not that you are looking for the deadline
scheduling per se (as in deadline scheduling is nice), what you want is
the zone locking semantics in that scheduler, is that right?

I.e. this business:
blk_queue_is_zoned(q)
blk_req_zone_write_lock(rq);
blk_req_zone_write_unlock(rq);
and mq-deadline solves this with a spinlock.

I will augment the patch to enforce mq-deadline
if blk_queue_is_zoned(q) is true, as it is clear that
any device with that characteristic must use mq-deadline.

Paoly might be interested in looking into whether BFQ could
also handle zoned devices in the future, I have no idea of how
hard that would be.

The zoned business seems a bit fragile. Should it even be
allowed to select any other scheduler than deadline on these
devices? Presenting all compiled in schedulers in
/sysblock/device/queue/scheduler sounds like just giving
sysadmins too much rope.

Yours,
Linus Walleij
