Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B244AC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 21:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80CB62086B
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 21:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80CB62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbeK3ISV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:18:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:19781 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbeK3ISV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 03:18:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 13:11:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="254584137"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2018 13:11:35 -0800
Date:   Thu, 29 Nov 2018 14:08:40 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/13] nvme-pci: remove the CQ lock for interrupt driven
 queues
Message-ID: <20181129210840.GG9377@localhost.localdomain>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129191310.9795-9-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 08:13:05PM +0100, Christoph Hellwig wrote:
> @@ -1050,12 +1051,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
>  	irqreturn_t ret = IRQ_NONE;
>  	u16 start, end;
>  
> -	spin_lock(&nvmeq->cq_lock);
> +	/*
> +	 * The rmb/wmb pair ensures we see all updates from a previous run of
> +	 * the irq handler, even if that was on another CPU.
> +	 */
> +	rmb();
>  	if (nvmeq->cq_head != nvmeq->last_cq_head)
>  		ret = IRQ_HANDLED;
>  	nvme_process_cq(nvmeq, &start, &end, -1);
>  	nvmeq->last_cq_head = nvmeq->cq_head;
> -	spin_unlock(&nvmeq->cq_lock);
> +	wmb();
>  
>  	if (start != end) {
>  		nvme_complete_cqes(nvmeq, start, end);

We saved the "start, end" only so we could do the real completion
without holding a queue lock. Since you're not using a lock anymore,
a further optimization can complete the CQE inline with moving the cq
head so that we don't go through queue twice.

That can be a follow on, though, this patch looks fine.

Reviewed-by: Keith Busch <keith.busch@intel.com>
