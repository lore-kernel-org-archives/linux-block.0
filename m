Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Add locking annotations to hctx_lock() and
 hctx_unlock()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Tejun Heo <tj@kernel.org>
References: <20180110193427.6601-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0c2e7dbf-b124-f448-ea39-51e1de4aa682@kernel.dk>
Date: Wed, 10 Jan 2018 12:36:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180110193427.6601-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 12:34 PM, Bart Van Assche wrote:
> This patch avoids that sparse reports the following:
> 
> block/blk-mq.c:637:33: warning: context imbalance in 'hctx_unlock' - unexpected unlock
> block/blk-mq.c:642:9: warning: context imbalance in 'hctx_lock' - wrong count at exit

Thanks Bart, applied.

-- 
Jens Axboe
