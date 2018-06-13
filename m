Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Wed, 13 Jun 2018 10:54:09 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [RFC] cleanup bcache bio handling
Message-ID: <20180613145409.GB17292@kmo-pixel>
References: <20180611194806.13222-1-hch@lst.de>
 <20180613095801.GB15100@kmo-pixel>
 <20180613110640.GA9712@ming.t460p>
 <20180613135632.GB32418@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180613135632.GB32418@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 13, 2018 at 03:56:32PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 13, 2018 at 07:06:41PM +0800, Ming Lei wrote:
> > > before bio_alloc_pages) that can be switched to something that just creates a
> > > single bvec.
> > 
> > Yes, multipage bvec shouldn't break any driver or fs.
> 
> It probably isn't broken, at least I didn't see assumptions of the same
> number of segments.  However the current poking into the bio internals as
> a bad idea for a couple of reasons.  First because it requires touching
> bcache for any of these changes, second because it won't get merging of
> pages into a single bio segment for bіos built by bch_bio_map or
> bch_bio_alloc_pages, and third bcache is the last user of
> bio_for_each_chunk_all in your branch, which I'd like to kill off to
> keep the number of iterators down.

Agreed about bio_for_each_chunk_all(), but I just looked at the patch that
introduces them and it looks to me like there's no need, they should just be
bio_for_each_segment_all().

Converting bch_bio_map() and bch_bio_alloc_pages() to bio_add_page() is fine by
me, but your patch series doesn't do any of those actual cleanups: your
description of the patch series does not actually match what it does.
