Return-Path: <SRS0=Gtqi=QL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 496BDC282C4
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3FC2082F
	for <linux-block@archiver.kernel.org>; Mon,  4 Feb 2019 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oE4f7OOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfBDO4h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:56:37 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46962 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbfBDO4h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Feb 2019 09:56:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NTbl8csVK76Z6t+JwDYMZggiZpbSYw6oPTXWImx8SHY=; b=oE4f7OOYGxnLDFfiExzgLTjrK
        F5u4OW5tZlBzwUZAFE4U0lzT1ICis9PR0lkCu6hdH9/jcO0c4vUP/oQKePam+2/aInZeR8v8bkBxq
        C0qTynpdQUJSHO4xvx417k+S0QkpcTlr0SEJHnMTKgMxGHnGHYEYiljIgxZqGfPoBZqbv0KjjbEC1
        5791c2ONivYZYZa9qMCqRFr8oiROA+aKl+8i1wqQTjwJRFCYIIhz3/L0hTsk5maw4COyecssajpE2
        iUiQhTqcNs63+Y60Qzj4TrunVB+zf6DLzeOoinnJwOqYiEUTZOif36H3iNSXuEwoqpcbjHBaZjvRH
        vOrVVvooA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gqffl-0004mY-A7; Mon, 04 Feb 2019 14:56:33 +0000
Date:   Mon, 4 Feb 2019 06:56:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH v4 12/16] block: sed-opal: unify retrieval of table
 columns
Message-ID: <20190204145633.GK31132@infradead.org>
References: <1549054223-12220-1-git-send-email-zub@linux.fjfi.cvut.cz>
 <1549054223-12220-13-git-send-email-zub@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549054223-12220-13-git-send-email-zub@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +++ b/block/opal_proto.h
> @@ -170,6 +170,8 @@ enum opal_token {
>  	OPAL_READLOCKED = 0x07,
>  	OPAL_WRITELOCKED = 0x08,
>  	OPAL_ACTIVEKEY = 0x0A,
> +	/* lockingsp table */
> +	OPAL_LIFECYCLE = 0x06,

Adding a name for the colum seems independent of the refactoring,
and probably should be a patch of its own.

> -	/* 0x08 is Manufacured Inactive */
> +	/* 0x08 is Manufactured Inactive */

Shouldn't this go into the typo fixes patch at the beginning of
the series?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
