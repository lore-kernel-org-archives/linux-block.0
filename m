Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <61457d9c4399baaf20f151eed4d5971625953504.1504742003.git.shli@fb.com>
References: <cover.1504742003.git.shli@fb.com> <61457d9c4399baaf20f151eed4d5971625953504.1504742003.git.shli@fb.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 7 Sep 2017 17:22:32 +0800
Message-ID: <CACVXFVPHaQucy9PZuAYUm328rigdiJ2KOpEVbL3Soif5GVMimQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] block/loop: don't hijack error number
To: Shaohua Li <shli@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, FB Kernel Team <kernel-team@fb.com>,
	Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 7, 2017 at 8:13 AM, Shaohua Li <shli@kernel.org> wrote:
> From: Shaohua Li <shli@fb.com>
>
> If the bio returns -EOPNOTSUPP, we shouldn't hijack it and return -EIO
>
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  drivers/block/loop.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 85de673..715b762 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -460,7 +460,7 @@ static void lo_complete_rq(struct request *rq)
>                 zero_fill_bio(bio);
>         }
>
> -       blk_mq_end_request(rq, cmd->ret < 0 ? BLK_STS_IOERR : BLK_STS_OK);
> +       blk_mq_end_request(rq, errno_to_blk_status(cmd->ret));
>  }
>
>  static void lo_rw_aio_do_completion(struct loop_cmd *cmd)
> @@ -476,7 +476,7 @@ static void lo_rw_aio_complete(struct kiocb *iocb, long ret, long ret2)
>  {
>         struct loop_cmd *cmd = container_of(iocb, struct loop_cmd, iocb);
>
> -       cmd->ret = ret;
> +       cmd->ret = ret > 0 ? 0 : ret;
>         lo_rw_aio_do_completion(cmd);
>  }
>
> @@ -1706,7 +1706,7 @@ static void loop_handle_cmd(struct loop_cmd *cmd)
>   failed:
>         /* complete non-aio request */
>         if (!cmd->use_aio || ret) {
> -               cmd->ret = ret ? -EIO : 0;
> +               cmd->ret = ret;
>                 blk_mq_complete_request(cmd->rq);
>         }
>  }
> --
> 2.9.5
>

Looks fine:

      Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming Lei
