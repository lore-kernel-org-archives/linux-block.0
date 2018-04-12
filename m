Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 12 Apr 2018 08:37:48 -0700
From: Tejun Heo <tj@kernel.org>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Alexandru Moise <00moses.alexander00@gmail.com>
Subject: Re: [PATCH] block: Ensure that a request queue is dissociated from
 the cgroup controller
Message-ID: <20180412153748.GB793541@devbig577.frc2.facebook.com>
References: <20180412015852.26014-1-bart.vanassche@wdc.com>
 <20180412135149.GX793541@devbig577.frc2.facebook.com>
 <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <af6dafea-d754-8a0d-b96b-81716f2ea24d@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Bart.

On Thu, Apr 12, 2018 at 08:09:17AM -0600, Bart Van Assche wrote:
> I have retested hotunplugging by rerunning the srp-test software. It
> seems like you overlooked that this patch does not remove the
> blkcg_exit_queue() call from blk_cleanup_queue()? If a device is
> hotunplugged it is up to the block driver to call
> blk_cleanup_queue(). And blk_cleanup_queue() will call
> blkcg_exit_queue().

Hmm... what'd prevent blg_lookup_and_create() racing against that?

Thanks.

-- 
tejun
