Return-Path: <martin.petersen@oracle.com>
To: Damien Le Moal <damien.lemoal@hgst.com>
Cc: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>
Subject: Re: [PATCH v3 1/7] block: Add 'zoned' queue limit
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <1475025757-6340-1-git-send-email-damien.lemoal@hgst.com>
	<1475025757-6340-2-git-send-email-damien.lemoal@hgst.com>
Date: Tue, 27 Sep 2016 23:42:00 -0400
In-Reply-To: <1475025757-6340-2-git-send-email-damien.lemoal@hgst.com> (Damien
	Le Moal's message of "Wed, 28 Sep 2016 10:22:31 +0900")
Message-ID: <yq1twd0zo53.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Damien" == Damien Le Moal <damien.lemoal@hgst.com> writes:

Damien> The zoned attribute is also exported as a string to applications
Damien> via sysfs. BLK_ZONED_NONE shows as "none", BLK_ZONED_HA as
Damien> "host-aware" and BLK_ZONED_HM as "host-managed".

Looks good. However, you should add the zoned attribute to
Documentation/ABI/testing/sysfs-block.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
