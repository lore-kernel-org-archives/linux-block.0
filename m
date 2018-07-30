Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
References: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 30 Jul 2018 20:06:36 +0800
Message-ID: <CACVXFVOECZjvDjya1q91me5JnTh=80asDnnDs7re3xi5+OPdJw@mail.gmail.com>
Subject: Re: [PATCH] block: blk_init_allocated_queue() set q->fq as NULL in
 the fail case
To: xiao jin <jin.xiao@intel.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bart Van Assche <bart.vanassche@wdc.com>,
	stable <stable@vger.kernel.org>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
	Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 30, 2018 at 2:11 PM, xiao jin <jin.xiao@intel.com> wrote:
> We find the memory use-after-free issue in __blk_drain_queue()
> on the kernel 4.14. After read the latest kernel 4.18-rc6 we
> think it has the same problem.
>
> Memory is allocated for q->fq in the blk_init_allocated_queue().
> If the elevator init function called with error return, it will
> run into the fail case to free the q->fq.
>
> Then the __blk_drain_queue() uses the same memory after the free
> of the q->fq, it will lead to the unpredictable event.
>
> The patch is to set q->fq as NULL in the fail case of
> blk_init_allocated_queue().
>
> Fixes: commit 7c94e1c157a2 ("block: introduce blk_flush_queue to drive flush machinery")
> Signed-off-by: xiao jin <jin.xiao@intel.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: <stable@vger.kernel.org>
> ---
>  block/blk-core.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b888175..52635e2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1072,6 +1072,7 @@ int blk_init_allocated_queue(struct request_queue *q)
>                 q->exit_rq_fn(q, q->fq->flush_rq);
>  out_free_flush_queue:
>         blk_free_flush_queue(q->fq);
> +       q->fq = NULL;
>         return -ENOMEM;
>  }
>  EXPORT_SYMBOL(blk_init_allocated_queue);
> --
> 1.7.9.5
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
