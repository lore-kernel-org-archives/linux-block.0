Return-Path: <hch@lst.de>
Date: Wed, 10 Oct 2018 15:27:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Matias Bjorling <matias.bjorling@wdc.com>
Subject: Re: [PATCH 06/11] block: Introduce BLKGETZONESZ ioctl
Message-ID: <20181010132726.GF22273@lst.de>
References: <20181010015239.24930-1-damien.lemoal@wdc.com> <20181010015239.24930-7-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181010015239.24930-7-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Oct 10, 2018 at 10:52:34AM +0900, Damien Le Moal wrote:
> Get a zoned block device zone size in number of 512 B sectors.
> The zone size is always 0 for regular block devices.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
