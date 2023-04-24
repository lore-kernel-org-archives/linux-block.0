Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1C8C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 07:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjDXHpx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 03:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjDXHpw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 03:45:52 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F5710D2
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 00:45:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ecb7fe8fb8so10717e87.0
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 00:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682322348; x=1684914348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjq5xKw6Rxw+nEpXoCZb9BKs6Kap41mbExYtxbfsCww=;
        b=H7puv617l8mNzi36jAWWj0m3JSEvg1nBZGltP4pVL21l38fLE/IGA1icU+YHadxqyy
         gkwJN9dy8QArpsQGTmAiWJdSMt241EmMFbUyG8BamP6RFc8VyOdmLapYcjKZAlvYDi2r
         Qi4KkVYSWPaK988JjMwIZLLYGknm+Xmdn89eQckVVCmriWaJsND8zY7ZJsm5IqRYLXfB
         zd2np9zH8lhCqy2gj2/l5kG3gaJ+dCHCqG7o9mIdftmdZDPcnqjINGiun93HdkfwBXgY
         ipbWqy1Nf6r0QEF0oYAqWrsPNVgkq/PV0zRjsTr9RXjDqKGYI+XQwyze+Cz2nyCq7ZGU
         gujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682322348; x=1684914348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjq5xKw6Rxw+nEpXoCZb9BKs6Kap41mbExYtxbfsCww=;
        b=Vt2Tdaq5Y+IlJo17PxEpT6x6vRlmZkj6f6IgEkQbpmXR6efFF0/0sWlKlf1aNL8HCV
         JLpJnqZUv0xTmFw3MBikWWWB5AhU8U1muWLCH6rxnT6Y5yHGqdBEl9mtRndbbMGyoINx
         4kdEBLb6wlA9dAL6GXE+6swqfeYeOcAIAEKVy9qry3hyftZobZaoQzCS1nSwxmTeInXE
         JZ/ekkzO9AX3qFFbC+e2uu+w6KSgWr/a55XflDziey1w3g8GPjgSnNIwRZ6GurnODGdq
         kFhpxe2OMyzB8jXPDFYhf8/ZYos7gpEGPcIoRPsqyBgHwexsSW0Onc2vKH0tm8RQDIxx
         bN8g==
X-Gm-Message-State: AAQBX9fDgSwghYQ1cZFqeBa7D1yCbYbwD2OAQWjw5xCM0E/Nk4Sfjx0X
        Qqc7TAo4KRtsUARZ28eEkEguOd4CpGLwQI5QZ/dMIANDR5CAfcx85qhNqw==
X-Google-Smtp-Source: AKy350ZhOqaChnH/38Xoy1wXYciVr9bJWcNWcy3rSdGQbi6mDWmXvBBbKQwYEX8fQtq68+dkY1xJytI+Dpqczs13DEI=
X-Received: by 2002:a05:6512:e94:b0:4e8:3fc8:4f80 with SMTP id
 bi20-20020a0565120e9400b004e83fc84f80mr194384lfb.4.1682322347862; Mon, 24 Apr
 2023 00:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff17f705fa0fdbd7@google.com>
In-Reply-To: <000000000000ff17f705fa0fdbd7@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 24 Apr 2023 09:45:35 +0200
Message-ID: <CACT4Y+ZgJGNGEW==RPdUQRMHGP1GUT7f_Y6CKjvqjizX7Ty6YA@mail.gmail.com>
Subject: Re: [syzbot] [block?] KCSAN: data-race in __mod_timer / blk_add_timer (6)
To:     syzbot <syzbot+da80e6a47db00f8be22c@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 24 Apr 2023 at 09:21, syzbot
<syzbot+da80e6a47db00f8be22c@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    148341f0a2f5 Merge tag 'vfs.misc.fixes.v6.3-rc6' of git://..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a5970dc80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=54d63ee086ae78d0
> dashboard link: https://syzkaller.appspot.com/bug?extid=da80e6a47db00f8be22c
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1c557f92a6e1/disk-148341f0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f2c85210e1ce/vmlinux-148341f0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b019d0447709/bzImage-148341f0.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+da80e6a47db00f8be22c@syzkaller.appspotmail.com

I did not fully grasp what happens here, but it looks fishy.
The comment on top of blk_add_timer() says "Notes: Each request has
its own timer". It looks like it's not true (?). A simple timer can't
ensure proper timeout for 2+ commands, right?


> ==================================================================
> BUG: KCSAN: data-race in __mod_timer / blk_add_timer
>
> write to 0xffff88810285dd20 of 8 bytes by task 26833 on cpu 0:
>  __mod_timer+0x625/0x890 kernel/time/timer.c:1121
>  mod_timer+0x1f/0x30 kernel/time/timer.c:1190
>  blk_add_timer+0x184/0x190 block/blk-timeout.c:164
>  blk_mq_start_request+0x100/0x2b0 block/blk-mq.c:1264
>  scsi_queue_rq+0x143b/0x1990 drivers/scsi/scsi_lib.c:1756
>  blk_mq_dispatch_rq_list+0x7b1/0x11f0 block/blk-mq.c:2059
>  __blk_mq_do_dispatch_sched block/blk-mq-sched.c:172 [inline]
>  blk_mq_do_dispatch_sched+0x4de/0x820 block/blk-mq-sched.c:186
>  __blk_mq_sched_dispatch_requests+0x1c1/0x260
>  blk_mq_sched_dispatch_requests+0x93/0x100 block/blk-mq-sched.c:338
>  __blk_mq_run_hw_queue+0x8e/0x110 block/blk-mq.c:2177
>  __blk_mq_delay_run_hw_queue+0xb3/0x3a0 block/blk-mq.c:2253
>  blk_mq_run_hw_queue+0x19f/0x330 block/blk-mq.c:2301
>  blk_mq_sched_insert_requests+0x1da/0x2c0 block/blk-mq-sched.c:492
>  blk_mq_dispatch_plug_list block/blk-mq.c:2748 [inline]
>  blk_mq_flush_plug_list+0x519/0x660 block/blk-mq.c:2790
>  __blk_flush_plug+0x223/0x280 block/blk-core.c:1153
>  blk_finish_plug+0x47/0x60 block/blk-core.c:1177
>  ext4_do_writepages+0x1c08/0x2140 fs/ext4/inode.c:2927
>  ext4_writepages+0x127/0x250 fs/ext4/inode.c:2964
>  do_writepages+0x1c5/0x340 mm/page-writeback.c:2551
>  filemap_fdatawrite_wbc+0xdb/0xf0 mm/filemap.c:390
>  __filemap_fdatawrite_range mm/filemap.c:423 [inline]
>  file_write_and_wait_range+0xfa/0x190 mm/filemap.c:781
>  ext4_sync_file+0x10d/0x720 fs/ext4/fsync.c:151
>  vfs_fsync_range+0x10b/0x120 fs/sync.c:188
>  generic_write_sync include/linux/fs.h:2452 [inline]
>  ext4_buffered_write_iter+0x397/0x3e0 fs/ext4/file.c:296
>  ext4_file_write_iter+0xd7/0x10e0
>  do_iter_write+0x418/0x700 fs/read_write.c:861
>  vfs_iter_write+0x50/0x70 fs/read_write.c:902
>  iter_file_splice_write+0x456/0x7d0 fs/splice.c:778
>  do_splice_from fs/splice.c:856 [inline]
>  direct_splice_actor+0x84/0xa0 fs/splice.c:1022
>  splice_direct_to_actor+0x2ee/0x5f0 fs/splice.c:977
>  do_splice_direct+0x104/0x180 fs/splice.c:1065
>  do_sendfile+0x3b8/0x950 fs/read_write.c:1255
>  __do_sys_sendfile64 fs/read_write.c:1317 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1309 [inline]
>  __x64_sys_sendfile64+0xbd/0x150 fs/read_write.c:1309
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> read to 0xffff88810285dd20 of 8 bytes by task 2708 on cpu 1:
>  blk_add_timer+0x118/0x190
>  blk_mq_start_request+0x100/0x2b0 block/blk-mq.c:1264
>  scsi_queue_rq+0x143b/0x1990 drivers/scsi/scsi_lib.c:1756
>  blk_mq_dispatch_rq_list+0x7b1/0x11f0 block/blk-mq.c:2059
>  __blk_mq_do_dispatch_sched block/blk-mq-sched.c:172 [inline]
>  blk_mq_do_dispatch_sched+0x4de/0x820 block/blk-mq-sched.c:186
>  __blk_mq_sched_dispatch_requests+0x1c1/0x260
>  blk_mq_sched_dispatch_requests+0x93/0x100 block/blk-mq-sched.c:338
>  __blk_mq_run_hw_queue+0x8e/0x110 block/blk-mq.c:2177
>  __blk_mq_delay_run_hw_queue+0xb3/0x3a0 block/blk-mq.c:2253
>  blk_mq_run_hw_queue+0x19f/0x330 block/blk-mq.c:2301
>  blk_mq_sched_insert_requests+0x1da/0x2c0 block/blk-mq-sched.c:492
>  blk_mq_dispatch_plug_list block/blk-mq.c:2748 [inline]
>  blk_mq_flush_plug_list+0x519/0x660 block/blk-mq.c:2790
>  __blk_flush_plug+0x223/0x280 block/blk-core.c:1153
>  blk_finish_plug+0x47/0x60 block/blk-core.c:1177
>  jbd2_journal_commit_transaction+0x1c09/0x33f0 fs/jbd2/commit.c:797
>  kjournald2+0x242/0x420 fs/jbd2/journal.c:209
>  kthread+0x1ac/0x1e0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>
> value changed: 0x0000000100014674 -> 0x00000001000148f4
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 2708 Comm: jbd2/sda1-8 Not tainted 6.3.0-rc5-syzkaller-00005-g148341f0a2f5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000ff17f705fa0fdbd7%40google.com.
