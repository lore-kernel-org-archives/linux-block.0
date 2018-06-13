Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Wed, 13 Jun 2018 05:58:01 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com
Cc: Jens Axboe <axboe@kernel.dk>, Coly Li <colyli@suse.de>,
	linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [RFC] cleanup bcache bio handling
Message-ID: <20180613095801.GB15100@kmo-pixel>
References: <20180611194806.13222-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180611194806.13222-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 11, 2018 at 09:48:00PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up various places where bcache is way too intimate
> with bio internals.  This is intended as a baseline for the multi-page
> biovec work, which requires some nasty workarounds for the existing
> code.
> 
> Note that I do not have a bcache test setup, so this will require
> some careful actual testing with whatever test cases are used for
> bcache.
> 
> Also the new bio_reused helper should be useful at least for MD raid,
> but that work is left for later.

Strong nak on the patch series (except for the patch to not clone in
bch_data_verify, that patch looks fine).

Unless something has seriously changed with how multi-page bvecs work since I
started that code nothing in bcache should be broken by it - Ming, can you
confirm or deny if that's still correct?

It is true that bch_bio_map() will be suboptimal when multi page bvecs go in,
but it won't be broken. The way it's used now is really conflating two different
things, but where it's used for mapping a bio to a single buffer (i.e. not
before bio_alloc_pages) that can be switched to something that just creates a
single bvec.
