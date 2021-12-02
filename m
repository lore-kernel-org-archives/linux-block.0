Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7FC433EF
	for <linux-block@archiver.kernel.org>; Thu,  2 Dec 2021 18:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbhLBSI1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:08:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57556 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbhLBSI1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Dec 2021 13:08:27 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D73E51FDFB;
        Thu,  2 Dec 2021 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638468303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sXhaWHINXp7ud+1atyzdlmBLVXdbdokQ4c0v6K8jfXY=;
        b=KJAMD7kLcUT62Bo80QmjhtBlfpFpnaz/Jr02EzzCe3UBxH9lFoKoyGjwOL4qkC07Yr4vgF
        0J5Qu8kHoCTzdfJTmsJYhnR+acW1az9JmBANPBrcZRVXGj78n5SopKXqd+GlIYiJQdua5R
        EdZRcRFxP/Br8aE+Hc+DCKjCvZxifgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638468303;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sXhaWHINXp7ud+1atyzdlmBLVXdbdokQ4c0v6K8jfXY=;
        b=t9vwx+KNnrJ5rtZcgJKox+GXAqEvRIMip4bZRtcvcsVtwnZYkEHy4gBfoBGYS4G5vtzdBF
        yy4AorUgs910WRBg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id C3FE0A3B81;
        Thu,  2 Dec 2021 18:05:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5ABCB1E0C01; Thu,  2 Dec 2021 19:05:00 +0100 (CET)
Date:   Thu, 2 Dec 2021 19:05:00 +0100
From:   Jan Kara <jack@suse.cz>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] loop: make autoclear operation asynchronous
Message-ID: <20211202180500.GA30284@quack2.suse.cz>
References: <0000000000007f2f5405d1bfe618@google.com>
 <e4bdc6b1-701d-6cc1-5d42-65564d2aa089@I-love.SAKURA.ne.jp>
 <bb3c04cf-3955-74d5-1e75-ae37a44f2197@i-love.sakura.ne.jp>
 <20c6dcbd-1b71-eaee-5213-02ded93951fc@i-love.sakura.ne.jp>
 <YaSpkRHgEMXrcn5i@infradead.org>
 <baeeebb3-c04e-ce0a-cb1d-56eb4a7e1914@i-love.sakura.ne.jp>
 <YaYfu0H2k0PSQL6W@infradead.org>
 <de6ec247-4a2d-7c3e-3700-90604f88e901@i-love.sakura.ne.jp>
 <20211202121615.GC1815@quack2.suse.cz>
 <3f4d1916-8e70-8914-57ba-7291f40765ae@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f4d1916-8e70-8914-57ba-7291f40765ae@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu 02-12-21 23:39:42, Tetsuo Handa wrote:
> On 2021/12/02 21:16, Jan Kara wrote:
> > Why not scheduling this using task_work_add()? It solves the locking
> > context problems, has generally lower overhead than normal work (no need to
> > schedule), and avoids possible unexpected side-effects of releasing
> > loopback device later. Also task work is specifically designed so that one
> > task work can queue another task work so we should be fine using it.
> 
> Indeed. But that will make really no difference between synchronous approach
> ( https://lkml.kernel.org/r/fb6adcdc-fb56-3b90-355b-3f5a81220f2b@i-love.sakura.ne.jp )
> and asynchronous approach
> ( https://lkml.kernel.org/r/d1f760f9-cdb2-f40d-33d8-bfa517c731be@i-love.sakura.ne.jp ), for
> disk->open_mutex is the only lock held when lo_release() is called.
> 
> Both approaches allow __loop_clr_fd() to run with no lock held, and both
> approaches need to be aware of what actions are taken by blkdev_put()
> before and after dropping disk->open_mutex. And
> bdev->bd_disk->fops->release() is the last action taken before dropping
> disk->open_mutex.
> 
> What is so happier with preventing what will be done after
> disk->open_mutex is dropped by blkdev_put() (i.e. __module_get() +
> kobject_get() before blkdev_put() calls kobject_put() + module_put(), and
> kobject_put() + module_put() upon task_work_run()), compared to doing
> things that can be done without disk->open_mutex (i.e. calling
> __loop_clr_fd() without disk->open_mutex) ?

So the advantage of using task work instead of just dropping open_mutex
before calling __loop_clr_fd() is that if something in block/bdev.c ever
changes and starts relying on open_mutex being held throughout blkdev_put()
then loop device handling will not suddently become broken. Generally it is
a bad practice to drop locks (even temporarily) upper layers have acquired.
Sometimes it is inevitable in in this case we can avoid that... So I'd
prefer if we used task work instead of dropping open_mutex inside loop
driver. Not sure what's Christoph's opinion though, I don't feel *that*
strongly about it.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
