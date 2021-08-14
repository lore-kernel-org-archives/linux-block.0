Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E3DC4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 07:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6556101E
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 07:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbhHNHmb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbhHNHma (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 03:42:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD12C06175F;
        Sat, 14 Aug 2021 00:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=K13tg5TodNeBZEaQs93qd2dLJt
        yJ7PjTsfGNesTofM6Aaks/5zmRuOD6XL04FlT5Ntvv3f3ET2Gb/F24YRmibcU7et52ZVoOJ85jWje
        R2cfnLwWPFs46A+jcu+WAj+xo+Ms4NcUKmJ5MbUup8+7XH7v/9gFKciyYVrmTsSTgLg8DTMeNg5Re
        thQo6TMQXWKUeiC1wGcFhZNCINqXYs5OatCA433+MSKG+iQE3JjLuolHDW8k5tyZBB6N6vuSuxasF
        ukq7vcuWMiDbrws/9l/L2CC/BRdkEu6yrKm18j7GlXLNJ0wrkA2LElSqs3EXvCFHXi5iAM1j3QAFu
        dM6tsC0Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEoHx-00GUoZ-UF; Sat, 14 Aug 2021 07:41:15 +0000
Date:   Sat, 14 Aug 2021 08:41:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+cf89d662483d6a1a0790@syzkaller.appspotmail.com
Subject: Re: [RESEND PATCH v2] loop: fix setting arbitrarily large block size
Message-ID: <YRdzkc6WoJOkP7yd@infradead.org>
References: <20210814024717.1839753-1-chouhan.shreyansh630@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814024717.1839753-1-chouhan.shreyansh630@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
