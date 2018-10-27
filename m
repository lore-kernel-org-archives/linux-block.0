Return-Path: <hare@suse.de>
Subject: Re: [PATCH 02/28] ms_block: convert to blk-mq
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
Cc: Maxim Levitsky <maximlevitsky@gmail.com>
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-3-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <62dc7b38-1389-a2b5-7fe7-b3d0c92ea4cc@suse.de>
Date: Sat, 27 Oct 2018 12:43:34 +0200
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Straight forward conversion, room for optimization in how everything
> is punted to a work queue. Also looks plenty racy all over the map,
> with the state changes. I fixed a bunch of them up while doing the
> conversion, but there are surely more.
> 
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   drivers/memstick/core/ms_block.c | 110 +++++++++++++++++--------------
>   drivers/memstick/core/ms_block.h |   1 +
>   2 files changed, 62 insertions(+), 49 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
