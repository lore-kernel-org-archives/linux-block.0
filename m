Return-Path: <martin.petersen@oracle.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCHv6 0/3] Deprecate DAC960 driver
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20181017152513.136526-1-hare@suse.de>
Date: Wed, 17 Oct 2018 21:14:06 -0400
In-Reply-To: <20181017152513.136526-1-hare@suse.de> (Hannes Reinecke's message
	of "Wed, 17 Oct 2018 17:25:10 +0200")
Message-ID: <yq1lg6wkqe9.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Hannes,

> as we're trying to get rid of the remaining request_fn drivers here's
> a patchset to move the DAC960 driver to the SCSI stack.  As per
> request from hch I've split up the driver into two new SCSI drivers
> called 'myrb' and 'myrs'.

Applied to 4.20/scsi-queue since Jens already dropped the block driver.

Have you considered a dummy CONFIG_BLK_DEV_DAC960 config option like we
did when we merged mpt2sas and mpt3sas?

Also, does MODULE_ALIAS do the right thing when a driver is split into
two distinct modules?

-- 
Martin K. Petersen	Oracle Linux Engineering
