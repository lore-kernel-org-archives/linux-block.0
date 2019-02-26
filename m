Return-Path: <SRS0=PBJN=RB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLACK
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1330DC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 23:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA194218D0
	for <linux-block@archiver.kernel.org>; Tue, 26 Feb 2019 23:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwpVnXzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfBZXfa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:35:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40085 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfBZXfa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Feb 2019 18:35:30 -0500
Received: by mail-lf1-f68.google.com with SMTP id a8so5234573lfi.7;
        Tue, 26 Feb 2019 15:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ZVkT2QLH5Ka9sBd9dlh3DGpeEKAnCsRCh/eX/qLvBzM=;
        b=MwpVnXzh4sFTTycVMvYh9sbCWGMVSTgO8gXIORMXeH+Z9DT6PkQDm/NBi9/AmBNCCi
         Aa24wFCL5FrDqF/pPas9VtK98nSvEoPlP3VL2rzZ0Na1F6iXfhvSqrtCHUimNOnwa9hD
         n85pzP2iJaZ2I0lqs70sJmDM0rcpKNabNzIN0zYa0hM8Ph6PjnVLPDEp621UXvJNUy+f
         pha2pzigGvxqxe1xLuwqkEOuUZMfWnK2w4s4oUvs73tnlazFTbrBQ+Pl/knfg8Y9pkoj
         7TPe8PzK2FZCzSFf4pEFutrtdF7RqEHHsIoxyh/h8N3o5R27+9mCpdxur9ZbxhGsWQlA
         AGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ZVkT2QLH5Ka9sBd9dlh3DGpeEKAnCsRCh/eX/qLvBzM=;
        b=Kjce3sy6xcV4i2/pFKYXrh73STRjx/y8mWvepz2eAlOTRRcH3IxDovW55VTAjEuwLa
         aRBTzSUkLOZlsdGNGYzAJnagCs2qrVfv2bWqhIT0Wuq+0PLbJxFyfUgB47sW9cUmZgMt
         I4QwIl9bCQggDbdaeC+N1BefiZfDBtFG15LRUsqY/RAgl9CVs6xE0XUPymzKEX2TTt9l
         H8XtX5tlzT23SH41o82q7y2htnJiygNaNtjTmT/Nfo9qkSsyqdJaBiCYSEwVhGffCgRw
         juJ3W1xvAyEBehnn1Q/4PLZcRLuLVyfEA0IzsThgSZfxMlUl+MiBrbsFP56XJnMyAe6s
         ZAag==
X-Gm-Message-State: AHQUAubyDOG68Svs3roFve+S7nHrXzJCc7w5NmU9HVmV5R7pfPKY9wp9
        yT8w3e5Qh+5i8/wklME+Gw1WQ6TNmnU=
X-Google-Smtp-Source: AHgI3Iba87Yvde6kTG+wOMytug3ReOQ5ubvF/CRuLXZnLkUywlIWAZZSiaqfHubxzf9UijFgGW1G2A==
X-Received: by 2002:a19:4848:: with SMTP id v69mr6485142lfa.35.1551224127821;
        Tue, 26 Feb 2019 15:35:27 -0800 (PST)
Received: from [84.217.160.14] (c-0ea0d954.501502050104-0-757473696b74.bbcust.telenor.se. [84.217.160.14])
        by smtp.gmail.com with ESMTPSA id t14sm567683lfk.83.2019.02.26.15.35.26
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 15:35:27 -0800 (PST)
From:   Thomas Lindroth <thomas.lindroth@gmail.com>
Subject: Regression caused by loopback related patches in 4.14.95
To:     jack@suse.cz
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org
Message-ID: <44a918ac-55fe-b7d3-5a4d-97acf3e38d95@gmail.com>
Date:   Wed, 27 Feb 2019 00:35:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When I run "losetup --verbose --partscan --read-only --find /mnt/gemini.61rn.3T/Backups/debian.raw"
on a 4.14.103 system losetup hangs for exactly 3 minutes. After the hang the loopback device works
like it should. The /mnt/gemini.61rn.3T mount is an ext4 fs on dm-crypt on a spinning sata disk.

The hang was introduced in 4.14.95 and there are several loop related patches in 4.14.95.
I bisected it down to commit c1e63df4f30c3918476ac9bc594355b0e9629893
"loop: Get rid of loop_index_mutex". Reverting that commit from 4.14.103 also fixes the problem.

This could be a problem in just the 4.14 stable series. I haven't tested any other series.

Here is the output of dmesg when losetup hangs:
[Feb26 21:59] systemd-udevd[996]: seq 2791 '/devices/virtual/block/loop0' is taking a long time
[Feb26 22:01] INFO: task losetup:7694 blocked for more than 120 seconds.
[  +0.000009]       Not tainted 4.14.103 #25
[  +0.000002] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  +0.000001] losetup         D
[  +0.000002]     0  7694   7687 0x00080000
[  +0.000002] Call Trace:
[  +0.000005]  ? __schedule+0x273/0x870
[  +0.000003]  schedule+0x2f/0x90
[  +0.000002]  schedule_preempt_disabled+0x11/0x20
[  +0.000002]  __mutex_lock.isra.2+0x32c/0x540
[  +0.000003]  ? __wake_up_common_lock+0x8a/0xc0
[  +0.000004]  blkdev_reread_part+0x16/0x30
[  +0.000100]  loop_reread_partitions+0x27/0x30
[  +0.000004]  loop_set_status+0x335/0x410
[  +0.000003]  loop_set_status64+0x4b/0x80
[  +0.000003]  lo_ioctl+0x1e7/0x7d0
[  +0.000003]  blkdev_ioctl+0x446/0x9d0
[  +0.000004]  block_ioctl+0x39/0x40
[  +0.000004]  do_vfs_ioctl+0xa4/0x650
[  +0.000002]  SyS_ioctl+0x74/0x80
[  +0.000004]  do_syscall_64+0x6e/0x170
[  +0.000003]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  +0.000003] RIP: 0033:0x7f455c7912a7
[  +0.000002] RSP: 002b:00007ffe5a9d6908 EFLAGS: 00000246
[  +0.000001]  ORIG_RAX: 0000000000000010
[  +0.000003] RAX: ffffffffffffffda RBX: 00007ffe5a9d6ab0 RCX: 00007f455c7912a7
[  +0.000002] RDX: 00007ffe5a9d6b50 RSI: 0000000000004c04 RDI: 0000000000000004
[  +0.000002] RBP: 0000000000000004 R08: 0000000000000008 R09: 696265642f737075
[  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f455ce816b8
[  +0.000002] R13: 0000000000000003 R14: 00007ffe5a9d6b50 R15: 00007ffe5a9d6930
[  +6.555728] systemd-udevd[996]: seq 2791 '/devices/virtual/block/loop0' killed
[  +0.000247] systemd-udevd[996]: worker [7697] terminated by signal 9 (KILL)
[  +0.000005] systemd-udevd[996]: worker [7697] failed while handling '/devices/virtual/block/loop0'
[  +0.052335]  loop0: p1 p2 < p5 >

 From that backtrace it looks like the problem is related to --partscan. Among the
loop related patches in 4.14.95 commit 57da9a9742200f391d1cf93fea389f7ddc25ec9a says:

   Note that syzbot is also reporting circular locking dependency between
   bdev->bd_mutex and lo->lo_ctl_mutex [2] which is caused by calling
   blkdev_reread_part() with lock held. This patch does not address it.

   [2] https://syzkaller.appspot.com/bug?id=bf154052f0eea4bc7712499e4569505907d15889

To me it looks like that is what is causing the hang. The syzkaller report says that the fix is
"loop: Fix deadlock when calling blkdev_reread_part()" but I don't see that commit in the
4.14 series.

This is an x86_64 Gentoo system. Here is the .config I use http://sprunge.us/u7YNBt
