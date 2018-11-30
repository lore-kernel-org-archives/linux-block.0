Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEE8C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A83C6206B7
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 08:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83C6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbeK3TZA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:25:00 -0500
Received: from verein.lst.de ([213.95.11.211]:48754 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeK3TZA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 14:25:00 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 8F4C468BDF; Fri, 30 Nov 2018 09:16:29 +0100 (CET)
Date:   Fri, 30 Nov 2018 09:16:29 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/13] nvme-pci: remove the CQ lock for interrupt
 driven queues
Message-ID: <20181130081629.GD18936@lst.de>
References: <20181129191310.9795-1-hch@lst.de> <20181129191310.9795-9-hch@lst.de> <20181129210840.GG9377@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129210840.GG9377@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 02:08:40PM -0700, Keith Busch wrote:
> On Thu, Nov 29, 2018 at 08:13:05PM +0100, Christoph Hellwig wrote:
> > @@ -1050,12 +1051,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
> >  	irqreturn_t ret = IRQ_NONE;
> >  	u16 start, end;
> >  
> > -	spin_lock(&nvmeq->cq_lock);
> > +	/*
> > +	 * The rmb/wmb pair ensures we see all updates from a previous run of
> > +	 * the irq handler, even if that was on another CPU.
> > +	 */
> > +	rmb();
> >  	if (nvmeq->cq_head != nvmeq->last_cq_head)
> >  		ret = IRQ_HANDLED;
> >  	nvme_process_cq(nvmeq, &start, &end, -1);
> >  	nvmeq->last_cq_head = nvmeq->cq_head;
> > -	spin_unlock(&nvmeq->cq_lock);
> > +	wmb();
> >  
> >  	if (start != end) {
> >  		nvme_complete_cqes(nvmeq, start, end);
> 
> We saved the "start, end" only so we could do the real completion
> without holding a queue lock. Since you're not using a lock anymore,
> a further optimization can complete the CQE inline with moving the cq
> head so that we don't go through queue twice.
> 
> That can be a follow on, though, this patch looks fine.

We still hold the lock for the polling case.
