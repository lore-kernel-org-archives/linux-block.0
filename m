Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v3] blk-mq: Avoid that submitting a bio concurrently with
 device removal triggers a crash
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20180410230240.27709-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d94ff79d-f8ed-7432-088a-c6b4a778c3ae@kernel.dk>
Date: Tue, 10 Apr 2018 17:46:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180410230240.27709-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/10/18 5:02 PM, Bart Van Assche wrote:
> Because blkcg_exit_queue() is now called from inside blk_cleanup_queue()
> it is no longer safe to access cgroup information during or after the
> blk_cleanup_queue() call. Hence protect the generic_make_request_checks()
> call with blk_queue_enter() / blk_queue_exit().

Looks good, applied.

-- 
Jens Axboe
