Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB24A3F328D
	for <linux-block@vger.kernel.org>; Sun, 20 Sep 2026 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789899121; cv=none; b=M7rIIpWJviSrtkPQSx+adVYt3Ri6PobNFxzptOvifeDQw1i3L06WNAgLaNoc4DD5gBBLJ3KQC657uXBQxDZ4O+GuxYgM/Gvq5/JiAHbSP32wToxDyVA+hON44FzW3iHR4AQJQmukUe8ZeB6a1puDgvtZUnstlJ++VWqHVE/rOhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789899121; c=relaxed/simple;
	bh=DGNCBaiXK9wQvWajz+Ku+3WoIhprXhWYBq36E/0h5ZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nGjzx9mAFtKO1eOQH3qR+w4pyfUnrgF+1dLvaRHn+bpXRJZKkXpoTu0M0TRAKJ8/k5Mt8Y6IFoIccwBSCcxu8wrC6hfRnBI5oujXfVFSWFPdc6GcWJaY3tHlRJohDBrKoe0m5OOO9rItO9Fq1gj/u6xn4qtj/mVXpVsvPNZ8SLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TtnjpJG+; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TtnjpJG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=V7
	0TaXcxjWQlHiwTt4xEgk1qQWD3gM6RWyz6NYA7vxc=; b=TtnjpJG+P5zHnPb0pd
	M5smygeXkQS8P33fP3NpVZGhBlnZnBvlUodYWXfAiplP+ww+gvw0ekeDEaBEXEc5
	OAt2Q6l46+U7eiT6G9Mt1cmYQQn1+5IMdjSOY3LZRVFeoLbMtyxPd3PhoHxvaQOk
	YiySBo2ErpvqG2SGsXgPD41wE=
Received: from ubuntu.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgC3dchgsa9qvH+FAQ--.48876S3;
	Sun, 20 Sep 2026 18:11:45 +0800 (CST)
From: huhai <15815827059@163.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	shikemeng@huaweicloud.com,
	Henry Hu <huhai@kylinos.cn>
Subject: [PATCH 1/2] sbitmap: add __sbitmap_add_wait_queue()
Date: Sun, 20 Sep 2026 18:11:31 +0800
Message-Id: <43c3f33e9097396a42f072e8777ff0b8298f6ba7.1789890726.git.huhai@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1789890726.git.huhai@kylinos.cn>
References: <cover.1789890726.git.huhai@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgC3dchgsa9qvH+FAQ--.48876S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF1kAF17GrykKF45Ww47XFb_yoW5CFW8pF
	W8JFnrC3Wxtr47u3y3JrWUAasIqw4kArnxGrWfKryYkr4UArnaqr4rCF43Ww45uFs7ZF4D
	Xr1FgwsrGr1UW3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlQ6XUUUUU=
X-CM-SenderInfo: rprvmiivyslimvzbiqqrwthudrp/xtbC7wELkGqvsWGmIgAA3k

From: Henry Hu <huhai@kylinos.cn>

sbitmap_add_wait_queue() takes the waitqueue lock, so a caller that
already holds it cannot use that helper.

Add __sbitmap_add_wait_queue() for that case. It updates the sbitmap
accounting and inserts the wait entry as non-exclusive, and asserts
with lockdep_assert_held() that the caller holds the waitqueue lock.
sbitmap_add_wait_queue() now takes the lock and calls it, so the
accounting and insertion stay under the same lock.

blk-mq can then use the sbitmap accounting helpers without changing
its waitqueue and dispatch lock ordering.

Assisted-by: LLM
Signed-off-by: Henry Hu <huhai@kylinos.cn>
---
 include/linux/sbitmap.h |  9 ++++++++-
 lib/sbitmap.c           | 23 +++++++++++++++++++----
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index cc7ad189caa5..ab8f34a97aa0 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -614,6 +614,13 @@ void sbitmap_prepare_to_wait(struct sbitmap_queue *sbq,
 void sbitmap_finish_wait(struct sbitmap_queue *sbq, struct sbq_wait_state *ws,
 				struct sbq_wait *sbq_wait);
 
+/*
+ * Like sbitmap_add_wait_queue(), but the caller must hold ws->wait.lock.
+ */
+void __sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
+			      struct sbq_wait_state *ws,
+			      struct sbq_wait *sbq_wait);
+
 /*
  * Wrapper around add_wait_queue(), which maintains some extra internal state
  */
@@ -622,7 +629,7 @@ void sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
 			    struct sbq_wait *sbq_wait);
 
 /*
- * Must be paired with sbitmap_add_wait_queue()
+ * Must be paired with sbitmap_add_wait_queue() or __sbitmap_add_wait_queue().
  */
 void sbitmap_del_wait_queue(struct sbq_wait *sbq_wait);
 
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 4d188d05db15..eb450c6bdaba 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -756,16 +756,31 @@ void sbitmap_queue_show(struct sbitmap_queue *sbq, struct seq_file *m)
 }
 EXPORT_SYMBOL_GPL(sbitmap_queue_show);
 
-void sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
-			    struct sbq_wait_state *ws,
-			    struct sbq_wait *sbq_wait)
+void __sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
+			      struct sbq_wait_state *ws,
+			      struct sbq_wait *sbq_wait)
 {
+	lockdep_assert_held(&ws->wait.lock);
+
 	if (!sbq_wait->sbq) {
 		sbq_wait->sbq = sbq;
 		atomic_inc(&sbq->ws_active);
-		add_wait_queue(&ws->wait, &sbq_wait->wait);
+		sbq_wait->wait.flags &= ~WQ_FLAG_EXCLUSIVE;
+		__add_wait_queue(&ws->wait, &sbq_wait->wait);
 	}
 }
+EXPORT_SYMBOL_GPL(__sbitmap_add_wait_queue);
+
+void sbitmap_add_wait_queue(struct sbitmap_queue *sbq,
+			    struct sbq_wait_state *ws,
+			    struct sbq_wait *sbq_wait)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ws->wait.lock, flags);
+	__sbitmap_add_wait_queue(sbq, ws, sbq_wait);
+	spin_unlock_irqrestore(&ws->wait.lock, flags);
+}
 EXPORT_SYMBOL_GPL(sbitmap_add_wait_queue);
 
 void sbitmap_del_wait_queue(struct sbq_wait *sbq_wait)
-- 
2.40.1

