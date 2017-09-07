Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4bedc1416a9cfbb4547cc0fb4c67e77462f407f1.1504742003.git.shli@fb.com>
References: <cover.1504742003.git.shli@fb.com> <4bedc1416a9cfbb4547cc0fb4c67e77462f407f1.1504742003.git.shli@fb.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 7 Sep 2017 17:05:35 +0800
Message-ID: <CACVXFVOHwjw1-ZdLYrAMoa68FufG3Jk0AD_V0w+h6A=_wbzaFQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] block/loop: use FALLOC_FL_ZERO_RANGE for REQ_OP_WRITE_ZEROES
To: Shaohua Li <shli@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>, FB Kernel Team <kernel-team@fb.com>,
	Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Thu, Sep 7, 2017 at 8:13 AM, Shaohua Li <shli@kernel.org> wrote:
> From: Shaohua Li <shli@fb.com>
>
> REQ_OP_WRITE_ZEROES really means zero the data. And in blkdev_fallocate,
> FALLOC_FL_ZERO_RANGE will retry but FALLOC_FL_PUNCH_HOLE not, even loop
> request doesn't have BLKDEV_ZERO_NOFALLBACK set.
>
> Signed-off-by: Shaohua Li <shli@fb.com>
> ---
>  drivers/block/loop.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 715b762..8934e25 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -426,6 +426,9 @@ static int lo_discard(struct loop_device *lo, struct request *rq, loff_t pos)
>         int mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
>         int ret;
>
> +       if (req_op(rq) == REQ_OP_WRITE_ZEROES)
> +               mode = FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE;
> +
>         if ((!file->f_op->fallocate) || lo->lo_encrypt_key_size) {
>                 ret = -EOPNOTSUPP;
>                 goto out;
> --
> 2.9.5
>

Looks fine,

      Reviewed-by: Ming Lei <ming.lei@redhat.com>


-- 
Ming Lei
