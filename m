Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 0/3] Separate zone requests from medium access requests
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20170228102535.15966-1-damien.lemoal@wdc.com>
	<20170228160259.GA22755@lst.de>
Date: Tue, 28 Feb 2017 21:52:31 -0500
In-Reply-To: <20170228160259.GA22755@lst.de> (Christoph Hellwig's message of
	"Tue, 28 Feb 2017 17:02:59 +0100")
Message-ID: <yq160jtu2s0.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

>>>>> "Christoph" == Christoph Hellwig <hch@lst.de> writes:

Christoph> I don't really like this too much - this is too many SCSI
Christoph> specifics for the block layer to care.  Maybe using bios for
Christoph> the zone ops was a mistake after all, and we should just have
Christoph> operations in struct block_device instead..

Yeah, I'm afraid I don't like this either.

Short term I still think we should adjust in sd. And then maybe longer
term revisit whether these hybrid commands should be something other
than bios.

-- 
Martin K. Petersen	Oracle Linux Engineering
