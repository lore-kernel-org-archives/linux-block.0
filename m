Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09292C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 05:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiDRFRm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 01:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiDRFRl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 01:17:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B8438AB;
        Sun, 17 Apr 2022 22:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=05bZopyuY2vKFmqnP3FA43TKOlvN0o/huqGPlzbxCOA=; b=1WAbili0haVJfedFeVXuHME/Yx
        JAzOOShmc9CNBO+MVWYoIkJCSGQIEitVTTTQEKSJV6MDMEpgSdytDkq592jPAFG5Y+zNgld6Fu318
        Yq/YCGGokVE+yD41LhzWuMSKPHR/zrYIkHd7PoqjrQ/QxU6Cg8XJzkYb9N5mUrizyaTC6fWP+sPAn
        xbo8V4u9ZTndhm4BXL2FVwQqk4tMCJJn+/zJCD+yi/nM7rBqqdfnJufA/vUAtX8vIMlSLtsRI0h5V
        YPwLOBEtq6Uj9h4z+GyEz7DjCkGrq/OT+DOytfjFnJGQXUzAFIY+KHMK1kCk0CBgjZ2pHtqH9LuBM
        NwdRO5MA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngJiz-00Fdw6-SN; Mon, 18 Apr 2022 05:14:57 +0000
Date:   Sun, 17 Apr 2022 22:14:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] block: add filemap_invalidate_lock_killable()
Message-ID: <Ylzz0bbN1y3OFABI@infradead.org>
References: <ff8f59e5-7699-0ccd-4da3-a34aa934a16b@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff8f59e5-7699-0ccd-4da3-a34aa934a16b@I-love.SAKURA.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'm starting to sound like a broken record as I'm stating it the third
time now, but: 

no, this does not in any way fix the problem of holding the invalidate
lock over long running I/O.  It just does ease the symptoms in the least
important but apparently visible to you caller.

What we need to do is to get the zeroing I/O out from under the
invalidate lock, just like how we don't do direct I/O under it.
