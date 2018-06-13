Return-Path: <hch@lst.de>
Date: Wed, 13 Jun 2018 09:32:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/6] block: add a bio_reuse helper
Message-ID: <20180613073204.GA22435@lst.de>
References: <20180611194806.13222-1-hch@lst.de> <20180611194806.13222-2-hch@lst.de> <20180612061629.GA19281@kmo-pixel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180612061629.GA19281@kmo-pixel>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 12, 2018 at 02:16:30AM -0400, Kent Overstreet wrote:
> On Mon, Jun 11, 2018 at 09:48:01PM +0200, Christoph Hellwig wrote:
> > This abstracts out a way to reuse a bio without destroying the
> > data pointers.
> 
> What is the point of this? What "data pointers" does it not destroy?

It keeps bi_vcnt and bi_size intact in addition to bi_max_vecs/bi_io_vec
already kept by the existing bio_reset.

The befit is that you don't need to rebuild bi_vcnt, bio_io_vec and
bi_size when reusing the bio.
