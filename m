Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA2CC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B2E213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 15:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qP0ALtrp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54B2E213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeK3CzA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:55:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeK3CzA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 21:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EVF9Rdfx17022hcsQGUOL+CC1b3G8NQcRaOFbe5iqzQ=; b=qP0ALtrpomjMmuQp89SWdVfk4
        xRy6PvE4dqGhwTPV+VMkuhSNn0aQ+7byMB84fIoWnNLU2bRqj/dSv8uEvOvvny1M0FiuhD5xeg1wC
        zlgdgfVV3kbik9nNTx32uCLBrwWVwdX/d8k70s7DSACYaXi3z4kc0EqmFwa4t1CQfTHJIk34Fx9B0
        Tl6fIEAEMSQ41y5FAjKe7CqF1Xlkgr4e+wh8ZGpa5Z13IhrV2f3PjAXnNiYo2s5G/G9IA8qonfpEv
        hXjkbnjPdbcfJsu0csgz5CB91u8ruLLSTDmUgeJ1hynISGqgVUtj4Ib6TUYEvmqo9HQSrl9hgnq3R
        p1j8Zcceg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSOYy-0004p3-OR; Thu, 29 Nov 2018 15:49:12 +0000
Date:   Thu, 29 Nov 2018 07:49:12 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/7] blk-mq: use bd->last == true for list inserts
Message-ID: <20181129154912.GE7234@infradead.org>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128133538.20329-7-axboe@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 28, 2018 at 06:35:37AM -0700, Jens Axboe wrote:
> If we are issuing a list of requests, we know if we're at the last one.
> If we fail issuing, ensure that we call ->commits_rqs() to flush any
> potential previous requests.
> 
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
