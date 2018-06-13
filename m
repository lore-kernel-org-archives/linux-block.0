Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Wed, 13 Jun 2018 04:54:41 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
	linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: add a bio_reuse helper
Message-ID: <20180613085441.GA15100@kmo-pixel>
References: <20180611194806.13222-1-hch@lst.de>
 <20180611194806.13222-2-hch@lst.de>
 <20180612061629.GA19281@kmo-pixel>
 <20180613073204.GA22435@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613073204.GA22435@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 13, 2018 at 09:32:04AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 12, 2018 at 02:16:30AM -0400, Kent Overstreet wrote:
> > On Mon, Jun 11, 2018 at 09:48:01PM +0200, Christoph Hellwig wrote:
> > > This abstracts out a way to reuse a bio without destroying the
> > > data pointers.
> > 
> > What is the point of this? What "data pointers" does it not destroy?
> 
> It keeps bi_vcnt and bi_size intact in addition to bi_max_vecs/bi_io_vec
> already kept by the existing bio_reset.
> 
> The befit is that you don't need to rebuild bi_vcnt, bio_io_vec and
> bi_size when reusing the bio.

bi_size is not immutable though, it will usually be modified by drivers when you
submit a bio.

I see what you're trying to do, but your approach is busted given the way the
block layer works today. You'd have to save bio->bi_iter before submitting the
bio and restore it afterwards for it to work.
