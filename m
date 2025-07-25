Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DC6293B42;
	Fri, 25 Jul 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753427546; cv=none; b=neuVkJT0jfQkcxT1EM18rCzFatVgSj1DTEVv5u6rtGC6/HgsOXodQXNJoqvPo80Dv5QaXPohhnzqplhi0D3Ej7ooVZ82MXGFR+RlNPsvgRqCFM/PVYMKvsR+XqACcc77iK0mhCqEvqVXFZKk6WgSlCHwuVGMBtd6dQdZwG8xdX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753427546; c=relaxed/simple;
	bh=xM2fy3uV59FY935HHY8dOHWnpWoGdJCUddc/ecWB0FE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1Fw9Vv7UKBNp9kEw9I8idsnYtjG+D33GbQvJ1HSZn1IRG6UzQW5JfPZEcGhxMHo/qw/dOiGdsoW48sMz5t9OYxQiV7q5yQ4VUcyYDSnDvfieLImkgO91OoKk9njcaxRKZdoK11EH9DATkDSEDbOA8u8G4jZYc/UHNw7wRxjSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bpJwR5HwBzYQvBQ;
	Fri, 25 Jul 2025 15:12:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6DAD61A1043;
	Fri, 25 Jul 2025 15:12:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3QBFRLoNonnivBQ--.56345S5;
	Fri, 25 Jul 2025 15:12:22 +0800 (CST)
From: Yu Kuai <yukuai1@huaweicloud.com>
To: jack@suse.cz,
	dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yukuai3@huawei.com,
	yukuai1@huaweicloud.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	johnny.chenyi@huawei.com
Subject: [PATCH 1/3] blk-ioc: add a new helper ioc_lookup_icq_rcu()
Date: Fri, 25 Jul 2025 15:05:45 +0800
Message-Id: <20250725070547.3953398-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
References: <20250725070547.3953398-1-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3QBFRLoNonnivBQ--.56345S5
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw13Xr47Xw4fKFWxGFWrGrg_yoW8uw15pF
	WagFs0yr1jgr4xCrn3J3ZrZryfWay8ursrXa9avw4Ykr92krnavF10yryjqr1S9rs7JFs5
	Xr17tw4UCry09rJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUqkskUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

From: Yu Kuai <yukuai3@huawei.com>

ioc_lookup_icq() is used by bfq to lookup bfqq from IO path, the helper
have to be protected by queue_lock, which is too heavy. Hence add a new
helper that is lookless, this is safe because both request_queue and ioc
can be pinged by IO that is still issuing.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-ioc.c | 34 ++++++++++++++++++++++++++++++++++
 block/blk.h     |  1 +
 2 files changed, 35 insertions(+)

diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index ce82770c72ab..4945b48dfdb6 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -343,6 +343,40 @@ struct io_cq *ioc_lookup_icq(struct request_queue *q)
 }
 EXPORT_SYMBOL(ioc_lookup_icq);
 
+/**
+ * ioc_lookup_icq_rcu - lookup io_cq from ioc in io path
+ * @q: the associated request_queue
+ *
+ * Look up io_cq associated with @ioc - @q pair from @ioc. Must be called from
+ * io issue path, either return NULL if current issue io to @q for the first
+ * time, or return a valid icq.
+ */
+struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q)
+{
+	struct io_context *ioc = current->io_context;
+	struct io_cq *icq;
+
+	WARN_ON_ONCE(percpu_ref_is_zero(&q->q_usage_counter));
+
+	if (!ioc)
+		return NULL;
+
+	icq = rcu_dereference(ioc->icq_hint);
+	if (icq && icq->q == q)
+		return icq;
+
+	icq = radix_tree_lookup(&ioc->icq_tree, q->id);
+	if (!icq)
+		return NULL;
+
+	if (WARN_ON_ONCE(icq->q != q))
+		return NULL;
+
+	rcu_assign_pointer(ioc->icq_hint, icq);
+	return icq;
+}
+EXPORT_SYMBOL(ioc_lookup_icq_rcu);
+
 /**
  * ioc_create_icq - create and link io_cq
  * @q: request_queue of interest
diff --git a/block/blk.h b/block/blk.h
index 468aa83c5a22..ef31b3ec1c69 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -461,6 +461,7 @@ static inline void req_set_nomerge(struct request_queue *q, struct request *req)
  */
 struct io_cq *ioc_find_get_icq(struct request_queue *q);
 struct io_cq *ioc_lookup_icq(struct request_queue *q);
+struct io_cq *ioc_lookup_icq_rcu(struct request_queue *q);
 #ifdef CONFIG_BLK_ICQ
 void ioc_clear_queue(struct request_queue *q);
 #else
-- 
2.39.2

