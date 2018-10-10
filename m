Return-Path: <hch@lst.de>
Date: Wed, 10 Oct 2018 15:26:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH 04/11] block: Introduce blkdev_nr_zones() helper
Message-ID: <20181010132639.GD22273@lst.de>
References: <20181010015239.24930-1-damien.lemoal@wdc.com> <20181010015239.24930-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181010015239.24930-5-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 10, 2018 at 10:52:32AM +0900, Damien Le Moal wrote:
> Introduce the blkdev_nr_zones() helper function to get the total
> number of zones of a zoned block device. This number is always 0 for a
> regular block device (q->limits.zoned == BLK_ZONED_NONE case).
> 
> Replace hard-coded number of zones calculation in dmz_get_zoned_device()
> with a call to this helper.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
