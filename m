Return-Path: <BATV+c89273d3eea146e66f74+4831+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 14 Nov 2016 10:05:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCHSET] Add support for simplified async direct-io
Message-ID: <20161114180503.GA31126@infradead.org>
References: <1479144519-15738-1-git-send-email-axboe@fb.com>
 <20161114173728.GA22167@infradead.org>
 <71ce9ae3-214d-b248-3507-cc96bea41a9b@fb.com>
 <20161114180052.GA24476@infradead.org>
 <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4f30a528-9996-4c6a-9513-8aa2054e4d4b@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Nov 14, 2016 at 11:02:47AM -0700, Jens Axboe wrote:
> > We need it unless we want unbounded allocations for the biovec.  With a
> > 1GB I/O we're at a page size allocation, and with 64MB I/Os that aren't
> > unheard of we'd be up to a 64 pages or an order 6 allocation which will
> > take down the VM.  We also need to pin down all the user memory while
> > doing the I/O instead of having throttling on the bio mempool before
> > doing the get_user_pages.
> 
> Just add the iterator and loop for every X pages? We can even put a plug
> around it, if we have to.

That's pretty much what my patch does..
