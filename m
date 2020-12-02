Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87620C71155
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208BB22250
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 19:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgLBTF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 14:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbgLBTF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 14:05:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E46C0613D4
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 11:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B5cODg3H+9V/Jixb9chLqjaBrP7CJZa7OtKmTzcFpkQ=; b=BIi5qi2wD3ql3tecsmCCLWVmO4
        qe3BFeqU0HbMI/HQ9uDCDD1tlcZ0JxG0wa32MuG4AeHNE3xyDvwqtrgedxMs9ObwdT+b5+xqUjcJT
        VZSGlPxUEjTNS5I0ZXSpcx4M/V6rVGoEIgsPosjgTepqXwaLrRsFbtrgRssLIN+XaluHdqNfI0c9d
        Hu/+eU3kiTIR+eAzMuOedMAulgYWvFgEWAdKU9NDhRL8bKFlwmZff5w311gnAcZdbVuatdRmUyfrZ
        v7JZiomtwT1PJLk307b96jv5rSdAeiZ48PP5IqSnlsowxdFo4tU3Lr6NwEQSf1f+a74QgzgV3bfeK
        BXfr71WA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkXRD-0005Rs-EU; Wed, 02 Dec 2020 19:05:15 +0000
Date:   Wed, 2 Dec 2020 19:05:15 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        joseph.qi@linux.alibaba.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: fix inflight statistics of part0
Message-ID: <20201202190515.GA19811@infradead.org>
References: <20201202111145.36000-1-jefflexu@linux.alibaba.com>
 <4317c6c9-886f-c921-70c1-ccc12ba6ae79@linux.alibaba.com>
 <20201202112050.GA2201@infradead.org>
 <699798e0-6b38-105f-aacc-938f3ecd6ce4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699798e0-6b38-105f-aacc-938f3ecd6ce4@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 02, 2020 at 09:48:03AM -0700, Jens Axboe wrote:
> On 12/2/20 4:20 AM, Christoph Hellwig wrote:
> > On Wed, Dec 02, 2020 at 07:17:55PM +0800, JeffleXu wrote:
> >>> Fixes: bf0ddaba65dd ("blk-mq: fix sysfs inflight counter")
> >>> Fixes: f299b7c7a9de ("blk-mq: provide internal in-flight variant")
> >>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >>> ---
> >>> v2: update the commit log, adding 'Fixes' tag
> >>
> >> Forgot to add 'stable' tag.
> > 
> > The fixes tags take care of that automatically.
> > 
> > Note that this patch will cause a merge conflict with my work in
> > linux-next, but the resolution is pretty trivial.
> 
> Might be better to handle on the stable side, and just apply this to
> 5.11. It's not a new regression.

If you apply it to for-5.11/block it won't compile.  It'll need a quick
s/partno/bd_partno/ there.
