Return-Path: <martin.petersen@oracle.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Subject: Re: [PATCH V7 6/8] scsi: sd_zbc: Initialize device request queue zoned data
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171108081118.7632-1-damien.lemoal@wdc.com>
	<20171108081118.7632-7-damien.lemoal@wdc.com>
Date: Wed, 08 Nov 2017 18:41:08 -0500
In-Reply-To: <20171108081118.7632-7-damien.lemoal@wdc.com> (Damien Le Moal's
	message of "Wed, 8 Nov 2017 17:11:16 +0900")
Message-ID: <yq160akxrsb.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Damien,

> wait for the disk capacity and number of zones to stabilize on the
> second revalidation pass to allocate and initialize the bitmaps.

Stabilize how?

-- 
Martin K. Petersen	Oracle Linux Engineering
