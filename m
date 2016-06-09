Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38641 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbcFILUA (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2016 07:20:00 -0400
Received: by mail-wm0-f51.google.com with SMTP id m124so55552872wme.1
        for <linux-block@vger.kernel.org>; Thu, 09 Jun 2016 04:19:59 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-rdma: check the number of hw queues mapped
To: Ming Lin <mlin@kernel.org>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
References: <1465415292-9416-1-git-send-email-mlin@kernel.org>
 <1465415292-9416-3-git-send-email-mlin@kernel.org>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	James Smart <james.smart@broadcom.com>
From: Sagi Grimberg <sagi@lightbits.io>
Message-ID: <575950DB.6080701@lightbits.io>
Date: Thu, 9 Jun 2016 14:19:55 +0300
MIME-Version: 1.0
In-Reply-To: <1465415292-9416-3-git-send-email-mlin@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This needs documentation in the form of:

/*
  * XXX: blk-mq might not map all our hw contexts but this is a must for
  * us for fabric connects. So until we can fix blk-mq we check that.
  */

> +	hw_queue_mapped = blk_mq_hctx_mapped(ctrl->ctrl.connect_q);
> +	if (hw_queue_mapped < ctrl->ctrl.connect_q->nr_hw_queues) {
> +		dev_err(ctrl->ctrl.device,
> +			"%d hw queues created, but only %d were mapped to sw queues\n",
> +			ctrl->ctrl.connect_q->nr_hw_queues,
> +			hw_queue_mapped);
> +		ret = -EINVAL;
> +		goto out_cleanup_connect_q;
> +	}
> +
>   	ret = nvme_rdma_connect_io_queues(ctrl);
>   	if (ret)
>   		goto out_cleanup_connect_q;
>
