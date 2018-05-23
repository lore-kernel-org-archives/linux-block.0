Return-Path: <hare@suse.de>
Subject: Re: [PATCH 03/14] nvme: return BLK_EH_DONE from ->timeout
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-4-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d17e44a1-8946-56df-a039-f4afa2be7329@suse.de>
Date: Wed, 23 May 2018 15:27:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> NVMe always completes the request before returning from ->timeout, either
> by polling for it, or by disabling the controller.  Return BLK_EH_DONE so
> that the block layer doesn't even try to complete it again.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c    | 14 +++++---------
>   drivers/nvme/host/rdma.c , |  2 +-
>   drivers/nvme/target/loop.c |  2 +-
>   3 files changed, 7 insertions(+), 11 deletions(-)
> 
Is there a way of _testing_ this patch?
It looks pretty dodgy, just replacing BLK_EH_HANDLED with 
BLK_EH_NOT_HANDLED.
And, as nothing else has changed, would imply that we can do it on 
older/stable versions, too.
Which means that the original code was buggy to start with.
Hence a test here would be really beneficial.

But then, assuming you did some tests here:

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
