Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "jack@suse.cz" <jack@suse.cz>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: Make writeback throttling defaults consistent for
 SQ devices
Date: Fri, 14 Apr 2017 15:42:53 +0000
Message-ID: <1492184571.2644.1.camel@sandisk.com>
References: <20170412082337.10256-1-jack@suse.cz>
In-Reply-To: <20170412082337.10256-1-jack@suse.cz>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-04-12 at 10:23 +0200, Jan Kara wrote:
> +#ifndef CONFIG_BLK_WBT_MQ
> +	if (q->mq_ops)
> +		return;
> +#endif
> +#ifndef CONFIG_BLK_WBT_SQ
> +	if (q->request_fn)
> +		return;
> +#endif
> +
> +	/*
> +	 * If this fails, we don't get throttling
> +	 */
> +	wbt_init(q);

Hello Jan,

How about using positive logic to enable WBT, e.g. as follows? Wouldn't
that make the code easier to read?

	if ((IS_ENABLED(CONFIG_BLK_WBT_MQ) &&=A0q->mq_ops) ||
	    (IS_ENABLED(CONFIG_BLK_WBT_SQ) && q->request_fn))
		wbt_init(q);

> +static void deadline_registered_queue(struct request_queue *q)
> +{
> +	wbt_enable_default(q);
> +}
> +
>  /*
>   * sysfs parts below
>   */
> @@ -445,6 +451,7 @@ static struct elevator_type iosched_deadline =3D {
>  		.elevator_latter_req_fn =3D	elv_rb_latter_request,
>  		.elevator_init_fn =3D		deadline_init_queue,
>  		.elevator_exit_fn =3D		deadline_exit_queue,
> +		.elevator_registered_fn =3D	deadline_registered_queue,
>  	},
> =20
>  	.elevator_attrs =3D deadline_attrs,
> [ ... ]
> @@ -91,6 +92,11 @@ static void noop_exit_queue(struct elevator_queue *e)
>  	kfree(nd);
>  }
> =20
> +static void noop_registered_queue(struct request_queue *q)
> +{
> +	wbt_enable_default(q);
> +}
> +
>  static struct elevator_type elevator_noop =3D {
>  	.ops.sq =3D {
>  		.elevator_merge_req_fn		=3D noop_merged_requests,
> @@ -100,6 +106,7 @@ static struct elevator_type elevator_noop =3D {
>  		.elevator_latter_req_fn		=3D noop_latter_request,
>  		.elevator_init_fn		=3D noop_init_queue,
>  		.elevator_exit_fn		=3D noop_exit_queue,
> +		.elevator_registered_fn		=3D noop_registered_queue,
>  	},
>  	.elevator_name =3D "noop",
>  	.elevator_owner =3D THIS_MODULE,

This approach is not suited for blk-mq because with blk-mq "none" means no
scheduler and hence no struct elevator_type. Please consider not to add any
elevator_registered_fn() callbacks to noop and deadline but instead to call
wbt_enable_default() from elv_unregister_queue().

Thanks,

Bart.=
