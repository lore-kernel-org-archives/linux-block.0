Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2E6C433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 14:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiKXOAo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Nov 2022 09:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiKXOAa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Nov 2022 09:00:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FD513C705
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 05:58:31 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o5-20020a17090a678500b00218cd5a21c9so1685734pjj.4
        for <linux-block@vger.kernel.org>; Thu, 24 Nov 2022 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VkflUhit7OoN55ql8xALxypH6TKph++jYyEKyALoOoY=;
        b=J20zac+mHU3mT4CWCx1AjwUMnLnD1d9/PwdlU+LMJFMTVyuzUuqI1bBakJWId7mdIs
         AF6cMXHqA0n8mio9knEYOBEii6DRbZZ77dfA/LVwzQL8jGISVtsdI3WtpVL4ONiUaNJL
         650k0DzrbPv9U1C/0xoSszESmPSQFPpxGKoVsMyL04SyWDhQ3eRQcxVy9xwgmn6IHxV8
         S9wbFf2IQmmnX3Uqy3CDTd+tVZYhBe2BvL4cBVIFm35jQYovkmQBvW2VEO7Wn9bFCw2J
         pm3fwpwWXX9yUirCLqiVe4EGkT25OaUTUStTPk62opbMwry97FdzeHK4fx12VaYj2pzi
         AzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VkflUhit7OoN55ql8xALxypH6TKph++jYyEKyALoOoY=;
        b=msnO+xjX1uQdInNMZwCKX2jF1p/jbJi2gwkAcgGuQ3HEZMbmwPorDn0BoaPVOEa0Yz
         gN4cYgQBiHNnIio0PWd8Atc10LlJLt4sviVIrXVH4TXtKFuSet0/1QyExXtkQjJhvI3Q
         056wThSRHwzFjSnv8azcWBR9U278v2+T+C15spOBhGChrGdeNyrL49juo+ZxV6kzIDLq
         SlmvpCS6dVohw9C0mfpqBL9csTJ7f4hKz31BG0Zp24Os/QjHipKJEiDMDcx09YXrO6FO
         H9JY7DDhM459dZ55/6XU9oPyED5yL/32yMyE/9soXtk7g6q5f3Fnru1W5sKAVNRdAtqF
         Bk5Q==
X-Gm-Message-State: ANoB5pm864uKsigBvi3bfObKG66CNoRS5dAeL/9ZGOPdRAZ8/fOSBCp1
        J+clJBTZp7UUYHtC+v8jro7Trw==
X-Google-Smtp-Source: AA0mqf5JzXsxuKD0AuSR9GA9eY/RYGcKsZtkyW87zP3M2xjuoNqdQ27yzsUCAjBsBhIKKy/ccgg9aQ==
X-Received: by 2002:a17:90a:ba97:b0:218:f5df:5cf1 with SMTP id t23-20020a17090aba9700b00218f5df5cf1mr5518212pjr.79.1669298310242;
        Thu, 24 Nov 2022 05:58:30 -0800 (PST)
Received: from [127.0.0.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id a28-20020aa795bc000000b00560cdb3784bsm1250769pfk.60.2022.11.24.05.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 05:58:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ye Bin <yebin@huaweicloud.com>
Cc:     ming.lei@redhat.com,
        syzbot+746a4eece09f86bc39d7@syzkaller.appspotmail.com,
        Ye Bin <yebin10@huawei.com>
In-Reply-To: <20221107033956.3276891-1-yebin@huaweicloud.com>
References: <20221107033956.3276891-1-yebin@huaweicloud.com>
Subject: Re: [PATCH] block: fix crash in 'blk_mq_elv_switch_none'
Message-Id: <166929830905.100836.12987821454081099289.b4-ty@kernel.dk>
Date:   Thu, 24 Nov 2022 06:58:29 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 7 Nov 2022 11:39:56 +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Syzbot found the following issue:
> general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
> CPU: 0 PID: 5234 Comm: syz-executor931 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
> RIP: 0010:__elevator_get block/elevator.h:94 [inline]
> RIP: 0010:blk_mq_elv_switch_none block/blk-mq.c:4593 [inline]
> RIP: 0010:__blk_mq_update_nr_hw_queues block/blk-mq.c:4658 [inline]
> RIP: 0010:blk_mq_update_nr_hw_queues+0x304/0xe40 block/blk-mq.c:4709
> RSP: 0018:ffffc90003cdfc08 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
> RDX: 000000000000001d RSI: 0000000000000002 RDI: 00000000000000e8
> RBP: ffff88801dbd0000 R08: ffff888027c89398 R09: ffffffff8de2e517
> R10: fffffbfff1bc5ca2 R11: 0000000000000000 R12: ffffc90003cdfc70
> R13: ffff88801dbd0008 R14: ffff88801dbd03f8 R15: ffff888027c89380
> FS:  0000555557259300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000005d84c8 CR3: 000000007a7cb000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  nbd_start_device+0x153/0xc30 drivers/block/nbd.c:1355
>  nbd_start_device_ioctl drivers/block/nbd.c:1405 [inline]
>  __nbd_ioctl drivers/block/nbd.c:1481 [inline]
>  nbd_ioctl+0x5a1/0xbd0 drivers/block/nbd.c:1521
>  blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl fs/ioctl.c:856 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Applied, thanks!

[1/1] block: fix crash in 'blk_mq_elv_switch_none'
      commit: 90b0296ece4bd8f70419f0addc1171be6feee195

Best regards,
-- 
Jens Axboe


