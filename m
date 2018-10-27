Return-Path: <hare@suse.de>
Subject: Re: [PATCH 06/28] blk-mq: remove the request_list usage
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-7-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <0371aa17-9253-29db-7846-97fff4bc85b8@suse.de>
Date: Sat, 27 Oct 2018 12:52:17 +0200
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-7-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> We don't do anything with it, that's just the legacy path.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
