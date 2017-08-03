Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] blk-mq: provide internal in-flight variant
Date: Thu, 3 Aug 2017 20:41:55 +0000
Message-ID: <1501792912.2922.18.camel@wdc.com>
References: <1501790516-6924-1-git-send-email-axboe@kernel.dk>
	 <1501790516-6924-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1501790516-6924-4-git-send-email-axboe@kernel.dk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Thu, 2017-08-03 at 14:01 -0600, Jens Axboe wrote:
> We don't have to inc/dec some counter, since we can just
> iterate the tags. That makes inc/dec a noop, but means we
> have to iterate busy tags to get an in-flight count.
> [ ... ]
> +unsigned int blk_mq_in_flight(struct request_queue *q,
> +			       struct hd_struct *part)
> +{
> +	struct mq_inflight mi =3D { .part =3D part, .inflight =3D 0 };

Hello Jens,

A minor stylistic comment: since a C compiler is required to initialize to =
zero
all member variables that have not been initialized explicitly I think
".inflight =3D 0" can be left out.

> diff --git a/block/genhd.c b/block/genhd.c
> index f735af67a0c9..ad5dc567d57f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -45,6 +45,35 @@ static void disk_add_events(struct gendisk *disk);
>  static void disk_del_events(struct gendisk *disk);
>  static void disk_release_events(struct gendisk *disk);
> =20
> +void part_inc_in_flight(struct request_queue *q, struct hd_struct *part,=
 int rw)
> +{
> +	if (q->mq_ops)
> +		return;
> +
> +	atomic_inc(&part->in_flight[rw]);
> +	if (part->partno)
> +		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
> +}
> [ ... ]
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 7f7427e00f9c..f2c5096b3a7e 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -362,28 +362,9 @@ static inline void free_part_stats(struct hd_struct =
*part)
>  #define part_stat_sub(cpu, gendiskp, field, subnd)			\
>  	part_stat_add(cpu, gendiskp, field, -subnd)
> =20
> -static inline void part_inc_in_flight(struct request_queue *q,
> -				      struct hd_struct *part, int rw)
> -{
> -	atomic_inc(&part->in_flight[rw]);
> -	if (part->partno)
> -		atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
> -}
> [ ... ]

Sorry but to me it seems like this part of the patch does match with the pa=
tch
description? The patch description mentions that inc and dec become a noop =
but
it seems to me that these functions have been uninlined instead of making t=
hese
a noop?

Bart.=
