Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A7CC433DB
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 08:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7EB22AAF
	for <linux-block@archiver.kernel.org>; Mon, 11 Jan 2021 08:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbhAKIGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbhAKIGa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Jan 2021 03:06:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FBCC061786;
        Mon, 11 Jan 2021 00:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/462xsoiQ5s3oGp2fbaA+kjjbZ55BjDK0eDv97mG05A=; b=E3ao1TNNWj8lhdcseniY57FgDm
        psn5Oo/Hh8p0p0HrnZ56ZZPpKQ05V9ti7WNEcnaMnQL675Lc6yEsykIDM4a3WCxYXIPr3/sBU2JTw
        UWdhqc0AqYBlChLrus7ouaPT/R2zR0B+wivcSMmFACTzH0V+Vh06zjXwEU/im/5FZqHgmY9TtjOJa
        xKpQ7be8neYQt4I8rXr8pPQ5q2sOCR16Nxh64KgE8LDpf3iFWAoIKcZ+SrrJo/cGnPJMXOvJy2Y+d
        XIfQGtWBkO/958/LhE8zvg462raCfEiGMQ0Q5sT9R8UWXiGCm1KOByorBmed0Vm1/WCYzUcN/qVMV
        zsdwDANQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kysCl-002uzS-V9; Mon, 11 Jan 2021 08:05:40 +0000
Date:   Mon, 11 Jan 2021 08:05:35 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: don't revert iter on -EIOCBQUEUED
Message-ID: <20210111080535.GA693550@infradead.org>
References: <f5247b60e7abbd2ff850cd108491f53a2e0c501a.1610207781.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5247b60e7abbd2ff850cd108491f53a2e0c501a.1610207781.git.asml.silence@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 09, 2021 at 04:00:32PM +0000, Pavel Begunkov wrote:
> Currently, if I/O is enqueued for async execution direct paths of
> generic_file_{read,write}_iter() will always revert the iter. There are
> no users expecting that, and that is also costly. Leave iterators as is
> on -EIOCBQUEUED.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
