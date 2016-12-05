Return-Path: <BATV+942a091854393eb11ca5+4852+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 5 Dec 2016 05:06:31 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Re: [PATCH 2/7] cfq-iosched: use appropriate run queue function
Message-ID: <20161205130631.GB7100@infradead.org>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-3-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480734921-23701-3-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 02, 2016 at 08:15:16PM -0700, Jens Axboe wrote:
> For MQ devices, we have to use other functions to run the queue.
> No functional changes in this patch, just a prep patch for
> support legacy schedulers on blk-mq.

I don't think supporting CFQ on blk-mq makes any sense.  Even if we
for some reason reuse existing scheduler (something I'm not in favour
except as bringup vehicle) we should limit it to deadline and in the
(hopefully near) future BFQ.
