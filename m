Return-Path: <hch@lst.de>
Date: Thu, 12 Apr 2018 08:27:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v3] blk-mq: Avoid that submitting a bio concurrently
	with device removal triggers a crash
Message-ID: <20180412062748.GC30499@lst.de>
References: <20180410230240.27709-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180410230240.27709-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 10, 2018 at 05:02:40PM -0600, Bart Van Assche wrote:
> Because blkcg_exit_queue() is now called from inside blk_cleanup_queue()
> it is no longer safe to access cgroup information during or after the
> blk_cleanup_queue() call. Hence protect the generic_make_request_checks()
> call with blk_queue_enter() / blk_queue_exit().

I think the problem is that blkcg does weird things from
blk_cleanup_queue.  I'd rather fix that root cause than working around it.
