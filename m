Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F65C43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829DA2084F
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 14:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ECA7WPa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfDZO7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:59:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfDZO7b (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 10:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zDNtr8shJvaJGriH3/XZtobzhjkOlkA51fj2UZb5t50=; b=ECA7WPa8gmlzoM6fE6wbVMEV+
        cB24ilkywxfajCRGDD/UhOjeZwnkFtzkioHR+9IZdAGG3FDl8dk6DUHE0Zu7cNvKSvTbsOR2YW+qY
        HqEyx+CDBfWmB+on3Gcb32vrN5h18UPgJIoo61AQ6OghyXTsNQI7hMJbJXYz3JtejW161G9YlFzNF
        KVGsgvzJD1duYM/ujwc51Puz+IfB34nW4hKyaYLdtweahGZJE4cJ8Nx0pnxj8NBsQBxsB4tH7pCV+
        J+9nUL/B85wHwKW8s61AQLYTimCQX3ZKbcZrVkP+ID8IdP3d6L5kP/IP0axVc2mux85YVQv/TVzdq
        kFb1idcCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK2K2-0004iV-G3; Fri, 26 Apr 2019 14:59:30 +0000
Date:   Fri, 26 Apr 2019 07:59:30 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/2] block: fix handling for BIO_NO_PAGE_REF
Message-ID: <20190426145930.GB12338@infradead.org>
References: <20190426104521.30602-1-ming.lei@redhat.com>
 <20190426104521.30602-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426104521.30602-2-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 06:45:20PM +0800, Ming Lei wrote:
> Commit 399254aaf489211 ("block: add BIO_NO_PAGE_REF flag") introduces
> BIO_NO_PAGE_REF, and once this flag is set for one bio, all pages
> in the bio won't be get/put during IO.
> 
> However, if one bio is submitted via __blkdev_direct_IO_simple(),
> even though BIO_NO_PAGE_REF is set, pages still may be put.
> 
> Fixes this issue by avoiding to put pages if BIO_NO_PAGE_REF is
> set.
> 
> Fixes: 399254aaf489211 ("block: add BIO_NO_PAGE_REF flag")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
