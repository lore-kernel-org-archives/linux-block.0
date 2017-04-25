Return-Path: <axboe@kernel.dk>
Date: Mon, 24 Apr 2017 22:00:26 -0600
From: Jens Axboe <axboe@kernel.dk>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org, keith.busch@intel.com,
	hch@infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme/scsi: Consider LBA format in IO splitting
 calculation
Message-ID: <20170425040025.GA23572@kernel.dk>
References: <20170425000243.2019-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170425000243.2019-1-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 24 2017, Jon Derrick wrote:
> The current command submission code uses a sector-based value when
> considering the maximum number of blocks per command. With a
> 4k-formatted namespace and a command exceeding max hardware limits, this
> calculation doesn't split IOs which should be split and fails in the
> nvme layer. This patch fixes that calculation and enables IO splitting
> in these circumstances.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  drivers/nvme/host/scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/scsi.c b/drivers/nvme/host/scsi.c
> index f49ae27..988da61 100644
> --- a/drivers/nvme/host/scsi.c
> +++ b/drivers/nvme/host/scsi.c
> @@ -1609,7 +1609,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>  	struct nvme_command c;
>  	u8 opcode = (is_write ? nvme_cmd_write : nvme_cmd_read);
>  	u16 control;
> -	u32 max_blocks = queue_max_hw_sectors(ns->queue);
> +	u32 max_blocks = queue_max_hw_sectors(ns->queue) >> (ns->lba_shift - 9);
>  
>  	num_cmds = nvme_trans_io_get_num_cmds(hdr, cdb_info, max_blocks);

Patch looks correct to me, as we always consider the hw sectors settings
in units of 512b blocks.

Reviewed-by: Jens Axboe <axboe@fb.com>

-- 
Jens Axboe
