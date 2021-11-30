Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0ABC433EF
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 12:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhK3NA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 08:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhK3NA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 08:00:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A9C061574
        for <linux-block@vger.kernel.org>; Tue, 30 Nov 2021 04:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yT8bkU4N1cVruLzq6XIiOr/QpqYSfaJq5dzTtWIkH5Q=; b=IT0dkj2oewIb6CBotNkurIOLZq
        AWxdeZsxUIPUVpHv1tjqzRlmoPudFo7xkhxqENvhztEQSUs3ha+S295OwZIieYgNg8lVaPgwyOA26
        Ix5dxDesRFG5N5yRFlTrIrFQTJnev58M24vc5BLNAGqGEheSwzRilGpHR2B/TPDMa1iR6pfS1rjzN
        SVro1Tmi1IGCwMiy1W67Vk1uk6rmqJBIdVVf93f9VQHiasc0uJ3YdVxp9Kg/DlqR+TrpyWtX3/2e0
        vipk49/Hv9Cl0qzi/Kb4yOMVyFGTyJiZcZNjTzXalXWYLm/C8A/RG5QYKPaGJ1exFw24rsWwhuzqT
        Cy1PMaMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ms2hP-005CBo-GU; Tue, 30 Nov 2021 12:57:31 +0000
Date:   Tue, 30 Nov 2021 04:57:31 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] possible deadlock in blkdev_put (2)
Message-ID: <YaYfu0H2k0PSQL6W@infradead.org>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 29, 2021 at 07:36:27PM +0900, Tetsuo Handa wrote:
> If the caller just want to call ioctl(LOOP_CTL_GET_FREE) followed by
> ioctl(LOOP_CONFIGURE), deferring __loop_clr_fd() would be fine.
> 
> But the caller might want to unmount as soon as fput(filp) from __loop_clr_fd() completes.
> I think we need to wait for __loop_clr_fd() from lo_release() to complete.

Anything else could have a reference to this or other files as well.
So I can't see how deferring the clear to a different context can be
any kind of problem in practice.
