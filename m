Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C778C6FD1F
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 07:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjCVHfx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjCVHfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 03:35:52 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5055981E
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:35:50 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id o32so4498821wms.1
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 00:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470549; x=1682062549;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m00lTin6YH108ne8YdnqpbMnNS8C4qC3p41B4VEeh1U=;
        b=HYGUiBH6FNYOt/pXqPQik97NfaZT9t1cfd5t1su7A6cIbD9dHLHvHp834eyo60uXnW
         hOkj0J/XukJ7cpVOuLlm6zCJmxzpipSr3EaW7emT6oypB/nSDCUKTM8yszhOYodJeYU9
         +0U8hsupQ9Bx320bkRJjBhUPkG9xd2xMY3/U0auXYMbIo4VhDwMDkEQVcAx96L7TGaWQ
         2QkV8ABXTEWj7r69IJGesqoiBSs7484kGS/Y4dAkSLGiTghCsANF+CnWyuPkEXDCO1lG
         91uTryghMe6/SnvvPfn9bIfdtjoTV66oqTEInCmv3s9g5pSLtcXbokgiF5VJOK4a16KY
         RK0g==
X-Gm-Message-State: AO0yUKVOqmf4NskrPZ5iYMZyqC1EGcLCUVLz9V0U/xd6zyJBP2dBzrvR
        vCN0huliARfUXFueKmW0dME=
X-Google-Smtp-Source: AK7set8UxSa33WeWSlcZp/PKOvD4rYbuPLVtcuyzAXNRtWYjxkSl1pENfY50GOxoeTIUg/ggaWoqeQ==
X-Received: by 2002:a05:600c:3b90:b0:3ee:52fb:6dd9 with SMTP id n16-20020a05600c3b9000b003ee52fb6dd9mr1735021wms.4.1679470548674;
        Wed, 22 Mar 2023 00:35:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c35c600b003ed29189777sm22549485wmq.47.2023.03.22.00.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:35:48 -0700 (PDT)
Message-ID: <ac4ecdd4-104e-0fcf-0ac5-42dde79daf35@grimberg.me>
Date:   Wed, 22 Mar 2023 09:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Content-Language: en-US
To:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, hch@lst.de
Cc:     Keith Busch <kbusch@kernel.org>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-2-kbusch@meta.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322002350.4038048-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> From: Keith Busch <kbusch@kernel.org>
> 
> tcp and rdma transports have lots of duplicate code setting up the
> different queue mappings. Add common helpers.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/fabrics.c | 95 +++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.h |  5 ++
>   drivers/nvme/host/rdma.c    | 81 ++-----------------------------
>   drivers/nvme/host/tcp.c     | 92 ++---------------------------------
>   4 files changed, 109 insertions(+), 164 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index bbaa04a0c502b..9dcb56ea1cc00 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -4,6 +4,7 @@
>    * Copyright (c) 2015-2016 HGST, a Western Digital Company.
>    */
>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/blk-mq-rdma.h>
>   #include <linux/init.h>
>   #include <linux/miscdevice.h>
>   #include <linux/module.h>
> @@ -957,6 +958,100 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	return ret;
>   }
>   
> +unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts)
> +{
> +	unsigned int nr_io_queues;
> +
> +	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
> +	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
> +	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
> +
> +	return nr_io_queues;
> +}
> +EXPORT_SYMBOL_GPL(nvme_nr_io_queues);

Given that it is shared only with tcp/rdma, maybe rename it
to nvmf_ip_nr_io_queues.

> +
> +void nvme_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
> +			u32 io_queues[HCTX_MAX_TYPES])
> +{
> +	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
> +		/*
> +		 * separate read/write queues
> +		 * hand out dedicated default queues only after we have
> +		 * sufficient read queues.
> +		 */
> +		io_queues[HCTX_TYPE_READ] = opts->nr_io_queues;
> +		nr_io_queues -= io_queues[HCTX_TYPE_READ];
> +		io_queues[HCTX_TYPE_DEFAULT] =
> +			min(opts->nr_write_queues, nr_io_queues);
> +		nr_io_queues -= io_queues[HCTX_TYPE_DEFAULT];
> +	} else {
> +		/*
> +		 * shared read/write queues
> +		 * either no write queues were requested, or we don't have
> +		 * sufficient queue count to have dedicated default queues.
> +		 */
> +		io_queues[HCTX_TYPE_DEFAULT] =
> +			min(opts->nr_io_queues, nr_io_queues);
> +		nr_io_queues -= io_queues[HCTX_TYPE_DEFAULT];
> +	}
> +
> +	if (opts->nr_poll_queues && nr_io_queues) {
> +		/* map dedicated poll queues only if we have queues left */
> +		io_queues[HCTX_TYPE_POLL] =
> +			min(opts->nr_poll_queues, nr_io_queues);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nvme_set_io_queues);

nvmf_ip_set_io_queues. Unless you think that this can be shared with
pci/fc as well?

> +
> +void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
> +		     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES])

Ugh, the ib_device input that may be null is bad...
I think that we can kill blk_mq_rdma_map_queues altogether
and unify the two.

But lets separate this and the patch before from the patch
that fixes the regression. I'd like that one to go asap
and unrelated to the others.

> +{
> +	struct nvmf_ctrl_options *opts = ctrl->opts;
> +
> +	if (opts->nr_write_queues && io_queues[HCTX_TYPE_READ]) {
> +		/* separate read/write queues */
> +		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> +			io_queues[HCTX_TYPE_DEFAULT];
> +		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> +		set->map[HCTX_TYPE_READ].nr_queues =
> +			io_queues[HCTX_TYPE_READ];
> +		set->map[HCTX_TYPE_READ].queue_offset =
> +			io_queues[HCTX_TYPE_DEFAULT];
> +	} else {
> +		/* shared read/write queues */
> +		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> +			io_queues[HCTX_TYPE_DEFAULT];
> +		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> +		set->map[HCTX_TYPE_READ].nr_queues =
> +			io_queues[HCTX_TYPE_DEFAULT];
> +		set->map[HCTX_TYPE_READ].queue_offset = 0;
> +	}
> +
> +	if (dev) {
> +		blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT], dev, 0);
> +		blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ], dev, 0);
> +	} else {
> +		blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> +		blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> +	}
> +
> +	if (opts->nr_poll_queues && io_queues[HCTX_TYPE_POLL]) {
> +		/* map dedicated poll queues only if we have queues left */
> +		set->map[HCTX_TYPE_POLL].nr_queues = io_queues[HCTX_TYPE_POLL];
> +		set->map[HCTX_TYPE_POLL].queue_offset =
> +			io_queues[HCTX_TYPE_DEFAULT] +
> +			io_queues[HCTX_TYPE_READ];
> +		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> +	}
> +
> +	dev_info(ctrl->device,
> +		"mapped %d/%d/%d default/read/poll queues.\n",
> +		io_queues[HCTX_TYPE_DEFAULT],
> +		io_queues[HCTX_TYPE_READ],
> +		io_queues[HCTX_TYPE_POLL]);
> +}
> +EXPORT_SYMBOL_GPL(nvme_map_queues);
> +
>   static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
>   		unsigned int required_opts)
>   {
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dcac3df8a5f76..bad3e21ffb8ba 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -215,5 +215,10 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		struct nvmf_ctrl_options *opts);
> +void nvme_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
> +			u32 io_queues[HCTX_MAX_TYPES]);
> +unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts);
> +void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
> +		     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES]);
>   
>   #endif /* _NVME_FABRICS_H */
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index bbad26b82b56d..cbec566db2761 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -718,18 +718,10 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
>   static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> -	struct ib_device *ibdev = ctrl->device->dev;
> -	unsigned int nr_io_queues, nr_default_queues;
> -	unsigned int nr_read_queues, nr_poll_queues;
> +	unsigned int nr_io_queues;
>   	int i, ret;
>   
> -	nr_read_queues = min_t(unsigned int, ibdev->num_comp_vectors,
> -				min(opts->nr_io_queues, num_online_cpus()));
> -	nr_default_queues =  min_t(unsigned int, ibdev->num_comp_vectors,
> -				min(opts->nr_write_queues, num_online_cpus()));
> -	nr_poll_queues = min(opts->nr_poll_queues, num_online_cpus());
> -	nr_io_queues = nr_read_queues + nr_default_queues + nr_poll_queues;
> -
> +	nr_io_queues = nvme_nr_io_queues(opts);
>   	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
>   	if (ret)
>   		return ret;
> @@ -744,34 +736,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
>   	dev_info(ctrl->ctrl.device,
>   		"creating %d I/O queues.\n", nr_io_queues);
>   
> -	if (opts->nr_write_queues && nr_read_queues < nr_io_queues) {
> -		/*
> -		 * separate read/write queues
> -		 * hand out dedicated default queues only after we have
> -		 * sufficient read queues.
> -		 */
> -		ctrl->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_READ];
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -			min(nr_default_queues, nr_io_queues);
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		/*
> -		 * shared read/write queues
> -		 * either no write queues were requested, or we don't have
> -		 * sufficient queue count to have dedicated default queues.
> -		 */
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -			min(nr_read_queues, nr_io_queues);
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	}
> -
> -	if (opts->nr_poll_queues && nr_io_queues) {
> -		/* map dedicated poll queues only if we have queues left */
> -		ctrl->io_queues[HCTX_TYPE_POLL] =
> -			min(nr_poll_queues, nr_io_queues);
> -	}
> -
> +	nvme_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
>   	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
>   		ret = nvme_rdma_alloc_queue(ctrl, i,
>   				ctrl->ctrl.sqsize + 1);
> @@ -2143,46 +2108,8 @@ static void nvme_rdma_complete_rq(struct request *rq)
>   static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
>   {
>   	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(set->driver_data);
> -	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
>   
> -	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
> -		/* separate read/write queues */
> -		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> -		set->map[HCTX_TYPE_READ].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_READ];
> -		set->map[HCTX_TYPE_READ].queue_offset =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		/* shared read/write queues */
> -		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> -		set->map[HCTX_TYPE_READ].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_READ].queue_offset = 0;
> -	}
> -	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
> -			ctrl->device->dev, 0);
> -	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
> -			ctrl->device->dev, 0);
> -
> -	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
> -		/* map dedicated poll queues only if we have queues left */
> -		set->map[HCTX_TYPE_POLL].nr_queues =
> -				ctrl->io_queues[HCTX_TYPE_POLL];
> -		set->map[HCTX_TYPE_POLL].queue_offset =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
> -			ctrl->io_queues[HCTX_TYPE_READ];
> -		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> -	}
> -
> -	dev_info(ctrl->ctrl.device,
> -		"mapped %d/%d/%d default/read/poll queues.\n",
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT],
> -		ctrl->io_queues[HCTX_TYPE_READ],
> -		ctrl->io_queues[HCTX_TYPE_POLL]);
> +	nvme_map_queues(set, &ctrl->ctrl, ctrl->device->dev, ctrl->io_queues);
>   }
>   
>   static const struct blk_mq_ops nvme_rdma_mq_ops = {
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7723a49895244..96298f8794e1a 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1781,58 +1781,12 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	return ret;
>   }
>   
> -static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
> -{
> -	unsigned int nr_io_queues;
> -
> -	nr_io_queues = min(ctrl->opts->nr_io_queues, num_online_cpus());
> -	nr_io_queues += min(ctrl->opts->nr_write_queues, num_online_cpus());
> -	nr_io_queues += min(ctrl->opts->nr_poll_queues, num_online_cpus());
> -
> -	return nr_io_queues;
> -}
> -
> -static void nvme_tcp_set_io_queues(struct nvme_ctrl *nctrl,
> -		unsigned int nr_io_queues)
> -{
> -	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> -	struct nvmf_ctrl_options *opts = nctrl->opts;
> -
> -	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
> -		/*
> -		 * separate read/write queues
> -		 * hand out dedicated default queues only after we have
> -		 * sufficient read queues.
> -		 */
> -		ctrl->io_queues[HCTX_TYPE_READ] = opts->nr_io_queues;
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_READ];
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -			min(opts->nr_write_queues, nr_io_queues);
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		/*
> -		 * shared read/write queues
> -		 * either no write queues were requested, or we don't have
> -		 * sufficient queue count to have dedicated default queues.
> -		 */
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -			min(opts->nr_io_queues, nr_io_queues);
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	}
> -
> -	if (opts->nr_poll_queues && nr_io_queues) {
> -		/* map dedicated poll queues only if we have queues left */
> -		ctrl->io_queues[HCTX_TYPE_POLL] =
> -			min(opts->nr_poll_queues, nr_io_queues);
> -	}
> -}
> -
>   static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	unsigned int nr_io_queues;
>   	int ret;
>   
> -	nr_io_queues = nvme_tcp_nr_io_queues(ctrl);
> +	nr_io_queues = nvme_nr_io_queues(ctrl->opts);
>   	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
>   	if (ret)
>   		return ret;
> @@ -1847,8 +1801,8 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	dev_info(ctrl->device,
>   		"creating %d I/O queues.\n", nr_io_queues);
>   
> -	nvme_tcp_set_io_queues(ctrl, nr_io_queues);
> -
> +	nvme_set_io_queues(ctrl->opts, nr_io_queues,
> +			   to_tcp_ctrl(ctrl)->io_queues);
>   	return __nvme_tcp_alloc_io_queues(ctrl);
>   }
>   
> @@ -2428,44 +2382,8 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(set->driver_data);
> -	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> -
> -	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
> -		/* separate read/write queues */
> -		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> -		set->map[HCTX_TYPE_READ].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_READ];
> -		set->map[HCTX_TYPE_READ].queue_offset =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		/* shared read/write queues */
> -		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> -		set->map[HCTX_TYPE_READ].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_READ].queue_offset = 0;
> -	}
> -	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> -	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> -
> -	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
> -		/* map dedicated poll queues only if we have queues left */
> -		set->map[HCTX_TYPE_POLL].nr_queues =
> -				ctrl->io_queues[HCTX_TYPE_POLL];
> -		set->map[HCTX_TYPE_POLL].queue_offset =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
> -			ctrl->io_queues[HCTX_TYPE_READ];
> -		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> -	}
> -
> -	dev_info(ctrl->ctrl.device,
> -		"mapped %d/%d/%d default/read/poll queues.\n",
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT],
> -		ctrl->io_queues[HCTX_TYPE_READ],
> -		ctrl->io_queues[HCTX_TYPE_POLL]);
> +
> +	nvme_map_queues(set, &ctrl->ctrl, NULL, ctrl->io_queues);
>   }
>   
>   static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
