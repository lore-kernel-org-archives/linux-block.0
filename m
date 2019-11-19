Return-Path: <SRS0=5EpG=ZL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4686CC432C0
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 03:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191122230F
	for <linux-block@archiver.kernel.org>; Tue, 19 Nov 2019 03:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574135653;
	bh=gVaoEfdiE6QGBVJzfbL1Mk1XcPXpP9BXLfVw/JsCMCQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Lo6HmcgEB+s3SiZ4sGYY5hYilWHxuU0+zFD3THqPhb2Zk5XvvBhRDO1N77KBC044F
	 JBHWQg/wqr38IZEJIM1DgR+e0/ejEyvzVddbmGA16vaPJWvCx/Af4oqhnOB61oLmAs
	 OWHk1TGLqem6hhXt1sEky4s5TWvOcMxhVmhqdy10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfKSDyM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Nov 2019 22:54:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbfKSDyM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 22:54:12 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22306222DD;
        Tue, 19 Nov 2019 03:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574135651;
        bh=gVaoEfdiE6QGBVJzfbL1Mk1XcPXpP9BXLfVw/JsCMCQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DkiMhRza8LV0gcVFrffeiUMy2HPFDAdV4VBn6Wgd1M1VQoGTDQghdmLngOD2oMw7a
         H7Vuu8OeOZB6T0CBMnVlcewDLC2T+tZeJ+sqFWhlhewIxok5FlMVbgLpGJeSCTpUdj
         2bU5aC4TUUwNbqsVnjYO7m9wOBAS8BTdanBvDL1M=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B91CC35227AF; Mon, 18 Nov 2019 19:54:10 -0800 (PST)
Date:   Mon, 18 Nov 2019 19:54:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>, axboe@kernel.dk,
        justin@coraid.com, linux-block@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in process_srcu / synchronize_srcu
Message-ID: <20191119035410.GR2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <000000000000b587670596839fab@google.com>
 <CANpmjNPpvyxZv9N042Uz1gQb7R0B1MOmCa255-czqWsc7SiOxg@mail.gmail.com>
 <20191104161152.GB20975@paulmck-ThinkPad-P72>
 <CANpmjNNFQbtDpBzbf-RkBp=mzhzXCLOO=scA=oB6xSWD3X9zEw@mail.gmail.com>
 <20191104165303.GG20975@paulmck-ThinkPad-P72>
 <20191119024805.GF3147@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119024805.GF3147@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 18, 2019 at 06:48:05PM -0800, Eric Biggers wrote:
> On Mon, Nov 04, 2019 at 08:53:03AM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 04, 2019 at 05:14:50PM +0100, Marco Elver wrote:
> > > On Mon, 4 Nov 2019 at 17:11, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Mon, Nov 04, 2019 at 12:31:56PM +0100, Marco Elver wrote:
> > > > > +RCU folks, since this is probably a data race in RCU.
> > > > >
> > > > > On Mon, 4 Nov 2019 at 12:29, syzbot
> > > > > <syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
> > > > > > git tree:       https://github.com/google/ktsan.git kcsan
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=17ade7ef600000
> > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
> > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=08f3e9d26e5541e1ecf2
> > > > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > > >
> > > > > > Unfortunately, I don't have any reproducer for this crash yet.
> > > > > >
> > > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > > Reported-by: syzbot+08f3e9d26e5541e1ecf2@syzkaller.appspotmail.com
> > > > > >
> > > > > > ==================================================================
> > > > > > BUG: KCSAN: data-race in process_srcu / synchronize_srcu
> > > > > >
> > > > > > write to 0xffffffff8604e8a0 of 8 bytes by task 17 on cpu 1:
> > > > > >   srcu_gp_end kernel/rcu/srcutree.c:533 [inline]
> > > > > >   srcu_advance_state kernel/rcu/srcutree.c:1146 [inline]
> > > > > >   process_srcu+0x207/0x780 kernel/rcu/srcutree.c:1237
> > > > > >   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> > > > > >   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> > > > > >   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> > > > > >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> > > > > >
> > > > > > read to 0xffffffff8604e8a0 of 8 bytes by task 12515 on cpu 0:
> > > > > >   srcu_might_be_idle kernel/rcu/srcutree.c:784 [inline]
> > > > > >   synchronize_srcu+0x107/0x214 kernel/rcu/srcutree.c:996
> > > > > >   fsnotify_connector_destroy_workfn+0x63/0xb0 fs/notify/mark.c:164
> > > > > >   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> > > > > >   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> > > > > >   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> > > > > >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> > > > > >
> > > > > > Reported by Kernel Concurrency Sanitizer on:
> > > > > > CPU: 0 PID: 12515 Comm: kworker/u4:8 Not tainted 5.4.0-rc3+ #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > Google 01/01/2011
> > > > > > Workqueue: events_unbound fsnotify_connector_destroy_workfn
> > > > > > ==================================================================
> > > > > > Kernel panic - not syncing: panic_on_warn set ...
> > > > > > CPU: 0 PID: 12515 Comm: kworker/u4:8 Not tainted 5.4.0-rc3+ #0
> > > > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > > > > Google 01/01/2011
> > > > > > Workqueue: events_unbound fsnotify_connector_destroy_workfn
> > > > > > Call Trace:
> > > > > >   __dump_stack lib/dump_stack.c:77 [inline]
> > > > > >   dump_stack+0xf5/0x159 lib/dump_stack.c:113
> > > > > >   panic+0x210/0x640 kernel/panic.c:221
> > > > > >   kcsan_report.cold+0xc/0x10 kernel/kcsan/report.c:302
> > > > > >   __kcsan_setup_watchpoint+0x32e/0x4a0 kernel/kcsan/core.c:411
> > > > > >   __tsan_read8 kernel/kcsan/kcsan.c:36 [inline]
> > > > > >   __tsan_read8+0x2c/0x30 kernel/kcsan/kcsan.c:36
> > > > > >   srcu_might_be_idle kernel/rcu/srcutree.c:784 [inline]
> > > > > >   synchronize_srcu+0x107/0x214 kernel/rcu/srcutree.c:996
> > > > > >   fsnotify_connector_destroy_workfn+0x63/0xb0 fs/notify/mark.c:164
> > > > > >   process_one_work+0x3d4/0x890 kernel/workqueue.c:2269
> > > > > >   worker_thread+0xa0/0x800 kernel/workqueue.c:2415
> > > > > >   kthread+0x1d4/0x200 drivers/block/aoe/aoecmd.c:1253
> > > > > >   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:352
> > > > > > Kernel Offset: disabled
> > > > > > Rebooting in 86400 seconds..
> > > > > >
> > > > > >
> > > > > > ---
> > > > > > This bug is generated by a bot. It may contain errors.
> > > > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > > > >
> > > > > > syzbot will keep track of this bug report. See:
> > > > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > >
> > > > Good catch!  Does the patch below help?
> > > 
> > > Looks good to me, thanks for the quick fix.
> > > 
> > > Acked-by: Marco Elver <elver@google.com>
> > 
> > Applied, thank you!
> > 
> > 							Thanx, Paul
> 
> This patch is not in linux-next.  What happened to it?

It is in -rcu, but arrived too late to make my pull request for
v5.5.  It will hit -next shortly after v5.5-rc1.

							Thanx, Paul
