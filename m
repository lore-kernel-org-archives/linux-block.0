Return-Path: <jack@suse.cz>
Date: Thu, 2 Feb 2017 14:32:41 +0100
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/4] block: Dynamically allocate and refcount
 backing_dev_info
Message-ID: <20170202133241.GA15545@quack2.suse.cz>
References: <20170131125429.14303-1-jack@suse.cz>
 <20170131125429.14303-4-jack@suse.cz>
 <20170201095007.GC17386@infradead.org>
 <20170201122257.GE11567@quack2.suse.cz>
 <53f2bb8c-d4e6-7af9-2250-cccdf520660b@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53f2bb8c-d4e6-7af9-2250-cccdf520660b@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Wed 01-02-17 14:45:20, Jens Axboe wrote:
> On 02/01/2017 04:22 AM, Jan Kara wrote:
> > On Wed 01-02-17 01:50:07, Christoph Hellwig wrote:
> >> On Tue, Jan 31, 2017 at 01:54:28PM +0100, Jan Kara wrote:
> >>> Instead of storing backing_dev_info inside struct request_queue,
> >>> allocate it dynamically, reference count it, and free it when the last
> >>> reference is dropped. Currently only request_queue holds the reference
> >>> but in the following patch we add other users referencing
> >>> backing_dev_info.
> >>
> >> Do we really need the separate slab cache?  Otherwise this looks
> >> fine to me.
> > 
> > Yeah, probably it is not worth it. I'll remove it.
> 
> I agree on that, it should not be a hot path. Will you respin the series
> after making this change? Would be great to get this queued up.

Yes, will send it later today. I was just waiting whether someone else does
not have more comments to the series.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
