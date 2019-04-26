Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3222FC43218
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 12:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C20206C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 12:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iNyi5n/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfDZMoh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:44:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfDZMoh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 08:44:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=R9HefWxmjnbBCWyJ1I7EFkjSPnM6RsFGxMlHsXjL/9A=; b=iNyi5n/3mbA1YefPB2WpbLZTa
        Nx/ODr94C0dc8Xb3SI7yNiXqHCxu0C5h5DSHxgUi8KhfV5uaAWBF3My1tvZVfCAzv48LPkLdto6uX
        rtL28/bwWHN594em6AJ/Bc0mpjGfQygMXeLjaPmyjv4AdL71LSMZ7rRIuIsvrl7kcMfIzblAYcc0/
        wLqWPiGV8DzgnoK51LzWrnWdf4S4NnVgIRg8Pn8ok8CoqOSftrPE758/z8C1i5c+oqwPwcnIFuzsT
        IJIyguOcIPVuspeMm+k/hSi2/HsUzqsJuxvrdVbmTBKoGGR9d3l+kD+YrOrwcpigKqCIWtyp4UQ5A
        pVUT5ErnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hK0DU-00069W-3F; Fri, 26 Apr 2019 12:44:36 +0000
Date:   Fri, 26 Apr 2019 05:44:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] iov_iter: fix iov_iter_type
Message-ID: <20190426124435.GA12339@infradead.org>
References: <20190426104521.30602-1-ming.lei@redhat.com>
 <20190426104521.30602-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426104521.30602-3-ming.lei@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 06:45:21PM +0800, Ming Lei wrote:
>  static inline enum iter_type iov_iter_type(const struct iov_iter *i)
>  {
> -	return i->type & ~(READ | WRITE);
> +	return i->type & ~(READ | WRITE | ITER_BVEC_FLAG_NO_REF);

The way we handle i->type is a complete mess.  I think we need
three different values:

   .rw (can be READ or WRITE)
   .type (ITER_IOVEC, ITER_KVEC, ITER_BVEC, ITER_PIPE, ITER_DISCARD)
   .flags (ITER_BVEC_FLAG_NO_REF)

.type seems to be worth an u8 on its own.  And at least as long
as we have space rw and flags should probably be their own u8 aswell,
although we could use accessors to fold them.
