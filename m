Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] block: BFQ default for single queue devices
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20181002124329.21248-1-linus.walleij@linaro.org>
Date: Wed, 3 Oct 2018 17:51:38 +0200
Cc: linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>,
 linux-mmc@vger.kernel.org,
 linux-mtd@lists.infradead.org,
 Pavel Machek <pavel@ucw.cz>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>
Message-Id: <B7588E6C-FCD5-460E-8334-8128CEF7BC07@linaro.org>
References: <20181002124329.21248-1-linus.walleij@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
List-ID: <linux-block@vger.kernel.org>



> Il giorno 02 ott 2018, alle ore 14:43, Linus Walleij =
<linus.walleij@linaro.org> ha scritto:
>=20
> This sets BFQ as the default scheduler for single queue
> block devices (nr_hw_queues =3D=3D 1) if it is available. This
> affects notably MMC/SD-cards but notably also UBI and
> the loopback device.
>=20
> I have been running it for a while without any negative
> effects on my pet systems and I want some wider testing
> so let's throw it out there and see what people say.
> Admittedly my use cases are limited.
>=20
> I talked to Pavel a bit back and it turns out he has a
> usecase for BFQ as well and I bet he also would like it
> as default scheduler for that system (Pavel tell us more,
> I don't remember what it was!)
>=20
> Intuitively I could understand that maybe we want to
> leave the loop device

Actually, I've tested loop devices too.  And, also with these virtual
devices, switching to bfq radically improves figures of merits as
responsiveness and latency for soft real-time applications.

Thanks,
Paolo


> (possibly others? nbd? rbd?) as
> "none", as it is probably relying on a scheduler on the
> device below it, so I'm open to passing in a scheduler hint
> from the respective subsystem in say struct blk_mq_tag_set.
> However that makes for a bit of syntactic dissonance
> with the struct member ".nr_hw_queues" (I wonder how
> the loop device can have 1 "hardware queue"?) so
> maybe we should in that case also rename that struct
> member to ".nr_queues" fair and square before we start
> making adjustments for treating queues differently whether
> they are in hardware or actually not.
>=20
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Paolo Valente <paolo.valente@linaro.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Artem Bityutskiy <dedekind1@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> block/elevator.c | 21 ++++++++++++++-------
> 1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/elevator.c b/block/elevator.c
> index e18ac68626e3..e5a2c39eee7b 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -948,13 +948,15 @@ int elevator_switch_mq(struct request_queue *q,
> }
>=20
> /*
> - * For blk-mq devices, we default to using mq-deadline, if available, =
for single
> - * queue devices.  If deadline isn't available OR we have multiple =
queues,
> - * default to "none".
> + * For blk-mq devices, we default to using:
> + * - "none" for multiqueue devices (nr_hw_queues !=3D 1)
> + * - "bfq", if available, for single queue devices
> + * - "mq-deadline" if "bfq" is not available for single queue devices
> + * - "none" for single queue devices as well as last resort
>  */
> int elevator_init_mq(struct request_queue *q)
> {
> -	struct elevator_type *e;
> +	struct elevator_type *e =3D NULL;
> 	int err =3D 0;
>=20
> 	if (q->nr_hw_queues !=3D 1)
> @@ -968,9 +970,14 @@ int elevator_init_mq(struct request_queue *q)
> 	if (unlikely(q->elevator))
> 		goto out_unlock;
>=20
> -	e =3D elevator_get(q, "mq-deadline", false);
> -	if (!e)
> -		goto out_unlock;
> +	if (IS_ENABLED(CONFIG_IOSCHED_BFQ))
> +		e =3D elevator_get(q, "bfq", false);
> +
> +	if (!e) {
> +		e =3D elevator_get(q, "mq-deadline", false);
> +		if (!e)
> +			goto out_unlock;
> +	}
>=20
> 	err =3D blk_mq_init_sched(q, e);
> 	if (err)
> --=20
> 2.17.1
>=20
