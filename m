Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39167C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CD520832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 07:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z0eSQ9mu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CD520832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeK1SQk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 13:16:40 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeK1SQk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 13:16:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5giSuqvoNJtla1IuEAfF5D+3ryGO5plKSrmnWmVxbWc=; b=Z0eSQ9muLkh5hkAspC3xrl2rq
        Db8OmdyTcqGxxe72UCInyprdUJamaElmB1oAMkzSmDvXY4EDI5cg4fBm1TQYv83/3bY/xuorgDLE0
        PIWBLFLhDBICk3vjFTcr/DXQ4cS2zQ1xhK3AmI5ZbKIfdW9dYA4Yuotk+qLwq1op+XY9Ay1lnzmgT
        0KHvtv9WurbyWz0lHnmeEiNPPmvZ2xTSdUIaR7nmy+HDDAC2d2g1Orj8TP+NJ7Xo5UyTz7LIVMz6o
        LilI4y+KNfKdOEoGU/knYlG5Jhme82/g7BUzrqI2r/cl14b3Ql9rV+QQzWmx6RJobXDtMSpHSv01X
        fLei+TPVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRu4n-0004NB-UK; Wed, 28 Nov 2018 07:16:01 +0000
Date:   Tue, 27 Nov 2018 23:16:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/8] blk-mq: add mq_ops->commit_rqs()
Message-ID: <20181128071601.GA11774@infradead.org>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126163556.5181-4-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 09:35:51AM -0700, Jens Axboe wrote:
> blk-mq passes information to the hardware about any given request being
> the last that we will issue in this sequence. The point is that hardware
> can defer costly doorbell type writes to the last request. But if we run
> into errors issuing a sequence of requests, we may never send the request
> with bd->last == true set. For that case, we need a hook that tells the
> hardware that nothing else is coming right now.
> 
> For failures returned by the drivers ->queue_rq() hook, the driver is
> responsible for flushing pending requests, if it uses bd->last to
> optimize that part. This works like before, no changes there.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

This looks fine, but normally I would only add the method together with
the actual user..

Reviewed-by: Christoph Hellwig <hch@lst.de>
