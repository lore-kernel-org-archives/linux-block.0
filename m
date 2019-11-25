Return-Path: <SRS0=vXr6=ZR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70A7C432C0
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B020B20835
	for <linux-block@archiver.kernel.org>; Mon, 25 Nov 2019 17:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="U+XkpZq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKYRkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Nov 2019 12:40:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfKYRkm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Nov 2019 12:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uxPYNIRvXaDDaZYdugd2AISuQeyYM+VNm+o9iO+FosU=; b=U+XkpZq0mAiGvkr+/u5C2Ze7b
        AR1n4xm4BNQUrTkqlPPE0rcpm1pR6sa60/rRHZzmhg4mIwOXqWLFypEd2raGJ91PKejoKMpLmUgJj
        L9frT+KC/V3hufQz9PCcHGyvyDUOK4bqYHFPatuUV0XsB4gzfQn7q9z1UZ+s0DP+BNRKabABJUTj9
        hVBl/rOvW5TxIC/22b2Hx4bDNuk2GXNRKmLll6b5F4fc6n7/azGk0RA4RVk+ccH6t7WZyi3Tz4PCL
        uHvv4EdPRi+ISff4Zn65dv4ONfunfxDIrnYedwp3OE+Ts28LcTy8cX2PnLFTR2Vi2TCNOEwQ+j57L
        DQCqLcRAw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZILl-0001gv-Sp; Mon, 25 Nov 2019 17:40:37 +0000
Date:   Mon, 25 Nov 2019 09:40:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        syzbot+21cfe1f803e0e158acf1@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: Replace bio_check_ro()'s WARN_ON()
Message-ID: <20191125174037.GA768@infradead.org>
References: <20180824211535.GA22251@beast>
 <201911221052.0FDE1A1@keescook>
 <20191122190707.GA2136@infradead.org>
 <94976fb5-12d3-557d-7f31-347d6116b18c@kernel.dk>
 <20191122191434.GA10150@infradead.org>
 <201911221131.A34DFAA49@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201911221131.A34DFAA49@keescook>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So I looked at this a bit, and doing the right thing (TM) will be
a little invase and thus not for 5.5.

But the 5.5. queue already has a patch from Mikulas Patocka:
8b2ded1c94c ("block: don't warn when doing fsync on read-only devices")
which should deal with this issue, and in fact I can't trigger the
WARN_ON with Jens' latest tree.
