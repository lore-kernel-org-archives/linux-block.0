Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54723 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdFSHUF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 03:20:05 -0400
Date: Mon, 19 Jun 2017 09:20:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH rfc 03/30] nvme-rdma: reuse configure/destroy admin
        queue
Message-ID: <20170619072004.GC13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-4-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497799324-19598-4-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 18, 2017 at 06:21:37PM +0300, Sagi Grimberg wrote:
> We have all we need in these functions now that these
> are aware if we are doing a full instantiation/removal.
> 
> For that we move nvme_rdma_configure_admin_queue to avoid
> a forward declaration, and we add blk_mq_ops forward declaration.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/rdma.c | 253 ++++++++++++++++++++++-------------------------
>  1 file changed, 119 insertions(+), 134 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 3e4c6aa119ee..5fef5545e365 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -140,6 +140,9 @@ static DEFINE_MUTEX(device_list_mutex);
>  static LIST_HEAD(nvme_rdma_ctrl_list);
>  static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
>  
> +static const struct blk_mq_ops nvme_rdma_mq_ops;
> +static const struct blk_mq_ops nvme_rdma_admin_mq_ops;
> +
>  /*
>   * Disabling this option makes small I/O goes faster, but is fundamentally
>   * unsafe.  With it turned off we will have to register a global rkey that
> @@ -562,20 +565,22 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
>  
>  static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
>  {
> +	if (test_bit(NVME_RDMA_Q_DELETING, &queue->flags))
> +		return;
>  	rdma_disconnect(queue->cm_id);
>  	ib_drain_qp(queue->qp);
>  }
>  
>  static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
>  {
> +	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
> +		return;
>  	nvme_rdma_destroy_queue_ib(queue);
>  	rdma_destroy_id(queue->cm_id);
>  }
>  
>  static void nvme_rdma_stop_and_free_queue(struct nvme_rdma_queue *queue)
>  {
> -	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
> -		return;
>  	nvme_rdma_stop_queue(queue);
>  	nvme_rdma_free_queue(queue);
>  }
> @@ -671,6 +676,116 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl, bool remo
>  	nvme_rdma_free_queue(&ctrl->queues[0]);
>  }
>  
static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl, bool new)

Too long line..

Also what about moving the helpers into the right place in the
previous patch that already re-indented most of this?
