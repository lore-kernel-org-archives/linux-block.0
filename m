Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C971BC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 13:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbiGFNGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiGFNGL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 09:06:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F98DEA1;
        Wed,  6 Jul 2022 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ce63EBe4Tq2Uux8fPs1Pycd4aTVkng2Wf2+PmZuWupU=; b=aVRTvSA1UJKof07qjOK7lF85rq
        ppGLIBe1l5SZn2IR5uT/g6O6COcRr9qIFNhOrUBf7LrdEdykgvsuyBJdvMg9PXyfosj9fpdmXiF0s
        U4pqKxdd1i3JfD6a0LO1134K4hG10jpzzerJRrDhK4wf7bFmhkzQnGlPcOtwONeG3S9YMeOQvToAw
        t4XbRh2ZYR6dNR6g/g8rXCkhNwookOWkOJ/BmhtWB2xsbU1eH+WXF0fy2WPVP2oUZFfrJ8j0nZesf
        vEzBEAnewPuz4t/STSKoITyPDmgZoQYgK5XwnJFfIHZkJougC1UEdEiSEoiXak5OcMlE8SOH1lBD2
        MA3zzhRQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o94jJ-00A9fn-Ln; Wed, 06 Jul 2022 13:06:09 +0000
Date:   Wed, 6 Jul 2022 06:06:09 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/20] block, blksnap: Kconfig
Message-ID: <YsWIwQ7Z2OKesQVI@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-19-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-19-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 13, 2022 at 06:53:11PM +0300, Sergei Shtepa wrote:
> +config BLK_SNAP_TRACKING_BLOCK_MINIMUM_SHIFT
> +	depends on BLK_SNAP
> +	int "The power of 2 for minimum trackings block size"

> +config BLK_SNAP_TRACKING_BLOCK_MAXIMUM_COUNT
> +	depends on BLK_SNAP

> +config BLK_SNAP_CHUNK_MINIMUM_SHIFT
> +	depends on BLK_SNAP

> +config BLK_SNAP_CHUNK_MAXIMUM_COUNT
> +	depends on BLK_SNAP
> +	int "The limit of the maximum number of snapshots chunks"

...

Is there any good reason for these to be compile options vs runtime
settings?

> +config BLK_SNAP_DEBUG_MEMORY_LEAK
> +	depends on BLK_SNAP
> +	bool "Enable memory leak detector"
> +	default n
> +	help
> +	  Enables debugging code to monitor memory consumption by the module.

Is there any advantage in this over kmemleak and friends?
