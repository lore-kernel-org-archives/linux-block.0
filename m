Return-Path: <hare@suse.de>
Date: Mon, 4 Jun 2018 08:13:25 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 01/12] nvme.h: untangle AEN notice definitions
Message-ID: <20180604081325.3f68253e@pentland.suse.de>
In-Reply-To: <20180530164600.26856-2-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
	<20180530164600.26856-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 30 May 2018 18:45:49 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Stop including the event type in the definitions for the notice type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/nvme/host/core.c | 30 ++++++++++++++++++------------
>  include/linux/nvme.h     |  8 ++++++--
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
