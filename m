Return-Path: <hare@suse.de>
Subject: Re: [PATCH 02/17] block: add REQ_DRV bit
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <74620ec2-91ed-b76d-4bc3-46b5f5e03e14@suse.de>
Date: Thu, 19 Oct 2017 07:48:29 +0200
MIME-Version: 1.0
In-Reply-To: <20171018165258.23212-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/18/2017 06:52 PM, Christoph Hellwig wrote:
> Set aside a bit in the request/bio flags for driver use.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  include/linux/blk_types.h | 5 +++++
>  1 file changed, 5 insertions(+)
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
