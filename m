Return-Path: <SRS0=Lpm0=ZT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FF2C432C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 02:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D830D206CC
	for <linux-block@archiver.kernel.org>; Wed, 27 Nov 2019 02:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="SMgYIVyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfK0CrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:47:11 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44076 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfK0CrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Nov 2019 21:47:10 -0500
Received: by mail-pj1-f66.google.com with SMTP id w8so9213960pjh.11
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2019 18:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=745A+eCsEg1muKCYSg2p/wtTP4Y+wsxmjId5exHGtfo=;
        b=SMgYIVyNSzhZH4ald3Xy3UtcVJF+AiXdjJnAZ68iotYqDWhZho5ZFo2BF//Sj/1kEO
         0RjE3/EpMLC4qRPsA8j+HZ06MCtN6+2it3lpenCl61EnBaYMN8m+tOv7eoQlej63dudM
         N4F8n0IZIw9bQrXXBOzXzxtxptLLvBD1IlGVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=745A+eCsEg1muKCYSg2p/wtTP4Y+wsxmjId5exHGtfo=;
        b=JLigwAzFh+xE0+GqMjDgqJQwmUcHB2GnFM5FyczW+XdPcHuzfEbO1MUzMJQYDI6Icm
         1T6SWyp0XMiaDqhPT54vo/T83uKBe9jbbi8GR/uSmUR14axkHciqMfsMbhLvIGnu/6Xn
         D6qvZkunCaL2tluMCkiJuF0BqpzP5/PuTAg4tdEigaOYPn0eMggt1KSaZArhfoAcU7FK
         mpJyRhXvT3c1cNjQuXqVXWzmOxUuumvOM6sTfVpU5ARIdbzEFWT4rd2jrrU+wmOsux3/
         DiVyyhbjUtnc6V2I10JdvYQeQW7SsIyTGf1/hWUIpl4U6azU0T4SefkLJlJjI4iOjQCU
         mY8w==
X-Gm-Message-State: APjAAAVuVJphNu9Iui9zexK5bksc3gpIAu4/HMp5J5Mod7MmAZjUe6qZ
        kl6KaSGbllBpd3Z3WeP6BJWPEA==
X-Google-Smtp-Source: APXvYqxTwpIYa40HIhvzypq9bOy9lOxP2whhAnbxjOBTaBb3PY21RhcYJbkySdG5bPTqXi0fIUJdYw==
X-Received: by 2002:a17:902:d205:: with SMTP id t5mr1546245ply.31.1574822829825;
        Tue, 26 Nov 2019 18:47:09 -0800 (PST)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id w15sm13416137pfi.168.2019.11.26.18.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 18:47:09 -0800 (PST)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi.kubota1012@sslab.ics.keio.ac.jp
Subject: [PATCH] block/genhd: Fix memory leak in error path of __alloc_disk_node()
Date:   Wed, 27 Nov 2019 02:40:57 +0000
Message-Id: <20191127024057.5827-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'disk->part_tbl' is malloced in disk_expand_part_tbl() and should be
freed before leaving from the error handling cases. However, current code
does not free this, causing a memory leak. Add disk_replace_part_tbl()
before freeing 'disk'.

I have tested this by randomly causing failures to the target code,
and verified on kmemleak that this memory leak does occur.

unreferenced object 0xffff888006dad500 (size 64):
  comm "systemd-udevd", pid 116, jiffies 4294895558 (age 121.716s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000eec79bf3>] disk_expand_part_tbl+0xab/0x170
    [<00000000624e7d03>] __alloc_disk_node+0xb1/0x1c0
    [<00000000ca3f4185>] 0xffffffffc01b8584
    [<000000006f88a6ee>] do_one_initcall+0x8b/0x2a4
    [<0000000016058199>] do_init_module+0xfd/0x380
    [<00000000b6fde336>] load_module+0x3fae/0x4240
    [<00000000c523d013>] __do_sys_finit_module+0x11a/0x1b0
    [<00000000f07bba26>] do_syscall_64+0x6d/0x1e0
    [<00000000979467fd>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 block/genhd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..8c4b63d7f507 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1504,6 +1504,7 @@ struct gendisk *__alloc_disk_node(int minors, int node_id)
 		 */
 		seqcount_init(&disk->part0.nr_sects_seq);
 		if (hd_ref_init(&disk->part0)) {
+			disk_replace_part_tbl(disk, NULL);
 			hd_free_part(&disk->part0);
 			kfree(disk);
 			return NULL;
-- 
2.17.1

