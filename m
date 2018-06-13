Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Wed, 13 Jun 2018 10:49:52 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
	linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: add a bio_reuse helper
Message-ID: <20180613144952.GA17292@kmo-pixel>
References: <20180611194806.13222-1-hch@lst.de>
 <20180611194806.13222-2-hch@lst.de>
 <20180612061629.GA19281@kmo-pixel>
 <20180613073204.GA22435@lst.de>
 <20180613085441.GA15100@kmo-pixel>
 <20180613135915.GC32418@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613135915.GC32418@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 13, 2018 at 03:59:15PM +0200, Christoph Hellwig wrote:
> On Wed, Jun 13, 2018 at 04:54:41AM -0400, Kent Overstreet wrote:
> > bi_size is not immutable though, it will usually be modified by drivers when you
> > submit a bio.
> > 
> > I see what you're trying to do, but your approach is busted given the way the
> > block layer works today. You'd have to save bio->bi_iter before submitting the
> > bio and restore it afterwards for it to work.
> 
> For bi_size, agreed this needs fixing.  bi_sector is always restored
> already by the callers, and the remaining fields are zeroed by bio_reset,
> which does the right thing.

This still shouldn't be a new helper. If the caller is restoring bi_sector they
can restore bi_size as well, and restoring only part of bi_iter should not be
encouraged as it's not safe in general - it is a quite reasonable thing to want
to restore a bio to the state it was pre submission (e.g. for bouncing) and what
you're doing is definitely _not_ safe in general.
