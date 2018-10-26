Return-Path: <hch@lst.de>
Date: Fri, 26 Oct 2018 09:45:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Xiao Ni <xni@redhat.com>,
	Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: Re: [PATCH 2/3] block: cleanup __blkdev_issue_discard()
Message-ID: <20181026074515.GB4660@lst.de>
References: <20181026062435.21398-1-ming.lei@redhat.com> <20181026062435.21398-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181026062435.21398-3-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 26, 2018 at 02:24:34PM +0800, Ming Lei wrote:
> Cleanup __blkdev_issue_discard().

It would help to explain what you clean up..

> +		unsigned int req_sects = min(nr_sects, (UINT_MAX >> 9) & ~bs_mask);

This creates an overly long line.
