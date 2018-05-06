Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH BUGFIX] block, bfq: postpone rq preparation to insert or
 merge
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1525532191.5406.15.camel@gmx.de>
Date: Sun, 6 May 2018 09:42:51 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block <linux-block@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 linus.walleij@linaro.org,
 bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
Message-Id: <223CABEA-71E0-426F-A4AB-17BA8437C978@linaro.org>
References: <20180504171701.6876-1-paolo.valente@linaro.org>
 <1525463210.622.1.camel@gmx.de> <1525508378.5406.6.camel@gmx.de>
 <9F155F9F-F6B2-465A-BA4D-A86FF6825071@linaro.org>
 <1525532191.5406.15.camel@gmx.de>
To: Mike Galbraith <efault@gmx.de>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 05 mag 2018, alle ore 16:56, Mike Galbraith <efault@gmx.de> =
ha scritto:
>=20
> On Sat, 2018-05-05 at 12:39 +0200, Paolo Valente wrote:
>>=20
>> BTW, if you didn't run out of patience with this permanent issue yet,
>> I was thinking of two o three changes to retry to trigger your =
failure
>> reliably.
>=20
> Sure, fire away, I'll happily give the annoying little bugger
> opportunities to show its tender belly.

I've attached a compressed patch (to avoid possible corruption from my
mailer).  I'm little confident, but no pain, no gain, right?

If possible, apply this patch on top of the fix I proposed in this
thread, just to eliminate possible further noise. Finally, the
patch content follows.

Hoping for a stroke of luck,
Paolo

diff --git a/block/bfq-mq-iosched.c b/block/bfq-mq-iosched.c
index 118f319af7c0..6662efe29b69 100644
--- a/block/bfq-mq-iosched.c
+++ b/block/bfq-mq-iosched.c
@@ -525,8 +525,13 @@ static void bfq_limit_depth(unsigned int op, struct =
blk_mq_alloc_data *data)
        if (unlikely(bfqd->sb_shift !=3D bt->sb.shift))
                bfq_update_depths(bfqd, bt);
=20
+#if 0
        data->shallow_depth =3D
                =
bfqd->word_depths[!!bfqd->wr_busy_queues][op_is_sync(op)];
+#else
+       data->shallow_depth =3D 1;
+#endif
+
=20
        bfq_log(bfqd, "wr_busy %d sync %d depth %u",
                        bfqd->wr_busy_queues, op_is_sync(op),


>=20
> 	-Mike
>=20
