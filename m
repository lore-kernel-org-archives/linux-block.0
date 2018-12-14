Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6255C43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 15:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD172070B
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 15:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeLNPqe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:46:34 -0500
Received: from verein.lst.de ([213.95.11.211]:48251 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNPqe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 10:46:34 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C181768DF1; Fri, 14 Dec 2018 16:46:32 +0100 (CET)
Date:   Fri, 14 Dec 2018 16:46:32 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 6/6] nvme-rdma: implement polling queue map
Message-ID: <20181214154632.GC24417@lst.de>
References: <20181213213410.9841-1-sagi@grimberg.me> <20181213213410.9841-7-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213213410.9841-7-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +static bool nvme_rdma_poller_queue(struct nvme_rdma_queue *queue)

Can we please make this poll_queue?  or at least polled_queue?
poller sounds odd..

> -		set->nr_maps = 2 /* default + read */;
> +		set->nr_maps = HCTX_MAX_TYPES;
>  	}
>  
>  	ret = blk_mq_alloc_tag_set(set);
> @@ -864,6 +881,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
>  			ret = PTR_ERR(ctrl->ctrl.connect_q);
>  			goto out_free_tag_set;
>  		}
> +
> +		if (ctrl->ctrl.opts->nr_poll_queues)
> +			blk_queue_flag_set(QUEUE_FLAG_POLL,
> +				ctrl->ctrl.connect_q);

The block core is supposed to detect we can poll based on nr_maps > 2,
and then set QUEUE_FLAG_POLL automatically.  Although I got the details
wrong for PCI as well, but I just sent a fix..
> +static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct nvme_rdma_queue *queue = hctx->driver_data;
> +	struct ib_cq *cq = queue->ib_cq;
> +
> +	return ib_process_cq_direct(cq, -1);

I think we can skip the cq local variable here.

Otherwise this looks really nice and simple, thanks for looking into it!

Do you have any performance number, especially with Jens' ringbuffer
code?
