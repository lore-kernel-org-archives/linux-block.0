Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D1C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF63208E7
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 08:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tPPXcwWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF63208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeKPTAP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:00:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32950 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeKPTAP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 14:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZkJ7CZAcg3Gbusda513hZyxZFR1sLS2AFBP4Lw/ak4w=; b=tPPXcwWtAO4mn0fwT/0ZurbN+
        ur58OsZcZ9KoMYAp9UXwAhom+LzBpaWLqGDCPDkBctyQPL2NUf/1ArFDBTi+HmY5/zu9PInl1mOmJ
        hEphmrwKHw8tqBSpYL4p8TlGhe+7RA24+vFpR85l0ZoeY3TVC3B7SWUIFTkOQ9/5q3fZHir1P3QEF
        Rk4Y5zSdVFb5h5SGBHeu+wrMrATDsBdXcCI/PzyT+03zrGl3eCVm036BF46ks4ID0R6dLKlzcZTno
        B2z860Smal6YDeh1+obznY8ZEekMNTMFMMs7qia2SMfxbBYVA5Si++SS7gIE4YDAfIqkY1MHnjs5p
        HTXAIapaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNZo5-0007gM-F0; Fri, 16 Nov 2018 08:48:53 +0000
Date:   Fri, 16 Nov 2018 00:48:53 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 10/11] block: for async O_DIRECT, mark us as polling if
 asked to
Message-ID: <20181116084853.GJ9023@infradead.org>
References: <20181115195135.22812-1-axboe@kernel.dk>
 <20181115195135.22812-11-axboe@kernel.dk>
 <20181116084739.GI9023@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116084739.GI9023@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 16, 2018 at 12:47:39AM -0800, Christoph Hellwig wrote:
> On Thu, Nov 15, 2018 at 12:51:34PM -0700, Jens Axboe wrote:
> > Inherit the iocb IOCB_HIPRI flag, and pass on REQ_HIPRI for
> > those kinds of requests.
> 
> Looks fine,

Actually.  Who is going to poll for them?  With the separate poll
queue this means they are now on the poll queue where there are
no interrupts, but aio won't end up calling blk_poll..
