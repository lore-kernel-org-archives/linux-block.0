Return-Path: <hch@lst.de>
Date: Tue, 28 Feb 2017 17:02:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
	Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 0/3] Separate zone requests from medium access requests
Message-ID: <20170228160259.GA22755@lst.de>
References: <20170228102535.15966-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170228102535.15966-1-damien.lemoal@wdc.com>
List-ID: <linux-block@vger.kernel.org>

I don't really like this too much - this is too many SCSI specifics
for the block layer to care.  Maybe using bios for the zone ops was a
mistake after all, and we should just have operations in struct block_device
instead..
