Return-Path: <ming.lei@redhat.com>
Date: Sun, 28 Oct 2018 08:51:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>, stable@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>, Xiao Ni <xni@redhat.com>,
	Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: Re: [PATCH 1/3] block: make sure discard bio is aligned with logical
 block size
Message-ID: <20181028005130.GA26731@ming.t460p>
References: <20181026062435.21398-1-ming.lei@redhat.com>
 <20181026062435.21398-2-ming.lei@redhat.com>
 <20181026074415.GA4660@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181026074415.GA4660@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 26, 2018 at 09:44:15AM +0200, Christoph Hellwig wrote:
> >  		if (req_sects > UINT_MAX >> 9)
> > -			req_sects = UINT_MAX >> 9;
> > +			req_sects = (UINT_MAX >> 9) & ~bs_mask;
> 
> Given that we have this same thing duplicated in write zeroes
> what about a documented helper?

IMO, using UINT_MAX & bs_mask is better because it is self-explanatory
in the context.

If we introduce one helper, it may not be easy to find a better
name than UINT_MAX.

thanks,
Ming
