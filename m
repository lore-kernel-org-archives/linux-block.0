Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A5BC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318162082F
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cFOedgbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318162082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbeK3CxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:53:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33772 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbeK3CxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:53:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=x9U4P1d1f2Mxw/kJUN84lCBIy/hYWiLKM5+b0CBYb9o=; b=cFOedgbJ3kcdWfOJwic306hfX
        JPKeDMTGYqfTMQdb566VDPgw1VVk0NyBBVdGMIz4HVt06cY/2MBsw+yJ8oCG8gSE98TZLu411eRwr
        8ZBxv8jb7xawr0NrXJ62yjoeeHq7aCWYrpNDKv9t3c27M5PkxzE49fOj+FmgkvKi+SXlshQcO7vy8
        rUbuoHMNZqmaWaqGs/IpamVOfEldRoUJ0c27d84wDZCajgy4rq9LBnoQyf89fNe2BeX2Gc+hRoBZD
        2Gys/wuiwxTW72vsjG/6glyrVbEaUJ9XtV2XXJbPs3ioA2f2lXRj/cWPQw7iG7iicUs+hejnzzLHe
        LVsNzqAuw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOXQ-0004WQ-OG; Thu, 29 Nov 2018 15:47:36 +0000
Date:   Thu, 29 Nov 2018 07:47:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] ataflop: implement mq_ops->commit_rqs() hook
Message-ID: <20181129154736.GD7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128133538.20329-6-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 06:35:36AM -0700, Jens Axboe wrote:
> We need this for blk-mq to kick things into gear, if we told it that
> we had more IO coming, but then failed to deliver on that promise.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
