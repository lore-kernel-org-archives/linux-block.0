Return-Path: <hare@suse.de>
Date: Mon, 4 Jun 2018 08:15:22 +0200
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org
Subject: Re: [PATCH 06/12] nvmet: implement the changed namespaces log
Message-ID: <20180604081522.35cd63b6@pentland.suse.de>
In-Reply-To: <20180530164600.26856-7-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
	<20180530164600.26856-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Wed, 30 May 2018 18:45:54 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Just keep a per-controller buffer of changed namespaces and copy it
> out in the get log page implementation.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/target/admin-cmd.c | 26 +++++++++++++++++
>  drivers/nvme/target/core.c      | 50
> +++++++++++++++++++++++++++------ drivers/nvme/target/nvmet.h     |
> 3 ++ 3 files changed, 70 insertions(+), 9 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
