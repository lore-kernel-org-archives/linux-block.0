Return-Path: <hare@suse.de>
Subject: Re: [PATCH 03/28] mspro_block: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-4-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <bf1fb1b1-ada5-64f5-14b5-b68eee40af76@suse.de>
Date: Sat, 27 Oct 2018 12:44:28 +0200
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-4-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Straight forward conversion, there's room for improvement.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/memstick/core/mspro_block.c | 121 +++++++++++++++-------------
>   1 file changed, 66 insertions(+), 55 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
