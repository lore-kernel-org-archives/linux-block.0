Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B12C43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B7A21479
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mBqadgfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeL0NQr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:16:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeL0NQq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 08:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zoD/apb1UfsPpDDGFbJ0OBTUWzjUCE6kC7SV7galQD4=; b=mBqadgfJDRXTK6lt0qLOupnpJ
        5dHcLzuYqiVEflVqaT44VgU04l3gVjyLulprNUExzgKzPi5eYRXpICMk9gSBkx+XruGCPNJezT94/
        1j1OT9109zNz+/zrUQwx99H+s2lgJk0pSfXppLvsyCIqIh7AcIjYOa8jUllH9RogUlbN/ZBTubXo2
        KEjZb7GtNgYI/eVJKEc6qsrvXmGnRu3zJZXc/4SJPXuQNlVxMehxrdUc085ILwA1mUTmBe7cD1F9S
        vPYgByALWFFi+ijuKmN9aHKt1F98sg6YxU2rxLGauX96EHcYCA78xrWICnUYipUyA7FDHRnwTmhfZ
        s9/sNulng==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcVWl-0000Fb-VD; Thu, 27 Dec 2018 13:16:45 +0000
Date:   Thu, 27 Dec 2018 14:15:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 04/22] block: use REQ_HIPRI_ASYNC for non-sync polled IO
Message-ID: <20181227131553.GA22342@infradead.org>
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-5-axboe@kernel.dk>
 <c34a6e3a-1142-4763-dfbe-9fa1b3579211@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c34a6e3a-1142-4763-dfbe-9fa1b3579211@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 21, 2018 at 12:25:07PM -0700, Jens Axboe wrote:
> On 12/21/18 12:22 PM, Jens Axboe wrote:
> > Tell the block layer if it's a sync or async polled request, so it can
> > do the right thing.
> 
> Forgot to drop this one, please disregard it as it's super ceded by the
> next patch anyway...

FYI, I'd just add the users in the patch introducing bio_set_polled.
