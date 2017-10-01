Return-Path: <BATV+17fc60db2b26bb61bafd+5152+infradead.org+hch@bombadil.srs.infradead.org>
Date: Sun, 1 Oct 2017 01:37:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: wire up completion notifier for laptop mode
Message-ID: <20171001083707.GA32648@infradead.org>
References: <05155e41-caab-0ff4-8520-5eff59c9cf7a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <05155e41-caab-0ff4-8520-5eff59c9cf7a@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Sat, Sep 30, 2017 at 10:06:45AM +0200, Jens Axboe wrote:
> For some reason, the laptop mode IO completion notified was never wired
> up for blk-mq. Ensure that we trigger the callback appropriately, to arm
> the laptop mode flush timer.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
