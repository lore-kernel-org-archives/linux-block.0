Return-Path: <hare@suse.de>
Date: Mon, 4 Jun 2018 08:16:39 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 11/12] nvme: use the changed namespaces list log to
 clear ns data changed AENs
Message-ID: <20180604081639.3ba0a18b@pentland.suse.de>
In-Reply-To: <20180530164600.26856-12-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
	<20180530164600.26856-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 30 May 2018 18:45:59 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Per section 5.2 we need to issue the corresponding log page to clear
> an AEN, so for a namespace data changed AEN we need to read the
> changed namespace list log.  And once we read that log anyway we
> might as well use it to optimize the rescan.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 51
> ++++++++++++++++++++++++++++++++++++---- drivers/nvme/host/nvme.h |
> 2 ++ 2 files changed, 49 insertions(+), 4 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
