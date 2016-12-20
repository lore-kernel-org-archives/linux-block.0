Return-Path: <paolo.valente@linaro.org>
Return-Path: <paolo.valente@linaro.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 3/8] block: move rq_ioc() to blk.h
From: Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <1481933536-12844-4-git-send-email-axboe@fb.com>
Date: Tue, 20 Dec 2016 11:12:01 +0100
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Linux-Kernal <linux-kernel@vger.kernel.org>,
 osandov@fb.com
Message-Id: <5A31E864-F10C-4CB4-B780-BB16524E3590@linaro.org>
References: <1481933536-12844-1-git-send-email-axboe@fb.com> <1481933536-12844-4-git-send-email-axboe@fb.com>
To: Jens Axboe <axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>


> Il giorno 17 dic 2016, alle ore 01:12, Jens Axboe <axboe@fb.com> ha =
scritto:
>=20
> We want to use it outside of blk-core.c.
>=20

Hi Jens,
no hooks equivalent to elevator_init_icq_fn and elevator_exit_icq_fn
are invoked.  In particular, the second hook let bfq (as with cfq)
know when it could finally exit the queue associated with the icq.
I'm trying to figure out how to make it without these hooks/signals,
but at no avail so far ...

Thanks,
Paolo

> Signed-off-by: Jens Axboe <axboe@fb.com>
> ---
> block/blk-core.c | 16 ----------------
> block/blk.h      | 16 ++++++++++++++++
> 2 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 61ba08c58b64..92baea07acbc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1040,22 +1040,6 @@ static bool blk_rq_should_init_elevator(struct =
bio *bio)
> }
>=20
> /**
> - * rq_ioc - determine io_context for request allocation
> - * @bio: request being allocated is for this bio (can be %NULL)
> - *
> - * Determine io_context to use for request allocation for @bio.  May =
return
> - * %NULL if %current->io_context doesn't exist.
> - */
> -static struct io_context *rq_ioc(struct bio *bio)
> -{
> -#ifdef CONFIG_BLK_CGROUP
> -	if (bio && bio->bi_ioc)
> -		return bio->bi_ioc;
> -#endif
> -	return current->io_context;
> -}
> -
> -/**
>  * __get_request - get a free request
>  * @rl: request list to allocate from
>  * @op: operation and flags
> diff --git a/block/blk.h b/block/blk.h
> index f46c0ac8ae3d..9a716b5925a4 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -264,6 +264,22 @@ void ioc_clear_queue(struct request_queue *q);
> int create_task_io_context(struct task_struct *task, gfp_t gfp_mask, =
int node);
>=20
> /**
> + * rq_ioc - determine io_context for request allocation
> + * @bio: request being allocated is for this bio (can be %NULL)
> + *
> + * Determine io_context to use for request allocation for @bio.  May =
return
> + * %NULL if %current->io_context doesn't exist.
> + */
> +static inline struct io_context *rq_ioc(struct bio *bio)
> +{
> +#ifdef CONFIG_BLK_CGROUP
> +	if (bio && bio->bi_ioc)
> +		return bio->bi_ioc;
> +#endif
> +	return current->io_context;
> +}
> +
> +/**
>  * create_io_context - try to create task->io_context
>  * @gfp_mask: allocation mask
>  * @node: allocation node
> --=20
> 2.7.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
