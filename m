Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31464C4338F
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 07:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B3461058
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 07:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbhHIHrf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhHIHrf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Aug 2021 03:47:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A19C0613CF
        for <linux-block@vger.kernel.org>; Mon,  9 Aug 2021 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jb846GQsLQ6JzHS8Jls/UR8JEXUrbT6zAPMJ7R/wzS4=; b=Iq/Cweuh12AVChdQneAHBeYNDK
        C+mKGBK3THrVI0ZBEvS20/P4iemfOJs8bsIyJZ0NasP2w6V6ZuRDkdn5vNZySYC8Z5pPerBkrWwFI
        8mSsCRHYWNNwCQOAyG2c/5z0YGrX3gi6u2FeSJCDXxsgLRkL41Yq2YDq9LKOmkwCRczgoni+xxBBh
        7e4zQBzAdh26izZXi6AUTOEWqZJEWhzwDKnz83gy5NX3gpk+cYYLHQxocYpsvXgY+RUtKg+CYo8tn
        X6eO8dVvU0//0a1aSJPKcu9U21MOyb9m0DjWOeOl17Xvn95zOZAyZ5/IFDjIbhmyleFjXqtv+uTbv
        EobgVvfQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mCzyx-00Alff-UZ; Mon, 09 Aug 2021 07:46:17 +0000
Date:   Mon, 9 Aug 2021 08:45:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3 3/4] block: rename IOPRIO_BE_NR
Message-ID: <YRDdN3SEXYIzY7LK@infradead.org>
References: <20210806111857.488705-1-damien.lemoal@wdc.com>
 <20210806111857.488705-4-damien.lemoal@wdc.com>
 <5f2640c5-0712-b822-9ac7-3daa974c0c30@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f2640c5-0712-b822-9ac7-3daa974c0c30@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Aug 07, 2021 at 10:16:39AM -0600, Jens Axboe wrote:
> >  /*
> > - * 8 best effort priority levels are supported
> > + * The RT and BE priority classes both support up to 8 priority levels.
> >   */
> > -#define IOPRIO_BE_NR	8
> > +#define IOPRIO_NR_LEVELS	8
> 
> That might not be a good idea, if an application already uses
> IOPRIO_BE_NR...

The constant has not actually been exposed in a uapi header in any
released kernel, so if there is a time to rename it it is now.
