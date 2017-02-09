Return-Path: <hch@lst.de>
Date: Thu, 9 Feb 2017 14:08:00 +0100
From: "hch@lst.de" <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"hare@suse.com" <hare@suse.com>, "hare@suse.de" <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jth@kernel.org" <jth@kernel.org>
Subject: Re: Boot regression (was "Re: [PATCH] genhd: Do not hold event
	lock when scheduling workqueue elements")
Message-ID: <20170209130800.GA12057@lst.de>
References: <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com> <MWHPR03MB26699D4657FB67A535972208BF430@MWHPR03MB2669.namprd03.prod.outlook.com> <1486436195.2791.1.camel@sandisk.com> <MWHPR03MB26695ACBEBDB30E3E2E108FBBF430@MWHPR03MB2669.namprd03.prod.outlook.com> <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com> <9199d528-f220-5b77-d657-c510ca210067@kernel.dk> <MWHPR03MB26697302F28F9C2C7D7390D4BF420@MWHPR03MB2669.namprd03.prod.outlook.com> <b21e5580-ed75-6150-3c83-43ecbb0292a5@kernel.dk> <20170208180314.GA17838@lst.de> <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

Hi Dexuan,

I've spent some time with the logs and looking over the code and
couldn't find any smoking gun.  I start to wonder if it might just
be a timing issue?

Can you try one or two things for me:

 1) run with the blk-mq I/O path for scsi by either enabling it a boot /
    module load time with the scsi_mod.use_blk_mq=Y option, or at compile
    time by enabling the CONFIG_SCSI_MQ_DEFAULT option.  If that fails
    with the commit a blk-mq run before the commit would also be useful.
 2) if possible run a VM config without the virtual CD-ROM drive -
    a lot of the scsi log chatter is about handling timeouts on the
    CD drive, so that might be able to isolate issues a bit better.

Note that I'll be offline from this afternoon European time until Sunday
night as I'm out in the mountains at a lodge without internet access,
but this issue will be my priority once back.
