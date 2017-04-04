Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Block SQ/MQ Request Priority
To: adam.manzanares@wdc.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1491319514-6671-1-git-send-email-adam.manzanares@wdc.com>
Cc: hch@infradead.org, Bart.VanAssche@sandisk.com
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0ee226a2-0be5-0832-e92d-785ee8a480e1@kernel.dk>
Date: Tue, 4 Apr 2017 15:40:27 -0600
MIME-Version: 1.0
In-Reply-To: <1491319514-6671-1-git-send-email-adam.manzanares@wdc.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/04/2017 09:25 AM, adam.manzanares@wdc.com wrote:
> From: Adam Manzanares <adam.manzanares@wdc.com>
> 
> In 4.10 I introduced a patch that associates the ioc priority with
> each request in the block layer. This work was done in the single queue
> block layer code. This patch unifies ioc priority to request mapping across
> the single/multi queue block layers.
> 
> I have tested this patch with the null block device driver with the following
> parameters.
> 
> null_blk queue_mode=2 irqmode=0 use_per_node_hctx=1 nr_devices=1
> 
> I have not seen a performance regression with this patch and I would appreciate
> any feedback or additional testing.
> 
> I have also verified that io priorities are passed to the device when using
> the SQ and MQ path to a SATA HDD that supports io priorities.

Applied, with an updated subject line, it didn't really describe what
the patch does. Thanks.

-- 
Jens Axboe
