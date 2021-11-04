Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60218C433EF
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BAA061076
	for <linux-block@archiver.kernel.org>; Thu,  4 Nov 2021 17:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhKDRgB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbhKDRgA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Nov 2021 13:36:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63A8C061714
        for <linux-block@vger.kernel.org>; Thu,  4 Nov 2021 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O7CbYRoePDlVJekNE1iJOrUev1cJh2lecJCAQ4qohnU=; b=yph/BgWZhLEFfE1K8ZGC2javbm
        Uhx/8bES7cfL+h86BGL2R6fCkWnhIRER3vmNWPQWaf170XVJ/r7yEcpEhi2JlrvhlXJxW7MdhMTHn
        zY6XmJjVg6k3rmgGxB0wjVKhr9GzWygZuYHKIoNU4OrlMseizJ4H/M1jL6B7FryLVbZeUon5ubM1b
        bI2Gpegu00/xrGVNT/aG5h/qNYbCm1lViO8VI3D8x7ldG4NtSxwdOw5uzAv14q2WyXzyA6IrywkQ3
        S6bhv5r+8D8lkuvkWmowBMzGsIMIdmVo7eXHqZXawFrGIif20CS2fYr9AoLzBNv3SYcNqufeT1VI/
        gEd4c0tw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1migc5-009g4q-F9; Thu, 04 Nov 2021 17:33:21 +0000
Date:   Thu, 4 Nov 2021 10:33:21 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org
Subject: Re: [PATCH 4/4] block: move plug rq alloc into helper and ensure
 queue match
Message-ID: <YYQZYfI/rmH5RshU@infradead.org>
References: <20211103183222.180268-1-axboe@kernel.dk>
 <20211103183222.180268-5-axboe@kernel.dk>
 <YYOlIGsSHN0+YrjK@infradead.org>
 <e211fa74-1b69-c2f6-ecc5-a2e5139b684e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e211fa74-1b69-c2f6-ecc5-a2e5139b684e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 04, 2021 at 05:35:10AM -0600, Jens Axboe wrote:
> I tend to prefer having logic flow from the expected conditions. And
> since we need to check if the plug is valid anyway, I prefer the current
> logic.

Well, for 99% of the I/O not using a cached request is the expected
condition.
