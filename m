Return-Path: <hare@suse.de>
Subject: Re: [PATCH 24/28] block: remove request_list code
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-25-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <57931473-6f94-1d56-e059-8558b7008a96@suse.de>
Date: Mon, 29 Oct 2018 08:10:55 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-25-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> It's now dead code, nobody uses it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-cgroup.c         |  47 ----------------
>   block/blk-core.c           |  75 --------------------------
>   block/blk-mq.c             |   4 --
>   block/blk.h                |   3 --
>   include/linux/blk-cgroup.h | 108 -------------------------------------
>   include/linux/blkdev.h     |  34 ------------
>   6 files changed, 271 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
