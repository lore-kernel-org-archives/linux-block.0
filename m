Return-Path: <hch@lst.de>
Date: Wed, 13 Sep 2017 22:17:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <Bart.VanAssche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V2 00/12] scsi-mq support for ZBC disks
Message-ID: <20170913201713.GA24926@lst.de>
References: <20170907161640.30465-1-damien.lemoal@wdc.com> <20170908082040.GA25719@lst.de> <c3305202-43d3-20e3-825a-ae5fff462d54@wdc.com> <20170911122411.GA22255@lst.de> <36d21ce8-543a-39ad-c729-30f9dbd383d0@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36d21ce8-543a-39ad-c729-30f9dbd383d0@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Sep 12, 2017 at 05:38:05PM +0900, Damien Le Moal wrote:
> struct blk_zoned {
> 	unsigned int nr_zones;
> 	unsigned long *seq_zones;
> };
> 
> struct request_queue {
> 	...
> #ifdef CONFIG_BLK_DEV_ZONED
> 	struct blk_zoned zoned;
> #endif
> 	...

Do we even need a new structure for it?  I'd just hang it off
the gendisk directly.

Except for that the idea looks fine to me.
