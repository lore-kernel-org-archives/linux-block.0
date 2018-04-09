Return-Path: <hch@lst.de>
Date: Mon, 9 Apr 2018 19:21:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, Bart.VanAssche@wdc.com,
	linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 7/7] block: use GFP_KERNEL for allocations from
	blk_get_request
Message-ID: <20180409172158.GB5697@lst.de>
References: <20180409153916.23901-1-hch@lst.de> <20180409153916.23901-8-hch@lst.de> <20180409165203.GE11756@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180409165203.GE11756@bombadil.infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 09, 2018 at 09:52:03AM -0700, Matthew Wilcox wrote:
> On Mon, Apr 09, 2018 at 05:39:16PM +0200, Christoph Hellwig wrote:
> > blk_get_request is used for pass-through style I/O and thus doesn't need
> > GFP_NOIO.
> 
> Obviously GFP_KERNEL is a big improvement over GFP_NOIO!  But can we take
> it all the way to GFP_USER, if this is always done in the ioctl path
> (which it seems to be, except for nfsd, which presumably won't have
> a cpuset memory allocation policy ... and if it did, the admin might
> appreciate it honouring said policy).

GFP_USER claims to be for allocations mapped into userspace, and except
for a few outliers that is how we use it.  I see no reason to change
that here.
