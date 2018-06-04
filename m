Return-Path: <hare@suse.de>
Date: Mon, 4 Jun 2018 08:17:06 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 12/12] nvme: limit warnings from nvme_identify_ns
Message-ID: <20180604081706.7be35b3e@pentland.suse.de>
In-Reply-To: <20180530164600.26856-13-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
	<20180530164600.26856-13-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 30 May 2018 18:46:00 +0200
Christoph Hellwig <hch@lst.de> wrote:

> When rescanning namespaces after an AEN we will issue Identify
> Namespace comands to namespaces that have gone away, so don't warn
> for this specific case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  drivers/nvme/host/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
