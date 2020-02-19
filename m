Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F0AC34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7DA2067D
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="niu1WAtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBSQ3p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:29:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgBSQ3p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iUyZYR9GtHsqp6ca6i8w76xqJZyMl4tEiGeZvPZ5XXM=; b=niu1WAtKtAqafCCgRnj1JNZOXf
        ZNg1RNu47+eanqVjpOW+IAZM/BXCIVxN+mN7JkRzIEg0qv0EowwspUeEnHKxq9bMg8428bbtR04sK
        yUg9OeN1BvAPfnN9JnziullUjPSWkl4Gs47fB7qhsO8RVTef6AR2PEFylzOJ5PoaqFXJmRWvWnoZp
        IlreGaqAU6a6/xs0PqP05ECrnd3c6hcOUYoXE3Gh7N525gxSAYGkPxXup+eRp3I7iy+knrtC0ML8u
        5ISHTwK6wIDAp8SB0T6x/6ZTA17A7roH2FKkw40TQYJpWtHELTVkoJpUq3IChmpeyCSeM3a72NGi7
        BVBYhTwA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SEL-0003Id-DW; Wed, 19 Feb 2020 16:29:45 +0000
Date:   Wed, 19 Feb 2020 08:29:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] bcache: move macro btree() and btree_root() into
 btree.h
Message-ID: <20200219162945.GD10644@infradead.org>
References: <20200215082858.128025-1-colyli@suse.de>
 <20200215082858.128025-2-colyli@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215082858.128025-2-colyli@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 15, 2020 at 04:28:56PM +0800, Coly Li wrote:
> In order to accelerate bcache registration speed, the macro btree()
> and btree_root() will be referenced out of btree.c. This patch moves
> them from btree.c into btree.h with other relative function declaration
> in btree.h, for the following changes.

Can you give them a bcache_ prefix?  That names are awfully generic
and bound to clash sooner or later.
