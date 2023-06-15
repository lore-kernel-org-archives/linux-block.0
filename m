Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E2CEB64DB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 04:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243037AbjFOE2m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 00:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjFOE2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 00:28:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3384D1BF8;
        Wed, 14 Jun 2023 21:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ejG9w4cJPpMx2MtWB2/TzesTTrIbhlDblEatBL+rFFo=; b=xlBbCBMWMtAXw4/lR2YXaFekAY
        pQOd7xmG5/woIsGPh6uaVJ+hy0XKBIA//1I3mTgPpxbTKUuMVCRLrAnuWitbNiFstGurMdBKPtu3/
        dog6vyLQpRb1C9QD+4sqnKBJuAlLVhTAS/WRTn2GphvG+lc6JSDGzF2f9YIOXQyhqbdrctjq0LhlI
        j4ZCaFufiqhOptpsPWUbj7FcLAUgazzmX7DoqsKbf+wxC0J/ARP2IBqRPcqEX7LrBgnU1JCs/TU8H
        FlKGJdGwLehbljfpE+S/IJhM9vypRUj7p1M7ViT06BseYTyqOI/uNiCA0rr2A9ophyc0Wrlr1WiUM
        Z0+AJRTg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9eb1-00Db7S-2x;
        Thu, 15 Jun 2023 04:28:31 +0000
Date:   Wed, 14 Jun 2023 21:28:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        Joanne Dow <jdow@earthlink.net>
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
Message-ID: <ZIqTb4ri+mb5JIbk@infradead.org>
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <3748744.kQq0lBPeGt@lichtvoll.de>
 <86671bf8-98db-7d82-f7cb-a80d6f6c064c@gmail.com>
 <4507409.LvFx2qVVIh@lichtvoll.de>
 <98267647-af04-d463-cb5d-c5d6b0a05777@gmail.com>
 <82d25ec7-47cb-cb40-c800-892af48a71f6@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d25ec7-47cb-cb40-c800-892af48a71f6@linux-m68k.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 15, 2023 at 10:13:14AM +1000, Finn Thain wrote:
> > affs_hardblocks.h is a UAPI header - what are the rules and 
> > ramifications around changes to those? Might not be worth the hassle in 
> > the end.
> > 
> 
> I think it's safe to fix the UAPI header if we are talking about 
> endianness annotations that affect static checking and not code 
> generation. The existing annotations in that struct would appear to 
> support that notion, if indeed they were put there for the benefit of the 
> kernel.

More importantly there has never been any API gurantee in the UAPI
headers.  Compiling user space code absolutely may break due to changes
to them (although we avoid that if we can), we just must not change the
kernel ABI.  But as as said the __be annotations are no-ops for
compilers, and do the right thing even in userspace for projects using
sparse.
