Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF3FC433F5
	for <linux-block@archiver.kernel.org>; Wed, 24 Nov 2021 03:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbhKXECM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 23:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhKXECM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 23:02:12 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F0EC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 19:59:03 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id n15so1469484qta.0
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 19:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLGJgEePI4OpXm0xDpudyx4k3wJI9GzavZRCOYQCuYU=;
        b=f4wMII+wD1aVedVSWEDL4k51ZQ1n29efpmduFalGGJ4Z0GYti2+U+Cwsxc9idMIehL
         gVTOVvRMuXcqeE7gHJPPlMj3jx9au1DxIIGBtkNtWRnVQduTxOzxki9xw//21VGrcgZa
         KH+/0HRqrQYYWGi8uS7Sib34mXIFAF8aGY+beLor/PNycaLzknwNMxCnz1g4nMegEjCp
         +bmJvz0qqmiBE/UbN0cQ3tGNx0sqjHKTUT1x7++VrvpuuR59ET2UtHQjpOYVn0RtdnRv
         tcfNO7Sn1e7wk+m5Vy0MrQorLwhcE3dtYlfz68LfWkov0xLCAuvVqp4DhISG6JZJdich
         5sXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FLGJgEePI4OpXm0xDpudyx4k3wJI9GzavZRCOYQCuYU=;
        b=F70rEn3JPlrbwQJcFXNlxc03PlBKjoj6HvR2yZyDw+EsXU/tFLv94aVlZntiZfpLax
         b94NW3Hm6/6IsPg1T78RCb2dQR3tRF3xmQ4WjLdb00nKO1IVuqEYQolZeHSvSL2Lq65q
         eD7OMyA2OGOY1iWrXPkFtBf3Hk8oD5yhy9EQf85nxmr/N5SttrPc93LF0ZXL0EWjxPmV
         6en3U5BoI+dMikoJXIX28cr+TNbTx50WE3aD7HPHSwsLjnMYZJ93mdXC6KLXzEsgxqoo
         t2rq5DOe/MzV+FLY5grY2MVHhevDDfQcc3JCZUdZ/H1n98AAOF9lfJ1dKnGHrYoq5/Ac
         X84A==
X-Gm-Message-State: AOAM530ep4MLjr8dHDRKXi7pSiLJXRK6DVYnAa3X+XIsmBWO9oQau0+d
        uVnaGpJhPkjoDXk0cD/bGZ22rZnHzL4=
X-Google-Smtp-Source: ABdhPJxc886yK8I5BPXeBLMx3/yqygYXNXwsbAYfKd25/7AcQCzRfSt6ICZGxYlkYwYXqZwoR4K0cg==
X-Received: by 2002:a05:622a:346:: with SMTP id r6mr3255745qtw.78.1637726341945;
        Tue, 23 Nov 2021 19:59:01 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id c3sm7759851qkp.47.2021.11.23.19.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 19:59:01 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>, Tejun Heo <tj@kernel.org>,
        Yanfei Xu <yanfei.xu@windriver.com>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] block: Fix two memory leaks in blkcg_init_queue
Date:   Tue, 23 Nov 2021 22:58:58 -0500
Message-Id: <20211124035858.1657142-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The ioprio and iolatency rqos never get free'd on error or queue exit, causing
the following leaks:

unreferenced object 0xffff97b143bc0900 (size 64):
  comm "kworker/u2:3", pid 101, jiffies 4294877468 (age 159.967s)
  hex dump (first 32 bytes):
    00 15 f9 86 ff ff ff ff 60 f4 cf 45 b1 97 ff ff  ........`..E....
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000063d10c99>] blk_ioprio_init+0x25/0xe0
    [<000000005dd8844d>] blkcg_init_queue+0x8d/0x140
    [<00000000bd7aac9b>] blk_alloc_queue+0x1ef/0x280
    [<0000000044d961f9>] blk_mq_init_queue+0x1a/0x60
    [<0000000031908ee1>] scsi_alloc_sdev+0x20f/0x370
    [<00000000e99f53d3>] scsi_probe_and_add_lun+0x9db/0xe10
    [<00000000942c5af3>] __scsi_scan_target+0xfc/0x5b0
    [<000000007194bb8f>] scsi_scan_channel+0x58/0x90
    [<00000000ebf8a49b>] scsi_scan_host_selected+0xe9/0x120
    [<00000000f745ec7d>] do_scan_async+0x18/0x160
    [<000000006f6ff8ca>] async_run_entry_fn+0x30/0x130
    [<000000003d813304>] process_one_work+0x1e8/0x3c0
    [<0000000020b6d54d>] worker_thread+0x50/0x3c0
    [<000000007fc10a0f>] kthread+0x132/0x160
    [<0000000010197ee2>] ret_from_fork+0x22/0x30
unreferenced object 0xffff97b143da4360 (size 96):
  comm "kworker/u2:3", pid 101, jiffies 4294877468 (age 159.987s)
  hex dump (first 32 bytes):
    40 1b f9 86 ff ff ff ff 60 f4 cf 45 b1 97 ff ff  @.......`..E....
    01 00 00 00 00 00 00 00 00 09 bc 43 b1 97 ff ff  ...........C....
  backtrace:
    [<000000000ffb4700>] blk_iolatency_init+0x25/0x160
    [<00000000c4cdb872>] blkcg_init_queue+0xc7/0x140
    [<00000000bd7aac9b>] blk_alloc_queue+0x1ef/0x280
    [<0000000044d961f9>] blk_mq_init_queue+0x1a/0x60
    [<0000000031908ee1>] scsi_alloc_sdev+0x20f/0x370
    [<00000000e99f53d3>] scsi_probe_and_add_lun+0x9db/0xe10
    [<00000000942c5af3>] __scsi_scan_target+0xfc/0x5b0
    [<000000007194bb8f>] scsi_scan_channel+0x58/0x90
    [<00000000ebf8a49b>] scsi_scan_host_selected+0xe9/0x120
    [<00000000f745ec7d>] do_scan_async+0x18/0x160
    [<000000006f6ff8ca>] async_run_entry_fn+0x30/0x130
    [<000000003d813304>] process_one_work+0x1e8/0x3c0
    [<0000000020b6d54d>] worker_thread+0x50/0x3c0
    [<000000007fc10a0f>] kthread+0x132/0x160
    [<0000000010197ee2>] ret_from_fork+0x22/0x30

Fixes: d70675121546 ("block: introduce blk-iolatency io controller")
Fixes: 556910e39249 ("block: Introduce the ioprio rq-qos policy")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 block/blk-cgroup.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 663aabfeba18..ced5ee637405 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -32,6 +32,7 @@
 #include <linux/psi.h>
 #include "blk.h"
 #include "blk-ioprio.h"
+#include "blk-rq-qos.h"
 #include "blk-throttle.h"
 
 /*
@@ -1200,16 +1201,18 @@ int blkcg_init_queue(struct request_queue *q)
 
 	ret = blk_throtl_init(q);
 	if (ret)
-		goto err_destroy_all;
+		goto err_qos_exit;
 
 	ret = blk_iolatency_init(q);
 	if (ret) {
 		blk_throtl_exit(q);
-		goto err_destroy_all;
+		goto err_qos_exit;
 	}
 
 	return 0;
 
+err_qos_exit:
+	rq_qos_exit(q);
 err_destroy_all:
 	blkg_destroy_all(q);
 	return ret;
@@ -1229,6 +1232,7 @@ int blkcg_init_queue(struct request_queue *q)
  */
 void blkcg_exit_queue(struct request_queue *q)
 {
+	rq_qos_exit(q);
 	blkg_destroy_all(q);
 	blk_throtl_exit(q);
 }
-- 
2.33.0

