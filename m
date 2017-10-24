Return-Path: <hare@suse.de>
Subject: Re: [PATCH 13/17] nvme: track subsystems
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <jthumshirn@suse.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-14-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3670fe01-f17d-92e4-ba51-fdd9fdfd3a6c@suse.de>
Date: Tue, 24 Oct 2017 09:33:26 +0200
MIME-Version: 1.0
In-Reply-To: <20171023145126.2471-14-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 10/23/2017 04:51 PM, Christoph Hellwig wrote:
> This adds a new nvme_subsystem structure so that we can track multiple
> controllers that belong to a single subsystem.  For now we only use it
> to store the NQN, and to check that we don't have duplicate NQNs unless
> the involved subsystems support multiple controllers.
> 
> Includes code originally from Hannes Reinecke to expose the subsystems
> in sysfs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c    | 200 +++++++++++++++++++++++++++++++++++++-------
>  drivers/nvme/host/fabrics.c |   4 +-
>  drivers/nvme/host/nvme.h    |  26 ++++--
>  3 files changed, 194 insertions(+), 36 deletions(-)
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
