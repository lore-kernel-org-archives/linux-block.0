Return-Path: <ming.lei@canonical.com>
MIME-Version: 1.0
In-Reply-To: <1470319801-20594-2-git-send-email-hch@lst.de>
References: <1470319801-20594-1-git-send-email-hch@lst.de> <1470319801-20594-2-git-send-email-hch@lst.de>
From: Ming Lei <ming.lei@canonical.com>
Date: Thu, 4 Aug 2016 22:24:46 +0800
Message-ID: <CACVXFVPLuXGG7y0U2_W-7mOAe8Ojy+uRfa3_cuhXYeXKpshQNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] loop: don't try to use AIO for discards
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Mike Christie <mchristi@redhat.com>,
	Dave Chinner <david@fromorbit.com>, linux-block <linux-block@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Aug 4, 2016 at 10:10 PM, Christoph Hellwig <hch@lst.de> wrote:
> Fix a fat-fingered conversion to the req_op accessors, and also
> use a switch statement to make it more obvious what is being checked.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reported-by: Dave Chinner <david@fromorbit.com>
> Fixes: c2df40 ("drivers: use req op accessor");
> ---
>  drivers/block/loop.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 075377e..91c2c88 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -1659,11 +1659,15 @@ static int loop_queue_rq(struct blk_mq_hw_ctx *hctx,
>         if (lo->lo_state != Lo_bound)
>                 return -EIO;
>
> -       if (lo->use_dio && (req_op(cmd->rq) != REQ_OP_FLUSH ||
> -           req_op(cmd->rq) == REQ_OP_DISCARD))
> -               cmd->use_aio = true;
> -       else
> +       switch (req_op(cmd->rq)) {
> +       case REQ_OP_FLUSH:
> +       case REQ_OP_DISCARD:
>                 cmd->use_aio = false;
> +               break;
> +       default:
> +               cmd->use_aio = lo->use_dio;
> +               break;
> +       }

Reviewed-by: Ming Lei <ming.lei@canonical.com>

>
>         queue_kthread_work(&lo->worker, &cmd->work);
>
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
