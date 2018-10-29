Return-Path: <hare@suse.de>
Subject: Re: [PATCH 16/28] blk-cgroup: remove legacy queue bypassing
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-17-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <20913e63-f631-deb1-406e-36a64319a06a@suse.de>
Date: Mon, 29 Oct 2018 08:00:13 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-17-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> We only support mq devices now.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-cgroup.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
