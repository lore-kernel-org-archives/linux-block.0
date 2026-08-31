Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C503C1F57
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 11:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174492; cv=none; b=rNRv+Ayb+AlUODqTVumo/sEWAlVJT1iD6fgJ5652pJcrBh8g8a36Soyp7dAhfxFQochHtUfrY3qVpwmA18VMoR8fO8/QXrrczaTfN8f9xhR5uWxdTUuc44iW4k3E0rEpUsHnn3kjqYLK+s/kaoHu9vTXejMQWFmdMSjO++uCchc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174492; c=relaxed/simple;
	bh=4krpdLYFAbC346LuGw9aJD8BVybv/Ef/3kCwbzK1CH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTU4Bdw6hHaObipv7eiYWJBCsQK5WAIOaCu+G9kb+QqL6LqPmaARwIgpx7+dUGVSlQv96n7s4h9jupqTQfVJN12vw89lwUGoVrDU/I5uBQC5IJKlmKzQV2jf/c8Q56vfUvSPsp8H+Q5moRaBNc0gbIFXuhtIAZZl6CsGdy+R3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hYR5r168tzKHMlh
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:07:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C659F41963
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:08:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBHMAuPYJVqZo_vAA--.44034S5;
	Mon, 31 Aug 2026 19:08:00 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH v2 1/4] block/mq-deadline: reject zero prio_aging_expire
Date: Mon, 31 Aug 2026 19:01:41 +0800
Message-Id: <20260831110144.2648156-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260831110144.2648156-1-yebin@huaweicloud.com>
References: <20260831110144.2648156-1-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHMAuPYJVqZo_vAA--.44034S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJFy3Cw48tw4UAw45Wr4rZrb_yoW5ZF4xpF
	W7X3Z8tr10g3W7XryfKr13tr1Sg397J347KrykAws7CFn5urWqvFyFkF90vF93Jr9rCw4a
	qr4vgFykGr98JFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Jrv_JF4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU14CJJUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/

From: Ye Bin <yebin10@huawei.com>

A prio_aging_expire of zero does not disable I/O priority in
mq-deadline.  Instead the priority aging path in
dd_dispatch_prio_aged_requests() is invoked with "now - 0 == now",
which causes best-effort and idle requests to be dispatched ahead of
pending real-time requests -- a classic priority inversion, not the
"priority disabled" behavior users may expect when writing zero.

Reject zero (and negative) values in the sysfs store with -EINVAL so
that a misconfiguration is reported rather than silently accepted.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/mq-deadline.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 5f643c0ce2a8..a4358625cfc8 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -31,7 +31,10 @@ static const int read_expire = HZ / 2;  /* max time before a read is submitted.
 static const int write_expire = 5 * HZ; /* ditto for writes, these limits are SOFT! */
 /*
  * Time after which to dispatch lower priority requests even if higher
- * priority requests are pending.
+ * priority requests are pending.  Must be > 0: a value of zero would make
+ * the priority aging path dispatch best-effort and idle requests ahead of
+ * pending real-time requests through "now - 0 == now", a classic priority
+ * inversion.
  */
 static const int prio_aging_expire = 10 * HZ;
 static const int writes_starved = 2;    /* max times reads can starve a write */
@@ -770,7 +773,6 @@ static ssize_t __FUNC(struct elevator_queue *e, const char *page, size_t count)
 	STORE_FUNCTION(__FUNC, __PTR, MIN, MAX, msecs_to_jiffies)
 STORE_JIFFIES(deadline_read_expire_store, &dd->fifo_expire[DD_READ], 0, INT_MAX);
 STORE_JIFFIES(deadline_write_expire_store, &dd->fifo_expire[DD_WRITE], 0, INT_MAX);
-STORE_JIFFIES(deadline_prio_aging_expire_store, &dd->prio_aging_expire, 0, INT_MAX);
 STORE_INT(deadline_writes_starved_store, &dd->writes_starved, INT_MIN, INT_MAX);
 STORE_INT(deadline_front_merges_store, &dd->front_merges, 0, 1);
 STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
@@ -778,6 +780,28 @@ STORE_INT(deadline_fifo_batch_store, &dd->fifo_batch, 0, INT_MAX);
 #undef STORE_INT
 #undef STORE_JIFFIES
 
+/*
+ * prio_aging_expire must be positive: a value of zero would make the
+ * priority aging path dispatch best-effort and idle requests ahead of
+ * pending real-time requests through "now - 0 == now", a classic priority
+ * inversion.  Reject zero and negative values instead of clamping, so that
+ * a misconfiguration is reported rather than silently accepted.
+ */
+static ssize_t deadline_prio_aging_expire_store(struct elevator_queue *e,
+						 const char *page, size_t count)
+{
+	struct deadline_data *dd = e->elevator_data;
+	int val, ret;
+
+	ret = kstrtoint(page, 0, &val);
+	if (ret < 0)
+		return ret;
+	if (val <= 0)
+		return -EINVAL;
+	dd->prio_aging_expire = msecs_to_jiffies(val);
+	return count;
+}
+
 #define DD_ATTR(name) \
 	__ATTR(name, 0644, deadline_##name##_show, deadline_##name##_store)
 
-- 
2.34.1

