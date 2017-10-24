Return-Path: <hare@suse.de>
Subject: Re: [PATCH 11/17] nvme: get rid of nvme_ctrl_list
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-12-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5b477087-d31d-43a1-2c1e-4d142f4786c3@suse.de>
Date: Tue, 24 Oct 2017 09:24:41 +0200
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-12-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> Use the core chrdev code to set up the link between the character device
> and the nvme controller.  This allows us to get rid of the global list
> of all controllers, and also ensures that we have both a reference to
> the controller and the transport module before the open method of the
> character device is called.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sagi Grimberg <sgi@grimberg.me>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/nvme/host/core.c | 76 ++++++++++--------------------------------------
>  drivers/nvme/host/nvme.h |  3 +-
>  2 files changed, 18 insertions(+), 61 deletions(-)
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
