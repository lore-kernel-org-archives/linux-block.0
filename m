Return-Path: <martin.petersen@oracle.com>
To: Damien Le Moal <damien.lemoal@hgst.com>
Cc: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>
Subject: Re: [PATCH v4 1/7] block: Add 'zoned' queue limit
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1475052339-10202-1-git-send-email-damien.lemoal@hgst.com>
	<1475052339-10202-2-git-send-email-damien.lemoal@hgst.com>
Date: Thu, 29 Sep 2016 21:59:57 -0400
In-Reply-To: <1475052339-10202-2-git-send-email-damien.lemoal@hgst.com>
	(Damien Le Moal's message of "Wed, 28 Sep 2016 17:45:33 +0900")
Message-ID: <yq1mviquoyq.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Damien" == Damien Le Moal <damien.lemoal@hgst.com> writes:

Damien> Add the zoned queue limit to indicate the zoning model of a
Damien> block device.  Defined values are 0 (BLK_ZONED_NONE) for regular
Damien> block devices, 1 (BLK_ZONED_HA) for host-aware zone block
Damien> devices and 2 (BLK_ZONED_HM) for host-managed zone block
Damien> devices. The standards defined drive managed model is not
Damien> defined here since these block devices do not provide any
Damien> command for accessing zone information. Drive managed model
Damien> devices will be reported as BLK_ZONED_NONE.

Damien> The helper functions blk_queue_zoned_model and bdev_zoned_model
Damien> return the zoned limit and the functions blk_queue_is_zoned and
Damien> bdev_is_zoned return a boolean for callers to test if a block
Damien> device is zoned.

Damien> The zoned attribute is also exported as a string to applications
Damien> via sysfs. BLK_ZONED_NONE shows as "none", BLK_ZONED_HA as
Damien> "host-aware" and BLK_ZONED_HM as "host-managed".

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
