Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B4C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF69320645
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF69320645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeK0Czv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:55:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:40545 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbeK0Czv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 21:55:51 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Nov 2018 08:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,282,1539673200"; 
   d="scan'208";a="111538070"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 26 Nov 2018 08:01:18 -0800
Date:   Mon, 26 Nov 2018 08:58:17 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Igor Konopko <igor.j.konopko@intel.com>
Cc:     "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Fix PCIe surprise removal scenario
Message-ID: <20181126155816.GQ26707@localhost.localdomain>
References: <20181123155810.60246-1-igor.j.konopko@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123155810.60246-1-igor.j.konopko@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 23, 2018 at 07:58:10AM -0800, Igor Konopko wrote:
> This patch fixes kernel OOPS for surprise removal
> scenario for PCIe connected NVMe drives.
> 
> After latest changes, when PCIe device is not present,
> nvme_dev_remove_admin() calls blk_cleanup_queue() on
> admin queue, which frees hctx for that queue.
> Moment later, on the same path nvme_kill_queues()
> calls blk_mq_unquiesce_queue() on admin queue and
> tries to access hctx of it, which leads to
> following OOPS scenario:
> 
> Oops: 0000 [#1] SMP PTI
> RIP: 0010:sbitmap_any_bit_set+0xb/0x40
> Call Trace:
>  blk_mq_run_hw_queue+0xd5/0x150
>  blk_mq_run_hw_queues+0x3a/0x50
>  nvme_kill_queues+0x26/0x50
>  nvme_remove_namespaces+0xb2/0xc0
>  nvme_remove+0x60/0x140
>  pci_device_remove+0x3b/0xb0
> 
> Fixes: cb4bfda62afa2 ("nvme-pci: fix hot removal during error handling")
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>

Thanks Igor, my previous proposal was a bit flawed, and this patch looks
good. For the future, you should adjust your commit log formatting to
use the more standard 72 character width.

The fix should go in for the next rc for sure. Maybe longer term, if
a request_queue has an active reference, it might make sense to have
blk-mq's APIs consistently handle these sorts of things.

Reviewed-by: Keith Busch <keith.busch@intel.com>


> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 65c42448e904..5aff95389694 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3601,7 +3601,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
>  	down_read(&ctrl->namespaces_rwsem);
>  
>  	/* Forcibly unquiesce queues to avoid blocking dispatch */
> -	if (ctrl->admin_q)
> +	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
>  		blk_mq_unquiesce_queue(ctrl->admin_q);
>  
>  	list_for_each_entry(ns, &ctrl->namespaces, list)
> -- 
> 2.14.5
