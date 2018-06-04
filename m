Return-Path: <hare@suse.de>
Date: Mon, 4 Jun 2018 08:14:10 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 04/12] nvmet: add a new nvmet_zero_sgl helper
Message-ID: <20180604081410.0ad79325@pentland.suse.de>
In-Reply-To: <20180530164600.26856-5-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
	<20180530164600.26856-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 30 May 2018 18:45:52 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Zeroes the SGL in the payload.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/nvme/target/core.c  | 7 +++++++
>  drivers/nvme/target/nvmet.h | 1 +
>  2 files changed, 8 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
