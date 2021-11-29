Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC50CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 29 Nov 2021 11:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376967AbhK2LIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Nov 2021 06:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352759AbhK2LGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Nov 2021 06:06:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32B4C08E85B
        for <linux-block@vger.kernel.org>; Mon, 29 Nov 2021 02:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3VzyOgDsyOXo1v/9+/nrvpfixuauNfUCdyNQfRe54NA=; b=pheIqu4PTb1WJyKtF6SbdHLmpE
        OYt2JQlGI/vVcFxJO93uF++oEUBMXqqbp97hQYGJ0wUWvkuy0FYD1/55cBS5+857AmEsDym+ZrcFb
        OwRQ46Ux41njEX1goItk311YGlHU8EKMe7Mux8wghgrLOr5hHcAdVUrWWFT/oPrpTYVmAJbcTnKA2
        NdpcvK+42nrAzfqaJsfSv08rHWvtNU5toJa8cVBRQgmGKK9x0mcgTHLnG3HCGZYC43uf9uPg5KtWC
        5p0CMGh7woDDAGayDOB3t5lc4HADZmAZiCN5Wbs62Dy6gY2t8nJK19fLd7mEmYbpIQwWYQ54c4VWS
        PpSI68ug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrdmT-000Nfl-2U; Mon, 29 Nov 2021 10:21:05 +0000
Date:   Mon, 29 Nov 2021 02:21:05 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] possible deadlock in blkdev_put (2)
Message-ID: <YaSpkRHgEMXrcn5i@infradead.org>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Nov 28, 2021 at 04:42:35PM +0900, Tetsuo Handa wrote:
> On 2021/11/28 14:32, Tetsuo Handa wrote:
> > If we can unconditionally start __loop_clr_fd() upon ioctl(LOOP_CLR_FD), I think
> > we can avoid circular locking between disk->open_mutex and flush_workqueue().
> 
> Too bad. There is ioctl(LOOP_SET_STATUS) which allows forcing __loop_clr_fd() to be
> called without ioctl(LOOP_CLR_FD). We have to support __loop_clr_fd() upon lo_release().
> 
> Is dropping disk->open_mutex inside lo_release()
> ( https://lkml.kernel.org/r/e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp ) possible?

I don't think we can drop open_mutex inside ->release. What is the
problem with offloading the clearing to a different context than the
one that calls ->release?
