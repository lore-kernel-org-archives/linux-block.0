Return-Path: <hare@suse.de>
Subject: Re: [PATCH 01/17] block: move REQ_NOWAIT
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8895468d-a36a-9f9c-0086-22e058cf5b23@suse.de>
Date: Thu, 19 Oct 2017 07:48:02 +0200
MIME-Version: 1.0
In-Reply-To: <20171018165258.23212-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/2017 06:52 PM, Christoph Hellwig wrote:
> This flag should be before the operation-specific REQ_NOUNMAP bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  include/linux/blk_types.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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
