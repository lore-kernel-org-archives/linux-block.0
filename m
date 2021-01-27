Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3FFC433E9
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 17:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EC264DA3
	for <linux-block@archiver.kernel.org>; Wed, 27 Jan 2021 17:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbhA0RNr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhA0RLi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 12:11:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422F8C061573
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 09:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=34+w+S7MCsN2gh9V4lTxkwPkwkPCHw2QT7n6VmEXuqM=; b=lLKNdfWcDjbIfPOrzxbpj6PYHJ
        wEv/72tM3hk5oSAb2Q0PM7NxOBr6XWe2wYyk83TdvjZ8taDd//BqUIxlh6P3bqLZlMmp3KswWKc3D
        y0vTIeK80y1P8WiM6aOqWZkVx1J8I8YkeflhHrDaqCPkc0NNglOCZeaSRaQsfcnVlBgJh/Xv+SBnj
        iNMbBYzTNUcsA1P7kC0g3bTWTl3klXl1rgP02Gy1ujNCWjE4oGzy9d0D+ZukWnm+3B6y5yiOylKu+
        E/Ys7E8J2Y727N/QVst/labjKZNsK5IvV8SyYPaNLCqyoUnX8qCRbDH4xXD9/EpiqcvTeDAKJ0svi
        riMCgprg==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4oLC-007Grm-9y; Wed, 27 Jan 2021 17:10:51 +0000
Date:   Wed, 27 Jan 2021 17:10:50 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 1/4] block: add a statistic table for io latency
Message-ID: <20210127171050.GA1732656@infradead.org>
References: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
 <20210127145930.8826-2-guoqing.jiang@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127145930.8826-2-guoqing.jiang@cloud.ionos.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 27, 2021 at 03:59:27PM +0100, Guoqing Jiang wrote:
> +config BLK_ADDITIONAL_DISKSTAT
> +	bool "Block layer additional diskstat"
> +	default n

n is the default default.  But more importantly I don't think having
this as a compile time option makes much sense sense.  No one is going
to recompile their kernel to get a few stats or to avoid the overhead
of these stats.
