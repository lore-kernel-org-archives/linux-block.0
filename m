Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D29EC04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014BE2082F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 21:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ckjSxlZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014BE2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeLJVhZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:37:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33724 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbeLJVhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 16:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FeOy7Q3Nykk4X0Gk1cDeO9q6mpGHhBNyrWfhXubOUzk=; b=ckjSxlZAkHDhZ+En3PIKZugmHp
        YSsXNSHCMrSOou3xsT9Hi+cxxFAMvjCzfA+aiVlVQIScm5W0lGjngrYjz627dY1j3kvZqqclKP7aU
        bIfduyQjTHpWIl4X6/AZu9ubQqHH2WpXbVMyJSVSBQbEIcCevIR3yZ7Cbpbao3VZMtsLiJb5gUebK
        JZvFpfyNFH17mM41JhR6kKgFlQq1I66roLa+f9/byAEqx/hUesraJJvu3yX8pd6QEOXSKqJ6vqz2w
        i4jOiCHx4ihnggBF8+ZShbcLebdiod+bd0f2nVj8u6uQhUpVoGSWhc+fqof9kJF5ww0QQc16uJSMZ
        Rv+JA7og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWTEy-0008Ja-7M; Mon, 10 Dec 2018 21:37:24 +0000
Date:   Mon, 10 Dec 2018 13:37:24 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     axboe@kernel.dk, snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: xfstests generic/347 seems unhappy on todays block for-next tree
Message-ID: <20181210213724.GA27905@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This test is described as:

# Test very basic thin device usage, exhaustion, and growth


And seems to hang like this:

generic/347 74s ... [  701.658856] run fstests generic/347 at 2018-12-10 21:05:23
[  701.845672] XFS (nvme0n1): Mounting V5 Filesystem
[  702.048278] XFS (nvme0n1): Ending clean mount
[  702.184992] XFS (nvme1n1): Unmounting Filesystem
[  702.453064] device-mapper: thin: Data device (dm-1) discard unsupported: Disabling discard passdown.
[  847.533607] INFO: task dmsetup:28965 blocked for more than 120 seconds.
[  847.536715]       Not tainted 4.20.0-rc6+ #4
[  847.538857] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  847.542613] dmsetup         D    0 28965  28695 0x00000000
[  847.545405] Call Trace:
[  847.548500]  ? __schedule+0x2e6/0xb00
[  847.550331]  schedule+0x27/0x70
[  847.551977]  io_schedule+0x11/0x40
[  847.553991]  dm_wait_for_completion+0xbe/0xd0
[  847.556151]  ? wait_woken+0x80/0x80
[  847.558165]  __dm_suspend+0x90/0x1e0
[  847.559888]  dm_internal_suspend_noflush+0x90/0xe0
[  847.562380]  pool_presuspend+0x41/0x60
[  847.564626]  suspend_targets+0x45/0xa0
[  847.566783]  __dm_suspend+0xe0/0x1e0
[  847.568454]  ? table_clear+0xb0/0xb0
[  847.570289]  dm_suspend+0xd3/0x110
[  847.572218]  ? up_read+0x17/0x90
[  847.573960]  dev_suspend+0x148/0x250
[  847.575671]  ctl_ioctl+0x1a7/0x3a0
[  847.577413]  ? _raw_spin_lock_irqsave_nested+0x10/0x40
[  847.579895]  dm_ctl_ioctl+0x5/0x10
[  847.581580]  do_vfs_ioctl+0xa0/0x6a0
[  847.583299]  ksys_ioctl+0x5b/0x90
[  847.584739]  __x64_sys_ioctl+0x11/0x20
[  847.586701]  do_syscall_64+0x4b/0x180
[  847.588679]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  847.590450] RIP: 0033:0x7f3b400a2f07
[  847.591709] Code: Bad RIP value.
[  847.592688] RSP: 002b:00007ffc29d632f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  847.595091] RAX: ffffffffffffffda RBX: 000055fbf64e0b00 RCX: 00007f3b400a2f07
[  847.597344] RDX: 000055fbf64e0b00 RSI: 00000000c138fd06 RDI: 0000000000000003
[  847.599027] RBP: 000000000000000c R08: 00007f3b405bc648 R09: 00007ffc29d63160
[  847.600660] R10: 00007f3b405bbb53 R11: 0000000000000246 R12: 000055fbf64e0b30
[  847.602441] R13: 00007f3b405bbb53 R14: 000055fbf64e0940 R15: 0000000000000000
[  847.604404] 
[  847.604404] Showing all locks held in the system:
[  847.605655] 1 lock held by khungtaskd/620:
[  847.606542]  #0: 00000000253d4c96 (rcu_read_lock){....}, at: debug_show_all_locks+0x15/0x175
[  847.608204] 1 lock held by in:imklog/3712:
[  847.608979]  #0: 00000000af869ccd (&f->f_pos_lock){+.+.}, at: __fdget_pos+0x3f/0x50
[  847.610629] 2 locks held by dmsetup/28965:
[  847.611410]  #0: 00000000e234e2ee (&md->suspend_lock/1){+.+.}, at: dm_suspend+0x22/0x110
[  847.613066]  #1: 00000000756de3cd (&md->suspend_lock#2){+.+.}, at: dm_internal_suspend_noflush+0xc/0xe0
[  847.614989] 
[  847.615323] =============================================
[  847.615323] 
