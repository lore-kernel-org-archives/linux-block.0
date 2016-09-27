Return-Path: <shaun.tancheff@seagate.com>
MIME-Version: 1.0
In-Reply-To: <1474888483-29762-4-git-send-email-damien.lemoal@hgst.com>
References: <1474888483-29762-1-git-send-email-damien.lemoal@hgst.com> <1474888483-29762-4-git-send-email-damien.lemoal@hgst.com>
From: Shaun Tancheff <shaun.tancheff@seagate.com>
Date: Tue, 27 Sep 2016 16:12:42 -0500
Message-ID: <CAJVOszAx9cfuWeSsh_LE--SXKT6ur9ZTdAYk7dzpc7njP=K06w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] block: update chunk_sectors in blk_stack_limits()
To: Damien Le Moal <damien.lemoal@hgst.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 26, 2016 at 6:14 AM, Damien Le Moal <damien.lemoal@hgst.com> wrote:
> From: Hannes Reinecke <hare@suse.de>
>
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
> ---
>  block/blk-settings.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index b1d5b7f..55369a6 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -631,6 +631,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>                         t->discard_granularity;
>         }
>
> +       if (b->chunk_sectors)
> +               t->chunk_sectors = min_not_zero(t->chunk_sectors,
> +                                               b->chunk_sectors);
> +
>         return ret;
>  }
>  EXPORT_SYMBOL(blk_stack_limits);
> --
> 2.7.4

Reviewed-by: Shaun Tancheff <shaun.tancheff@seagate.com>
Tested-by: Shaun Tancheff <shaun.tancheff@seagate.com>


> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Shaun Tancheff
