Return-Path: <hare@suse.de>
Subject: Re: [PATCH 15/28] blk-wbt: kill check for legacy queue type
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-16-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <18bded6f-1ef0-836b-19ad-5698645f14d6@suse.de>
Date: Mon, 29 Oct 2018 07:59:34 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-16-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Everything is blk-mq at this point, so it doesn't make any sense
> to have this option available as it does nothing.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/Kconfig   | 6 ------
>   block/blk-wbt.c | 3 +--
>   2 files changed, 1 insertion(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
