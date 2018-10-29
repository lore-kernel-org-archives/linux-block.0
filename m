Return-Path: <hare@suse.de>
Subject: Re: [PATCH 17/28] block: remove legacy rq tagging
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-18-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <a4dd85ee-5d28-3708-1e50-f3402678b2ba@suse.de>
Date: Mon, 29 Oct 2018 08:01:48 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-18-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> It's now unused, kill it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   Documentation/block/biodoc.txt |  88 --------
>   block/Makefile                 |   2 +-
>   block/blk-core.c               |   6 -
>   block/blk-mq-debugfs.c         |   2 -
>   block/blk-mq-tag.c             |   6 +-
>   block/blk-sysfs.c              |   3 -
>   block/blk-tag.c                | 378 ---------------------------------
>   include/linux/blkdev.h         |  35 ---
>   8 files changed, 3 insertions(+), 517 deletions(-)
>   delete mode 100644 block/blk-tag.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
