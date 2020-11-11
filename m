Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A53C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 07:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F6320795
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 07:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BSbg88HM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgKKHhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgKKHhW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 02:37:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3006C0613D1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2020 23:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6mNxzOrdi6hy2yM2w1oPELyakLIzq6/dLk3wGTLtpWg=; b=BSbg88HMxx0NvMBeMlgNz1q/jo
        HKNT9i1UHgmmWYXdAH/5nYk+hi00HRTlycRqw2ckiZ55kJZ41/vjRDFNp55soBTJMTk0TFcgoX2+8
        bkZrDXXCKtc4ERAgRlYb/se516JydBYrbzr/WSCWvOhiS4lrzqxab9xHj2hXYTW0cMEE468Mqr2Aw
        K5ZOXB9uN97nWsO4jaSTn7wzx92eLis4VpIJSO7GVmADxt5DykEEKu48FwfNBEJHjz44Ny49piV0f
        QiPfQfRlkjO8J06Ap0IXgu/pzKojJS832LsbYJAQcv966TLTHqT3xPnwL9F49fMZ1J+02YhkZu6TD
        qfd3sGFA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kckgz-0004SK-3Z; Wed, 11 Nov 2020 07:37:21 +0000
Date:   Wed, 11 Nov 2020 07:37:21 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: Improve blk_revalidate_disk_zones() checks
Message-ID: <20201111073721.GA17000@infradead.org>
References: <20201111073606.767757-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111073606.767757-1-damien.lemoal@wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 11, 2020 at 04:36:06PM +0900, Damien Le Moal wrote:
> Improves the checks on the zones of a zoned block device done in
> blk_revalidate_disk_zones() by making sure that the device report_zones
> method did report at least one zone and that the zones reported exactly
> cover the entire disk capacity, that is, that there are no missing zones
> at the end of the disk sector range.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
