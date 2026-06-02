Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FECC331230;
	Tue,  2 Jun 2026 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780362755; cv=none; b=kIyp6toQFxqxxsktfDEz5MyVK/24yMI30x1FZSbkSMLo2nz9Is1xtZGuBNtadCmX88QZRti+w4eve2dg504MbXVY9dsAu9sQrbHKrfW6qJlxPlTNTqqlYXlhHJXC/cVu+8Etprgj+fQwCgS3qTCmgcXZoZRqPB/E5P8lSC6Mt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780362755; c=relaxed/simple;
	bh=m24aGW2PzX8xiQGXsCvpGVezkI66i2jcalDfzoTF75U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IyrA+89nCOZyp2+/fwMF9ObSXWtoJBPUZbdBrAcN6lgStqVNUtdkZPge0uQ1tzfYlqtCmlKtbCSuNrI9mgXeJaTM1fz8miVFlf9C1TjNM9eA7tQN6mL4aldj5s6+QIErGGkd0wgPRAR4EQ2D6Ke+IPU0ysAv79xhaEZr6zyxL3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JxKMYwcJ; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JxKMYwcJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=YH
	UU0uNmBMtso8+/SjG6RQUWaeoXZm7NfIMfjnURWl8=; b=JxKMYwcJezZbcZBC/N
	TI1aO5Tu9lZew2cz2nrwcqBVYJASFBataUgICybljw41aESOlHvSaipIsaZBsWJb
	WzeGbU+gZ9jzC7pEy9WBvxuBOxaUjgHQkfxG/wHk7keuTAS1YfPI/JKaKNmuhCZL
	woXOJvjgVjMV6etRdHvGkePdQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wCn79rwLR5qfha1Aw--.8588S2;
	Tue, 02 Jun 2026 09:12:17 +0800 (CST)
From: kensanya@163.com
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: [PATCH] blk-mq: clarify blk_mq_quiesce_queue_nowait() comment
Date: Tue,  2 Jun 2026 09:12:14 +0800
Message-Id: <20260602011214.34272-1-kensanya@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCn79rwLR5qfha1Aw--.8588S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryDXry8tFy3ZrWxKF1fCrg_yoW8Xw4xpr
	WDKFWDCw1vgr4UX3y8Za1fWFy7uws8Gr4fAFn3A34Yyan8KF1Iqr1vga4UXa1IvrZ7Arsr
	uF4UJrZ0vF1kAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jdhLnUUUUU=
X-CM-SenderInfo: 5nhq2txq1dqiywtou0bp/xtbCwRGphWoeLfGhugAA3P

From: TanZheng <tanzheng@kylinos.cn>

The FIXME added in 2017 suggested removing this function once mpt3sas
stopped using scsi_internal_device_*block_nowait().  That is no longer
accurate: blk_mq_quiesce_queue_nowait() is now a fundamental building
block used by blk_mq_quiesce_queue(), blk_mq_quiesce_tagset(),
scsi_host_block() and others for batched quiesce without sleeping per
queue.Replace the FIXME with a comment.

Signed-off-by: TanZheng <tanzheng@kylinos.cn>
---
 block/blk-mq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a24175441380..b9a96d922baf 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -255,8 +255,14 @@ void blk_mq_unfreeze_queue_non_owner(struct request_queue *q)
 EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue_non_owner);
 
 /*
- * FIXME: replace the scsi_internal_device_*block_nowait() calls in the
- * mpt3sas driver such that this function can be removed.
+ * Mark a request queue as quiesced without waiting for in-flight dispatches
+ * to finish.  Callers that need to ensure dispatch has drained must follow
+ * this with blk_mq_wait_quiesce_done() on the queue's tag_set, or use
+ * blk_mq_quiesce_queue() which combines both steps.
+ *
+ * This split exists so multiple queues (e.g. all LUNs on a SCSI host, or all
+ * queues in a tag_set) can be quiesced without sleeping per queue, then
+ * waited on once at tag_set scope.
  */
 void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 {
-- 
2.25.1

