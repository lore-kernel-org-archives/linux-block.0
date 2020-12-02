Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932EAC64E7C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1FC2222C
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 08:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgLBIaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 03:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbgLBIaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 03:30:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2D9C0613CF
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 00:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+D4YxFbGIx7X1PWPA7MlgAk34dAJSIhMSHm4papUTzM=; b=ETroqHTVQkBS6radrkpRGMlGhN
        u7D9r2DWH7bt6PHcdSFFSmCDRhnZrG1AQHb1MeX/EfDFsSta3NqAQVkfoIuFsc7fOzpzFJmflTatp
        y+224cQtLBXkECvjuZ/pTEa4zuERECLBt8gD1dHyvrpIcOn009xO8mLu18dKzTjbhJpytv2RCyfgE
        xHSeNJDj+x8yGC4zesPh9QFst5IHEDmiWWK+Odvq7w3YV9NO/wJIXoJdbr/JTnIvmEAAD979DrTE8
        8S8ok45ziXr/6Ecet9d9TwDAw0+FL7u0+D+Bjc8zyCe80Ujq3bHg6/RbexRJVApqquM9AnccexpLJ
        A1CKtQPg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkNW9-0006Ch-9D; Wed, 02 Dec 2020 08:29:41 +0000
Date:   Wed, 2 Dec 2020 08:29:41 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] block: fix inflight statistics of part0
Message-ID: <20201202082941.GA23319@infradead.org>
References: <20201126094833.61309-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126094833.61309-1-jefflexu@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 26, 2020 at 05:48:33PM +0800, Jeffle Xu wrote:
> The inflight of partition 0 doesn't include inflight IOs to all
> sub-partitions, since currently mq calculates inflight of specific
> partition by simply camparing the value of the partition pointer.
> 
> Thus the following case is possible:
> 
> $ cat /sys/block/vda/inflight
> ?? ?? ?? ??0 ?? ?? ?? ??0
> $ cat /sys/block/vda/vda1/inflight
> ?? ?? ?? ??0 ?? ?? ??128
> 
> Partition 0 should be specially handled since it represents the whole
> disk.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But can you resend with your information on the old kernels, and maybe
even with a Fixes tag?
