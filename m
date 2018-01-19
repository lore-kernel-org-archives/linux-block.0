Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 0/3] Avoid that blk_mq_delay_run_hw_queue() introduces
 unintended delays
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
References: <20180119165856.17677-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <a2252aaa-4fb0-2c0b-fae1-fc5df7426068@kernel.dk>
Date: Fri, 19 Jan 2018 12:54:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180119165856.17677-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 1/19/18 9:58 AM, Bart Van Assche wrote:
> Hello Jens,
> 
> Earlier today it was agreed that a blk_mq_delay_run_hw_queue() call followed
> by a blk_mq_run_hw_queue() call should result in an immediate queue run. Hence
> this patch series. Please consider this patch series for kernel v4.16.

Thanks Bart, applied.

-- 
Jens Axboe
