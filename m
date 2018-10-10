Return-Path: <hch@lst.de>
Date: Wed, 10 Oct 2018 15:28:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH 09/11] block: Expose queue nr_zones in sysfs
Message-ID: <20181010132836.GI22273@lst.de>
References: <20181010015239.24930-1-damien.lemoal@wdc.com> <20181010015239.24930-10-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181010015239.24930-10-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 10, 2018 at 10:52:37AM +0900, Damien Le Moal wrote:
> Expose through sysfs the nr_zones field of a zoned block device request
> queue. This represents the total number of zones of the device
> calculated using the known disk capacity and zone size.
> 
> Exposing this value helps in debugging disk issues as well as
> facilitating scripts based use of the disk (e.g. blktests).

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
