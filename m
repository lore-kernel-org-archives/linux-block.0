Return-Path: <hch@lst.de>
Date: Wed, 13 Jun 2018 15:59:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: add a bio_reuse helper
Message-ID: <20180613135915.GC32418@lst.de>
References: <20180611194806.13222-1-hch@lst.de> <20180611194806.13222-2-hch@lst.de> <20180612061629.GA19281@kmo-pixel> <20180613073204.GA22435@lst.de> <20180613085441.GA15100@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613085441.GA15100@kmo-pixel>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 13, 2018 at 04:54:41AM -0400, Kent Overstreet wrote:
> bi_size is not immutable though, it will usually be modified by drivers when you
> submit a bio.
> 
> I see what you're trying to do, but your approach is busted given the way the
> block layer works today. You'd have to save bio->bi_iter before submitting the
> bio and restore it afterwards for it to work.

For bi_size, agreed this needs fixing.  bi_sector is always restored
already by the callers, and the remaining fields are zeroed by bio_reset,
which does the right thing.
