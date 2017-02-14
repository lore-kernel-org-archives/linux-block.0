Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: "hch@lst.de" <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Bart Van Assche
	<Bart.VanAssche@sandisk.com>, "hare@suse.com" <hare@suse.com>, "hare@suse.de"
	<hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "jth@kernel.org"
	<jth@kernel.org>, Nick Meier <Nick.Meier@microsoft.com>, "Alex Ng (LIS)"
	<alexng@microsoft.com>, Long Li <longli@microsoft.com>, "Adrian Suhov
 (Cloudbase Solutions SRL)" <v-adsuho@microsoft.com>, "Chris Valean (Cloudbase
 Solutions SRL)" <v-chvale@microsoft.com>
Subject: RE: Boot regression (was "Re: [PATCH] genhd: Do not hold event	lock
 when scheduling workqueue elements")
Date: Tue, 14 Feb 2017 14:46:41 +0000
Message-ID: <MWHPR03MB2669CCE370BC22E648A468F6BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <9199d528-f220-5b77-d657-c510ca210067@kernel.dk>
 <MWHPR03MB26697302F28F9C2C7D7390D4BF420@MWHPR03MB2669.namprd03.prod.outlook.com>
 <b21e5580-ed75-6150-3c83-43ecbb0292a5@kernel.dk>
 <20170208180314.GA17838@lst.de>
 <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170209130800.GA12057@lst.de>
 <MWHPR03MB2669B4FFC900983C8C357A77BF440@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170214134736.GA19620@lst.de>
 <MWHPR03MB2669C439014CD20B21ED3A69BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
 <20170214142837.GB20706@lst.de>
In-Reply-To: <20170214142837.GB20706@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

> From: hch@lst.de [mailto:hch@lst.de]
> Sent: Tuesday, February 14, 2017 22:29
> To: Dexuan Cui <decui@microsoft.com>
> Subject: Re: Boot regression (was "Re: [PATCH] genhd: Do not hold event l=
ock
> when scheduling workqueue elements")
>=20
> Ok, thanks for testing.  Can you try the patch below?  It fixes a
> clear problem which was partially papered over before the commit
> you bisected to, although it can't explain why blk-mq still works.

Still bad luck. :-(

BTW, I'm using the first "bad" commit (scsi: allocate scsi_cmnd structures =
as
part of struct request) + the 2 patches you provided today.

I suppose I don't need to test the 2 patches on the latest linux-next repo.

Thanks,
-- Dexuan
