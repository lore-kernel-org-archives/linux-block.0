Return-Path: <hch@lst.de>
Date: Fri, 26 Oct 2018 09:44:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>, stable@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Xiao Ni <xni@redhat.com>,
	Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: Re: [PATCH 1/3] block: make sure discard bio is aligned with
 logical block size
Message-ID: <20181026074415.GA4660@lst.de>
References: <20181026062435.21398-1-ming.lei@redhat.com> <20181026062435.21398-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181026062435.21398-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

>  		if (req_sects > UINT_MAX >> 9)
> -			req_sects = UINT_MAX >> 9;
> +			req_sects = (UINT_MAX >> 9) & ~bs_mask;

Given that we have this same thing duplicated in write zeroes
what about a documented helper?
