Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940626FA4B
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782530878; cv=none; b=jEuSEMn3r9u80HjTkswt5bwqyAM2rAXqi3h2FzwKa1116VvPIDau4d1EV6/Ch5Ly2dgZww89hxc8WlVbLqyC9+I1ghJYAEGKmS+9mQ1ulBho1uaL2d7RsEFAPCqaxG24SffQRTeiL80J4dk5OVXA6alQvetKBZ3sRfGnA3WKjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782530878; c=relaxed/simple;
	bh=c/WZA9XqIPPLIhfog1ZnFNeTEBlrIkOJH9slgNunSZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kGghnrRxUTbtvSsF1P8NKxMMzC9fKHTzGxJ99q6Wh7qGHuEJGGPq0OisqHwNQgfSA0FXvb3pjYHDNbjT6VjrlrcnqJiBO2vgnvZQ/JPdH+wsUPIGYmxuFbxQdJS7LTMcxxW1CzeQimmWyjb68RpqUmPmoQej2TYHP0a8ISoNHio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gW3rxnfD; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gW3rxnfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=RT
	nTgpsaksIHKOaynhIsltXBamF3MNXLhFw42Y5PZsk=; b=gW3rxnfDJOxULU8Is9
	99yzw1DixqhMk+BFn7SbXrmPt+jOGgUitwKgshTmDU0DSAbI5okYBZRgnFTkMe6N
	9EI7CW6GDCbnQw5sTV3pqCuEcF0b2NegueWphdecCvkmIWt4DTcnVOwZKTLH4eNu
	EixPc8ehBsWeo9gsS66iziNpo=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD3vzokQz9qDY9dEQ--.45193S2;
	Sat, 27 Jun 2026 11:27:33 +0800 (CST)
From: dayou5941@163.com
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	liyouhong <liyouhong@kylinos.cn>
Subject: [PATCH] block: assert blk_iou_cmd fits in the io_uring_cmd PDU
Date: Sat, 27 Jun 2026 11:27:31 +0800
Message-Id: <20260627032731.2878510-1-dayou5941@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD3vzokQz9qDY9dEQ--.45193S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr47Cr4fCw1DJFykKF18uFg_yoWDKrb_CF
	95G34F9ryUJFs3ur10k3WfZr9ay3y7Wryjgr9aqr9Fqa17ZayDC3s7Cr4Ivrn8ua9rZFW3
	Gan8Wr4xtF4IvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbkwIPUUUUU==
X-CM-SenderInfo: 5gd103ivzuiqqrwthudrp/xtbC+gZE8mo-QyZJ0QAA3i

From: liyouhong <liyouhong@kylinos.cn>

blk_iou_cmd is stored in io_uring_cmd->pdu via io_uring_cmd_to_pdu() for
block device io_uring commands (e.g. discard).  The PDU is only 32 bytes
inline storage; add a static_assert matching scsi_bsg.c so that future
struct growth cannot silently overflow it.

Signed-off-by: liyouhong <liyouhong@kylinos.cn>
---
 block/ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index ab2c9ed79946..3c8fd365aa9f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -856,12 +856,17 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 }
 #endif
 
+/*
+ * Per-command block io_uring PDU stored in io_uring_cmd.pdu[32].
+ * Holds discard state between submission, completion and task work.
+ */
 struct blk_iou_cmd {
 	u64 start;
 	u64 len;
 	int res;
 	bool nowait;
 };
+static_assert(sizeof(struct blk_iou_cmd) <= sizeof_field(struct io_uring_cmd, pdu));
 
 static void blk_cmd_complete(struct io_tw_req tw_req, io_tw_token_t tw)
 {
-- 
2.25.1

