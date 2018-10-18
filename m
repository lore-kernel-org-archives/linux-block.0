Return-Path: <willy@infradead.org>
Date: Thu, 18 Oct 2018 08:06:05 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 0/5] block: introduce helpers for allocating io buffer
 from slab
Message-ID: <20181018150605.GC32429@bombadil.infradead.org>
References: <20181018131817.11813-1-ming.lei@redhat.com>
 <20181018140342.GB32429@bombadil.infradead.org>
 <20181018140551.GA26500@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018140551.GA26500@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 04:05:51PM +0200, Christoph Hellwig wrote:
> On Thu, Oct 18, 2018 at 07:03:42AM -0700, Matthew Wilcox wrote:
> > Before we go down this road, could we have a discussion about what
> > hardware actually requires this?  Storage has this weird assumption that
> > I/Os must be at least 512 byte aligned in memory, and I don't know where
> > this idea comes from.  Network devices can do arbitrary byte alignment.
> > Even USB controllers can do arbitrary byte alignment.  Sure, performance
> > is going to suck and there are definite risks on some architectures
> > with doing IOs that are sub-cacheline aligned, but why is storage such a
> > special snowflake that we assume that host controllers are only capable
> > of doing 512-byte aligned DMAs?
> 
> Actually most storage controllers requires 4-byte alignment, but there is
> a significant subset that requires 512-byte alignment.

Can you name one that does require 512-byte alignment, preferably still
in use?  Or even >4-byte alignment.  I just checked AHCI and that requires
only 2-byte alignment.

I have reason to believe that these are uncommon because of the feedback
we got in the NVMe committee after releasing 1.0 which required 4-byte
alignment from people whining that they just couldn't guarantee 4-byte
alignment in their host devices and they absolutely needed to have no
alignment requirements (!)
