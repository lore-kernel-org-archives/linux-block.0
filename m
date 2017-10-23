Return-Path: <martin.petersen@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Benjamin Block <bblock@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 9/9] bsg: split handling of SCSI CDBs vs transport requeues
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20171003104845.10417-1-hch@lst.de>
	<20171003104845.10417-10-hch@lst.de>
	<20171019155933.GE26185@bblock-ThinkPad-W530>
	<20171020162630.GA14277@lst.de>
	<20171020164727.GA26380@bblock-ThinkPad-W530>
	<yq1bmkymlss.fsf@oracle.com> <20171023062949.GA16978@lst.de>
Date: Mon, 23 Oct 2017 03:17:29 -0400
In-Reply-To: <20171023062949.GA16978@lst.de> (Christoph Hellwig's message of
	"Mon, 23 Oct 2017 08:29:49 +0200")
Message-ID: <yq17evmmiye.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>


Christoph,

>> Yes, I expected the bsg bits to go through Jens' tree.
>
> Ok, then I misremembered it, and we'll have to delay the remaining
> patches until the next merge window, as they depend on the previous
> ones.

I don't mind taking them through SCSI if Jens agrees.

-- 
Martin K. Petersen	Oracle Linux Engineering
