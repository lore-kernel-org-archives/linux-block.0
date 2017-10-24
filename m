Return-Path: <hare@suse.de>
Subject: Re: [PATCH 08/17] nvme: use kref_get_unless_zero in nvme_find_get_ns
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-9-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e6c92822-7c64-b11b-8bb3-41c456ad4c8b@suse.de>
Date: Tue, 24 Oct 2017 09:21:03 +0200
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-9-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> For kref_get_unless_zero to protect against lookup vs free races we need
> to use it in all places where we aren't guaranteed to already hold a
> reference.  There is no such guarantee in nvme_find_get_ns, so switch to
> kref_get_unless_zero in this function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/nvme/host/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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
