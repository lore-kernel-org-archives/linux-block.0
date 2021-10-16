Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCB7C433F5
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D0B61211
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 04:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbhJPEcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 00:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbhJPEcF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 00:32:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550E6C061762
        for <linux-block@vger.kernel.org>; Fri, 15 Oct 2021 21:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LL5e8xFCxstKvsTxKiFlmr7ka7Z/Opuaos9VIq29Onk=; b=FMTTJW0+IMnNPzqHdjN+6DEy7K
        6+LVAb1jDIxfK4pMruXfjEfnkhkePyA/FVhWCEiwCq/r3h5VEWmGc8ACuDrG8i5W0BTjDoEUiUF31
        ea2KZ5XyL6jX6zh2JDCRMoBOkpGy/zXa9E0p45n1Wp8dt8G1G0UWfF4vfrmeIpK+0RuElXvGYvXAN
        Z6DLRkm0Ryyk/kGNxOZMD2hjzbSF31d6SWd4wREqADSMSCZZukOR+BQikofxJLkfJBSiw00PfEwYP
        TMVXEXR9AyASvwrcUpovBEW3C7Abm0WXHHDzLpPX3eaxdFU1D7sc765YJ3IOCR2Qzg2dsuxBUYDcy
        GmTAAa0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbbKX-009j5l-Ka; Sat, 16 Oct 2021 04:29:57 +0000
Date:   Fri, 15 Oct 2021 21:29:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 8/9] io_uring: utilize the io_batch infrastructure for
 more efficient polled IO
Message-ID: <YWpVRXYGuN8mA7nH@infradead.org>
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-9-axboe@kernel.dk>
 <YWfkVtB+pMpaG2T3@infradead.org>
 <7ed66f47-6f5a-39b2-7cd8-df7cf0952743@kernel.dk>
 <YWhWBt7kljI+BGbX@infradead.org>
 <c80263c8-f6d6-e3d9-058f-26d64c7e5acc@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c80263c8-f6d6-e3d9-058f-26d64c7e5acc@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 14, 2021 at 12:14:19PM -0600, Jens Axboe wrote:
> > Either way this should be commented as right now it looks pretty
> > arbitrary.
> 
> I got rid of this and added a dev_id kind of cookie that gets matched
> on batched addition.

Thinking about this a bit more.  I don't think we need to differenciate
devices, just complete handlers.  That is everything using the same
->complete_batch handler could go onto the same list.  Which means
different nvme devices can be polled together.  So I think we can
just check the complete/complete_batch handler and be done with it.
The big benefit besides saving a field is that this is pretty much
self-explaining.
