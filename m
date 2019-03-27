Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E93C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 06:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A8D22075D
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553669448;
	bh=u6Xyy14cXyCMnPtVwZQ17b0SeMUzittednYp8JmoM7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=meoz1sdvFvzKXKEAJNYlopK6alOmp6/xDc3oLKF4F4vmN+zSNaFLiTwlqn12Cn1mX
	 gVArlQJTcLMJLUHcKbxTjWaRQOUVUCXz8OYO62/pagw2C7xYUZvyznqrWbCB1pcqYQ
	 WGyamyOfe2WdaD8aWr+dZqK2GYN+QAHTEawqeN3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbfC0Gur (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:50:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:15182 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbfC0Gur (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 02:50:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 23:50:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,275,1549958400"; 
   d="scan'208";a="126216665"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2019 23:50:45 -0700
Date:   Wed, 27 Mar 2019 00:51:56 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-nvme <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V2 7/8] nvme: use blk_mq_queue_tag_inflight_iter
Message-ID: <20190327065156.GC7389@localhost.localdomain>
References: <20190325134917.GA4328@localhost.localdomain>
 <70e14e12-2ffc-37db-dd8f-229bc580546e@oracle.com>
 <CACVXFVMw9G6n44-knV6oa3FxJ6YzN05ZRajkgUnhLJupnkadOQ@mail.gmail.com>
 <d749592c-42c8-19a8-0885-5048a2101e5a@oracle.com>
 <20190326235726.GC4328@localhost.localdomain>
 <c0d65c3c-bf2e-ff84-caac-e64b30e4e79f@oracle.com>
 <20190327021521.GA7389@localhost.localdomain>
 <1bbe1b5c-3564-55e8-6824-f679b3c5dd3f@oracle.com>
 <20190327023354.GB7389@localhost.localdomain>
 <9f3a574d-d2ea-3fd0-472c-85ad0bae4daf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f3a574d-d2ea-3fd0-472c-85ad0bae4daf@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 27, 2019 at 10:45:33AM +0800, jianchao.wang wrote:
> 1. a hctx->fq.flush_rq of dead request_queue that shares the same tagset
>    The whole request_queue is cleaned up and freed, so the hctx->fq.flush is freed back to a slab
>
> 2. a removed io scheduler's sched request
>    The io scheduled is detached and all of the structures are freed, including the pages where sched
>    requests locates.
> 
> So the pointers in tags->rqs[] may point to memory that is not used as a blk layer request.

Oh, free as in kfree'd, not blk_mq_free_request. So it's a read-after-
free that you're concerned about, not that anyone explicitly changed a
request->state.

We at least can't free the flush_queue until the queue is frozen. If the
queue is frozen, we've completed the special fq->flush_rq where its end_io
replaces tags->rqs[tag] back to the fq->orig_rq from the static_rqs,
so nvme's iterator couldn't see the fq->flush_rq address if it's invalid.

The sched_tags concern, though, appears theoretically possible.
