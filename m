Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4690812
	for <linux-block@vger.kernel.org>; Wed, 15 May 2024 01:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736737; cv=none; b=kCcjreFoZUmWq1znerPyA8s0kZzWgO5iXfM1N1p+7NurW8lDmEuQ9Ubua40AipWsKYWjWQomtKsbx1ljqYZEk8Y9kExfv75lDrQlWtjlCaNFlCd3YQmlSl6wBiWwn9iLGcFsv5ETr1UeYa7Qj6n1/GO5bg3nGlo/ddcsOUz1Bcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736737; c=relaxed/simple;
	bh=WxWQHkAkQ3kTFrtbB5UblJOZr1EDWb/uQxr7e9PyLWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rq1xDKOINq5urQNCwYupYWU0UefLKqPMABq2hp2c1Sj/MY4QjEauQYxWysPNXWzHdAciwZTbu92H9NtLTPtWzM0De3c9TJoJevP4ieTsWNcTB6zW82u9jtLvSSz0gp3pNequFB8/xlPsxqBNLIB5diwnagZcYdOg4qtLhzum0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJ9hYDzG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJ9hYDzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715736734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGKoZkJUmWaaV+EKb29TxZkRunrslIu2yAMBC/QhwKY=;
	b=CJ9hYDzGBQg+W+CiuIWrbeXBv7rtNJJuc29SpiOxT80mY/BkQB92twjsFn+idWkl6H5L2w
	+5b9m7ugLr4o2CeVtMp9Q1ddrRIP5jM7RLgPjRhdKeyig/7cYrv+zYKq9QPgu19jv4yoVh
	bgQQyutcEAXfZ8kjpcsviDU4U7MZKxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-cyt22AuNP-mVz6SLQ8RVIA-1; Tue, 14 May 2024 21:32:12 -0400
X-MC-Unique: cyt22AuNP-mVz6SLQ8RVIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 393908008AD;
	Wed, 15 May 2024 01:32:12 +0000 (UTC)
Received: from localhost (unknown [10.72.112.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0AF701C0654B;
	Wed, 15 May 2024 01:32:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jay Shin <jaeshin@redhat.com>
Subject: [PATCH 1/2] blk-cgroup: fix list corruption from resetting io stat
Date: Wed, 15 May 2024 09:31:56 +0800
Message-ID: <20240515013157.443672-2-ming.lei@redhat.com>
In-Reply-To: <20240515013157.443672-1-ming.lei@redhat.com>
References: <20240515013157.443672-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Since commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
each iostat instance is added to blkcg percpu list, so blkcg_reset_stats()
can't reset the stat instance by memset(), otherwise the llist may be
corrupted.

Fix the issue by only resetting the counter part.

Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Jay Shin <jaeshin@redhat.com>
Fixes: 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 58 ++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 23 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 059467086b13..86752b1652b5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -619,12 +619,45 @@ static void blkg_destroy_all(struct gendisk *disk)
 	spin_unlock_irq(&q->queue_lock);
 }
 
+static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
+{
+	int i;
+
+	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
+		dst->bytes[i] = src->bytes[i];
+		dst->ios[i] = src->ios[i];
+	}
+}
+
+static void __blkg_clear_stat(struct blkg_iostat_set *bis)
+{
+	struct blkg_iostat cur = {0};
+	unsigned long flags;
+
+	flags = u64_stats_update_begin_irqsave(&bis->sync);
+	blkg_iostat_set(&bis->cur, &cur);
+	blkg_iostat_set(&bis->last, &cur);
+	u64_stats_update_end_irqrestore(&bis->sync, flags);
+}
+
+static void blkg_clear_stat(struct blkcg_gq *blkg)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct blkg_iostat_set *s = per_cpu_ptr(blkg->iostat_cpu, cpu);
+
+		__blkg_clear_stat(s);
+	}
+	__blkg_clear_stat(&blkg->iostat);
+}
+
 static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 			     struct cftype *cftype, u64 val)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
 	struct blkcg_gq *blkg;
-	int i, cpu;
+	int i;
 
 	mutex_lock(&blkcg_pol_mutex);
 	spin_lock_irq(&blkcg->lock);
@@ -635,18 +668,7 @@ static int blkcg_reset_stats(struct cgroup_subsys_state *css,
 	 * anyway.  If you get hit by a race, retry.
 	 */
 	hlist_for_each_entry(blkg, &blkcg->blkg_list, blkcg_node) {
-		for_each_possible_cpu(cpu) {
-			struct blkg_iostat_set *bis =
-				per_cpu_ptr(blkg->iostat_cpu, cpu);
-			memset(bis, 0, sizeof(*bis));
-
-			/* Re-initialize the cleared blkg_iostat_set */
-			u64_stats_init(&bis->sync);
-			bis->blkg = blkg;
-		}
-		memset(&blkg->iostat, 0, sizeof(blkg->iostat));
-		u64_stats_init(&blkg->iostat.sync);
-
+		blkg_clear_stat(blkg);
 		for (i = 0; i < BLKCG_MAX_POLS; i++) {
 			struct blkcg_policy *pol = blkcg_policy[i];
 
@@ -949,16 +971,6 @@ void blkg_conf_exit(struct blkg_conf_ctx *ctx)
 }
 EXPORT_SYMBOL_GPL(blkg_conf_exit);
 
-static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
-{
-	int i;
-
-	for (i = 0; i < BLKG_IOSTAT_NR; i++) {
-		dst->bytes[i] = src->bytes[i];
-		dst->ios[i] = src->ios[i];
-	}
-}
-
 static void blkg_iostat_add(struct blkg_iostat *dst, struct blkg_iostat *src)
 {
 	int i;
-- 
2.44.0

