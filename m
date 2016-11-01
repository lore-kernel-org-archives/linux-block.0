Return-Path: <hch@lst.de>
Date: Tue, 1 Nov 2016 18:06:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: block device direct I/O fast path
Message-ID: <20161101170636.GA22639@lst.de>
References: <1477936765-8828-1-git-send-email-hch@lst.de> <20161101170019.GB9797@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161101170019.GB9797@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Tue, Nov 01, 2016 at 11:00:19AM -0600, Jens Axboe wrote:
> #2 is a bit more problematic, I'm pondering how we can implement that on
> top of the bio approach. The nice thing about the request based approach
> is that we have a 1:1 mapping with the unit on the driver side. And we
> have a place to store the timer. I don't particularly love the embedded
> timer, however, it'd be great to implement that differently. Trying to
> think of options there, haven't found any yet.

I have a couple ideas for that.  Give me a few weeks and I'll send
patches.
