Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7C0C34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD91324654
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cyo/GGaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgBSQgQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:36:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34282 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgBSQgQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7ZSbNFkxei41IBj0vQCwV7MDN8Vq2H6fNuqbJft01qc=; b=Cyo/GGaRgIWMGOogxR2laGCqOs
        QmbJPjaUllV4ccs4NoDJXB8yVj0rbDMW+rjmWQr217DWdPpyQZ/MbAZHsBiZxqvZ8nPwggcoj5iBN
        c9THBYGzY6508A0jwL2Nk4aITxlNrK2cba+9hxSC9cM3px0gLZoA3HQOoPtDUyGUth+KTYPLp9ak+
        cJ8x+jhihq44IUlT/SPLUqZQM/EByQ/6iYXxSLsez6hQ65o1m7cwKr4g4ZmvrmC8NE6t15fXtTkHZ
        1fhfA1O3rO/4KbXZ3EC+AOidkCMenkqhGIpdiDIk3da25stIQx3+Id2qLN7JxcFHfZqNBMIJYp06F
        BCmYgB4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SKd-00076v-5c; Wed, 19 Feb 2020 16:36:15 +0000
Date:   Wed, 19 Feb 2020 08:36:15 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: insert passthrough request into hctx->dispatch
 directly
Message-ID: <20200219163615.GE18377@infradead.org>
References: <20200215032140.4093-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215032140.4093-1-ming.lei@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 15, 2020 at 11:21:40AM +0800, Ming Lei wrote:
> For some reason, device may be in one situation which can't handle
> FS request, so STS_RESOURCE is always returned and the FS request
> will be added to hctx->dispatch. However passthrough request may
> be required at that time for fixing the problem. If passthrough
> request is added to scheduler queue, there isn't any chance for
> blk-mq to dispatch it given we prioritize requests in hctx->dispatch.
> Then the FS IO request may never be completed, and IO hang is caused.
> 
> So passthrough request has to be added to hctx->dispatch directly.
> 
> Fix this issue by inserting passthrough request into hctx->dispatch
> directly. Then it becomes consistent with original legacy IO request
> path, in which passthrough request is always added to q->queue_head.

Do you have a description of an actual problem this fixes?  Maybe even
a reproducer for blktests?
