Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054BEC28B22
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D334261101
	for <linux-block@archiver.kernel.org>; Thu,  9 Sep 2021 06:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbhIIGdO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 02:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhIIGdO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 02:33:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBC7C061575
        for <linux-block@vger.kernel.org>; Wed,  8 Sep 2021 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=41B3xOaMOkOmkYBxAKE/Vt8LAMpecipLwlcFajaS190=; b=bmbhsHTpBgF2UF3+6HWRRO5QfG
        63oHMi5nIn0c6pZA5vdIKY/UXIl6vfB6znesd2KbFRhVXEEXYKRl5nY9cFifcVgqVSheJorjh7ekW
        aEmfKcsbLK/kgH59on5+f9CcRoOgK9OhIc6eBXtoCr8uxTV0VE71b3XM2zxv1JGKSqnbTgT58bVhY
        Z8cPepq+4rXdwPozI2ooTWIKNwoi4jRn6eFtine3zFc6lbCoXp5Y4NbXdgJI57vGMgy7mYeWmIGpv
        YAfvBnlRUNGq7sA+dXit3craTzunBcHuuPRikYVVqF3WDSZ1z4FedDYHgVbFMmE108bprdjN/rEWe
        oVVkHFhw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mODaO-009Xty-Sq; Thu, 09 Sep 2021 06:31:06 +0000
Date:   Thu, 9 Sep 2021 07:31:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Xie Yongji <xieyongji@bytedance.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, yixingchen@bytedance.com
Subject: Re: [PATCH] nbd: clear wb_err in bd_inode on disconnect
Message-ID: <YTmqJHd7YWAQ2lZ7@infradead.org>
References: <20210907121425.91-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907121425.91-1-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 07, 2021 at 08:14:25PM +0800, Xie Yongji wrote:
> When a nbd device encounters a writeback error, that error will
> get propagated to the bd_inode's wb_err field. Then if this nbd
> device's backend is disconnected and another is attached, we will
> get back the previous writeback error on fsync, which is unexpected.
> To fix it, let's clear out the wb_err on disconnect.

I really do not like how internals of the implementation like into
drivers here.  Can you add a block layer helper to clear any state
instead? This should incude e.g. the size just cleared above and should
also be used by the loop driver as well.
