Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B234DC7EE2A
	for <linux-block@archiver.kernel.org>; Mon,  5 Jun 2023 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjFEVs5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 17:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjFEVsj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 17:48:39 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26389103
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 14:48:36 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f4453b607eso791926e87.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 14:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686001714; x=1688593714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PluP4pcqVp71M7UxnRP1BkUQjoEKQCeTxcFCsx0HT2E=;
        b=LgoUYO0rf7MME/gzi9GGDmp9lTH6uQYfGiULAitHKIjSPbsQeg5owpA59neemy7+gS
         givwzYcZD+6bLa8RcvwiJt7njnekC5n73kwXyxoxiwXQUBCz8ZnZU9Chp+CgSm9+I9RD
         b46kjBCg1CJwW/KkJFJeQrc8F050NGnwVKB5XPHPGBOcROKNCuDu4kPhM/Qg/Rd0vOQR
         uN/0gR32f/Y3OtMCUO9aONn4GLw/h24CfYGfPX1dTo3BdB0lW6qGs6M+bIHRxC/YKCd/
         r3oFOg1Cmmf52tVpy0/kxtfAySyijaQu7oeFh+rwlJqAoTPtokMKL6WjURA0oanK7aWi
         gGyg==
X-Gm-Message-State: AC+VfDzX26etxL43J4KCIT8axK9b0IBPtYvwmf6syFidvQNSwPGV1qvO
        Q1QRqqHgshIHaT5kt6s7MVKJ4aLlx/g=
X-Google-Smtp-Source: ACHHUZ6AVk4xND3kKuKtE+dG5nfWFMXNYK5ajgsdr58a8P2KGASY6jmQ+9ebzKBrztHL4H7pBi8uNg==
X-Received: by 2002:ac2:4824:0:b0:4f6:2d40:f910 with SMTP id 4-20020ac24824000000b004f62d40f910mr138673lft.0.1686001714204;
        Mon, 05 Jun 2023 14:48:34 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id s16-20020ac25ff0000000b004b5979f9ba8sm1237664lfg.210.2023.06.05.14.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 14:48:33 -0700 (PDT)
Message-ID: <5ac19a92-bfc8-1e1e-a37d-983f19217df7@grimberg.me>
Date:   Tue, 6 Jun 2023 00:48:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] nvme: add API of nvme_delete_dead_ctrl
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc:     Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org
References: <20230530094322.258090-1-ming.lei@redhat.com>
 <20230530094322.258090-2-ming.lei@redhat.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230530094322.258090-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> When driver confirms that the controller is dead, this controller should
> be deleted with marking as DEAD. Otherwise, upper layer may wait forever
> in __bio_queue_enter() since the disk won't be marked as DEAD.
> Especially, in del_gendisk(), disk won't be marked as DEAD unless bdev
> sync & invalidate returns. If any writeback IO waits in
> __bio_queue_enter(), IO deadlock is caused.
> 
> Add nvme_delete_dead_ctrl() for avoiding such kind of io deadlock.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 24 +++++++++++++++++++++++-
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ccb6eb1282f8..413213cfa417 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -227,16 +227,38 @@ static void nvme_delete_ctrl_work(struct work_struct *work)
>   	nvme_do_delete_ctrl(ctrl);
>   }
>   
> -int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
> +static int __nvme_delete_ctrl(struct nvme_ctrl *ctrl,
> +			      enum nvme_ctrl_state state)
>   {
> +	if (state != NVME_CTRL_DELETING && state != NVME_CTRL_DEAD)
> +		return -EINVAL;
> +
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
>   		return -EBUSY;
> +	if (state == NVME_CTRL_DEAD) {
> +		if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DEAD))
> +			return -EBUSY;
> +	}
>   	if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
>   		return -EBUSY;
>   	return 0;
>   }

the user can trigger a delete in exactly the same condition as
the transport (say a nanosecond before the transport exhaust
the max_reconnects).

I think that we'd want something like
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 841f155fe0b3..6c718ad46e06 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -231,6 +231,11 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl)
  {
         if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
                 return -EBUSY;
+
+       if (ctrl->ops->transport_disconnected &&
+           ctrl->ops->transport_disconnected(ctrl))
+               nvme_change_ctrl_state(ctrl, NVME_CTRL_DEAD);
+
         if (!queue_work(nvme_delete_wq, &ctrl->delete_work))
                 return -EBUSY;
         return 0;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 054bf2f8b1a1..657d3f79953d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2828,6 +2828,13 @@ static bool nvme_pci_supports_pci_p2pdma(struct 
nvme_ctrl *ctrl)
         return dma_pci_p2pdma_supported(dev->dev);
  }

+static bool nvme_pci_disconnected(struct nvme_ctrl *nctrl)
+{
+       struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+       return !pci_device_is_present(to_pci_dev(dev->dev));
+}
+
  static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
         .name                   = "pcie",
         .module                 = THIS_MODULE,
@@ -2841,6 +2848,7 @@ static const struct nvme_ctrl_ops 
nvme_pci_ctrl_ops = {
         .get_address            = nvme_pci_get_address,
         .print_device_info      = nvme_pci_print_device_info,
         .supports_pci_p2pdma    = nvme_pci_supports_pci_p2pdma,
+       .transport_disconnected = nvme_pci_disconnected,
  };

  static int nvme_dev_map(struct nvme_dev *dev)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..2a03df693b0e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2235,6 +2235,18 @@ static void nvme_rdma_reset_ctrl_work(struct 
work_struct *work)
         nvme_rdma_reconnect_or_remove(ctrl);
  }

+static bool nvme_rdma_disconnected(struct nvme_ctrl *nctrl)
+{
+       struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+       int i;
+
+       for (i = 0; i < ctrl->queue_count; i++) {
+               if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags))
+                       return false;
+       }
+       return true;
+}
+
  static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
         .name                   = "rdma",
         .module                 = THIS_MODULE,
@@ -2247,6 +2259,7 @@ static const struct nvme_ctrl_ops 
nvme_rdma_ctrl_ops = {
         .delete_ctrl            = nvme_rdma_delete_ctrl,
         .get_address            = nvmf_get_address,
         .stop_ctrl              = nvme_rdma_stop_ctrl,
+       .transport_disconnected = nvme_rdma_disconnected,
  };

  /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fe01ba75570d..043ce9878560 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2536,6 +2536,18 @@ static int nvme_tcp_get_address(struct nvme_ctrl 
*ctrl, char *buf, int size)
         return len;
  }

+static bool nvme_tcp_disconnected(struct nvme_ctrl *nctrl)
+{
+       struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+       int i;
+
+       for (i = 0; i < ctrl->queue_count; i++) {
+               if (test_bit(NVME_TCP_Q_LIVE, &ctrl->queues[i].flags))
+                       return false;
+       }
+       return true;
+}
+
  static const struct blk_mq_ops nvme_tcp_mq_ops = {
         .queue_rq       = nvme_tcp_queue_rq,
         .commit_rqs     = nvme_tcp_commit_rqs,
@@ -2569,6 +2581,7 @@ static const struct nvme_ctrl_ops 
nvme_tcp_ctrl_ops = {
         .delete_ctrl            = nvme_tcp_delete_ctrl,
         .get_address            = nvme_tcp_get_address,
         .stop_ctrl              = nvme_tcp_stop_ctrl,
+       .transport_disconnected = nvme_tcp_disconnected,
  };

  static bool
--
