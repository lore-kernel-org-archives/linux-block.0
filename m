Return-Path: <hare@suse.de>
Subject: Re: [PATCH 14/28] block: remove blk_complete_request()
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-15-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0a37182b-db2c-4492-54f7-3f16bf545d06@suse.de>
Date: Mon, 29 Oct 2018 07:59:01 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-15-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> It's now unused.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-softirq.c    | 20 --------------------
>   include/linux/blkdev.h |  1 -
>   2 files changed, 21 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
