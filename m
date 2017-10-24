Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 9/9] bsg: split handling of SCSI CDBs vs transport
 requeues
To: "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Benjamin Block <bblock@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>
References: <20171003104845.10417-1-hch@lst.de>
 <20171003104845.10417-10-hch@lst.de>
 <20171019155933.GE26185@bblock-ThinkPad-W530> <20171020162630.GA14277@lst.de>
 <20171020164727.GA26380@bblock-ThinkPad-W530> <yq1bmkymlss.fsf@oracle.com>
 <20171023062949.GA16978@lst.de> <yq17evmmiye.fsf@oracle.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <251daef6-a5bd-47d1-99a2-24d0d11b7bff@kernel.dk>
Date: Tue, 24 Oct 2017 11:46:12 -0600
MIME-Version: 1.0
In-Reply-To: <yq17evmmiye.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/2017 01:17 AM, Martin K. Petersen wrote:
> 
> Christoph,
> 
>>> Yes, I expected the bsg bits to go through Jens' tree.
>>
>> Ok, then I misremembered it, and we'll have to delay the remaining
>> patches until the next merge window, as they depend on the previous
>> ones.
> 
> I don't mind taking them through SCSI if Jens agrees.

I'm fine with that, as long as the last issue Benjamin brought up has
been fixed up.

-- 
Jens Axboe
