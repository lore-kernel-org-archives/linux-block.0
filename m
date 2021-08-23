Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FADAC4338F
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 07:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ADA1611F2
	for <linux-block@archiver.kernel.org>; Mon, 23 Aug 2021 07:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhHWHY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Aug 2021 03:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbhHWHY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Aug 2021 03:24:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C972C061575
        for <linux-block@vger.kernel.org>; Mon, 23 Aug 2021 00:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tzhAPiQucoT3M1zfZKGTlyd9hXwotiPKwppGZepPbtk=; b=fz9o0HA1yTDejxhC0A2xyXvNPT
        TnO5/668LDlEGfpS7jEeNeY88Lp1d300nu/vqALDPmURgVH3quBmYwUq56XEhTNehgviqCENhwu+e
        ReKnbTF7nKHyK53j+bklMjv/hiERPU93SdNehO47arzMus7sij3P8rt6UQOYRN5z7WIDlc6QPfEZU
        nwVSVjwObZC0L4wACpBSjYxfhWt82Vnuy2yG/aeeJ11ZlTQvAZggZi881wTt94xcBzjXl4xY1aDMi
        5MmAch076ywVRNGLbFRoe67bB07LgYTkyJGyK8tDfVENmSQ356BGDQDd9op8b6+02vS1MKBjQ5NY/
        +qyBhKtg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mI4In-009Q8n-Fe; Mon, 23 Aug 2021 07:23:29 +0000
Date:   Mon, 23 Aug 2021 08:23:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: slab-out-of-bounds access in bio_integrity_alloc()
Message-ID: <YSNM7apl1iCnaz+r@infradead.org>
References: <4b6318fb-0008-1747-64d5-b31991324acf@acm.org>
 <7ed9a751-8874-14d1-cbc1-af39768cce95@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ed9a751-8874-14d1-cbc1-af39768cce95@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 20, 2021 at 09:06:29PM -0600, Jens Axboe wrote:
> On 8/20/21 4:58 PM, Bart Van Assche wrote:
> > Hi,
> > 
> > It's been a while since I ran blktests. If I run it against Jens' for-next
> > branch (39916d4054e7 ("Merge branch 'for-5.15/io_uring' into for-next")) a
> > slab-out-of-bounds access complaint appears. Is anyone already looking into
> > this?
> 
> Does this help?

Btw, we still have the memset based initialization in bio_reset.
We should probably add a shared function for the common initialization
between bio_init and bio_reset and then remove BIO_RESET_BYTES
entirely, and just document the fields that survive a reset in
in the struct definition.

