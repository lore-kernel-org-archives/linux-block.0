Return-Path: <willy@infradead.org>
Date: Thu, 18 Oct 2018 07:03:42 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 0/5] block: introduce helpers for allocating io buffer
 from slab
Message-ID: <20181018140342.GB32429@bombadil.infradead.org>
References: <20181018131817.11813-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018131817.11813-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 09:18:12PM +0800, Ming Lei wrote:
> Hi,
> 
> Filesystems may allocate io buffer from slab, and use this buffer to
> submit bio. This way may break storage drivers if they have special
> requirement on DMA alignment.

Before we go down this road, could we have a discussion about what
hardware actually requires this?  Storage has this weird assumption that
I/Os must be at least 512 byte aligned in memory, and I don't know where
this idea comes from.  Network devices can do arbitrary byte alignment.
Even USB controllers can do arbitrary byte alignment.  Sure, performance
is going to suck and there are definite risks on some architectures
with doing IOs that are sub-cacheline aligned, but why is storage such a
special snowflake that we assume that host controllers are only capable
of doing 512-byte aligned DMAs?

I just dragged out the NCR53c810 data sheet from 1993, and it's capable of
doing arbitrary alignment of DMA.  NVMe is capable of 4-byte aligned DMA.
What hardware needs this 512 byte alignment?
