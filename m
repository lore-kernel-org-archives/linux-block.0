Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E6EC433F5
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46FF61216
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhKDShX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhKDShW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:37:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944B5C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n84d/GK2fRDz7rtUfDVmO6Hnzq5Q4B9uTsP7FnIcg5Y=; b=P5Uy2QDOMdqzfiyiStBY12XaJ5
        3wdyea7yygetohbtXm3QjhhCMv0IL79aGFY7atNzcLmwT0CtsCFvrFXx0BWXEAowxBZGjpjvwcY4T
        QxmK+RrFe0n/jEh2dG3eo3sP+PDCHV0XEBZ5e3VjSkcF9WeHi3iW4xGjOl1zdBVPMI1h1mQZUTKNR
        jDdFQ6/IwAKoRwRdAMwwETamxn4uUR85DVOhBuAZ3EzxACZt9IJVDaCexpj1rSJD0AZU/ZVYl1+QQ
        6D3W2MgMDQwIx0HwKd7I0DDNyUttpooAeZgu0zUcEVa6Hy1NV2M8bEepL5BktX/5+F9F83lk91Dvq
        CSXQ7v2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mihZU-009nbg-9k; Thu, 04 Nov 2021 18:34:44 +0000
Date:   Thu, 4 Nov 2021 11:34:44 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, hch@infradead.org
Subject: Re: [PATCH 1/5] block: have plug stored requests hold references to
 the queue
Message-ID: <YYQnxC65eFMXj3op@infradead.org>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-2-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104182201.83906-2-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 12:21:57PM -0600, Jens Axboe wrote:
> Requests that were stored in the cache deliberately didn't hold an enter
> reference to the queue, instead we grabbed one every time we pulled a
> request out of there. That made for awkward logic on freeing the remainder
> of the cached list, if needed, where we had to artificially raise the
> queue usage count before each free.
> 
> Grab references up front for cached plug requests. That's safer, and also
> more efficient.

I think it would be useful to add zour explanation why the cached
requests should be flushed at schedule time now here.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
