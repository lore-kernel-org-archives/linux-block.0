Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC278C43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B6220818
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B6220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733000AbeKOBoT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:44:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:11717 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732950AbeKOBoT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:44:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 07:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,232,1539673200"; 
   d="scan'208";a="108202616"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga001.jf.intel.com with ESMTP; 14 Nov 2018 07:40:33 -0800
Date:   Wed, 14 Nov 2018 08:37:07 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/6] nvme: don't disable local ints for polled queue
Message-ID: <20181114153706.GA11416@localhost.localdomain>
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-2-axboe@kernel.dk>
 <20181114084322.GA14954@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114084322.GA14954@infradead.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 14, 2018 at 12:43:22AM -0800, Christoph Hellwig wrote:
> static int nvme_poll_noirq(struct blk_mq_hw_ctx *hctx, unsigned int tag)
> {
>         struct nvme_queue *nvmeq = hctx->driver_data;
> >  	u16 start, end;
> 	bool found;
> >  
> >  	if (!nvme_cqe_pending(nvmeq))
> >  		return 0;
> >  
> > +	spin_lock(&nvmeq->cq_lock);
> >  	found = nvme_process_cq(nvmeq, &start, &end, tag);
> > +	spin_unlock(&nvmeq->cq_lock);
> > +
> >  	nvme_complete_cqes(nvmeq, start, end);
> >  	return found;
> 
> And while we are at it:  I think for the irq-driven queues in a
> separate queue for poll setup we might not even need to take the
> CQ lock.  Which might be an argument for only allowing polling
> if we have the separate queues just to keep everything simple.

That's a pretty cool observation. We still poll interrupt driven queues
in the timeout path as a sanity check (it really has helped in debugging
timeout issues), but we can temporarily disable the cq's irq and be
lockless.
