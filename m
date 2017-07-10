Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f169.google.com ([209.85.128.169]:36688 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754447AbdGJS5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jul 2017 14:57:12 -0400
Received: by mail-wr0-f169.google.com with SMTP id c11so150999773wrc.3
        for <linux-block@vger.kernel.org>; Mon, 10 Jul 2017 11:57:11 -0700 (PDT)
Subject: Re: [PATCH rfc 08/30] nvme-rdma: cleanup error path in controller
 reset
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
 <1497799324-19598-9-git-send-email-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <57675cfb-a63a-3fef-ae63-0f8387b67082@broadcom.com>
Date: Mon, 10 Jul 2017 11:57:06 -0700
MIME-Version: 1.0
In-Reply-To: <1497799324-19598-9-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 6/18/2017 8:21 AM, Sagi Grimberg wrote:
> No need to queue an extra work to indirect controller
> uninit and put the final reference.
>
>
>   static void nvme_rdma_del_ctrl_work(struct work_struct *work)
>   {
>   	struct nvme_rdma_ctrl *ctrl = container_of(work,
>   				struct nvme_rdma_ctrl, delete_work);
>   
> -	__nvme_rdma_remove_ctrl(ctrl, true);
> +	nvme_uninit_ctrl(&ctrl->ctrl);
> +	nvme_rdma_shutdown_ctrl(ctrl, true);
> +	nvme_put_ctrl(&ctrl->ctrl);
>   }
>   
>   static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
> @@ -1791,14 +1784,6 @@ static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
>   	return ret;
>   }
>   
...

> @@ -1832,10 +1814,13 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>   
>   	return;
>   
> -del_dead_ctrl:
> -	/* Deleting this dead controller... */
> +out_destroy_io:
> +	nvme_rdma_destroy_io_queues(ctrl, true);
> +out_destroy_admin:
> +	nvme_rdma_destroy_admin_queue(ctrl, true);
>   	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
> -	WARN_ON(!queue_work(nvme_wq, &ctrl->delete_work));
> +	nvme_uninit_ctrl(&ctrl->ctrl);
> +	nvme_put_ctrl(&ctrl->ctrl);
>   }
>   
>   static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {

Recommend calls to nvme_stop_keep_alive() prior to nvme_uninit_ctrl().

-- james
