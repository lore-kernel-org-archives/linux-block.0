Return-Path: <hare@suse.de>
Subject: Re: [PATCH 10/29] block: remove q->lld_busy_fn()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181029163444.9940-1-axboe@kernel.dk>
 <20181029163444.9940-11-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d187ebf6-3a73-ac40-0756-5cb0ad42c2c2@suse.de>
Date: Mon, 29 Oct 2018 17:58:06 +0100
MIME-Version: 1.0
In-Reply-To: <20181029163444.9940-11-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 5:34 PM, Jens Axboe wrote:
> Nobody is using the legacy path for blk_lld_busy() anymore, remove
> it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-core.c       | 2 --
>   block/blk-settings.c   | 6 ------
>   include/linux/blkdev.h | 3 ---
>   3 files changed, 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
