Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73560C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0EA206BB
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 08:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L2eZLvKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A0EA206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeKSSZs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 13:25:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeKSSZs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 13:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5tNOk6xlpRAjAQieLiQgb7mPnwANAz+tjmMssWaJqUM=; b=L2eZLvKBBieqM5b2jVtDgvPYQ
        In5uuhoQrYP3oRpLeZ47t5KUzQ5UzcP6wLUEiXzbiXwoJjkhhTINUhA0MaYE4kWHK2dEte02yV8PB
        jpmiFuOP0lvsrdSFItroeauaaf1L6VISjdbohhcx3h8qCftR5wCdJa8VDtAM9l9nB94VjkyCsVzAF
        EsyVyq9SOtUL++uLDScrXQU3osjy5uM2RurF1w24atnNFI02mfbk8QG6yD83sEFWKeLLOJOpdi909
        OH6DdSohPCpOeVMTYd4E1ApoT0uvHcXJn9iDi5U0UhuSjZO2cb3IdN46XWTAR3eqWpFo15EtVlu0M
        9DnUln29A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOeWG-00050F-NT; Mon, 19 Nov 2018 08:02:56 +0000
Date:   Mon, 19 Nov 2018 00:02:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/7] blk-mq: remove 'tag' parameter from mq_ops->poll()
Message-ID: <20181119080256.GE9622@infradead.org>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-6-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181117214354.822-6-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 17, 2018 at 02:43:52PM -0700, Jens Axboe wrote:
> We always pass in -1 now and none of the callers use the tag value,
> remove the parameter.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
