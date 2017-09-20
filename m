Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: Fix blk_mq_get_request() error path
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Ming Lei <ming.lei@redhat.com>, stable@vger.kernel.org
References: <20170920184704.20735-1-bart.vanassche@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <101a7cde-8597-ceb6-7a99-646e6fdea2a8@kernel.dk>
Date: Wed, 20 Sep 2017 12:51:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170920184704.20735-1-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 09/20/2017 12:47 PM, Bart Van Assche wrote:
> blk_mq_get_tag() can modify data->ctx. This means that in the
> error path of blk_mq_get_request() data->ctx should be passed to
> blk_mq_put_ctx() instead of local_ctx.

It's just a cosmetic thing, the only part that matters is that
we balance the get and put. I'd take this as a cleanup for
the next series, but not as a Fixes anything and definitely
not for stable.

-- 
Jens Axboe
