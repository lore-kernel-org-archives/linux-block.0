Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF9EC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B544B214AF
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 15:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S4p279uX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfLLPrx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:47:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:54444 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbfLLPrx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 10:47:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IEJ3LeivFspfBiEBb2hcfjpdM0Mp6JK3jjIKi4Wc18c=; b=S4p279uXXCBU2Sr7nSNRYnMxg
        XiIwyLIqLjc1P45nwb/Wj3dgZbFCAcqAr7eEAiLZr6zwJBPMeKUiODz9cIszdXW3b14yOn5qVpV6U
        NB7t01b2WDvZCld45yc9I8rWI2VGusbHpRmMMRbw8OF247CsdscrR/85ZguLg0qLb5FrKuvixAKFm
        NbRsRjYvwPj/XAosoZI+sW4d7jEKcasecmk0NUdKxzrSyI5YRMGcQLFUz646ffp/e5gYFeTl+qLF+
        qWR2ldl1Vj6gMlEbWATpI8mF1XNgccJguf2rMJ65uTsl6wAMXPIVlzp7HO7tXjs3QMkxYiTOPhg7J
        3xorWtnyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ifQgy-0002qW-C1; Thu, 12 Dec 2019 15:47:52 +0000
Date:   Thu, 12 Dec 2019 07:47:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCHSET 0/5] Support for RWF_UNCACHED
Message-ID: <20191212154752.GA3936@infradead.org>
References: <20191210162454.8608-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210162454.8608-1-axboe@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 10, 2019 at 09:24:49AM -0700, Jens Axboe wrote:
> Seems to me that we have an opportunity to provide something that sits
> somewhere in between buffered and O_DIRECT, and this is where
> RWF_UNCACHED enters the picture. If this flag is set on IO, we get the
> following behavior:
> 
> - If the data is in cache, it remains in cache and the copy (in or out)
>   is served to/from that.
> 
> - If the data is NOT in cache, we add it while performing the IO. When
>   the IO is done, we remove it again.
> 
> With this, I can do 100% smooth buffered reads or writes without pushing
> the kernel to the state where kswapd is sweating bullets. In fact it
> doesn't even register.
> 
> Comments appreciated! Patches are against current git (ish), and can
> also be found here:

I can't say I particularly like the model, as it still has all the
page cache overhead.  Direct I/O with bounce buffers for unaligned I/O
sounds simpler and faster to me.
