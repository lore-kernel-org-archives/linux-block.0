Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3158EC433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5C61215
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 18:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbhKDSyx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhKDSyw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 14:54:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82996C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Q7TYfl6dCbyGb+Arvu44YuQT0M
        hueJmFvM2+LpXL6Dq0rcc+CP6nMwWksGQQV/yKW84ezmXagWjTggs1lCl3aHtVnt1PqT6KcW/Tu2a
        1mcApR7uQdnCLuAUqRrwUd1rh3JZ67FSXdI39sx4nD8u6K2NNciS9OUF5Fstvfa9lrj6B0MGgd6r0
        upTNaVvcuSkq312qmnEXcCf9C0nttMzTScx2coGktiT+8c7eFWfke9hN4dnfyGlqpecb1iQXht3JY
        axI0LRo4uRO7+obLNbvGYRtkO4zVbWa3B7TUbrHisBQM6B1klOBa33n6l51FinOUH4+w7eAepm7D0
        VNolz9DA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mihqQ-009pUa-5R; Thu, 04 Nov 2021 18:52:14 +0000
Date:   Thu, 4 Nov 2021 11:52:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/5] block: move queue enter logic into
 blk_mq_submit_bio()
Message-ID: <YYQr3jl3avsuOUAJ@infradead.org>
References: <20211104182201.83906-1-axboe@kernel.dk>
 <20211104182201.83906-5-axboe@kernel.dk>
 <YYQoLzMn7+s9hxpX@infradead.org>
 <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
 <YYQo4ougXZvgv11X@infradead.org>
 <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
 <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
