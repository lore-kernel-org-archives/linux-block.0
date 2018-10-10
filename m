Return-Path: <hch@lst.de>
Date: Wed, 10 Oct 2018 15:25:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH 01/11] scsi: sd_zbc: Rearrange code
Message-ID: <20181010132533.GA22273@lst.de>
References: <20181010015239.24930-1-damien.lemoal@wdc.com> <20181010015239.24930-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181010015239.24930-2-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 10, 2018 at 10:52:29AM +0900, Damien Le Moal wrote:
> Move the urswrz check out of sd_zbc_read_zones() and into
> sd_zbc_read_zoned_characteristics() where that value is obtained (read
> from the disk zoned characteristics VPD page). Since this function now
> does more than simply reading the VPD page, rename it to
> sd_zbc_check_zoned_characteristics().
> Also fix the error message displayed when reading that VPD page fails.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
