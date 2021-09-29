Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A1AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 06:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75BC8613A9
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 06:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbhI2G5G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhI2G5F (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 02:57:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389EC06161C;
        Tue, 28 Sep 2021 23:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vJnhZzHesizlzOdq1W43Xav44aVM2wENIbQ/nsFlymI=; b=Cy2EgRLEDgo0P9vw2aShtTeXSs
        IHuAGK6bOhq2ej6lcZPWx/I8Bf8itVXDpzRwTkqSf25TjzpRrQQMQArgDV3rhu5ORhUloCTkFSz96
        j97cFhOiB4b5ajnrqrlbUUsaLQpljoltvqlT8OTqG98in8fir/Zid0toRW2TW2evGSnWCPWRnkwF2
        SQEjrGiVtMwtMpFGix1xZKLGbI7RuKR6Lo4j5fMsSoNApqCNI88/b0DgU3kbhEZ0wLHA1kARXXIMg
        Ma6kxjb531khDUzeWwuricyGFZvumHIvbNf9Dj9EvRoZusqeZGZVDRUWiRJ33wdCDZ2IPLhdrRNHR
        x8JGBkjA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVTTv-00Ba5N-PF; Wed, 29 Sep 2021 06:54:38 +0000
Date:   Wed, 29 Sep 2021 07:54:19 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tim@cyberelk.net, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] pcd: capture error codes on pcd_probe() and
 pf_probe()
Message-ID: <YVQNmzv5RvjV5RK+@infradead.org>
References: <1632897629-84965-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632897629-84965-1-git-send-email-yang.lee@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 29, 2021 at 02:40:29PM +0800, Yang Li wrote:
> No error code were being captured when pcd_probe() and
> pf_probe() fail, capture them by assigning them to ret.
> 
> Clean up smatch warning:
> drivers/block/paride/pcd.c:939 pcd_init_unit() warn: missing error code
> 'ret'
> drivers/block/paride/pf.c:963 pf_init_unit() warn: missing error code
> 'ret'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Please not.  I have a major rewrite of the paride probing pending,
which Jens just wanted to make conditional on potentially dropping the
drivers entirely.  So either we take the real series to clean this mess
up or we drop the drivers, but we need to stop this sugarcoating of
fundamentally bad code.
