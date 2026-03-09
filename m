Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C74C3803ED
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050964; cv=none; b=uSQERS8YbRzymEe5nEGN5N6nmWEuhnMg3hHcooyT/+ccS24Mh1M0aNWtwFR870MkjlXE6ngIij6IigkPIyPDdJhIofdiME6VEscflm9shc7Pu6KwVudceu41ZdMuQewTM/riqvLhcMZGfmQnj6MSKjMYR/3Bp9yPpgMUWOFJIns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050964; c=relaxed/simple;
	bh=MA9sQnLiuZy6KGmGqechv31+qSKWZ7oeqFzcXKsqNSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoWzQ7HVueYP9HKwJf1EBs1MOqyO4Vd6E8BX1rga48i4QrR0UxamTJRLf7IiyVH1RaTr1ucbkbPQ5Ejp43dSumnV0OfR3p0Z0yvvWXAqs7Vx6FhIzeP28DF7fScx+XcjVJUrGiUq6UEX4Kk3AS6ltxUDhEY5x0vJoifUD5ehKRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dh15NXTH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dh15NXTH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773050960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=US86VN5kkobsatL1Dlg/ylYmZj1+gOU0IJcJn5oPtlU=;
	b=dh15NXTHHUJTkv6BjevtipdsTw7WZjyY1x0h0aq4JkjoINVxIu43t74DKTrPShZmGMpSfo
	81lMjgcwuC4Rvo/TJtb+rWZjQdE8bhXsSEyfqqM/9D8Rcq3LBzanamRilyMfi0frpPCWLF
	E8m97pxs2EYYw3mz3+rIk8rAXpbuyBI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-7yOgQ4J2Mey5ITtsVg_1nw-1; Mon,
 09 Mar 2026 06:09:17 -0400
X-MC-Unique: 7yOgQ4J2Mey5ITtsVg_1nw-1
X-Mimecast-MFC-AGG-ID: 7yOgQ4J2Mey5ITtsVg_1nw_1773050957
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9EB7C1956054;
	Mon,  9 Mar 2026 10:09:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 69BF518001FE;
	Mon,  9 Mar 2026 10:09:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] blk-cgroup: wait for blkcg cleanup before initializing new disk
Date: Mon,  9 Mar 2026 18:09:06 +0800
Message-ID: <20260309100906.1740351-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When a queue is shared across disk rebind (e.g., SCSI unbind/bind), the
previous disk's blkcg state is cleaned up asynchronously via
disk_release() -> blkcg_exit_disk(). If the new disk's blkcg_init_disk()
runs before that cleanup finishes, we may overwrite q->root_blkg while
the old one is still alive, and radix_tree_insert() in blkg_create()
fails with -EEXIST because the old blkg entries still occupy the same
queue id slot in blkcg->blkg_tree. This causes the sd probe to fail
with -ENOMEM.

Fix it by waiting in blkcg_init_disk() for root_blkg to become NULL,
which indicates the previous disk's blkcg cleanup has completed.

Fixes: 1059699f87eb ("block: move blkcg initialization/destroy into disk allocation/release handler")
Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b70096497d38..7aa2ed7f7c82 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1498,6 +1498,27 @@ int blkcg_init_disk(struct gendisk *disk)
 	struct blkcg_gq *new_blkg, *blkg;
 	bool preloaded;
 
+	/*
+	 * If the queue is shared across disk rebind (e.g., SCSI), the
+	 * previous disk's blkcg state is cleaned up asynchronously via
+	 * disk_release() -> blkcg_exit_disk(). Wait for that cleanup to
+	 * finish (indicated by root_blkg becoming NULL) before setting up
+	 * new blkcg state. Otherwise, we may overwrite q->root_blkg while
+	 * the old one is still alive, and radix_tree_insert() in
+	 * blkg_create() will fail with -EEXIST because the old entries
+	 * still occupy the same queue id slot in blkcg->blkg_tree.
+	 */
+	if (READ_ONCE(q->root_blkg)) {
+		/* 20s is a random timeout, disk_release() should be done well before */
+		unsigned long end = jiffies + msecs_to_jiffies(20000);
+
+		while (READ_ONCE(q->root_blkg) &&
+				time_before(jiffies, end))
+			msleep(1);
+		if (READ_ONCE(q->root_blkg))
+			return -EEXIST;
+	}
+
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
-- 
2.47.1

