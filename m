Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFAAC04AAC
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 11:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6F720675
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 11:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbfETLMD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 07:12:03 -0400
Received: from verein.lst.de ([213.95.11.211]:51559 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbfETLMD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 07:12:03 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id ED9F268B20; Mon, 20 May 2019 13:11:41 +0200 (CEST)
Date:   Mon, 20 May 2019 13:11:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block: don't decrement nr_phys_segments for
 physically contigous segments
Message-ID: <20190520111141.GA5137@lst.de>
References: <20190516084058.20678-1-hch@lst.de> <20190516084058.20678-2-hch@lst.de> <20190516131703.GA26943@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516131703.GA26943@ming.t460p>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 16, 2019 at 09:17:04PM +0800, Ming Lei wrote:
> ll_merge_requests_fn() is only called from attempt_merge() in case
> that ELEVATOR_BACK_MERGE is returned from blk_try_req_merge(). However,
> for discard merge of both virtio_blk and nvme, ELEVATOR_DISCARD_MERGE is
> always returned from blk_try_req_merge() in attempt_merge(), so looks
> ll_merge_requests_fn() shouldn't be called for virtio_blk/nvme's discard
> request. Just wondering if you may explain a bit how the change on
> ll_merge_requests_fn() in this patch makes a difference on the above
> two commits?

Good question.  I've seen virtio overwriting its range, but I think
this might have been been with a series to actually decrement
nr_phys_segments for all cases where we can merge the tail and front
bvecs.  So mainline probably doesn't see it unless someone calls
blk_recalc_rq_segments due to a partial completion or when using
dm-multipath.  Thinking of it at least the latter seems like a real
possibily, although a rather unlikely use case.

> > Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
> 
> I guess it should be dff824b2aadb ("nvme-pci: optimize mapping of small
> single segment requests").

Indeed.
