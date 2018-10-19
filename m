Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
References: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1539941093-32058-1-git-send-email-jianchao.w.wang@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 19 Oct 2018 17:46:35 +0800
Message-ID: <CACVXFVO_vDrwGbv0gOOhcYsRFfDhiawfX6Myvgxeht5B_P54TA@mail.gmail.com>
Subject: Re: [PATCH] block: don't check position contiguity for DISCARD in attempt_merge
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 19, 2018 at 5:23 PM Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
>
> Discard command supports multiple ranges of blocks, so needn't
> checking position contiguity when merging. Let's do the same thing
> in attempt_merge as the blk_try_merge.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-merge.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a4674..c94749b 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -732,9 +732,10 @@ static struct request *attempt_merge(struct request_queue *q,
>                 return NULL;
>
>         /*
> -        * not contiguous
> +        * not contiguous, except for DISCARD
>          */
> -       if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> +       if ((req_op(req) != REQ_OP_DISCARD) &&
> +           (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next)))
>                 return NULL;
>
>         if (rq_data_dir(req) != rq_data_dir(next)
> --
> 2.7.4
>
Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming Lei
