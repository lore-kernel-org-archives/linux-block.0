Return-Path: <hare@suse.de>
Subject: Re: [PATCH 25/28] block: kill request slab cache
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-26-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <23072f96-982c-dbef-de5e-4603ea2c5269@suse.de>
Date: Mon, 29 Oct 2018 08:11:28 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-26-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-core.c | 8 --------
>   block/blk.h      | 1 -
>   2 files changed, 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
