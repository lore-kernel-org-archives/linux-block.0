Return-Path: <ming.lei@redhat.com>
Date: Mon, 5 Nov 2018 11:41:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Rui Salvaterra <rsalvaterra@gmail.com>,
	stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
	Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: Re: [PATCH V2 0/3] block: make sure discard/writesame bio is aligned
 with logical block size
Message-ID: <20181105034143.GE13699@ming.t460p>
References: <20181029125719.4998-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181029125719.4998-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Oct 29, 2018 at 08:57:16PM +0800, Ming Lei wrote:
> Hi,
> 
> The 1st & 3rd patch fixes bio size alignment issue.
> 
> The 2nd patch cleans up __blkdev_issue_discard() a bit.
> 
> V2:
> 	- introduce helper of bio_allowed_max_sectors()
> 	- add commit log for patch 2
> 
> 
> Ming Lei (3):
>   block: make sure discard bio is aligned with logical block size
>   block: cleanup __blkdev_issue_discard()
>   block: make sure writesame bio is aligned with logical block size
> 
>  block/blk-lib.c   | 26 +++++++-------------------
>  block/blk-merge.c |  3 ++-
>  block/blk.h       | 10 ++++++++++
>  3 files changed, 19 insertions(+), 20 deletions(-)
> 
> Cc: Rui Salvaterra <rsalvaterra@gmail.com>
> Cc: stable@vger.kernel.org
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Xiao Ni <xni@redhat.com>
> Cc: Mariusz Dabrowski <mariusz.dabrowski@intel.com>

V2 addresses Christoph's comment by introducing bio_allowed_max_sectors().

Ping...

Thanks,
Ming
