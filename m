Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BDAC61DA4
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 06:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBPGIc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 01:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBPGIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 01:08:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B847547437
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 22:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pj1Q7PVOxo6X4R/uU2UkAh8+Iq8mO6jXJ9aA2DGVz74=; b=dNrQV+AT7AgsaXQrMoo8SLvKZs
        xR1L+FvrkDssNS8quXhqcwCplAofKPhPaBOKefjP7jz/My+hN56+W3+UNg/k/lWaE+OEyIK/rVkl2
        jx5G5c1sCefJmmvKg42gg+d86aVitg4nP/DsAcuQx7mn2ZSqskR3B0l10XTz2ImSW7NMpHeJuV6Cp
        r4PGHmVUV6QWzUJxz1+QBsGB2XXRN7OHvqf5pAhWVKEcxqehmvdzpsHlwaPHgGxDXb3GwL4Al3ZbV
        In/WnHGfMwHfpvYdUINzWo6KUEU97jKTIKOiLDpxAvukVqd8b6bjD4wnZoXLXUAs1aUY3aiY9eHvf
        mn8wTYYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSXRJ-008eNJ-E4; Thu, 16 Feb 2023 06:08:17 +0000
Date:   Wed, 15 Feb 2023 22:08:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] brd: mark as nowait compatible
Message-ID: <Y+3IUcJLNK8WAkov@infradead.org>
References: <776a5fa2-818c-de42-2ac3-a4588df218ca@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <776a5fa2-818c-de42-2ac3-a4588df218ca@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 15, 2023 at 04:43:47PM -0700, Jens Axboe wrote:
> By default, non-mq drivers do not support nowait. This causes io_uring
> to use a slower path as the driver cannot be trust not to block. brd
> can safely set the nowait flag, as worst case all it does is a NOIO
> allocation.

But a NOIO allocation can block.  I think we need to do a
GFP_NOWAIT allocation in brd_insert_page if the NOWAIT flag is set.
