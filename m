Return-Path: <hare@suse.de>
Subject: Re: [PATCH 05/17] block: don't look at the struct device dev_t in
 disk_devt
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-6-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e4c00ca1-44ca-4e48-cec7-ba5ea15e340e@suse.de>
Date: Tue, 24 Oct 2017 09:08:21 +0200
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-6-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> The hidden gendisks introduced in the next patch need to keep the dev
> field in their struct device empty so that udev won't try to create
> block device nodes for them.  To support that rewrite disk_devt to
> look at the major and first_minor fields in the gendisk itself instead
> of looking into the struct device.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/genhd.c         | 4 ----
>  include/linux/genhd.h | 2 +-
>  2 files changed, 1 insertion(+), 5 deletions(-)
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
