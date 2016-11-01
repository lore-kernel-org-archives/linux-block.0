Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 1 Nov 2016 11:00:19 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: block device direct I/O fast path
Message-ID: <20161101170019.GB9797@kernel.dk>
References: <1477936765-8828-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477936765-8828-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 31 2016, Christoph Hellwig wrote:
> Hi Jens,
> 
> this small series adds a fasth path to the block device direct I/O
> code.  It uses new magic created by Kent to avoid allocating an array
> for the pages, and as part of that allows small, non-aio direct I/O
> requests to be done without memory allocations or atomic ops and with
> a minimal cache footprint.  It's basically a cut down version of the
> new iomap direct I/O code, and in the future it might also make sense
> to move the main direct I/O code to a similar model.  But indepedent
> of that it's always worth to optimize the case of small, non-I/O
> requests as allocating the bio and biovec on stack and a trivial
> completion handler will always win over a full blown implementation.

I'm not particularly tied to the request based implementation that I did
here:

http://git.kernel.dk/cgit/linux-block/log/?h=blk-dio

I basically wanted to solve two problems with that:

1) The slow old direct-io.c code
2) Implement the hybrid polling

#1 is accomplished with your code as well, though it does lack suppor
for async IO, but that would not be hard to add.

#2 is a bit more problematic, I'm pondering how we can implement that on
top of the bio approach. The nice thing about the request based approach
is that we have a 1:1 mapping with the unit on the driver side. And we
have a place to store the timer. I don't particularly love the embedded
timer, however, it'd be great to implement that differently. Trying to
think of options there, haven't found any yet.

-- 
Jens Axboe
