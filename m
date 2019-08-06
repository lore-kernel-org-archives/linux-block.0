Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57FCC31E40
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 15:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A931216B7
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 15:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565106349;
	bh=xrqCbvPkHoboTlfcr5S/pDG99lCcGa471UGms9F/+Q0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PkLBWzIPQcHbSExvU0YFIgaUO6B1JzyNLCbXpUoLXzyz6WQvSFHwR2S+FhV89Gvnr
	 1D2r6jRwEkpPa5SoAreVtPeLvT9l19tv9qK/d9+tyrM5EuGSd6q3/OwLHP1Ia44Bix
	 dDsA7GgLQsJDT1WUO+VfiYWlRvFuyKakruDnLe/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfHFPpt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:45:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:54421 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfHFPps (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Aug 2019 11:45:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 08:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="179187981"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2019 08:45:46 -0700
Date:   Tue, 6 Aug 2019 09:43:17 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     syzbot <syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: WARNING: refcount bug in blk_mq_free_request (2)
Message-ID: <20190806154313.GC24030@localhost.localdomain>
References: <000000000000d0df7f058f625d13@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d0df7f058f625d13@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 05, 2019 at 10:52:07AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    e21a712a Linux 5.3-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10cf349a600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4c9e9f08e9e8960
> dashboard link: https://syzkaller.appspot.com/bug?extid=f4316dab9d4518b755eb
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117a1906600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aa11aa600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+f4316dab9d4518b755eb@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> refcount_t: underflow; use-after-free.
> WARNING: CPU: 1 PID: 16 at lib/refcount.c:190 refcount_sub_and_test_checked  
> lib/refcount.c:190 [inline]
> WARNING: CPU: 1 PID: 16 at lib/refcount.c:190  
> refcount_sub_and_test_checked+0x1d0/0x200 lib/refcount.c:180
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 16 Comm: ksoftirqd/1 Not tainted 5.3.0-rc3 #98
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   panic+0x2dc/0x755 kernel/panic.c:219
>   __warn.cold+0x20/0x4c kernel/panic.c:576
>   report_bug+0x263/0x2b0 lib/bug.c:186
>   fixup_bug arch/x86/kernel/traps.c:179 [inline]
>   fixup_bug arch/x86/kernel/traps.c:174 [inline]
>   do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
>   do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
>   invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1026
> RIP: 0010:refcount_sub_and_test_checked lib/refcount.c:190 [inline]
> RIP: 0010:refcount_sub_and_test_checked+0x1d0/0x200 lib/refcount.c:180
> Code: 1d 7e b3 64 06 31 ff 89 de e8 9c a3 35 fe 84 db 75 94 e8 53 a2 35 fe  
> 48 c7 c7 80 02 c6 87 c6 05 5e b3 64 06 01 e8 18 15 07 fe <0f> 0b e9 75 ff  
> ff ff e8 34 a2 35 fe e9 6e ff ff ff 48 89 df e8 b7
> RSP: 0018:ffff8880a990fbb0 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000000100 RSI: ffffffff815c3ba6 RDI: ffffed1015321f68
> RBP: ffff8880a990fc48 R08: ffff8880a9900440 R09: ffffed1015d24101
> R10: ffffed1015d24100 R11: ffff8880ae920807 R12: 00000000ffffffff
> R13: 0000000000000001 R14: ffff8880a990fc20 R15: 0000000000000000
>   refcount_dec_and_test_checked+0x1b/0x20 lib/refcount.c:220
>   blk_mq_free_request+0x3b8/0x580 block/blk-mq.c:524
>   __blk_mq_end_request block/blk-mq.c:550 [inline]
>   blk_mq_end_request+0x456/0x560 block/blk-mq.c:559
>   nbd_complete_rq+0x42/0x50 drivers/block/nbd.c:322
>   blk_done_softirq+0x2fe/0x4d0 block/blk-softirq.c:37
>   __do_softirq+0x262/0x98c kernel/softirq.c:292
>   run_ksoftirqd kernel/softirq.c:603 [inline]
>   run_ksoftirqd+0x8e/0x110 kernel/softirq.c:595
>   smpboot_thread_fn+0x6a3/0xa40 kernel/smpboot.c:165
>   kthread+0x361/0x430 kernel/kthread.c:255
>   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

It looks like ndb's timeout handler may complete the same request twice:
first via ndb_config_put()->ndb_clear_sock(), then again explicitly
through a direct call to blk_mq_complete_request().
