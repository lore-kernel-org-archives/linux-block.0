Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
Date: Wed, 3 Oct 2018 17:53:23 +0200
Cc: Damien.LeMoal@wdc.com,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Jan Kara <jack@suse.cz>,
 aherrmann@suse.com,
 mgorman@suse.com,
 Chunyan Zhang <zhang.chunyan@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name,
 Mark Brown <broonie@kernel.org>
Message-Id: <1E24731C-13E1-41CC-A96A-ABDAA6175849@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
 <05fdbe23-ec01-895f-e67e-abff85c1ece2@kernel.dk>
 <B5321A64-8A1A-42FF-A337-F4524BDA179B@linaro.org>
 <1538550325.14984.108.camel@gmail.com>
 <CACRpkdaLZXGKMQGJPH02p2QPkxUDA03Y=cu_wBR_+rFaLWTw7g@mail.gmail.com>
 <BN3PR0401MB164003C967C45F2681F503A7E7E90@BN3PR0401MB1640.namprd04.prod.outlook.com>
 <CACRpkdbHiq9bstRzyg-fJfXKnXr8wD1YzAooLAwQKM0OzP=HVA@mail.gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 03 ott 2018, alle ore 10:28, Linus Walleij =
<linus.walleij@linaro.org> ha scritto:
>=20
> On Wed, Oct 3, 2018 at 9:42 AM Damien Le Moal <Damien.LeMoal@wdc.com> =
wrote:
>=20
>> There is another class of outliers: host-managed SMR disks (SATA and =
SCSI,
>> definitely single hw queue). For these, using mq-deadline is =
mandatory in many
>> cases in order to guarantee sequential write command delivery to the =
device
>> driver. Having the default changed to bfq, which as far as I know is =
not SMR
>> friendly (can sequential writes within a single zone be reordered ?) =
is asking
>> for troubles (unaligned write errors showing up).
>=20
> Ah, that is interesting.
>=20
> Which device driver files are we talking about here, specifically?
> I'd like to take a look.
>=20
> I guess what you say is not that you are looking for the deadline
> scheduling per se (as in deadline scheduling is nice), what you want =
is
> the zone locking semantics in that scheduler, is that right?
>=20
> I.e. this business:
> blk_queue_is_zoned(q)
> blk_req_zone_write_lock(rq);
> blk_req_zone_write_unlock(rq);
> and mq-deadline solves this with a spinlock.
>=20
> I will augment the patch to enforce mq-deadline
> if blk_queue_is_zoned(q) is true, as it is clear that
> any device with that characteristic must use mq-deadline.
>=20
> Paoly might be interested in looking into whether BFQ could
> also handle zoned devices in the future, I have no idea of how
> hard that would be.
>=20

Absolutely, as I already wrote in my reply to Damien.

In the meantime, Linus, augmenting your patch as you propose seems
a clean and effective solution to me.

Thanks,
Paolo

> The zoned business seems a bit fragile. Should it even be
> allowed to select any other scheduler than deadline on these
> devices? Presenting all compiled in schedulers in
> /sysblock/device/queue/scheduler sounds like just giving
> sysadmins too much rope.
>=20
> Yours,
> Linus Walleij
