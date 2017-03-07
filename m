Return-Path: <hare@suse.de>
Subject: Re: [PATCH 01/11] block: Fix bdi assignment to bdev inode when racing
 with disk delete
To: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
References: <20170306163404.1238-1-jack@suse.cz>
 <20170306163404.1238-2-jack@suse.cz>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Lekshmi Pillai <lekshmicpillai@in.ibm.com>, Tejun Heo <tj@kernel.org>,
 NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <052a2b21-cf6e-68c3-00a7-ad0aae5c5cb8@suse.de>
Date: Tue, 7 Mar 2017 07:47:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170306163404.1238-2-jack@suse.cz>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 03/06/2017 05:33 PM, Jan Kara wrote:
> When disk->fops->open() in __blkdev_get() returns -ERESTARTSYS, we
> restart the process of opening the block device. However we forget to
> switch bdev->bd_bdi back to noop_backing_dev_info and as a result bdev
> inode will be pointing to a stale bdi. Fix the problem by setting
> bdev->bd_bdi later when __blkdev_get() is already guaranteed to succeed.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/block_dev.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
