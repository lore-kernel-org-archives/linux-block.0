Return-Path: <hch@lst.de>
Date: Wed, 2 Nov 2016 15:54:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH 3/4] blk-mq: implement hybrid poll mode for sync
	O_DIRECT
Message-ID: <20161102145459.GD13964@lst.de>
References: <1478034325-28232-1-git-send-email-axboe@fb.com> <1478034325-28232-4-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1478034325-28232-4-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 03:05:24PM -0600, Jens Axboe wrote:
> This patch enables a hybrid polling mode. Instead of polling after IO
> submission, we can induce an artificial delay, and then poll after that.
> For example, if the IO is presumed to complete in 8 usecs from now, we
> can sleep for 4 usecs, wake up, and then do our polling. This still puts
> a sleep/wakeup cycle in the IO path, but instead of the wakeup happening
> after the IO has completed, it'll happen before. With this hybrid
> scheme, we can achieve big latency reductions while still using the same
> (or less) amount of CPU.
> 
> Signed-off-by: Jens Axboe <axboe@fb.com>

This looks very nice.  I'll need to run some tests before giving the
formal ACK, though.
