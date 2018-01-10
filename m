Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Explain when 'active_queues' is decremented
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Johannes Thumshirn <jthumshirn@suse.de>
References: <20180110163333.14345-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <34dffec4-0733-5440-9ae0-cf2efa41f476@kernel.dk>
Date: Wed, 10 Jan 2018 09:45:38 -0700
MIME-Version: 1.0
In-Reply-To: <20180110163333.14345-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/10/18 9:33 AM, Bart Van Assche wrote:
> It is nontrivial to derive from the blk-mq source code when
> blk_mq_tags.active_queues is decremented. Hence add a comment that
> explains this.

That is how it works, applied the patch, thanks Bart.

-- 
Jens Axboe
