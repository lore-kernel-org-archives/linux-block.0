Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38641C433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21CCC60C4B
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbhJPEmZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 00:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbhJPEmY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 00:42:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A76CC061570
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 21:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=z0vO4dXAWuwVXUc7HsJUAWzlkoDXICJSohT6FU4ScNY=; b=Gtm6SYtOkx3h7UvnKWGVgPuiim
        95veErAdKA17vMPzRPX/xs+p9bZnRQv5lRMoh1RU+msGbIvWFmwtpOSGRAupCe6AeFjpAltxDJZk2
        yzsEt+gIASXMHsN9/QNGbKKg44Wn26Axe1KJswU6i+sdIegXg70dWoQ+wv4180ZraduVKh2fpofu2
        aGBeRh+v5xttt24/X8R2OcyUFwQIkoUhApvzdr/ur6vXllVaKitR5SP8edjbDgrA2Fk5PO0RYDFWc
        HMz9VLBJx5QIWJR+IaGRCfGC7/hGM2Xm7lNpcA0aM/P/vTycB7D4XX+kGq48UWY1Ci4z3PZhU3aMF
        OqlEuxbQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbbUX-009jxu-80; Sat, 16 Oct 2021 04:40:17 +0000
Date:   Fri, 15 Oct 2021 21:40:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: handle fast path of bio splitting inline
Message-ID: <YWpXsaw1nKmYOvOy@infradead.org>
References: <30045b11-0064-1849-5b10-f8fa05c6958d@kernel.dk>
 <YWfCY7LuCldVANXj@infradead.org>
 <87379eeb-679a-19a9-2b00-89ff64b34113@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87379eeb-679a-19a9-2b00-89ff64b34113@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 07:16:50AM -0600, Jens Axboe wrote:
> On 10/13/21 11:38 PM, Christoph Hellwig wrote:
> > On Wed, Oct 13, 2021 at 02:44:14PM -0600, Jens Axboe wrote:
> >> The fast path is no splitting needed. Separate the handling into a
> >> check part we can inline, and an out-of-line handling path if we do
> >> need to split.
> >>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > 
> > What about something like this version instead?
> 
> A bit of a combo, I think this will do fine.

Fine with me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
