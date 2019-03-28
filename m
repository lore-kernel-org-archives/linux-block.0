Return-Path: <SRS0=7L3l=R7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B95EC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 03:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FA32075E
	for <linux-block@archiver.kernel.org>; Thu, 28 Mar 2019 03:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553743927;
	bh=NACTPYz6sQRsa3cR4+CBhxoUmDh3jdfIQ6Z45wKamUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vHN54FOWK1p+kTnmf0+R2ryTg2CZiIIC6jcAkt25EZcXr6hHFE2pm3OqRd9G2FPC6
	 IfwTKkzuniYkTHXm6mPJ9gDYLz/NbkIRl0NnoT8k1MpFGE9VVeQSKSsROocUC3ZQoM
	 gWcHF7cgFOpCv9NRL47V476s/v3VKQ73xnrcoe1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfC1DcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 23:32:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:53673 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbfC1DcG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 23:32:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 20:32:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,278,1549958400"; 
   d="scan'208";a="137893966"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga003.jf.intel.com with ESMTP; 27 Mar 2019 20:32:05 -0700
Date:   Wed, 27 Mar 2019 21:33:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
Message-ID: <20190328033317.GC8448@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com>
 <20190311184031.GA11707@lst.de>
 <20190311193753.GE10411@localhost.localdomain>
 <20190327083142.GQ20525@lst.de>
 <20190327132116.GA8419@localhost.localdomain>
 <3d72ec9f-0aa5-d455-b453-40c319871287@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d72ec9f-0aa5-d455-b453-40c319871287@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 28, 2019 at 09:42:51AM +0800, jianchao.wang wrote:
> On 3/27/19 9:21 PM, Keith Busch wrote:
> > +void blk_mq_terminate_queued_requests(struct request_queue *q, int hctx_idx)
> > +{
> > +	if (WARN_ON_ONCE(!atomic_read(&q->mq_freeze_depth)))
> > +		return;
> > +	if (WARN_ON_ONCE(!blk_queue_quiesced(q)))
> > +		return;
> > +	blk_sync_queue(q);
> > +	blk_mq_queue_tag_busy_iter(q, blk_mq_terminate_request, &hctx_idx);
> > +}
> 
> 
> Is it really OK to end these requests directly w/o dequeue ?
> All of them are on ctx->rq_list, or hctx->dispatch list or internal queue of io scheduler.
> 
> Terrible things may happen after we unquiesce the queue.

Good point. This was intended as a last action before killing an hctx or
the entire request queue, so I didn't expect they'd be turned back on, but
it's easy enough to splice lists and handle those requests directly. We
wouldn'even need to iterate tags that way, and may be better way to
handle this.
