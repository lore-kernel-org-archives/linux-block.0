Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5FAC34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FAD72067D
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CuskNoV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgBSQ2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:28:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbgBSQ2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GwhmZYOXRKo5GEKPILaa/bNrAAaJJsxIZFE07QbD0wk=; b=CuskNoV23y0pgw1lrJE3Z/uBKg
        kgo2Mw4zt1V4h6kjNj+Lj0V+RL0DI/31PtIl/cia3LVFABALbkRas5vqQ29sz3daMa7j9vtOfMdYV
        K4fO/H976LDtxjWe861017Oyk7KzG8d4ZEu2vdkWoXHllsyHBmTDINOOIWKUB9D3gFIgcBmrfxKyT
        6ID1AeqpGla9b/ZQFm74guNcca/fOpEzxoj0lYfsU1iU425eM9wXmIuq5yd0eRcOGj3oSm9jGoOL8
        fmYPiz7mv4q/gH4Q8D9lpZ9XE3JMmDOIsvCLm+ksUxv2wBecGMKO26F384mm0LgzZxDZgP8VAP4UX
        sVsojUAg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SDU-00032E-OA; Wed, 19 Feb 2020 16:28:52 +0000
Date:   Wed, 19 Feb 2020 08:28:52 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] block: Fix partition support for host aware zoned block
 devices
Message-ID: <20200219162852.GB10644@infradead.org>
References: <20200219042632.819101-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219042632.819101-1-shinichiro.kawasaki@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 19, 2020 at 01:26:32PM +0900, Shin'ichiro Kawasaki wrote:
> +	/* Iterate partitions skipping the holder device at index 0 */

s/holder/whole/ ?

> +extern bool disk_has_partitions(struct gendisk *disk);

No need for externs on function prototypes in headers.
