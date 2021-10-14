Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8A3C433FE
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 16:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8916109F
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 16:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhJNQJt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 12:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhJNQJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 12:09:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2771C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=akXy4GJA/KJl0LYPpMWbDI9E16z5v7YaaCgwDcbvDdY=; b=C1quXw0r7eDVmiFwfVWumJISNc
        cpd/1SeaSuK8w3g6uytSIvJVyZruQDMdCyAGNM1ABkQNN8C7wdTzrA/EyZDjbnu6uzEkxmd/p0bOV
        Ve+sUZJa/FiSIH2Gen9DplRPQvhunRSWxrxb8Y1YW/Ei0tWrhIUvo8dxLO61xZHVz4R8fwWB4C9s3
        pMJdT97jpk7eDSts9UiNi+Ag9ZfEhPaMPVkr2P0ci78i1mPp29Mq94tLvSDjFY2CkaGy4n2whseRV
        fAwcBv6m0cqOWT41M8eo3jX1+tyqgpgPbg7nKDHHHKrrhqIE8lwl0wo5PXntIR4LLgrr9QSz2XQSW
        9fUx0KlA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mb3Gh-003n6J-L9; Thu, 14 Oct 2021 16:07:43 +0000
Date:   Thu, 14 Oct 2021 09:07:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
Message-ID: <YWhVz3HqwhnoiJpp@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-7-axboe@kernel.dk>
 <YWffkZ2w/mhcJIAU@infradead.org>
 <f42b215e-0126-d2c1-2548-b58aaf3cbb84@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f42b215e-0126-d2c1-2548-b58aaf3cbb84@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 09:30:57AM -0600, Jens Axboe wrote:
> > Can we turn this into a normal for loop?
> > 
> > 	for (req = rq_list_peek(&iob->req_list); req; req = rq_list_next(req)) {
> > 		..
> > 	}
> 
> If you prefer it that way for nvme, for me the while () setup is much
> easier to read than a really long for line.

I prefer the loop over the while loop.  My real preference would be
a helper macro and do:

	for_each_rq(req, &iob->req_list) {

as suggested last round.
