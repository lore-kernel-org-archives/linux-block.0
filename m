Return-Path: <hare@suse.de>
Subject: Re: [PATCH 01/28] sunvdc: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: David Miller <davem@davemloft.net>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-2-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <f9818f77-c7a7-16c3-7e83-52170e68cc14@suse.de>
Date: Sat, 27 Oct 2018 12:42:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-2-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Convert from the old request_fn style driver to blk-mq.
> 
> Cc: David Miller <davem@davemloft.net>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/block/sunvdc.c | 149 +++++++++++++++++++++++++++--------------
>   1 file changed, 98 insertions(+), 51 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
