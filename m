Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D455C64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 11:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD9BB206E0
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 11:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgLBLVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 06:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbgLBLVc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 06:21:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7514DC0613CF
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/RmF1sGzLAZXGJbZYhQfRxfCBX3ujiG7y2uTh3SKUq8=; b=TpZqu6XhCT+WCLrzOOqHsuDCu2
        c/320LZ8TIuoY5gyxYIFMn/BEu/4dZp23813lKr1ljJYacxl33OdqvIitGxp5rtFhCyxOB7zqojmi
        SrqMumAxKwDczjle4Y90fr6lDVefygic1RWrKuYUcTCAZdiL6z4Ei0pDqTMhuZq4cgtkMy14u3Fy+
        cmNELDE2d3hsXTSGoZPGgJ6YKP+Dl14F2Fd61kmBuaucSkQhJzz/KyoDIBTrYp9yCT5UGFd8l3eAO
        BVYOe4jHRf2IGl+KTAFj8u2n7Hpsq9TTmH9vZ0syKvr+CqctcIjZ3RFu4sGnrrEPdbY9c6dprX9DY
        Mk39iXGQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkQBm-0000iZ-3s; Wed, 02 Dec 2020 11:20:50 +0000
Date:   Wed, 2 Dec 2020 11:20:50 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, joseph.qi@linux.alibaba.com, hch@infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] block: fix inflight statistics of part0
Message-ID: <20201202112050.GA2201@infradead.org>
References: <20201202111145.36000-1-jefflexu@linux.alibaba.com>
 <4317c6c9-886f-c921-70c1-ccc12ba6ae79@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4317c6c9-886f-c921-70c1-ccc12ba6ae79@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 02, 2020 at 07:17:55PM +0800, JeffleXu wrote:
> > Fixes: bf0ddaba65dd ("blk-mq: fix sysfs inflight counter")
> > Fixes: f299b7c7a9de ("blk-mq: provide internal in-flight variant")
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > ---
> > v2: update the commit log, adding 'Fixes' tag
> 
> Forgot to add 'stable' tag.

The fixes tags take care of that automatically.

Note that this patch will cause a merge conflict with my work in
linux-next, but the resolution is pretty trivial.
