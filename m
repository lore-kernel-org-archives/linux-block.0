Return-Path: <msnitzer@redhat.com>
Date: Fri, 19 Jan 2018 12:21:27 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/3] blk-mq: Avoid that blk_mq_delay_run_hw_queue()
 introduces unintended delays
Message-ID: <20180119172127.GB29664@redhat.com>
References: <20180119165856.17677-1-bart.vanassche@wdc.com>
 <20180119165856.17677-3-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180119165856.17677-3-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jan 19 2018 at 11:58am -0500,
Bart Van Assche <bart.vanassche@wdc.com> wrote:

> Make sure that calling blk_mq_run_hw_queue() or
> blk_mq_kick_requeue_list() triggers a queue run without delay even
> if blk_mq_delay_run_hw_queue() has been called recently and if its
> delay has not yet expired.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>
