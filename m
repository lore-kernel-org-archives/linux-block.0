Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2584C433B4
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 09:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65756109F
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 09:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344669AbhESJn3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 05:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbhESJn3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 05:43:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA678C06175F
        for <linux-block@vger.kernel.org>; Wed, 19 May 2021 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=i5/rcuB3h98iYIA9flpvwsfUNKaoI8+PIH0PEQr5xhk=; b=J2g16vyRtJ/0fnzSkzehLupFmu
        Q9KP0Tyz2IH8HF9ZyHJtZ280R7CrgSnlxbGprB7UjXFHQ56NJI1DEpysuDB8YWBRNOaRNwZaT5KUi
        SiRO+YDb4LmBAlRiS4xNXEvglDyzoXaQas5HcJ1If1B1adMcIbiA4D0lsPtZw+qxO489rvI6JDzPK
        U8/BWmjSK9t+pVROirTXIGpuKNZ8cNw0TmRq1xMCF3QOIvruI/3dxS+QT34ZFk48xZ4QZloUvl7XR
        JUcjb0x9MLrAOqVhHODplUgAFv1qkdulcgNuihtNbkqQ/gxqkRFqALZqy4C60AmzrTIGd923UhS65
        nHB2BTXg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1ljIht-00EoYw-JM; Wed, 19 May 2021 09:41:42 +0000
Date:   Wed, 19 May 2021 10:41:37 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 03/11] block: introduce BIO_ZONE_WRITE_LOCKED bio flag
Message-ID: <YKTdUYIizUPCtiTa@infradead.org>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-4-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519025529.707897-4-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 19, 2021 at 11:55:21AM +0900, Damien Le Moal wrote:
> Introduce the BIO flag BIO_ZONE_WRITE_LOCKED to indicate that a BIO owns
> the write lock of the zone it is targeting. This is the counterpart of
> the struct request flag RQF_ZONE_WRITE_LOCKED. This new BIO flag is
> reserved for now for zone write locking control for device mapper
> targets exposing a zoned block device.

So normally we try to use a REQ_* flag instead of duplicate BIO_ and
RQF ones.  But I think this is a special case as the flag never gets
propagated.  Can you document that in the commit log?

With that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
