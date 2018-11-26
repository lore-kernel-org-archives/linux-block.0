Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB29C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150CF20855
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DwKeFjZA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150CF20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbeK0Dar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:30:47 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:39034 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeK0Dar (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:30:47 -0500
Received: by mail-io1-f67.google.com with SMTP id k7so4574637iob.6
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQNpMrnHiA8Sq6l5G1VGOnfunRBbHhhFUOFsxMZRY6o=;
        b=DwKeFjZAG8fw1993XjAg0QLcyl+9+CVEyCM0k5OSMU9z4luAQ175CJFmH4+3Kd/wE/
         LgDQQMfHZQdT2dzue0Zzi0Itxp9cAXi8Wnc09x/vo+9sNEDmJVCm2wdkiuk9R8xy6Zzd
         uCBK7lW2oZ37knZc3P/3ouzTMalIa8f2hcuPGQXsAxPjdb5Me6DK3DapTUNFBLeUxQp4
         fOprsVcmWP0moBpHGcHd/sMMem/8/epTFK0rkWnhbnJFvL2q/93qPbU9SXMkuE1Ka55w
         lBmQyTvSjEXy7ZZ4h12kwUr2ziwVOCY+R91Vl244auZrTH1gwnLrfDu/ONC2FBUj+6zP
         /GdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQNpMrnHiA8Sq6l5G1VGOnfunRBbHhhFUOFsxMZRY6o=;
        b=nfhpj5N2OUCLpQ/K7BzbRetq7y+LNPkD9ZKudbsm9Rbi2bCoJNia+Xo9ZM4s2zG886
         J2U8+6X+4rcrBxDdj+pEn0jKRr2i+HSdh26GjZ5FGD+hSe9j3Hu9qtngo2Ig7ImPdcIK
         h/jUu54KTK4vL2uGDKUgRokKcmFPWbyK3Z6NC5gE7O8QRm7HHLZW1khKUL1ofFGRm0EV
         ceInDTKPDTx4fjyqwMpk/MjJTpvnCL1qR2YV1dAoXBc1Wb09KMs5SXJ6enoT7M9qqrXI
         yZd7s6b0RSs1N/jpZkyHvyryKFqqbTKfjLSC5zJh72v3Huzqd4Hq+48YJPZS5Eq8cBRY
         eW9Q==
X-Gm-Message-State: AA+aEWamGT5K3o7AJilN2sAkEF858mFQnbaVq8fXcCjxLQnzhT8yH2HA
        2yuu/1a4kyjYnap1elmrr6bOaTtoHug=
X-Google-Smtp-Source: AFSGD/WyesAa5saWos3qvLjDmOhwwkDw32e2g6Szojfa1CsYC9l0r6J34H9EP73aA0obu7dRYIBk3w==
X-Received: by 2002:a6b:14c6:: with SMTP id 189mr21191603iou.179.1543250168835;
        Mon, 26 Nov 2018 08:36:08 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r11sm263717iog.46.2018.11.26.08.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:36:07 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/8] nvme: implement mq_ops->commit_rqs() hook
Date:   Mon, 26 Nov 2018 09:35:52 -0700
Message-Id: <20181126163556.5181-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126163556.5181-1-axboe@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
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
 drivers/nvme/host/pci.c | 52 +++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73effe586e5f..d503bf6cd8ba 100644
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
@@ -522,22 +523,52 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
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
 	spin_lock(&nvmeq->sq_lock);
 
 	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
 
-	if (++nvmeq->sq_tail == nvmeq->q_depth)
-		nvmeq->sq_tail = 0;
-	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
-			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
-		writel(nvmeq->sq_tail, nvmeq->q_db);
+	/*
+	 * Write sq tail if we have to, OR if the next command would wrap
+	 */
+	nvmeq->sq_tail = nvme_next_ring_index(nvmeq, nvmeq->sq_tail);
+	if (write_sq ||
+	    nvme_next_ring_index(nvmeq, nvmeq->sq_tail) == nvmeq->last_sq_tail)
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
 
@@ -923,7 +954,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, &cmnd);
+	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -999,8 +1030,7 @@ static void nvme_complete_cqes(struct nvme_queue *nvmeq, u16 start, u16 end)
 {
 	while (start != end) {
 		nvme_handle_cqe(nvmeq, start);
-		if (++start == nvmeq->q_depth)
-			start = 0;
+		start = nvme_next_ring_index(nvmeq, start);
 	}
 }
 
@@ -1108,7 +1138,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
-	nvme_submit_cmd(nvmeq, &c);
+	nvme_submit_cmd(nvmeq, &c, true);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -1531,6 +1561,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 
 	spin_lock_irq(&nvmeq->cq_lock);
 	nvmeq->sq_tail = 0;
+	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1603,6 +1634,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 #define NVME_SHARED_MQ_OPS					\
 	.queue_rq		= nvme_queue_rq,		\
+	.commit_rqs		= nvme_commit_rqs,		\
 	.rq_flags_to_type	= nvme_rq_flags_to_type,	\
 	.complete		= nvme_pci_complete_rq,		\
 	.init_hctx		= nvme_init_hctx,		\
-- 
2.17.1

