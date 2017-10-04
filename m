Return-Path: <axboe@kernel.dk>
Subject: Re: [RFC] bsg-lib interface cleanup
To: Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
 Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20171003104845.10417-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4c1113f7-64f0-98a2-9997-9f6a8666acdb@kernel.dk>
Date: Wed, 4 Oct 2017 08:35:44 -0600
MIME-Version: 1.0
In-Reply-To: <20171003104845.10417-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/03/2017 04:48 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up various abuses of the bsg interfaces, and then
> splits bsg for SCSI passthrough from bsg for arbitrary transport
> passthrough.  This removes the scsi_request abuse in bsg-lib that is
> very confusing, and also makes sure we can sanity check the requests
> we get.  The current code will happily execute scsi commands against
> bsg-lib queues, and transport pass through against scsi nodes, without
> any indication to the driver that we are doing the wrong thing.
> 
> The series includes the fix from Bejamin as the first patch as I
> rebased on top of it, but that one really needs to got into 4.14 ASAP.

I added patch 1 for 4.14.

-- 
Jens Axboe
