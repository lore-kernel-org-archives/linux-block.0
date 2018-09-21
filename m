Return-Path: <ming.lei@redhat.com>
Date: Fri, 21 Sep 2018 15:25:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <david@fromorbit.com>, Ming Lei <tom.leiming@gmail.com>,
	linux-block <linux-block@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"open list:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: block: DMA alignment of IO buffer allocated from slab
Message-ID: <20180921072511.GA8188@ming.t460p>
References: <CACVXFVOBq3L_EjSTCoiqUL1PH=HMR5EuNNQV0hNndFpGxmUK6g@mail.gmail.com>
 <20180921015608.GA31060@dastard>
 <20180921070805.GC14529@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180921070805.GC14529@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 21, 2018 at 09:08:05AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 21, 2018 at 11:56:08AM +1000, Dave Chinner wrote:
> > > 3) If slab can't guarantee to return 512-aligned buffer, how to fix
> > > this data corruption issue?
> > 
> > I think that the block layer needs to check the alignment of memory
> > buffers passed to it and take appropriate action rather than
> > corrupting random memory and returning a sucess status to the bad
> > bio.
> 
> Or just reject the I/O.  But yes, we already have the
> queue_dma_alignment helper in the block layer, we just don't do it
> in the fast path.  I think generic_make_request_checks needs to
> check it, and print an error and return a warning if the alignment
> requirement isn't met.

That can be done in generic_make_request_checks(), but some cost may be
introduced, because each bvec needs to be checked in the fast path.

Thanks,
Ming
