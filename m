Return-Path: <hare@suse.de>
Subject: Re: [PATCH 06/14] blk-mq: add 'type' attribute to the sysfs hctx
 directory
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-7-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c0a1ab79-bb88-f422-4c8b-c065046c2987@suse.de>
Date: Mon, 29 Oct 2018 08:38:05 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-7-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> It can be useful for a user to verify what type a given hardware
> queue is, expose this information in sysfs.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq-sysfs.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
