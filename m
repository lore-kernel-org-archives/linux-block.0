Return-Path: <hch@lst.de>
Date: Mon, 23 Jul 2018 09:33:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Cc: martin.petersen@oracle.com, linux-block@vger.kernel.org,
	axboe@kernel.dk, keith.busch@intel.com,
	linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH 2/2] nvme: use blk API to remap ref tags for IOs with
	metadata
Message-ID: <20180723073301.GB18365@lst.de>
References: <1532252998-2375-1-git-send-email-maxg@mellanox.com> <1532252998-2375-2-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1532252998-2375-2-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

On Sun, Jul 22, 2018 at 12:49:58PM +0300, Max Gurtovoy wrote:
> Also moved the logic of the remapping to the nvme core driver instead
> of implementing it in the nvme pci driver. This way all the other nvme
> transport drivers will benefit from it (in case they'll implement metadata
> support).
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Martin K. Petersen <martin.petersen@oracle.com>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/nvme/host/core.c | 23 +++++++++++++--
>  drivers/nvme/host/nvme.h |  9 +-----
>  drivers/nvme/host/pci.c  | 75 +-----------------------------------------------
>  3 files changed, 23 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 46df030b2c3f..0d94d3eb641c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -591,6 +591,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
>  		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
>  
>  	if (ns->ms) {
> +		u32 ref_tag = nvme_block_nr(ns, blk_rq_pos(req));
>  		/*

Please add an empty line here.

> +void nvme_cleanup_cmd(struct request *req)
> +{
> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
> +	    nvme_error_status(req) == BLK_STS_OK) {

This line can simply be nvme_req(req)->status == 0
