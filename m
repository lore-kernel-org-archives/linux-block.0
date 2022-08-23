Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2180C32772
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 16:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbiHWQei (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Aug 2022 12:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbiHWQdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 12:33:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771019FA86
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 07:51:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o14-20020a17090a0a0e00b001fabfd3369cso14902778pjo.5
        for <linux-block@vger.kernel.org>; Tue, 23 Aug 2022 07:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=2OCHz3jaq9ji7FCyQ19Mwipf2lkMm1M6du4jKkL5WtY=;
        b=eCsX87bOlCxcvTYGpqMXnoNyL29ocJvQSVi9DD5w60s9uOVik+BSULEfezjDLneBuR
         K9oU1If70li76n+/Jh0DjXOr461bfGnk0ow19HfDYuafHK4d1+tHUvs/7/WATsBVTFde
         74HkgDKDFMHYIsboHWyP5LBYvHhmC8iqq95U5oKAMxL4EMqG1keKm8Tu1jYSdE4EswdO
         rGCqs+yJjqQHW6dGUds653ecFsY/27sMCD/Lm9i6SehyDc0vs3N5JJd3geBKkifyI1ec
         3vHqv8KFQ91yaib+tnuKqiDe8Kd7mOVqMue3bBXMDYB/4Fp/lHCNf3AneUEj+NPXMgIf
         S/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=2OCHz3jaq9ji7FCyQ19Mwipf2lkMm1M6du4jKkL5WtY=;
        b=LA8Wy5WcbeIYYejkDFftRwL80LDOywgIA68JYVcZOr4sfwncENbiRiGzc+hIeX+jhM
         q7tHZkrcq+SACjPUNoCcJH8+Q1MZ1CwJA0cwkbn+XCL6a2YTsQukM3Mhl/5tA7AF8n1J
         rcMoIk8KN6xpt1dKUEhq1EUhiMbjIijnX2N/LYuiN/rcOl6decbk9nWSfPqfmC5bRSx8
         WDb4pwPxiYb/f/p3Eq2k3BrEwwpti7PGZhDwCDljMfCLH3rNdEZzEnRiq7ZWV0BTdT2y
         EiDeIuUL/62+jyk8BwOL+AfeCRyHmEWGmaboHTs4Qg1NJ+9kjAgPOKaXGY/UDS6kQSHg
         LDbw==
X-Gm-Message-State: ACgBeo2OVS92j8pyJzCDEr73JALrIQaOI1Y2kIduu6EMe7NxXZMq8PBf
        yS4cDx9yluVm5AGbSJJhJ0tEf1Szsi53sg==
X-Google-Smtp-Source: AA6agR4u6UST9DFB3v2PSq5Zlf/RzX5fGdw+5JizFGZiVyqL96wJ/TniZRgJGs1pPHv4AMTnvTEfDg==
X-Received: by 2002:a17:902:d3cb:b0:172:bf02:a979 with SMTP id w11-20020a170902d3cb00b00172bf02a979mr21307313plb.100.1661266262875;
        Tue, 23 Aug 2022 07:51:02 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id l8-20020a170903244800b0016bea74d11esm6822724pls.267.2022.08.23.07.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:51:01 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, acourbot@chromium.org
Cc:     linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org, suwan.kim027@gmail.com
Subject: [PATCH] virtio-blk: Fix WARN_ON_ONCE in virtio_queue_rq()
Date:   Tue, 23 Aug 2022 23:50:05 +0900
Message-Id: <20220823145005.26356-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If a request fails at virtio_queue_rqs(), it is inserted to requeue_list
and passed to virtio_queue_rq(). Then blk_mq_start_request() can be called
again at virtio_queue_rq() and trigger WARN_ON_ONCE like below trace because
request state was already set to MQ_RQ_IN_FLIGHT in virtio_queue_rqs()
despite the failure.

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

This patch defers the execution of blk_mq_start_request() after
virtblk_add_req() within virtio_queue_rqs(). virtblk_add_req() is the last
preparation step to submit a request to virtqueue. So we can ensure that
we call blk_mq_start_request() after all the preparations finish.

In virtio_queue_rq(), call blk_mq_start_request() before virtblk_add_req()
to avoid its execution inside spinlock.

Fixes: 0e9911fa768f ("virtio-blk: support mq_ops->queue_rqs()")
Reported-by: Alexandre Courbot <acourbot@chromium.org>
Tested-by: Alexandre Courbot <acourbot@chromium.org>
Signed-off-by: Suwan Kim <suwan.kim027@gmail.com>
---
 drivers/block/virtio_blk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 30255fcaf181..73a0620a7cff 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -322,8 +322,6 @@ static blk_status_t virtblk_prep_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(status))
 		return status;
 
-	blk_mq_start_request(req);
-
 	vbr->sg_table.nents = virtblk_map_data(hctx, req, vbr);
 	if (unlikely(vbr->sg_table.nents < 0)) {
 		virtblk_cleanup_cmd(req);
@@ -349,6 +347,8 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(status))
 		return status;
 
+	blk_mq_start_request(req);
+
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	err = virtblk_add_req(vblk->vqs[qid].vq, vbr);
 	if (err) {
@@ -409,6 +409,8 @@ static bool virtblk_add_req_batch(struct virtio_blk_vq *vq,
 			virtblk_unmap_data(req, vbr);
 			virtblk_cleanup_cmd(req);
 			rq_list_add(requeue_list, req);
+		} else {
+			blk_mq_start_request(req);
 		}
 	}
 
-- 
2.26.3

