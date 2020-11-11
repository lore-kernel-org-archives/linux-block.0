Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1309C4742C
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80816206B5
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tprOeYM4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgKKILt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKKILt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:11:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F0BC0613D1
        for <linux-block@vger.kernel.org>; Wed, 11 Nov 2020 00:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YUL0ZR+J9//qMFXOZExGjCSvHJpwikWO6Osnp1Mefeg=; b=tprOeYM4I5NUDsX54uh1eVMjPm
        FhopmKzxklJP7XWaja9PtYEN864eR5LmeGo5iDZpMVLom9KtoqmVb0knhaSjJEhaXtzXQd3019bDh
        qnybClzTUsIR1xpA4kBT9ou8YPEu6JD2u0JBbQ4LOaV0hvx4uH49L0ZIo2ijFCXjFBdq4gK+zOZ1n
        YrSSDIMEqHQwECHhZF9aIMC5Sn8qbYukF99CDExCUU11joU0T/jseCaGOmW3qkbzLO1TH96L3jlJe
        nnNgjMBIxrJWc0sJFTA/RPjcLfjWd0Rhfa4Ye+Y1jhSvaKbzXIDjuS7RA0raq/SyuogIJI1kzR96D
        plfZZu7w==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclEJ-0006Xc-FM; Wed, 11 Nov 2020 08:11:47 +0000
Date:   Wed, 11 Nov 2020 08:11:47 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 4/9] null_blk: improve zone locking
Message-ID: <20201111081147.GD23360@infradead.org>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-5-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111051648.635300-5-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> +	spin_lock_init(&dev->zone_res_lock);
> +	if (dev->memory_backed)
>  		dev->zone_locks = bitmap_zalloc(dev->nr_zones, GFP_KERNEL);
> +	else
> +		dev->zone_locks = kmalloc_array(dev->nr_zones,
> +						sizeof(spinlock_t), GFP_KERNEL);
> +	if (!dev->zone_locks) {

Using the same pointer for different types is pretty horrible.  At very
least we should use a union.

But I think we'd end up with less contention if we add a new

struct nullb_zone

that contains the fields of blk_zone that we actuall care about plus:

	union {
		spinlock_t	spinlock;
		mutex_t		mutex;
	}

and then use the proper lock primitive also for the memory backed case.
