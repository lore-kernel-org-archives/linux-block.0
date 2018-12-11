Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7590C07E85
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8946E2054F
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 13:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8946E2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbeLKNmW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:42:22 -0500
Received: from verein.lst.de ([213.95.11.211]:55412 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbeLKNmW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 08:42:22 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7CE1868DD2; Tue, 11 Dec 2018 14:42:20 +0100 (CET)
Date:   Tue, 11 Dec 2018 14:42:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5/5] nvme-rdma: support read/write queue separation
Message-ID: <20181211134220.GE20614@lst.de>
References: <20181211104936.25333-1-sagi@grimberg.me> <20181211104936.25333-6-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211104936.25333-6-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This probably wants a little explanation..

>  	struct nvme_rdma_ctrl *ctrl = set->driver_data;
> +	struct blk_mq_queue_map *map;
> +	int offset = 0;
> +
> +	if (ctrl->ctrl.opts->nr_write_queues) {
> +		/* separate read/write queues */
> +		map = &set->map[HCTX_TYPE_DEFAULT];
> +		map->queue_offset = offset;
> +		map->nr_queues = ctrl->ctrl.opts->nr_write_queues;
> +		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
> +		offset += map->nr_queues;
> +
> +		map = &set->map[HCTX_TYPE_READ];
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		map->queue_offset = offset;
> +		blk_mq_rdma_map_queues(map, ctrl->device->dev, offset);
> +		offset += map->nr_queues;
>  
> +	} else {
> +		/* mixed read/write queues */
> +		map = &set->map[HCTX_TYPE_DEFAULT];
> +		map->queue_offset = 0;
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
> +
> +		map = &set->map[HCTX_TYPE_READ];
> +		map->queue_offset = 0;
> +		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
> +		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
> +	}

Same comment and suggested style as for the TCP one.
