Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "shli@fb.com"
	<shli@fb.com>
Subject: Re: [PATCH] blk-throttle: Suppress a compiler warning
Date: Thu, 20 Apr 2017 15:36:27 +0000
Message-ID: <1492702586.2642.5.camel@sandisk.com>
References: <20170419235504.5463-1-bart.vanassche@sandisk.com>
	 <089b9e20-c20d-1d10-f230-4aebbb5f03ee@kernel.dk>
In-Reply-To: <089b9e20-c20d-1d10-f230-4aebbb5f03ee@kernel.dk>
Content-Type: text/plain; charset="windows-1251"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-19 at 18:09 -0600, Jens Axboe wrote:
> On 04/19/2017 05:55 PM, Bart Van Assche wrote:
> > Avoid that the following warning is reported when building with
> > W=3D1 and with CONFIG_BLK_DEV_THROTTLING_LOW=3Dn:
> >=20
> > block/blk-throttle.c: In function =91blk_throtl_bio=92:
> > block/blk-throttle.c:2042:6: warning: variable =91ret=92 set but not us=
ed [-Wunused-but-set-variable]
> >   int ret;
> >       ^~~
> >=20
> > Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> > Cc: Shaohua Li <shli@fb.com>
> > ---
> >  block/blk-throttle.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> > index c82bf9b1fe72..9081ed9a5345 100644
> > --- a/block/blk-throttle.c
> > +++ b/block/blk-throttle.c
> > @@ -2059,6 +2059,10 @@ bool blk_throtl_bio(struct request_queue *q, str=
uct blkcg_gq *blkg,
> >  	if (ret =3D=3D 0 || ret =3D=3D -EBUSY)
> >  		bio->bi_cg_private =3D tg;
> >  	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
> > +#else
> > +	/* Avoid that the compiler complains about not using ret */
> > +	if (ret) {
> > +	}
> >  #endif
>=20
> Ugh, that may get rid of the warning, but it does not help on
> the readability or the ifdefs. How about something like the below?
> Naming could probably be improved...
>=20
>=20
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index c82bf9b1fe72..b78db2e5fdff 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -2030,6 +2030,20 @@ static inline void throtl_update_latency_buckets(s=
truct throtl_data *td)
>  }
>  #endif
> =20
> +static void blk_throtl_assoc_bio(struct throtl_grp *tg, struct bio *bio)
> +{
> +#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> +	int ret;
> +
> +	ret =3D bio_associate_current(bio);
> +	if (ret =3D=3D 0 || ret =3D=3D -EBUSY)
> +		bio->bi_cg_private =3D tg;
> +	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
> +#else
> +	bio_associate_current(bio);
> +#endif
> +}
> +
>  bool blk_throtl_bio(struct request_queue *q, struct blkcg_gq *blkg,
>  		    struct bio *bio)
>  {
> @@ -2039,7 +2053,6 @@ bool blk_throtl_bio(struct request_queue *q, struct=
 blkcg_gq *blkg,
>  	bool rw =3D bio_data_dir(bio);
>  	bool throttled =3D false;
>  	struct throtl_data *td =3D tg->td;
> -	int ret;
> =20
>  	WARN_ON_ONCE(!rcu_read_lock_held());
> =20
> @@ -2054,12 +2067,7 @@ bool blk_throtl_bio(struct request_queue *q, struc=
t blkcg_gq *blkg,
>  	if (unlikely(blk_queue_bypass(q)))
>  		goto out_unlock;
> =20
> -	ret =3D bio_associate_current(bio);
> -#ifdef CONFIG_BLK_DEV_THROTTLING_LOW
> -	if (ret =3D=3D 0 || ret =3D=3D -EBUSY)
> -		bio->bi_cg_private =3D tg;
> -	blk_stat_set_issue(&bio->bi_issue_stat, bio_sectors(bio));
> -#endif
> +	blk_throtl_assoc_bio(tg, bio);
>  	blk_throtl_update_idletime(tg);
> =20
>  	sq =3D &tg->service_queue;
>=20

Hello Jens,

The above patch looks fine to me. Do you want to queue this patch with
my Reviewed-by or do you prefer that I post the above as a v2?

Thanks,

Bart.=
