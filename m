Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F365C433E9
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69849238A1
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbhAHOhY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbhAHOhT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 09:37:19 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA1EC0612EA
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 06:36:38 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h16so11382302edt.7
        for <linux-block@vger.kernel.org>; Fri, 08 Jan 2021 06:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u25adq35DuqO+Mk8+/7OS6CK54gsT8vmqBWNkLqnsMk=;
        b=EXCTRJZ2MLDyMo2NSQ7ft9JCYTUJO0OTkQjNFCPTF6q80JZS+IZv13LGAOWQPKRlGw
         X5hSK+JiLzo1yn1JVBBgEWDtpzBhS6nvAw2swvxUnX9tLXZOoYmmYkLgEIzf6ZCV59Ap
         BVHh+pW6rGbPL4BJ32Ym2U5VSBKTPLYmLzpm0cV7W5MB6F2q9oRjk3LWT/yV1P3rOMwa
         sivUOAD2pNTnn14mYZSJfK53bNLDI8d0Vj/saSDiTExQhLLm4PZ46vzwrQvIaHxPT71M
         5Spj13pUACMu46JnttsIYXN6R12KlRiVBcbk89Q0Gf7yA/mkIm7AdhQKjYg7iiSjKulz
         jxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u25adq35DuqO+Mk8+/7OS6CK54gsT8vmqBWNkLqnsMk=;
        b=WMe/p76t1+1i3yXJTfgWwWLgZbjcM0ra11S4v8FagAU04/PTJYoOU4p78uUBd/II8M
         pY9qTN2RrCSgNM2uo6x1daF/gVx+nrFB6iYLogiixjWP+DvFOBBffdZo8q8tVwJdFZc1
         UmUFQVcaBRKKHndTS7AOe7FcUyKlyIjB4/T/RlJ/in5J/qKtFPUVPvMvdWlm5vgedI6a
         n1PpAJuxW9kBgkRiHm02vQvmquLsYq94SQ6ANmoDIqJC8yjoUnH/G5DkESU3b3LEnqvu
         T71ToqUIBHuTDlctTZ3NiNZqZkaQdFK99Sl3wOEsyQPfA/tGYphMcbN9t2R/A7KhSQYB
         pYXg==
X-Gm-Message-State: AOAM532o7NiVIaQsFnDhM2eZeK9mIc3rjuOt748CjDdbmkdaW798vVGY
        kw2CZgpycYxyBtcCw0zEdcAiLHcOrD8bNg==
X-Google-Smtp-Source: ABdhPJwg783FMSI3NPXY9btnzSd6k+BHnUgUuhw3mrQ40KowzRlM/JoUzTFr2jWNPuJFRkEY8Mgckg==
X-Received: by 2002:a50:8741:: with SMTP id 1mr5544045edv.349.1610116597300;
        Fri, 08 Jan 2021 06:36:37 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4906:c200:31ac:50df:cd1f:f7fc])
        by smtp.gmail.com with ESMTPSA id e25sm3858698edq.24.2021.01.08.06.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:36 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-rc 2/5] block/rnbd-srv: Fix use after free in rnbd_srv_sess_dev_force_close
Date:   Fri,  8 Jan 2021 15:36:31 +0100
Message-Id: <20210108143634.175394-3-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
References: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

KASAN detect following BUG:
[  778.215311] ==================================================================
[  778.216696] BUG: KASAN: use-after-free in rnbd_srv_sess_dev_force_close+0x38/0x60 [rnbd_server]
[  778.219037] Read of size 8 at addr ffff88b1d6516c28 by task tee/8842

[  778.220500] CPU: 37 PID: 8842 Comm: tee Kdump: loaded Not tainted 5.10.0-pserver #5.10.0-1+feature+linux+next+20201214.1025+0910d71
[  778.220529] Hardware name: Supermicro Super Server/X11DDW-L, BIOS 3.3 02/21/2020
[  778.220555] Call Trace:
[  778.220609]  dump_stack+0x99/0xcb
[  778.220667]  ? rnbd_srv_sess_dev_force_close+0x38/0x60 [rnbd_server]
[  778.220715]  print_address_description.constprop.7+0x1e/0x230
[  778.220750]  ? freeze_kernel_threads+0x73/0x73
[  778.220896]  ? rnbd_srv_sess_dev_force_close+0x38/0x60 [rnbd_server]
[  778.220932]  ? rnbd_srv_sess_dev_force_close+0x38/0x60 [rnbd_server]
[  778.220994]  kasan_report.cold.9+0x37/0x7c
[  778.221066]  ? kobject_put+0x80/0x270
[  778.221102]  ? rnbd_srv_sess_dev_force_close+0x38/0x60 [rnbd_server]
[  778.221184]  rnbd_srv_sess_dev_force_close+0x38/0x60 [rnbd_server]
[  778.221240]  rnbd_srv_dev_session_force_close_store+0x6a/0xc0 [rnbd_server]
[  778.221304]  ? sysfs_file_ops+0x90/0x90
[  778.221353]  kernfs_fop_write+0x141/0x240
[  778.221451]  vfs_write+0x142/0x4d0
[  778.221553]  ksys_write+0xc0/0x160
[  778.221602]  ? __ia32_sys_read+0x50/0x50
[  778.221684]  ? lockdep_hardirqs_on_prepare+0x13d/0x210
[  778.221718]  ? syscall_enter_from_user_mode+0x1c/0x50
[  778.221821]  do_syscall_64+0x33/0x40
[  778.221862]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  778.221896] RIP: 0033:0x7f4affdd9504
[  778.221928] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
[  778.221956] RSP: 002b:00007fffebb36b28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  778.222011] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4affdd9504
[  778.222038] RDX: 0000000000000002 RSI: 00007fffebb36c50 RDI: 0000000000000003
[  778.222066] RBP: 00007fffebb36c50 R08: 0000556a151aa600 R09: 00007f4affeb1540
[  778.222094] R10: fffffffffffffc19 R11: 0000000000000246 R12: 0000556a151aa520
[  778.222121] R13: 0000000000000002 R14: 00007f4affea6760 R15: 0000000000000002

[  778.222764] Allocated by task 3212:
[  778.223285]  kasan_save_stack+0x19/0x40
[  778.223316]  __kasan_kmalloc.constprop.7+0xc1/0xd0
[  778.223347]  kmem_cache_alloc_trace+0x186/0x350
[  778.223382]  rnbd_srv_rdma_ev+0xf16/0x1690 [rnbd_server]
[  778.223422]  process_io_req+0x4d1/0x670 [rtrs_server]
[  778.223573]  __ib_process_cq+0x10a/0x350 [ib_core]
[  778.223709]  ib_cq_poll_work+0x31/0xb0 [ib_core]
[  778.223743]  process_one_work+0x521/0xa90
[  778.223773]  worker_thread+0x65/0x5b0
[  778.223802]  kthread+0x1f2/0x210
[  778.223833]  ret_from_fork+0x22/0x30

[  778.224296] Freed by task 8842:
[  778.224800]  kasan_save_stack+0x19/0x40
[  778.224829]  kasan_set_track+0x1c/0x30
[  778.224860]  kasan_set_free_info+0x1b/0x30
[  778.224889]  __kasan_slab_free+0x108/0x150
[  778.224919]  slab_free_freelist_hook+0x64/0x190
[  778.224947]  kfree+0xe2/0x650
[  778.224982]  rnbd_destroy_sess_dev+0x2fa/0x3b0 [rnbd_server]
[  778.225011]  kobject_put+0xda/0x270
[  778.225046]  rnbd_srv_sess_dev_force_close+0x30/0x60 [rnbd_server]
[  778.225081]  rnbd_srv_dev_session_force_close_store+0x6a/0xc0 [rnbd_server]
[  778.225111]  kernfs_fop_write+0x141/0x240
[  778.225140]  vfs_write+0x142/0x4d0
[  778.225169]  ksys_write+0xc0/0x160
[  778.225198]  do_syscall_64+0x33/0x40
[  778.225227]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

[  778.226506] The buggy address belongs to the object at ffff88b1d6516c00
                which belongs to the cache kmalloc-512 of size 512
[  778.227464] The buggy address is located 40 bytes inside of
                512-byte region [ffff88b1d6516c00, ffff88b1d6516e00)

The problem is in the sess_dev release function we call
rnbd_destroy_sess_dev, and could free the sess_dev already, but we still
set the keep_id in rnbd_srv_sess_dev_force_close, which lead to use
after free.

To fix it, move the keep_id before the sysfs removal, and cache the
rnbd_srv_session for lock accessing,

Fixes: 786998050cbc ("block/rnbd-srv: close a mapped device from server side.")
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
Reviewed-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index b8e44331e494..a6a68d44f517 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -338,10 +338,12 @@ static int rnbd_srv_link_ev(struct rtrs_srv *rtrs,
 
 void rnbd_srv_sess_dev_force_close(struct rnbd_srv_sess_dev *sess_dev)
 {
-	mutex_lock(&sess_dev->sess->lock);
-	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
-	mutex_unlock(&sess_dev->sess->lock);
+	struct rnbd_srv_session	*sess = sess_dev->sess;
+
 	sess_dev->keep_id = true;
+	mutex_lock(&sess->lock);
+	rnbd_srv_destroy_dev_session_sysfs(sess_dev);
+	mutex_unlock(&sess->lock);
 }
 
 static int process_msg_close(struct rtrs_srv *rtrs,
-- 
2.25.1

