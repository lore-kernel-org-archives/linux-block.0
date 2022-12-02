Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76806C4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 09:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiLBJLL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 04:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiLBJLI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 04:11:08 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACAE8C440
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 01:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1L79jcFqFqokfeQ0zfbZM6+/02mbZb36bD8l5JGIQ6U=; b=Kq6+0UE6SXYjgV4YxAbxBUc3cM
        BNGqjCoCnUXBKw0AWfo1NwHEqIjIoIm9t2vazDtmSHEBnCOODdJrASmDNHwILiGH0vQaqboyMwEeq
        7r7o7JDyYId2hwrNSG4cpkziMz+5QawY0twRYxMs7ugXUWiWFmGG0BKZu6sFBPH5fAUAK4oXZOheN
        1g/pQz4y+rSNJrDX1PJATeclqNxQP+EdSnJ7ANs35D04Q3TekIll4uLKdLCiYsHngLfwIv1MKbJD2
        nfTiM5kcORC6gQaTv7ex+6gR2RtcwKutpuYkw4lH+WlHAWjufMCcrr6ccKcuqpaHq22P1RiYfhjWO
        KRv9L5gg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p124Y-00Eq5P-D3; Fri, 02 Dec 2022 09:11:06 +0000
Date:   Fri, 2 Dec 2022 01:11:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     luca.boccassi@gmail.com, linux-block@vger.kernel.org,
        jonathan.derrick@linux.dev, gmazyland@gmail.com, axboe@kernel.dk,
        stepan.horacek@gmail.com
Subject: Re: [PATCH] sed-opal: if key is available from IOC_OPAL_SAVE use it
 when locking
Message-ID: <Y4nBKoTQfgr8u5wS@infradead.org>
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
 <20221202084845.66mn2m3srfabehnu@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202084845.66mn2m3srfabehnu@wittgenstein>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 02, 2022 at 09:48:45AM +0100, Christian Brauner wrote:
> It might be better to add an ioctl that would allow to set an option on
> the opal device after it was opened which marks it as closable without
> providing the key?

Yes.

And while we're at it: please fix the overly long lines in the block
comment that make it completely unreadable.
