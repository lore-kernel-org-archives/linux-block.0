Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF9DC64E8A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 17:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DC22074A
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v71CKSQj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgK3RGb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Nov 2020 12:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgK3RGb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Nov 2020 12:06:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744E5C0613CF
        for <linux-block@vger.kernel.org>; Mon, 30 Nov 2020 09:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=29ua36AlWUH6HMjlPo210LX/N/71WtOaxe4/BvMwAd4=; b=v71CKSQj10qFQuhPfPBdRLL8P/
        hbC6teQWp8w4h3GIeRXzXiRdDSouoPALACj0gLY0usTDn0z1cmgqeum0gwy8qRB3C5D0GDfqajHq6
        g5Pptw2zQU7cgsT68+krqWCmfncl9jrZeJxE3YkBz4IZ04w/nEVNXeHyt8V9ZaGy/fHEQl41ARMyo
        NLg82ioMGNVY03iDz3hWf6pQYn1uF3uiJKs1a/0uig3Iw6dPNQKfmWqQPXRtBvZQGj35ZHUE2Hcr6
        sEHhPuf69Y0tYhWoBH8iRLVwOV18m/kWPvhRRpoyTTJdGjwg2JexWe3OBagkP1X72A0gM57pxLzm+
        vFjP267g==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjmcW-0002k4-Ld; Mon, 30 Nov 2020 17:05:48 +0000
Date:   Mon, 30 Nov 2020 17:05:48 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] block: fix inflight statistics of part0
Message-ID: <20201130170548.GA10078@infradead.org>
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

I'm not sure and can see arguments for either side.  In doubt we should
stick to historic behavior, can you check what old kernels (especially
before blk-mq) did?
