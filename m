Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CCAC7618E
	for <linux-block@archiver.kernel.org>; Sat, 22 Apr 2023 03:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjDVDFV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Apr 2023 23:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjDVDFT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Apr 2023 23:05:19 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A26212D;
        Fri, 21 Apr 2023 20:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d/drIpsV3nVkI3AWmke+ca/OYDz5JWaoOhQ63wKz7tg=; b=t5z7h+1lNmQrXDkWpzx1/m5Gej
        XWRSmJq80eCVKtUu4NvPpX0IljSWYYX70YWBIMfZUHqOHWmbJHZyiMNO4Jto8y2JcR/+ANy2OURaN
        xRrA5kySnWRi8l0RD2t5bcv2w9p5OaP9mH5/5Ft4XedWVuOghAF4GAl15lRBazm5bSya8jIMz0VnF
        xXRfnfa9LYquFCqzBffOdnpRk58AlUQSlC24kSiMi5pnzvjuVzHTuHiJNLj4gYhmEoxo9X0uy6X6R
        ggjHKxy1Ctsgv/bs0xuZW8ENhxyLvHPdMSVVlAibXhiM0OZCo1wSlec4K+rzwM/Ve8yqQFI5s2tNN
        qYijGnzg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pq3Yg-00CHMA-1V;
        Sat, 22 Apr 2023 03:05:06 +0000
Date:   Fri, 21 Apr 2023 20:05:06 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, brauner@kernel.org,
        djwong@kernel.org, p.raghav@samsung.com, da.gomez@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, hare@suse.de, kbusch@kernel.org,
        patches@lists.linux.dev, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/8] shmem: convert to use folio_test_hwpoison()
Message-ID: <ZENO4vZzmN8lJocK@bombadil.infradead.org>
References: <20230421214400.2836131-1-mcgrof@kernel.org>
 <20230421214400.2836131-3-mcgrof@kernel.org>
 <ZEMRbcHSQqyek8Ov@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEMRbcHSQqyek8Ov@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 21, 2023 at 11:42:53PM +0100, Matthew Wilcox wrote:
> On Fri, Apr 21, 2023 at 02:43:54PM -0700, Luis Chamberlain wrote:
> > The PageHWPoison() call can be converted over to the respective folio call
> > folio_test_hwpoison(). This introduces no functional changes.
> 
> Um, no.  Nobody should use folio_test_hwpoison(), it's a nonsense.
> 
> Individual pages are hwpoisoned.  You're only testing the head page
> if you use folio_test_hwpoison().  There's folio_has_hwpoisoned() to
> test if _any_ page in the folio is poisoned.  But blindly converting
> PageHWPoison to folio_test_hwpoison() is wrong.

Thanks! I don't see folio_has_hwpoisoned() though.

  Luis
