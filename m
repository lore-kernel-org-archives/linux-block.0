Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2673BC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E096F2081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 13:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0NfQ0rSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E096F2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbeK2Ahb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:37:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36324 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbeK2Aha (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 19:37:30 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so4928999plo.3
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 05:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V/xqOQg5v+54GYY0PUH1Gr/pzQRFudbqhjzeM8aHuvM=;
        b=0NfQ0rSlEmg5n37nt3dFhMOl0SXPHdNkcBZYHFC7XBilMtfF1zEvNuo5FTzgyic0RA
         spELV+5U86QnhDs+ZB8jMXyIXFa078NDsqyzbYFoAEYtmjzduBFm9dzE1Ai2Z43h03Gw
         k6O9LAAJdtWrRJK5XFpbCkkYo/GCXRit3QVst+z01vLPyjYJgWcsJtz3fXt0qYdRBMt0
         kQAhMY4+fX6ZU1OxJiiB3uoqWIa8b1hdqlLjK3z4xcvMsvM1saSQn6+MHtXscHzFDeV+
         2D7MPmQlsk20JAJuICwPla4VzkP5GBbPp2XXOy1etQKgifYLqhwWvnFcSekoQM8tCxVe
         m1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V/xqOQg5v+54GYY0PUH1Gr/pzQRFudbqhjzeM8aHuvM=;
        b=Trs09Ni8OcGJS+mShoJ/uamGRuIn8ZykYgzRk3kd4Fn7shgNOaAycL6jb7KLkwHINO
         3/8c+obIWJRX4bznhL1SpZrs6gB9zCCUhZBir5S3c1y1Qr05+h3Pt4/PZF6a9GUPj4nM
         HpY+yb9ifIh4N9wa/pOJCpoZMEC1gJmSULe41+RlgnA9NJ11ojmuf5oUyBDYzZvKi1r4
         kRiuxsqoVAOZq/vi9uUEaG3UH4rF5qOmbEboKF1UlkbdG1PkBrIScN+g5uE4VkquPTOi
         yHHOv/MbIJJjJdBYjuIX+i5XAizHKhn+roMGq0y1ZdLcj5HfU2NJxww3zUjQ7pZRuxg/
         6xWQ==
X-Gm-Message-State: AA+aEWZRzSL1HTht0I22VbSwn1zitMDWff8IDHpTHg+xwXx44WQinb4B
        vesudcX4B79z9mNtSLU5/piRIz9voj0=
X-Google-Smtp-Source: AFSGD/XbLd0n+TEDneo0MNaPXnLpliORl09ikKosfaGSnT9nH9AuGQiLTObJek0s1xT2/5jvHpluog==
X-Received: by 2002:a17:902:1d4a:: with SMTP id u10mr34316872plu.122.1543412149205;
        Wed, 28 Nov 2018 05:35:49 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id q75sm4744925pfa.38.2018.11.28.05.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:35:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
Date:   Wed, 28 Nov 2018 06:35:34 -0700
Message-Id: <20181128133538.20329-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split the command submission and the SQ doorbell ring, and add the
doorbell ring as our ->commit_rqs() hook. This allows a list of
requests to be issued, with nvme only writing the SQ update when
it's necessary. This is more efficient if we have lists of requests
to issue, particularly on virtualized hardware, where writing the
SQ doorbell is more expensive than on real hardware. For those cases,
performance increases of 2-3x have been observed.

The use case for this is plugged IO, where blk-mq flushes a batch of
requests at the time.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 52 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73effe586e5f..42472bd0cfed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -203,6 +203,7 @@ struct nvme_queue {
 	u16 q_depth;
 	s16 cq_vector;
 	u16 sq_tail;
+	u16 last_sq_tail;
 	u16 cq_head;
 	u16 last_cq_head;
 	u16 qid;
@@ -522,22 +523,59 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
+static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
+{
+	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
+			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
+		writel(nvmeq->sq_tail, nvmeq->q_db);
+	nvmeq->last_sq_tail = nvmeq->sq_tail;
+}
+
+static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
+{
+	if (++index == nvmeq->q_depth)
+		return 0;
+
+	return index;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
  * @cmd: The command to send
+ * @write_sq: whether to write to the SQ doorbell
  */
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
+static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
+			    bool write_sq)
 {
+	u16 next_tail;
+
 	spin_lock(&nvmeq->sq_lock);
 
 	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
-			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
-		writel(nvmeq->sq_tail, nvmeq->q_db);
+
+	next_tail = nvmeq->sq_tail + 1;
+	if (next_tail == nvmeq->q_depth)
+		next_tail = 0;
+
+	/*
+	 * Write sq tail if we have to, OR if the next command would wrap
+	 */
+	if (write_sq || next_tail == nvmeq->last_sq_tail)
+		nvme_write_sq_db(nvmeq);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+
+	spin_lock(&nvmeq->sq_lock);
+	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
+		nvme_write_sq_db(nvmeq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -923,7 +961,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, &cmnd);
+	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -1108,7 +1146,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
-	nvme_submit_cmd(nvmeq, &c);
+	nvme_submit_cmd(nvmeq, &c, true);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -1531,6 +1569,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 
 	spin_lock_irq(&nvmeq->cq_lock);
 	nvmeq->sq_tail = 0;
+	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1603,6 +1642,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 #define NVME_SHARED_MQ_OPS					\
 	.queue_rq		= nvme_queue_rq,		\
+	.commit_rqs		= nvme_commit_rqs,		\
 	.rq_flags_to_type	= nvme_rq_flags_to_type,	\
 	.complete		= nvme_pci_complete_rq,		\
 	.init_hctx		= nvme_init_hctx,		\
-- 
2.17.1

