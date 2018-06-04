Return-Path: <hare@suse.de>
Date: Mon, 4 Jun 2018 08:16:17 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 10/12] nvme: mark nvme_queue_scan static
Message-ID: <20180604081617.01da7284@pentland.suse.de>
In-Reply-To: <20180530164600.26856-11-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
	<20180530164600.26856-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 30 May 2018 18:45:58 +0200
Christoph Hellwig <hch@lst.de> wrote:

> And move it toward the top of the file to avoid a forward declaration.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/nvme/host/core.c | 19 +++++++++----------
>  drivers/nvme/host/nvme.h |  1 -
>  2 files changed, 9 insertions(+), 11 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
