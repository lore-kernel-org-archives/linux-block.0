Return-Path: <BATV+ac864a57ff6e79c7caf1+5530+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 14 Oct 2018 11:49:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH 12/17] blk-mq-sched: export way for drivers to insert
 request
Message-ID: <20181014184935.GA1944@infradead.org>
References: <20181011165909.32615-1-axboe@kernel.dk>
 <20181011165909.32615-13-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181011165909.32615-13-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 11, 2018 at 10:59:04AM -0600, Jens Axboe wrote:
> We'll need this for the IDE conversion, which queues sense requests.

Why can't the ide code use blk_execute_rq_nowait?
