Return-Path: <hch@lst.de>
Date: Wed, 17 Oct 2018 08:14:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Richard Weinberger <richard@nod.at>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	"linux-mtd @ lists . infradead . org" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH, RFC] ubd: remove use of blk_rq_map_sg
Message-ID: <20181017061418.GA21790@lst.de>
References: <20181015065637.1860-1-hch@lst.de> <CAFLxGvwx4TPTHRY91LMBdd7h4pgCjw2zY7Q67r3CRHTqfzSB1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFLxGvwx4TPTHRY91LMBdd7h4pgCjw2zY7Q67r3CRHTqfzSB1w@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 17, 2018 at 12:43:14AM +0200, Richard Weinberger wrote:
> On Mon, Oct 15, 2018 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > There is no good reason to create a scatterlist in the ubd driver,
> > it can just iterate the request directly.
> 
> BTW: Does it make sense to drop blk_rq_map_sq from()
> drivers/mtd/ubi/block.c too?
> If so we have to allocate a temporary structure for the worker thread
> for each segment, just like
> UBD does already. I'm not sure if that is cheaper than blk_rq_map_sq().

UBI should not need a new per-thread structure, mostly because there
are no threads involved.  The scatterlist support in UBI only seems
to exists for ubiblock, but it goes down a few layers.  In the end
all that could switch to a iov_iter-like setup and clean things up
a lot, but it would be a fair amount of work.
