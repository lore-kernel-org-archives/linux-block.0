Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1533716548-1645-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1533716548-1645-1-git-send-email-jianchao.w.wang@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 8 Aug 2018 17:24:12 +0800
Message-ID: <CACVXFVMKQRT5_gyikVAPMKY_KPmQ2_w+VnZhKKCK9Sm4WphqQw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: count the hctx as active before allocate tag
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 8, 2018 at 4:22 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, we count the hctx as active after allocate tag
> successfully. The other shared-tags users could exhaust the tags
> and starve a non-active and waiting-tag hctx. Count the hctx as
> active before try to allocate tag to fix this.

This patch looks fine.

>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae44e85..acd40eb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -369,6 +369,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>                         e->type->ops.mq.limit_depth(op, data);
>         }
>
> +       blk_mq_tag_busy(data.hctx);
> +

blk_mq_tag_busy is only required for driver tag.

Thanks,
Ming Lei
