Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485D2C433EF
	for <linux-block@archiver.kernel.org>; Sun, 29 May 2022 00:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiE2ARi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 28 May 2022 20:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiE2ARh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 May 2022 20:17:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5819540A34
        for <linux-block@vger.kernel.org>; Sat, 28 May 2022 17:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UDJlJSNbzJ+L31x4X4Jb/+dKOjWCFYf/Q0kV79iKh2E=; b=UkkiY2ixmesvOdN8dCAb6ShMm5
        +Jn31FABJQoRd5iYAoTIRUkbBOV7PMwbyssbKTxc6cpZTSncJh4T+h1NZrpE+ahno9kCyqGZo1+fI
        /6aNOlRsP7LWYzNcNLZ5wW/gHk3xibhUptrYPn9u1jDDB2p6QmkAYkv8UkHrR+QoZMKoZ4zMIFP+2
        BOxROsLFeFvOJ8e0jquYD+Dl/bvlxThoKPKh3ZOctqWVyqwOhjzNKWQqD9GzxS+kjA2g+YTwGYJRE
        CYvdToZ3WfgGLMkaF0up4EDLFNhH8sCLqU7435kVqLLqcXPxGnEMNwJtHhm6OUJ5G4+VNTR4GFPWO
        l6t8N4xg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nv6cd-003F2Y-Dg; Sun, 29 May 2022 00:17:31 +0000
Date:   Sun, 29 May 2022 01:17:31 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: bioset_exit poison from dm_destroy
Message-ID: <YpK7m+14A+pZKs5k@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not quite sure whose bug this is.  Current Linus head running xfstests
against ext4 (probably not ext4's fault?)

01818 generic/250	run fstests generic/250 at 2022-05-28 23:48:09
01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
01818 EXT4-fs (dm-0): unmounting filesystem.
01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
01818 EXT4-fs (dm-0): unmounting filesystem.
01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
01818 Buffer I/O error on dev dm-0, logical block 3670000, async page read
01818 EXT4-fs (dm-0): unmounting filesystem.
01818 EXT4-fs (dm-0): mounted filesystem with ordered data mode. Quota mode: none.
01818 EXT4-fs (dm-0): unmounting filesystem.
01818 general protection fault, probably for non-canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
01818 CPU: 0 PID: 1579117 Comm: dmsetup Kdump: loaded Not tainted 5.18.0-11049-g1dec3d7fd0c3-dirty #262
01818 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
01818 RIP: 0010:__cpuhp_state_remove_instance+0xf0/0x1b0
01818 Code: a0 f8 d7 81 42 3b 1c 28 7f d9 4c 89 e1 31 d2 89 de 89 7d dc e8 01 fd ff ff 8b 7d dc eb c5 49 8b 04 24 49 8b 54 24 08 48 85 c0 <48> 89 02 74 04 48 89 50 08 48 b8 00 01 00 00 00 00 ad de 48 c7 c7
01818 RSP: 0018:ffff888101fcfc60 EFLAGS: 00010286
01818 RAX: dead000000000100 RBX: 0000000000000017 RCX: 0000000000000000
01818 RDX: dead000000000122 RSI: ffff8881233b0ae8 RDI: ffffffff81e3b080
01818 RBP: ffff888101fcfc88 R08: 0000000000000008 R09: 0000000000000003
01818 R10: 0000000000000000 R11: 00000000002dc6c0 R12: ffff8881233b0ae8
01818 R13: 0000000000000000 R14: ffffffff81e38f58 R15: ffff88817b5a3c00
01818 FS:  00007ff56daec280(0000) GS:ffff888275800000(0000) knlGS:0000000000000000
01818 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
01818 CR2: 00005591ad94f198 CR3: 000000017b5a0004 CR4: 0000000000770eb0
01818 PKRU: 55555554
01818 Call Trace:
01818  <TASK>
01818  ? kfree+0x66/0x250
01818  bioset_exit+0x32/0x210
01818  cleanup_mapped_device+0x34/0xf0
01818  __dm_destroy+0x149/0x1f0
01818  ? table_clear+0xc0/0xc0
01818  dm_destroy+0xe/0x10
01818  dev_remove+0xd9/0x120
01818  ctl_ioctl+0x1cb/0x420
01818  dm_ctl_ioctl+0x9/0x10
01818  __x64_sys_ioctl+0x89/0xb0
01818  do_syscall_64+0x35/0x80
01818  entry_SYSCALL_64_after_hwframe+0x46/0xb0
01818 RIP: 0033:0x7ff56de3b397
01818 Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a9 da 0d 00 f7 d8 64 89 01 48
01818 RSP: 002b:00007ffe55367ef8 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
01818 RAX: ffffffffffffffda RBX: 00007ff56df31a8e RCX: 00007ff56de3b397
01818 RDX: 000055daad7cab30 RSI: 00000000c138fd04 RDI: 0000000000000003
01818 RBP: 00007ffe55367fb0 R08: 00007ff56df81558 R09: 00007ffe55367d60
01818 R10: 00007ff56df808a2 R11: 0000000000000206 R12: 00007ff56df808a2
01818 R13: 00007ff56df808a2 R14: 00007ff56df808a2 R15: 00007ff56df808a2
01818  </TASK>
01818 Modules linked in: crct10dif_generic crct10dif_common [last unloaded: crc_t10dif]

