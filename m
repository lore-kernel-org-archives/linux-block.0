Return-Path: <hch@lst.de>
Date: Wed, 23 Aug 2017 20:03:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 1/5] block: Warn if blk_queue_rq_timed_out() is called
	for a blk-mq queue
Message-ID: <20170823180309.GB5802@lst.de>
References: <20170823175633.12680-1-bart.vanassche@wdc.com> <20170823175633.12680-2-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170823175633.12680-2-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 23, 2017 at 10:56:29AM -0700, Bart Van Assche wrote:
> The timeout handler set by blk_queue_rq_timed_out() is only used
> in single queue mode. Calling this function for blk-mq drivers is
> wrong. Hence issue a warning if this function is called by a blk-mq
> driver.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
