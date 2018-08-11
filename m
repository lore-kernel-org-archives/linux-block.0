Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blkcg: Make blkg_root_lookup() work for queues in bypass
 mode
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>
References: <20180810202807.14620-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <136b0b15-c51d-77f9-087b-7baa92c092dd@kernel.dk>
Date: Sat, 11 Aug 2018 15:41:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180810202807.14620-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/10/18 2:28 PM, Bart Van Assche wrote:
> For legacy queues the only call of blkg_root_lookup() happens after
> bypass mode has been enabled. Since blkg_lookup() returns NULL for
> queues in bypass mode, modify the blkg_root_lookup() such that it
> no longer depends on bypass mode. Rename the function into
> blk_queue_root_blkg() as suggested by Tejun.

Applied, thanks.

-- 
Jens Axboe
