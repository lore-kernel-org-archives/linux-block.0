Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A62C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 15:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B41205C9
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 15:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Gh+jqDZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbfAQPWY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:22:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48408 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfAQPWX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 10:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sgSScnt1QgVVEcuj+G3pWGQu+BBf+74x7z1h6AeXWRw=; b=Gh+jqDZInJpqo+rDIQmUlY/PB
        au9IPKApynMgAy19qVeeL/pETLA61jXdN/bLIBRAhLKR1UrCcJPCk4+bwhtCqKwhduxOZEnQPUnFr
        TboIWo4cT2vlmoSrEjRswmYOBjiZZSnggQmV89lQb4DPlUzUlBtHKrVBl0ylTA6Jw3sXLQiHRy2Eq
        PxndiS717CKZjpH6C5Au83D892XmJF6YNcHWKmmzuTqKQRvdyiA8j/0xcytgNh09ai1jZTeRvTcRJ
        5g2ukhR8y0vR9VAK8qPWgQcfec4ZwRukDLjpT/KH3CxeZmAktTUm+LyhQoJ5AXGAc/aBMaAjx8fqY
        EufVQdk2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gk9Uq-0007QA-Mt; Thu, 17 Jan 2019 15:22:20 +0000
Date:   Thu, 17 Jan 2019 07:22:20 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Kozub <zub@linux.fjfi.cvut.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: Re: [PATCH 00/16] block: sed-opal: support shadow MBR done flag and
 write
Message-ID: <20190117152220.GC20359@infradead.org>
References: <20190116225533.BD1396004E@linux.fjfi.cvut.cz>
 <20190117085727.GA14092@infradead.org>
 <alpine.LRH.2.21.1901171030320.26315@linux.fjfi.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1901171030320.26315@linux.fjfi.cvut.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 17, 2019 at 10:40:49AM +0100, David Kozub wrote:
> On Thu, 17 Jan 2019, Christoph Hellwig wrote:
> 
> > the way the series appear looks odd, because it wasn't threaded or
> > even ordered, and the patches from Jonas seem to have been sent out
> > by you under his name.  Can you resend them carefully threaded, all
> > mails from you with the additional from header for resends?
> 
> Ouch. I'm sorry about the ordering/threading. I (wrongly) assumed that if I
> just send the mails in order, that suffices. I'll try to fix that in v2.
> 
> W.r.t. "from": Most of the patches were originally created by Jonas. I
> touched some in order to apply review suggestions or make some small fixes.
> But some stayed identical to Jonas' version and I didn't want to strip him
> of authorship. I used git format-patch to produce the mails and the commit
> author was propagated to the from header.
> 
> What is the proper way when I am not the author?

Send the actual mail as from you, and put another From: line for
the original author into the mail body as the first non-empty line.
