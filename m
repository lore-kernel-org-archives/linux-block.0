Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F27C00144
	for <linux-block@archiver.kernel.org>; Mon,  1 Aug 2022 06:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiHAGLh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Aug 2022 02:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiHAGLg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Aug 2022 02:11:36 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB8313EA1
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 23:11:35 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id g24so7355561qtu.2
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 23:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=6QzMfYmyElgrsoPB4qWxUR7PG1j0GVwLYBTv9a/1akc=;
        b=GfeBoExhYGBDzLwOoEDzR7PExJAzDTdGfqqsR9NdF9os+dh3CKpymp4utHMCJ9TbYx
         6PXj//EpfUArOR5wlNg+fAypIVs5FUZLNr6NO3Q9slpRWf0F9I1lavmnpS4L+Z56PNFt
         YOkfDhudkYtv9x9lMjyBGLxnKmdHgeujWy0x4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=6QzMfYmyElgrsoPB4qWxUR7PG1j0GVwLYBTv9a/1akc=;
        b=YNhAOfDwt9li9UVsgp8AqKv6Q2WFlHofwCbJP8btseAqL4LBfMXZGD38BE1DS3K2KV
         na1zbHWTpHPeDsWLwO62AQOjzn/nIQ6BuJa8GtG/ifAyO8wYtpYI5kcHD/o00MJndIJz
         BKP8etnC7BPZaWS03jqXtWF+1ttMyLGa/ttSITVd9wCrVKh/d40yaK+20m9PlFPkztuv
         ykp8BiIN73bLWSIGFCcT8mgdk3Kr3AgRr1n6DxqQMoalx4IKEMTyDluv9vVYGWEA4bb5
         now+8QzeAc0Kgc45F+L8Jzo7gPcJhgLsCrYIBfFd0NrCoiyNzNxnpstAFGbsHBT4avGl
         PuWg==
X-Gm-Message-State: ACgBeo369tsWBFkrCM/7elCC5NxF6zEC9s8spGm+1r4Ogl+tgG4lkri9
        XgfyEzRRYty58038iVLceG0uFwkseXKvuw==
X-Google-Smtp-Source: AA6agR5DXK4XdTcJc7msGQZe2uTKzA2W7pecAVXuDlRBT8I0E+FFOLkyiIYkuEz6M0GfydkUdiyNTw==
X-Received: by 2002:ac8:7f47:0:b0:32e:c266:1405 with SMTP id g7-20020ac87f47000000b0032ec2661405mr3489758qtk.119.1659334294545;
        Sun, 31 Jul 2022 23:11:34 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h13-20020a05620a284d00b006af59e9ddeasm7829142qkp.18.2022.07.31.23.11.34
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jul 2022 23:11:34 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id y127so17389798yby.8
        for <linux-block@vger.kernel.org>; Sun, 31 Jul 2022 23:11:34 -0700 (PDT)
X-Received: by 2002:a25:cd06:0:b0:676:e2e7:40a with SMTP id
 d6-20020a25cd06000000b00676e2e7040amr4753483ybf.367.1659334293747; Sun, 31
 Jul 2022 23:11:33 -0700 (PDT)
MIME-Version: 1.0
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 1 Aug 2022 15:11:22 +0900
X-Gmail-Original-Message-ID: <CAPBb6MUP5sH2Ohgrm4UE9ygOF2nKK4dEYWsrwfDUbSMH5Lb=ew@mail.gmail.com>
Message-ID: <CAPBb6MUP5sH2Ohgrm4UE9ygOF2nKK4dEYWsrwfDUbSMH5Lb=ew@mail.gmail.com>
Subject: WARN_ON_ONCE reached with "virtio-blk: support mq_ops->queue_rqs()"
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I am getting this warning when booting a 5.19 Linux guest on crosvm
(5.18 did not have this issue):

[    1.890468] ------------[ cut here ]------------
[    1.890776] WARNING: CPU: 2 PID: 122 at block/blk-mq.c:1143
blk_mq_start_request+0x8a/0xe0
[    1.891045] Modules linked in:
[    1.891250] CPU: 2 PID: 122 Comm: journal-offline Not tainted 5.19.0+ #44
[    1.891504] Hardware name: ChromiumOS crosvm, BIOS 0
[    1.891739] RIP: 0010:blk_mq_start_request+0x8a/0xe0
[    1.891961] Code: 12 80 74 22 48 8b 4b 10 8b 89 64 01 00 00 8b 53
20 83 fa ff 75 08 ba 00 00 00 80 0b 53 24 c1 e1 10 09 d1 89 48 34 5b
41 5e c3 <0f> 0b eb b8 65 8b 05 2b 39 b6 7e 89 c0 48 0f a3 05 39 77 5b
01 0f
[    1.892443] RSP: 0018:ffffc900002777b0 EFLAGS: 00010202
[    1.892673] RAX: 0000000000000000 RBX: ffff888004bc0000 RCX: 0000000000000000
[    1.892952] RDX: 0000000000000000 RSI: ffff888003d7c200 RDI: ffff888004bc0000
[    1.893228] RBP: 0000000000000000 R08: 0000000000000001 R09: ffff888004bc0100
[    1.893506] R10: ffffffffffffffff R11: ffffffff8185ca10 R12: ffff888004bc0000
[    1.893797] R13: ffffc90000277900 R14: ffff888004ab2340 R15: ffff888003d86e00
[    1.894060] FS:  00007ffa143a4640(0000) GS:ffff88807dd00000(0000)
knlGS:0000000000000000
[    1.894412] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.894682] CR2: 00005648577d9088 CR3: 00000000053da004 CR4: 0000000000170ee0
[    1.894953] Call Trace:
[    1.895139]  <TASK>
[    1.895303]  virtblk_prep_rq+0x1e5/0x280
[    1.895509]  virtio_queue_rq+0x5c/0x310
[    1.895710]  ? virtqueue_add_sgs+0x95/0xb0
[    1.895905]  ? _raw_spin_unlock_irqrestore+0x16/0x30
[    1.896133]  ? virtio_queue_rqs+0x340/0x390
[    1.896453]  ? sbitmap_get+0xfa/0x220
[    1.896678]  __blk_mq_issue_directly+0x41/0x180
[    1.896906]  blk_mq_plug_issue_direct+0xd8/0x2c0
[    1.897115]  blk_mq_flush_plug_list+0x115/0x180
[    1.897342]  blk_add_rq_to_plug+0x51/0x130
[    1.897543]  blk_mq_submit_bio+0x3a1/0x570
[    1.897750]  submit_bio_noacct_nocheck+0x418/0x520
[    1.897985]  ? submit_bio_noacct+0x1e/0x260
[    1.897989]  ext4_bio_write_page+0x222/0x420
[    1.898000]  mpage_process_page_bufs+0x178/0x1c0
[    1.899451]  mpage_prepare_extent_to_map+0x2d2/0x440
[    1.899603]  ext4_writepages+0x495/0x1020
[    1.899733]  do_writepages+0xcb/0x220
[    1.899871]  ? __seccomp_filter+0x171/0x7e0
[    1.900006]  file_write_and_wait_range+0xcd/0xf0
[    1.900167]  ext4_sync_file+0x72/0x320
[    1.900308]  __x64_sys_fsync+0x66/0xa0
[    1.900449]  do_syscall_64+0x31/0x50
[    1.900595]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[    1.900747] RIP: 0033:0x7ffa16ec96ea
[    1.900883] Code: b8 4a 00 00 00 0f 05 48 3d 00 f0 ff ff 77 41 c3
48 83 ec 18 89 7c 24 0c e8 e3 02 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00
00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 43 03 f8 ff 8b
44 24
[    1.901302] RSP: 002b:00007ffa143a3ac0 EFLAGS: 00000293 ORIG_RAX:
000000000000004a
[    1.901499] RAX: ffffffffffffffda RBX: 0000560277ec6fe0 RCX: 00007ffa16ec96ea
[    1.901696] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000016
[    1.901884] RBP: 0000560277ec5910 R08: 0000000000000000 R09: 00007ffa143a4640
[    1.902082] R10: 00007ffa16e4d39e R11: 0000000000000293 R12: 00005602773f59e0
[    1.902459] R13: 0000000000000000 R14: 00007fffbfc007ff R15: 00007ffa13ba4000
[    1.902763]  </TASK>
[    1.902877] ---[ end trace 0000000000000000 ]---

Apparently the state of the queue is not as expected, for some reason:

    WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);

Reverting 0e9911fa768f removes the warning, as does commenting out the
queue_rqs op of the virtio-blk device.

I am not particularly versed in the block device layer so thought I
would report this first. Please let me know if I can provide more
information.

Cheers,
Alex.
