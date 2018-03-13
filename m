Return-Path: <axboe@kernel.dk>
Subject: Re: bsg-lib interface cleanup V2
To: Christoph Hellwig <hch@lst.de>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 Johannes Thumshirn <jthumshirn@suse.de>,
 Benjamin Block <bblock@linux.vnet.ibm.com>
References: <20180313162841.9030-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <44d766ac-2836-f940-d633-ff179d4c4c44@kernel.dk>
Date: Tue, 13 Mar 2018 10:41:03 -0700
MIME-Version: 1.0
In-Reply-To: <20180313162841.9030-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 3/13/18 9:28 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up various abuses of the bsg interfaces, and then
> splits bsg for SCSI passthrough from bsg for arbitrary transport
> passthrough.  This removes the scsi_request abuse in bsg-lib that is
> very confusing, and also makes sure we can sanity check the requests
> we get.  The current code will happily execute scsi commands against
> bsg-lib queues, and transport pass through against scsi nodes, without
> any indication to the driver that we are doing the wrong thing.

Applied for 4.17, thanks.

-- 
Jens Axboe
