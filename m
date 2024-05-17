Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8314E4C6B
	for <linux-block@vger.kernel.org>; Fri, 17 May 2024 02:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715911529; cv=none; b=mvkD/nmKSycZPeV09drT+WmIqevV26Rc2cnzcqp1IArDcvE/MM0oNilokuz3OD8b2BsVVzdPfVDUCNEwOtHjjLzhGJg8HO79JXdCCh10urRnmWIduF8a2t9DNSifwAxu8xuqvU+Bu941X7Jz92uRPKQLcOg6xZV20xwxA1Xuyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715911529; c=relaxed/simple;
	bh=ZejH+4HmL8pciSfKJRmw5Je4mOVgauL/761alxRVwHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p1FsNj6mhklawzsdxhA4qnugrUdNb+BwvHEY7prxBK1XBylnhJzamFP2/he514tobOZv2woudWk/f/KPfnV/cIT685qHbYiIOP06X5UchJH2cUHwRWIyAUjsO4fDbT8erWc67Yagshd7/yomNpsZqZRZVDIhDYU42gLtEu43q14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYbH0i8w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYbH0i8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715911525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EBkl2QvjID6I1wof475xlkmA4EWOG/rp7T+62G2aYfQ=;
	b=GYbH0i8w292YQGWEi29tCzvrvEcvvZEq64p9XnfuXzC88R8k7IP8pVZwCkzzUqGQDXV+zH
	flOGL89n4bhJSk6JBS/80WKiHM1r++Pxrz8t4WUSHTjldxs/pufbs6++ME/qRhD/cqNOlB
	ZQEUcqkwTHt4EhakeqOqeEG9FzfSrJg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-RdDDk9UGP7iSJim_IFYSPg-1; Thu,
 16 May 2024 22:05:22 -0400
X-MC-Unique: RdDDk9UGP7iSJim_IFYSPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0252E1C3F0E2;
	Fri, 17 May 2024 02:05:22 +0000 (UTC)
Received: from localhost (unknown [10.72.112.58])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0DCA21C0654B;
	Fri, 17 May 2024 02:05:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Raju Cheerla <rcheerla@redhat.com>
Subject: [PATCH] blk-mq: add helper for checking if one CPU is mapped to specified hctx
Date: Fri, 17 May 2024 10:05:14 +0800
Message-ID: <20240517020514.149771-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Commit a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
rules out isolated CPUs from hctx->cpumask, and hctx->cpumask should only be
used for scheduling kworker.

Add helper blk_mq_cpu_mapped_to_hctx() and apply it into cpuhp handlers.

This patch avoids to forget clearing INACTIVE of hctx state in case that one
isolated CPU becomes online, and fixes hang issue when allocating request
from this hctx's tags.

Cc: Raju Cheerla <rcheerla@redhat.com>
Fixes: a46c27026da1 ("blk-mq: don't schedule block kworker on isolated CPUs")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---

Will add one blktest to cover this kind of issue.

 block/blk-mq.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8e01e4b32e10..579921a2f1c6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3545,12 +3545,28 @@ static int blk_mq_hctx_notify_offline(unsigned int cpu, struct hlist_node *node)
 	return 0;
 }
 
+/*
+ * Check if one CPU is mapped to the specified hctx
+ *
+ * Isolated CPUs have been ruled out from hctx->cpumask, which is supposed
+ * to be used for scheduling kworker only. For other usage, please call this
+ * helper for checking if one CPU belongs to the specified hctx
+ */
+static bool blk_mq_cpu_mapped_to_hctx(unsigned int cpu,
+		const struct blk_mq_hw_ctx *hctx)
+{
+	struct blk_mq_hw_ctx *mapped_hctx = blk_mq_map_queue_type(hctx->queue,
+			hctx->type, cpu);
+
+	return mapped_hctx == hctx;
+}
+
 static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node *node)
 {
 	struct blk_mq_hw_ctx *hctx = hlist_entry_safe(node,
 			struct blk_mq_hw_ctx, cpuhp_online);
 
-	if (cpumask_test_cpu(cpu, hctx->cpumask))
+	if (blk_mq_cpu_mapped_to_hctx(cpu, hctx))
 		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 	return 0;
 }
@@ -3568,7 +3584,7 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *node)
 	enum hctx_type type;
 
 	hctx = hlist_entry_safe(node, struct blk_mq_hw_ctx, cpuhp_dead);
-	if (!cpumask_test_cpu(cpu, hctx->cpumask))
+	if (!blk_mq_cpu_mapped_to_hctx(cpu, hctx))
 		return 0;
 
 	ctx = __blk_mq_get_ctx(hctx->queue, cpu);
-- 
2.44.0

