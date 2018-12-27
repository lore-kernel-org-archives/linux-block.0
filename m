Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6C7C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB4620873
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uyxqLdK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeL0N53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:57:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53238 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeL0N52 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 08:57:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=svkZGNte1FIwXLo8zy/2wHlPfRHmPfYEB6UkgNgh124=; b=uyxqLdK/Or4BgfFqfO2vCWDZ5
        +U3hAs7nwj8rpiXaMjh1oVzxIM71ZuuALmakmCjHZOYZoAyqYIIyMLOPseNBnn07g/tc34SD/l2tb
        NiWjjKT7ZVugUwK5Rn2OCMctLeb1jYOJbKIojy0iEACS+LEUvKYAmEVqQhvs7Sb+BUfVw3s3egQ6x
        +NzpPY20Xn0R3Bg18UBlNoDsmwQvYtZ2z41ATr9dk7oQALRmYFgM84vVjDHwyYUOLYmPZYKAa1vnQ
        /2sU2r+5jnuM6rfrVd6Qnj2f1TZDBLuTi5p6fJnonxPKVs4weiAXyD0sFFq8sUfs+p+AYmJW/VJsE
        rs+wwgw2g==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcWAC-0006Jr-2T; Thu, 27 Dec 2018 13:57:28 +0000
Date:   Thu, 27 Dec 2018 14:57:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 18/22] aio: add support for pre-mapped user IO buffers
Message-ID: <20181227135724.GD25525@infradead.org>
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-19-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221192236.12866-19-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This looks like just a little too much overloading to me.  I think
the read/write to/from buffer just needs their own opcodes and
entirely separate code path.
