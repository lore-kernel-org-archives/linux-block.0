Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36410C433F5
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 07:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhLBH0L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 02:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235587AbhLBH0K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 02:26:10 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44DFC061574
        for <linux-block@vger.kernel.org>; Wed,  1 Dec 2021 23:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZEm4NKlnD2xdC0wOI5Dvvxiv+XRhz6MwJwttUFJzceY=; b=gX/qOJmN88SpZk0jKWWrQDaFAu
        xKTKhZhbae2Y4NwbAOKdxmiaZmRI+kHWR1N16NId+ZYAV+J+UZ/75vG3mF/Nh+A3x1IenH8UJPGCl
        +uSaM9hUyec9xnOSj9TO6UT1ncNGBBfNZjhXmruObwWKMoIBkwavTIpDTePH7fG8+Nhl9yLq0+E9T
        S4Oa3gYMKp/15tqU9E3AwC6GGtNz5VtCn47BG6RRFDVyBNRuEfu9TsPoLsd+QTZIoUAKjufmO6uSX
        cVZrBPnzhW/pAr1EPRLqLuqGAczCi+KCJ68MECz8svhjbK7+nNzpAXOntErqW7dIZAcvXKi5VV8E0
        2ZZeNjMA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msgQV-00BAvr-Ot; Thu, 02 Dec 2021 07:22:43 +0000
Date:   Wed, 1 Dec 2021 23:22:43 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] loop: make autoclear operation asynchronous
Message-ID: <Yah0Q//l+I+eM+kf@infradead.org>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
 <YaYfu0H2k0PSQL6W@infradead.org>
 <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 01, 2021 at 11:41:23PM +0900, Tetsuo Handa wrote:
> OK. Here is a patch.
> Is this better than temporarily dropping disk->open_mutex ?

This looks much better, and also cleans up the horrible locking warts
in __loop_clr_fd.
