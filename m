Return-Path: <hch@lst.de>
Date: Wed, 10 Oct 2018 15:27:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH 07/11] block: Introduce BLKGETNRZONES ioctl
Message-ID: <20181010132737.GG22273@lst.de>
References: <20181010015239.24930-1-damien.lemoal@wdc.com> <20181010015239.24930-8-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181010015239.24930-8-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 10, 2018 at 10:52:35AM +0900, Damien Le Moal wrote:
> Get a zoned block device total number of zones. The device can be a
> partition of the whole device. The number of zones is always 0 for
> regular block devices.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
