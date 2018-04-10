Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v2] blk-mq: Avoid that submitting a bio concurrently with
 device removal triggers a crash
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20180410204554.28914-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <038bad34-0cdc-b97a-adff-c07e5fb4b98a@kernel.dk>
Date: Tue, 10 Apr 2018 16:35:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180410204554.28914-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/10/18 2:45 PM, Bart Van Assche wrote:
> Because blkcg_exit_queue() is now called from inside blk_cleanup_queue()
> it is no longer safe to access cgroup information during or after the
> blk_cleanup_queue() call. Hence protect the generic_make_request_checks()
> call with blk_queue_enter() / blk_queue_exit().

This looks better. But can we please get rid of the ternary? I hate it
with a vengeance, especially when it ends up spanning multiple lines.
This:

flags = 0;
if (bio->bi_opf & REQ_NOWAIT)
	flags = BLK_MQ_REQ_NOWAIT;

is so much more readable.

-- 
Jens Axboe
