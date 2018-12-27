Return-Path: <SRS0=Cd4S=PE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07CBC43387
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B48620873
	for <linux-block@archiver.kernel.org>; Thu, 27 Dec 2018 13:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xx8idl2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbeL0N56 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Dec 2018 08:57:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53260 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeL0N56 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Dec 2018 08:57:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kFylryrzj+y5DHWxrYWkZqTA09TxV2U6pol9EbALQH4=; b=Xx8idl2cq99lF801KgEQtkzFr
        shJfNCP6VEhi26EtxOh0e81c1pRpe8MA7RiMgQvghHYmGJISWaYp54CqFbgsztEfmPwXLey3BNEpw
        V8y/Ki5ot6z+P1hyoHXUphlQ4Rse3sObblpSkr/BQXt/CiqilZcW6vGwnK47xg+FNoqWN6E+Z1H+b
        C9lqAxSc+g7bP0dNEsaqv96XZh4jbelMdxvVZZ4pT1QYUEE5gqU1YLw93HMbGzJbS2Ez6xvmULP2M
        SYS6oIB45srxhEXoMC3FBH+8tq7uyUjJbg4zLY0zC4d6USCTqMGG6qb3U+fTXlzxgw/GBmLt5upsu
        ZDgXg8UAQ==;
Received: from [46.183.103.17] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gcWAf-0006Kz-DA; Thu, 27 Dec 2018 13:57:58 +0000
Date:   Thu, 27 Dec 2018 14:57:53 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 19/22] aio: support kernel side submission for aio with
 SCQRING
Message-ID: <20181227135753.GE25525@infradead.org>
References: <20181221192236.12866-1-axboe@kernel.dk>
 <20181221192236.12866-20-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221192236.12866-20-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 21, 2018 at 12:22:33PM -0700, Jens Axboe wrote:
> If an application sets IOCTX_FLAG_SCQTHREAD, the io_context gets a
> single thread backing. If used with buffered IO, this will limit
> the device queue depth to 1, but it will be async, IOs will simply
> be serialized.
> 
> Or an application can set IOCTX_FLAG_SQWQ, in which case the io_context
> gets a work queue backing. The concurrency level is the mininum of
> twice the available CPUs, or the queue depth specific for the context.
> For this mode, we attempt to do buffered reads inline, in case they are
> cached. So we should only punt to a workqueue, if we would have to block
> to get our data.

I'm really worried about having this code present twice.  Do we have
strong use cases for both?  Can't we emulate IOCTX_FLAG_SCQTHREAD good
enough with a workqueue without concurrency management?
