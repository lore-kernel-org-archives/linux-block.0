Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE358C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8436101D
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 17:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbhJMR32 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 13:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhJMR32 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 13:29:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A9C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f8Tl+yDNSxaTrcvO5Pfeh/nf+riwY5tsFTmFxFTsomI=; b=X599FTL+IMDj8Z6HFpTc+CC49Y
        s8aWjyg398IN9duXJgyVZ0Ixd35ZtilmmN7hAby2pXgWSj6Ex9WmZ8bCqNKAW+ubnJwggDwJeRbOC
        ADDXUUJbFuj7voAEdSFFRrqjrMdT92yr4a+bqOD+YAb9FyE8YNSe5LjqFhpR0Nx/tC+UOsHz7bttF
        NpRtqkb1jPlsO+d46JCN6OsZIZy/cgPtHzG9XJnBH0wnYmNig7ISTzqklLIYS3I1TWWyhKrLSE5Lm
        KDJm1HgWebNV8FKYcfHuolIBtPu8F1XtlXpJ8ZKVV9zM78vLsShsz/zwxYCNgyMsmLmTFoyP4HGAV
        r/NY1bIA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mai1F-007f1L-CE; Wed, 13 Oct 2021 17:26:38 +0000
Date:   Wed, 13 Oct 2021 18:26:21 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] block: don't bother iter advancing a fully done bio
Message-ID: <YWcWvdwVNoM6Stag@infradead.org>
References: <20211013164937.985367-1-axboe@kernel.dk>
 <20211013164937.985367-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013164937.985367-4-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 13, 2021 at 10:49:36AM -0600, Jens Axboe wrote:
> +extern void __bio_advance(struct bio *, unsigned);

No need for the extern, but it would be nice to spell out the argument
names.

> +static inline void bio_advance(struct bio *bio, unsigned int nbytes)
> +{

The kerneldoc comment for bio_advance needs to move here now.
