Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA3C433E6
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCE523884
	for <linux-block@archiver.kernel.org>; Fri,  8 Jan 2021 14:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbhAHOhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Jan 2021 09:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbhAHOhU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Jan 2021 09:37:20 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69A8C0612FD
        for <linux-block@vger.kernel.org>; Fri,  8 Jan 2021 06:36:39 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id ga15so14825292ejb.4
        for <linux-block@vger.kernel.org>; Fri, 08 Jan 2021 06:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDFpQWrHMsuKz/nh26/noW6aHuNV8mbI1uQD9qPo1DM=;
        b=FDhELJkw7kpTs1Too27M1GbjuEU6VA8MqoDNV6jlYAL0RrNIYmqMlkHCdWJVzldtDO
         3fTDAbyLUrs91J900Nk35cI2RZVbk/XcdrJ3lxPfQzWWk3sf4i65wfdvd+yDZgcI7QRn
         Laj1r4OH2T0Mo32K8RnzQrLN2u54L7MzNmCblvh7RT9hL6gcRSbe2S4qJQTmWWtNedKb
         6m17NTcrnRNSn2j6QJPUFt3BUmmemDNrkOTj/KGYcJJd1McQu5NeSEvuOBKo+6ggmKtR
         C1Nkh6r9jMIqykWuyQfX+jI2jnpij6RcNJ0rIh/CJ0nEVYNmdSZrxOAWY9BUSqJVoRUB
         2NBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDFpQWrHMsuKz/nh26/noW6aHuNV8mbI1uQD9qPo1DM=;
        b=TH/ryDQSGh1VH8AsiOKx4Ld3a5m7bnnJDtTd2M4C5+WL5KSv435xYfQx5YHtuz0VRn
         92FY6+WUekIpJQ6fuD92EmHO9KxcyxxOO13t3k18GNQ4Csp3OossUbm1n6H78Y32BDAh
         Zkt466tIg3rpn+lEYn7bDT9ut8bZeaBbrPTn3dM7iMK/0Jp3SM/KEzE3Rd4aqz7xvZPj
         y87fwAnvcHRG+SMM1UhBhU6CyQU7Kg45o6XsHFRYkumr5LWrEkoc26YP3siIdao49c2c
         MnbaQ55YTvNp/DajOgnKU9a5XNiIS93zdtzuPLTd07eI//psylDqlr6IFERscZxPxcHe
         oQ5g==
X-Gm-Message-State: AOAM532BKD7wogClu6Wi1DvUHL6EXGSPbmj26LJvjW/pSZJXk48KruBr
        doBclXR/qJiqMTpmC41C/0poUJl/8IEHPQ==
X-Google-Smtp-Source: ABdhPJxciLNzvQWim5KMMvqRtG2gwMHveOv/3jfMUXZyAYTJnF3QD6mFEhV5y48fOClONWl3o69ZZQ==
X-Received: by 2002:a17:906:3a0d:: with SMTP id z13mr2806615eje.2.1610116598220;
        Fri, 08 Jan 2021 06:36:38 -0800 (PST)
Received: from jwang-Latitude-5491.fkb.profitbricks.net ([2001:16b8:4906:c200:31ac:50df:cd1f:f7fc])
        by smtp.gmail.com with ESMTPSA id e25sm3858698edq.24.2021.01.08.06.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 06:36:37 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH for-rc 3/5] block/rnbd-clt: Fix sg table use after free
Date:   Fri,  8 Jan 2021 15:36:32 +0100
Message-Id: <20210108143634.175394-4-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
References: <20210108143634.175394-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>

Since dynamically allocate sglist is used for rnbd_iu, we can't free sg
table after send_usr_msg since the callback function (cqe.done) could
still access the sglist.

Otherwise KASAN reports UAF issue:

[ 4856.600257] BUG: KASAN: use-after-free in dma_direct_unmap_sg+0x53/0x290
[ 4856.600772] Read of size 4 at addr ffff888206af3a98 by task swapper/1/0

[ 4856.601729] CPU: 1 PID: 0 Comm: swapper/1 Kdump: loaded Tainted: G        W         5.10.0-pserver #5.10.0-1+feature+linux+next+20201214.1025+0910d71
[ 4856.601748] Hardware name: Supermicro Super Server/X11DDW-L, BIOS 3.3 02/21/2020
[ 4856.601766] Call Trace:
[ 4856.601785]  <IRQ>
[ 4856.601822]  dump_stack+0x99/0xcb
[ 4856.601856]  ? dma_direct_unmap_sg+0x53/0x290
[ 4856.601888]  print_address_description.constprop.7+0x1e/0x230
[ 4856.601913]  ? freeze_kernel_threads+0x73/0x73
[ 4856.601965]  ? mark_held_locks+0x29/0xa0
[ 4856.602019]  ? dma_direct_unmap_sg+0x53/0x290
[ 4856.602039]  ? dma_direct_unmap_sg+0x53/0x290
[ 4856.602079]  kasan_report.cold.9+0x37/0x7c
[ 4856.602188]  ? mlx5_ib_post_recv+0x430/0x520 [mlx5_ib]
[ 4856.602209]  ? dma_direct_unmap_sg+0x53/0x290
[ 4856.602256]  dma_direct_unmap_sg+0x53/0x290
[ 4856.602366]  complete_rdma_req+0x188/0x4b0 [rtrs_client]
[ 4856.602451]  ? rtrs_clt_close+0x80/0x80 [rtrs_client]
[ 4856.602535]  ? mlx5_ib_poll_cq+0x48b/0x16e0 [mlx5_ib]
[ 4856.602589]  ? radix_tree_insert+0x3a0/0x3a0
[ 4856.602610]  ? do_raw_spin_lock+0x119/0x1d0
[ 4856.602647]  ? rwlock_bug.part.1+0x60/0x60
[ 4856.602740]  rtrs_clt_rdma_done+0x3f7/0x670 [rtrs_client]
[ 4856.602804]  ? rtrs_clt_rdma_cm_handler+0xda0/0xda0 [rtrs_client]
[ 4856.602857]  ? check_flags.part.31+0x6c/0x1f0
[ 4856.602927]  ? rcu_read_lock_sched_held+0xaf/0xe0
[ 4856.602963]  ? rcu_read_lock_bh_held+0xc0/0xc0
[ 4856.603137]  __ib_process_cq+0x10a/0x350 [ib_core]
[ 4856.603309]  ib_poll_handler+0x41/0x1c0 [ib_core]
[ 4856.603358]  irq_poll_softirq+0xe6/0x280
[ 4856.603392]  ? lockdep_hardirqs_on_prepare+0x111/0x210
[ 4856.603446]  __do_softirq+0x10d/0x646
[ 4856.603540]  asm_call_irq_on_stack+0x12/0x20
[ 4856.603563]  </IRQ>

[ 4856.605096] Allocated by task 8914:
[ 4856.605510]  kasan_save_stack+0x19/0x40
[ 4856.605532]  __kasan_kmalloc.constprop.7+0xc1/0xd0
[ 4856.605552]  __kmalloc+0x155/0x320
[ 4856.605574]  __sg_alloc_table+0x155/0x1c0
[ 4856.605594]  sg_alloc_table+0x1f/0x50
[ 4856.605620]  send_msg_sess_info+0x119/0x2e0 [rnbd_client]
[ 4856.605646]  remap_devs+0x71/0x210 [rnbd_client]
[ 4856.605676]  init_sess+0xad8/0xe10 [rtrs_client]
[ 4856.605706]  rtrs_clt_reconnect_work+0xd6/0x170 [rtrs_client]
[ 4856.605728]  process_one_work+0x521/0xa90
[ 4856.605748]  worker_thread+0x65/0x5b0
[ 4856.605769]  kthread+0x1f2/0x210
[ 4856.605789]  ret_from_fork+0x22/0x30

[ 4856.606159] Freed by task 8914:
[ 4856.606559]  kasan_save_stack+0x19/0x40
[ 4856.606580]  kasan_set_track+0x1c/0x30
[ 4856.606601]  kasan_set_free_info+0x1b/0x30
[ 4856.606622]  __kasan_slab_free+0x108/0x150
[ 4856.606642]  slab_free_freelist_hook+0x64/0x190
[ 4856.606661]  kfree+0xe2/0x650
[ 4856.606681]  __sg_free_table+0xa4/0x100
[ 4856.606707]  send_msg_sess_info+0x1d6/0x2e0 [rnbd_client]
[ 4856.606733]  remap_devs+0x71/0x210 [rnbd_client]
[ 4856.606763]  init_sess+0xad8/0xe10 [rtrs_client]
[ 4856.606792]  rtrs_clt_reconnect_work+0xd6/0x170 [rtrs_client]
[ 4856.606813]  process_one_work+0x521/0xa90
[ 4856.606833]  worker_thread+0x65/0x5b0
[ 4856.606853]  kthread+0x1f2/0x210
[ 4856.606872]  ret_from_fork+0x22/0x30

The solution is to free iu's sgtable after the iu is not used anymore.
And also move sg_alloc_table into rnbd_get_iu accordingly.

Fixes: 5a1328d0c3a7 ("block/rnbd-clt: Dynamically allocate sglist for rnbd_iu")
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-clt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 9165e70bee0c..c696c3a937d7 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -375,12 +375,19 @@ static struct rnbd_iu *rnbd_get_iu(struct rnbd_clt_session *sess,
 	init_waitqueue_head(&iu->comp.wait);
 	iu->comp.errno = INT_MAX;
 
+	if (sg_alloc_table(&iu->sgt, 1, GFP_KERNEL)) {
+		rnbd_put_permit(sess, permit);
+		kfree(iu);
+		return NULL;
+	}
+
 	return iu;
 }
 
 static void rnbd_put_iu(struct rnbd_clt_session *sess, struct rnbd_iu *iu)
 {
 	if (atomic_dec_and_test(&iu->refcount)) {
+		sg_free_table(&iu->sgt);
 		rnbd_put_permit(sess, iu->permit);
 		kfree(iu);
 	}
@@ -487,8 +494,6 @@ static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id, bool wait)
 	iu->buf = NULL;
 	iu->dev = dev;
 
-	sg_alloc_table(&iu->sgt, 1, GFP_KERNEL);
-
 	msg.hdr.type	= cpu_to_le16(RNBD_MSG_CLOSE);
 	msg.device_id	= cpu_to_le32(device_id);
 
@@ -502,7 +507,6 @@ static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id, bool wait)
 		err = errno;
 	}
 
-	sg_free_table(&iu->sgt);
 	rnbd_put_iu(sess, iu);
 	return err;
 }
@@ -575,7 +579,6 @@ static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
 	iu->buf = rsp;
 	iu->dev = dev;
 
-	sg_alloc_table(&iu->sgt, 1, GFP_KERNEL);
 	sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
 
 	msg.hdr.type	= cpu_to_le16(RNBD_MSG_OPEN);
@@ -594,7 +597,6 @@ static int send_msg_open(struct rnbd_clt_dev *dev, bool wait)
 		err = errno;
 	}
 
-	sg_free_table(&iu->sgt);
 	rnbd_put_iu(sess, iu);
 	return err;
 }
@@ -622,8 +624,6 @@ static int send_msg_sess_info(struct rnbd_clt_session *sess, bool wait)
 
 	iu->buf = rsp;
 	iu->sess = sess;
-
-	sg_alloc_table(&iu->sgt, 1, GFP_KERNEL);
 	sg_init_one(iu->sgt.sgl, rsp, sizeof(*rsp));
 
 	msg.hdr.type = cpu_to_le16(RNBD_MSG_SESS_INFO);
@@ -650,7 +650,6 @@ static int send_msg_sess_info(struct rnbd_clt_session *sess, bool wait)
 	} else {
 		err = errno;
 	}
-	sg_free_table(&iu->sgt);
 	rnbd_put_iu(sess, iu);
 	return err;
 }
-- 
2.25.1

