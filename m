Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7107C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 16:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95AEF6137C
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 16:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhJUQXU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUQXU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 12:23:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8554AC061764;
        Thu, 21 Oct 2021 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FX0dkun5WT6rd/7wz/5I/0pAp1+2wzVqcn4smVW06Kk=; b=NPBHrnNN+GDT52A4PBcACmDn+n
        rab14iBDZnViJNWCw1829ZH7Z3XU0R9+7bfp4i8w2QRfbFwas+K+/IG5a2u5c/tdnUmdfgWM/F7+2
        +izW7wLkAaUw5BNcfkaGoE65OwPN0wjAZZJV8F2GEto4hbTaPWj124O8UwnUt41FNJ62S4OL10rgX
        bGJln2+QGPF1WJD0S7zLiD+NCWNxzVd0LH8B0ICqHG9IbYWEKrDYZhINaR8oLHCZTHsNJzJLe581Z
        PBXMSObezQsrpck2Xl7xnG15Fiv1QEbptqNu9SnzdySZnkkiZ5m3HwGPxm/fTBDIgT6DGKMzSQB7p
        dtjmRZiw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdaoR-008L91-Fa; Thu, 21 Oct 2021 16:21:03 +0000
Date:   Thu, 21 Oct 2021 09:21:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Christoph Hellwig <hch@lst.de>,
        Finn Thain <fthain@linux-m68k.org>
Subject: Re: [PATCH v2] ataflop: remove ataflop_probe_lock mutex
Message-ID: <YXGTbx0bp/kZCSDf@bombadil.infradead.org>
References: <1d9351dc-baeb-1a54-625c-04ce01b009b0@i-love.sakura.ne.jp>
 <6d26961c-3b51-d6e1-fb95-b72e720ed5d0@gmail.com>
 <5524e6ee-e469-9775-07c4-7baf5e330148@i-love.sakura.ne.jp>
 <YXGTNjhWfVjsB9A8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXGTNjhWfVjsB9A8@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 21, 2021 at 09:20:06AM -0700, Luis Chamberlain wrote:
> On Sun, Oct 17, 2021 at 11:09:47AM +0900, Tetsuo Handa wrote:
> > Commit bf9c0538e485b591 ("ataflop: use a separate gendisk for each media
> > format") introduced ataflop_probe_lock mutex, but forgot to unlock the
> > mutex when atari_floppy_init() (i.e. module loading) succeeded. This will
> > result in double lock deadlock if ataflop_probe() is called. Also,
> > unregister_blkdev() must not be called from atari_floppy_init() with
> > ataflop_probe_lock held when atari_floppy_init() failed, for
> > ataflop_probe() waits for ataflop_probe_lock with major_names_lock held
> > (i.e. AB-BA deadlock).
> > 
> > __register_blkdev() needs to be called last in order to avoid calling
> > ataflop_probe() when atari_floppy_init() is about to fail, for memory for
> > completing already-started ataflop_probe() safely will be released as soon
> > as atari_floppy_init() released ataflop_probe_lock mutex.
> > 
> > As with commit 8b52d8be86d72308 ("loop: reorder loop_exit"),
> > unregister_blkdev() needs to be called first in order to avoid calling
> > ataflop_alloc_disk() from ataflop_probe() after del_gendisk() from
> > atari_floppy_exit().
> > 
> > By relocating __register_blkdev() / unregister_blkdev() as explained above,
> > we can remove ataflop_probe_lock mutex, for probe function and __exit
> > function are serialized by major_names_lock mutex.
> > 
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> > Fixes: bf9c0538e485b591 ("ataflop: use a separate gendisk for each media format")
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

I should note though that this does not apply to linux-next, I rebased
it and will send a rebased version on my v3 series of my last patch set
for add_disk error handling work().

  Luis
