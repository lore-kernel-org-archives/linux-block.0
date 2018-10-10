Return-Path: <hch@lst.de>
Date: Wed, 10 Oct 2018 15:34:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH 11/11] block: Introduce revalidate_disk_zones()
Message-ID: <20181010133431.GJ22273@lst.de>
References: <20181010015239.24930-1-damien.lemoal@wdc.com> <20181010015239.24930-12-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181010015239.24930-12-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

> +static inline unsigned long *__alloc_zone_bitmap(int node,
> +						 unsigned int nr_zones)
> +{
> +	return kcalloc_node(BITS_TO_LONGS(nr_zones), sizeof(unsigned long),
> +			    GFP_NOIO | __GFP_ZERO, node);

kcalloc already implies GFP_NOIO.

> +/*
> + * Allocate an array of struct blk_zone to get nr_zones zone information.
> + * The allocated array may be smaller than nr_zones.
> + */
> +static struct blk_zone *__alloc_zones(int node, unsigned int *nr_zones)

Any reason to have the __ prefix for these two functions?  A blk_ one
would seem more sensible.

> +/**
> + * revalidate_disk_zones - (re)allocate and initialize zone bitmaps
> + * @disk:	Target disk
> + *
> + * Description:
> + *    Helper function for low-level device drivers to (re) allocate and
> + *    initialize a disk request queue zone bitmaps. This functions should
> + *    normally be called within the disk ->revalidate method.
> + *    For BIO based queues, no zone bitmap is allocated.
> + */
> +int revalidate_disk_zones(struct gendisk *disk)

Add a blk_ prefix?

Also no need for the Description: header in the kerneldoc comment.
