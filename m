Return-Path: <hch@lst.de>
Date: Tue, 14 Feb 2017 15:51:01 +0100
From: "hch@lst.de" <hch@lst.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "hch@lst.de" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Bart Van Assche <Bart.VanAssche@sandisk.com>,
	"hare@suse.com" <hare@suse.com>, "hare@suse.de" <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jth@kernel.org" <jth@kernel.org>,
	Nick Meier <Nick.Meier@microsoft.com>,
	"Alex Ng (LIS)" <alexng@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"Adrian Suhov (Cloudbase Solutions SRL)" <v-adsuho@microsoft.com>,
	"Chris Valean (Cloudbase Solutions SRL)" <v-chvale@microsoft.com>
Subject: Re: Boot regression (was "Re: [PATCH] genhd: Do not hold event
	lock when scheduling workqueue elements")
Message-ID: <20170214145101.GA21427@lst.de>
References: <MWHPR03MB26697302F28F9C2C7D7390D4BF420@MWHPR03MB2669.namprd03.prod.outlook.com> <b21e5580-ed75-6150-3c83-43ecbb0292a5@kernel.dk> <20170208180314.GA17838@lst.de> <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com> <20170209130800.GA12057@lst.de> <MWHPR03MB2669B4FFC900983C8C357A77BF440@MWHPR03MB2669.namprd03.prod.outlook.com> <20170214134736.GA19620@lst.de> <MWHPR03MB2669C439014CD20B21ED3A69BF580@MWHPR03MB2669.namprd03.prod.outlook.com> <20170214142837.GB20706@lst.de> <MWHPR03MB2669CCE370BC22E648A468F6BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <MWHPR03MB2669CCE370BC22E648A468F6BF580@MWHPR03MB2669.namprd03.prod.outlook.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 14, 2017 at 02:46:41PM +0000, Dexuan Cui wrote:
> > From: hch@lst.de [mailto:hch@lst.de]
> > Sent: Tuesday, February 14, 2017 22:29
> > To: Dexuan Cui <decui@microsoft.com>
> > Subject: Re: Boot regression (was "Re: [PATCH] genhd: Do not hold event lock
> > when scheduling workqueue elements")
> > 
> > Ok, thanks for testing.  Can you try the patch below?  It fixes a
> > clear problem which was partially papered over before the commit
> > you bisected to, although it can't explain why blk-mq still works.
> 
> Still bad luck. :-(
> 
> BTW, I'm using the first "bad" commit (scsi: allocate scsi_cmnd structures as
> part of struct request) + the 2 patches you provided today.
> 
> I suppose I don't need to test the 2 patches on the latest linux-next repo.

I'd love a test on that repo actually.  We had a few other for sense
handling since then I think.
