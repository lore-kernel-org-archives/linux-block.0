Return-Path: <hare@suse.de>
Date: Mon, 4 Jun 2018 08:14:31 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 05/12] nvmet: split log page implementation
Message-ID: <20180604081431.374c5488@pentland.suse.de>
In-Reply-To: <20180530164600.26856-6-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
	<20180530164600.26856-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 30 May 2018 18:45:53 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Remove the common code to allocate a buffer and copy it into the SGL.
> Instead the two no-op implementations just zero the SGL directly, and
> the smart log allocates a buffer on its own.  This prepares for the
> more elaborate ANA log page.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 99
> ++++++++++++--------------------- 1 file changed, 36 insertions(+),
> 63 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
