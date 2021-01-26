Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC11C433DB
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 15:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A096C2310E
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 15:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406079AbhAZPLL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 10:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406197AbhAZPJV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 10:09:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E93DC061A31;
        Tue, 26 Jan 2021 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jywVRgQb+R/8nrC6wcC0tprf9W0TUepj2A0VJnxWY7w=; b=D4n+1nPul2NOhNPZRJuwX9YBXA
        JCsbDOMHCHWzYej2yXoxgPSqOSFOSutcobuuWI4mrpr2gxzMUDgMRUeHaPla/101DVXo0E2AWgrYV
        9qcPPaqJlzqQgs6POzLFnL8qlSEosQofGYG+V4fgpkbMBH1OXZo0s+BaoVzJ/LlxghxvO5AM8vdZC
        jMQpJZRfNz/zt9dVM8wPjs6RQke1S6dshAm2nT/DLTOsyf8oKb4OkCjOmzr+JzXgQOSUezIeXLnIW
        NfWwvWl5+8K859FC+VwnewuNACvy8w+x7rH5FySoGGAL4E4cH50i7BeSeMiPrAJHyFaG6G1Gg8GMv
        qIaWxJVQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l4PuB-005nGD-92; Tue, 26 Jan 2021 15:05:48 +0000
Date:   Tue, 26 Jan 2021 15:05:19 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Changheun Lee <nanich.lee@samsung.com>, Johannes.Thumshirn@wdc.com,
        asml.silence@gmail.com, axboe@kernel.dk, damien.lemoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        osandov@fb.com, patchwork-bot@kernel.org, tj@kernel.org,
        tom.leiming@gmail.com, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, mj0123.lee@samsung.com,
        seunghwan.hyun@samsung.com, sookwan7.kim@samsung.com,
        woosung2.lee@samsung.com, yt0928.kim@samsung.com
Subject: Re: [PATCH v3 1/2] bio: limit bio max size
Message-ID: <20210126150519.GA1377213@infradead.org>
References: <CGME20210126014805epcas1p2c4fc40f01c9c89b0a94ff6cac5408347@epcas1p2.samsung.com>
 <20210126013235.28711-1-nanich.lee@samsung.com>
 <20210126035748.GA1071341@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126035748.GA1071341@T590>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 26, 2021 at 11:57:48AM +0800, Ming Lei wrote:
> >  				*same_page = false;
> >  				return false;
> >  			}
> 
> So far we don't need bio->bi_disk or bio->bi_bdev(will be changed in
> Christoph's patch) during adding page to bio, so there is null ptr
> refereance risk.

I've started resurrecting my old plan to always have a valid device
in the bio from allocation time on.  It is pretty invasive, but
probably worth it.  Sending out the first prep series right now, the
actual changes should be ready for an RFC later this week.
