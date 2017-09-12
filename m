Return-Path: <james.smart@broadcom.com>
Return-Path: <james.smart@broadcom.com>
Subject: Re: [PATCH 10/10] Reserved tag for active ns command
To: Anish M Jhaveri <anish.jhaveri@paviliondata.com>, sagi@grimberg.me,
 hch@lst.de, keith.busch@intel.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20170912043302.uikxktbfqjfzwfvn@haynes>
From: James Smart <james.smart@broadcom.com>
Message-ID: <8ab4b015-4c3d-256f-a842-468edbc59059@broadcom.com>
Date: Tue, 12 Sep 2017 08:53:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170912043302.uikxktbfqjfzwfvn@haynes>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Please commonize the # of reserved tags.  There's more than 1 transport 
and they all do the same things.

-- james


On 9/11/2017 9:33 PM, Anish M Jhaveri wrote:
> Using reserved tag for setting standby namespace to active using nvme command.
>
> Signed-off-by: Anish M Jhaveri <anish.jhaveri@paviliondata.com>
> ---
>   drivers/nvme/host/rdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index cb6a5f8..d094793 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1550,7 +1550,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
>   	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
>   	ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
>   	ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
> -	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
> +	ctrl->admin_tag_set.reserved_tags = 3; /* connect + keep-alive */
>   	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
>   	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
>   		SG_CHUNK_SIZE * sizeof(struct scatterlist);
