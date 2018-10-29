Return-Path: <hare@suse.de>
Subject: Re: [PATCH 28/28] block: get rid of blk_queued_rq()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-29-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <b8fae1df-7a4d-1eee-d76e-04e651ce2c3f@suse.de>
Date: Mon, 29 Oct 2018 08:12:52 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-29-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> No point in hiding what this does, just open code it in the
> one spot where we are still using it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c         | 2 +-
>   include/linux/blkdev.h | 2 --
>   2 files changed, 1 insertion(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
