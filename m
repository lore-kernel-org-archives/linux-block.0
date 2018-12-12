Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52CCC04EB8
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A6C20851
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 07:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A6C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbeLLHLm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 02:11:42 -0500
Received: from verein.lst.de ([213.95.11.211]:60258 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbeLLHLm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 02:11:42 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3401768D8D; Wed, 12 Dec 2018 08:11:40 +0100 (CET)
Date:   Wed, 12 Dec 2018 08:11:40 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH RFC 4/4] nvme-multipath: disable polling for underlying
 namespace request queue
Message-ID: <20181212071140.GD28461@lst.de>
References: <20181211233652.9705-1-sagi@grimberg.me> <20181211233652.9705-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211233652.9705-5-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

[adding Jens]

> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1547,6 +1547,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	if (ns->head->disk) {
>  		nvme_update_disk_info(ns->head->disk, ns, id);
>  		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
> +		/* XXX: multipath device does not support polling for now... */
> +		blk_queue_flag_clear(QUEUE_FLAG_POLL, ns->queue);

I'd drop the XXX.  But I think we actually have a block layer problem
here.  Currently stacking devices will just pass through REQ_HIPRI,
despite none of them supporting any polling for it.

So we need to make sure in the block layer or I/O submitter that
REQ_HIPRI is only set if QUEUE_FLAG_POLL is supported.  I think it would
also help if we rename it to REQ_POLL to make this more obvious.

