Return-Path: <hch@lst.de>
Date: Thu, 18 Oct 2018 16:05:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>, xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 0/5] block: introduce helpers for allocating io buffer
 from slab
Message-ID: <20181018140551.GA26500@lst.de>
References: <20181018131817.11813-1-ming.lei@redhat.com> <20181018140342.GB32429@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181018140342.GB32429@bombadil.infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 18, 2018 at 07:03:42AM -0700, Matthew Wilcox wrote:
> Before we go down this road, could we have a discussion about what
> hardware actually requires this?  Storage has this weird assumption that
> I/Os must be at least 512 byte aligned in memory, and I don't know where
> this idea comes from.  Network devices can do arbitrary byte alignment.
> Even USB controllers can do arbitrary byte alignment.  Sure, performance
> is going to suck and there are definite risks on some architectures
> with doing IOs that are sub-cacheline aligned, but why is storage such a
> special snowflake that we assume that host controllers are only capable
> of doing 512-byte aligned DMAs?

Actually most storage controllers requires 4-byte alignment, but there is
a significant subset that requires 512-byte alignment.
