Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54754 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdFSHVu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jun 2017 03:21:50 -0400
Date: Mon, 19 Jun 2017 09:21:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH rfc 28/30] nvme: update tagset nr_hw_queues when
        reallocating io queues
Message-ID: <20170619072148.GE13168@lst.de>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me> <1497799324-19598-29-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1497799324-19598-29-git-send-email-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Jun 18, 2017 at 06:22:02PM +0300, Sagi Grimberg wrote:
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Could use a changelog.

Ming: does this solve your problem of not seeing the new queues
after a qemu CPU hotplug + reset?

> ---
>  drivers/nvme/host/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6937ba26ff2c..476c49c0601f 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2776,6 +2776,9 @@ int nvme_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>  		ret = blk_mq_reinit_tagset(ctrl->tagset);
>  		if (ret)
>  			goto out_free_io_queues;
> +
> +		blk_mq_update_nr_hw_queues(ctrl->tagset,
> +				ctrl->queue_count - 1);
>         }
>  
>  	ret = nvme_start_io_queues(ctrl);
> -- 
> 2.7.4
---end quoted text---
