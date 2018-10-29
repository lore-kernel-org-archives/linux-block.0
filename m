Return-Path: <hare@suse.de>
Subject: Re: [PATCH 07/29] blk-mq: provide mq_ops->busy() hook
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181029163444.9940-1-axboe@kernel.dk>
 <20181029163444.9940-8-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fe0e50b6-f7ac-d154-e6ee-fff475a3f176@suse.de>
Date: Mon, 29 Oct 2018 17:56:57 +0100
MIME-Version: 1.0
In-Reply-To: <20181029163444.9940-8-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/29/18 5:34 PM, Jens Axboe wrote:
> We'll hook into this from blk_lld_busy(), allowing blk-mq to also
> return whether or not a given queue currently has requests in
> progress.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-core.c       | 2 ++
>   include/linux/blk-mq.h | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
