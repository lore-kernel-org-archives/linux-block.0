Return-Path: <hare@suse.de>
Subject: Re: [PATCH 07/12] genhd: Annotate all part and part_tbl pointer
 dereferences
To: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bart.vanassche@sandisk.com>, Tejun Heo <tj@kernel.org>,
 Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>
References: <20170817232311.25948-1-bart.vanassche@wdc.com>
 <20170817232311.25948-8-bart.vanassche@wdc.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <efffa7df-7610-fd04-7dae-5ef426f9c2f7@suse.de>
Date: Fri, 18 Aug 2017 09:39:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170817232311.25948-8-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/18/2017 01:23 AM, Bart Van Assche wrote:
> Annotate gendisk.part_tbl and disk_part_tbl.part dereferences with
> rcu_dereference_protected(). This patch does not change the behavior
> of the modified code but ensures that sparse does not complain about
> disk->part_tbl manipulations nor about part_tbl->part accesses.
> Additionally, improve documentation of the locking requirements of
> the modified functions.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> ---
>  block/genhd.c             | 15 ++++++++++-----
>  block/partition-generic.c | 15 ++++++++++++---
>  2 files changed, 22 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
