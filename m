Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] blk-mq: use EWMA to estimate congestion threshold
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
 Sagi Grimberg <sagi@grimberg.me>
References: <20170711182103.11461-1-ming.lei@redhat.com>
 <20170711182103.11461-5-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <db7526a0-d534-8bc2-93de-546f4dabccfb@kernel.dk>
Date: Tue, 11 Jul 2017 12:25:16 -0600
MIME-Version: 1.0
In-Reply-To: <20170711182103.11461-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 07/11/2017 12:21 PM, Ming Lei wrote:
> When .queue_rq() returns BLK_STS_RESOURCE(BUSY), we can
> consider that there is congestion in either low level
> driver or hardware.
> 
> This patch uses EWMA to estimate this congestion threshold,
> then this threshold can be used to detect/avoid congestion.

This whole patch set lacks some sort of reasoning why this
makes sense. I'm assuming you want to reduce unnecessary
restarts of the queue? I would much rather ensure that we only
start when we absolutely have to to begin with, I'm pretty sure
we have a number of cases where that is not so.

What happens with fluid congestion boundaries, with shared tags?

-- 
Jens Axboe
