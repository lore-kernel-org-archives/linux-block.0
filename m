Return-Path: <hare@suse.de>
Subject: Re: [PATCH 04/17] block: add a blk_steal_bios helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-5-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <c1a19718-bb24-0a36-8d89-874c79291bc0@suse.de>
Date: Tue, 24 Oct 2017 09:07:19 +0200
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> This helpers allows to bounce steal the uncompleted bios from a request so
> that they can be reissued on another path.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  block/blk-core.c       | 20 ++++++++++++++++++++
>  include/linux/blkdev.h |  2 ++
>  2 files changed, 22 insertions(+)
> Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
