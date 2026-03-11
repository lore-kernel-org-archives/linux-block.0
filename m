Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA892E7F3A
	for <linux-block@vger.kernel.org>; Wed, 11 Mar 2026 03:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199731; cv=none; b=DcpNEzJZUh4anAP+CR888MbN7MMP56DShU9/Y+X5Ly6MX+3dB3JSTG+e0RM3huMRrCGwtKw28O7G23W80m9tfN+MwmphjcFH3b/2eR9uVjdB082O6zwVb6psXoZbKJOqpDREZQOyYYXxHegzb5UaWWC8lKV8/tPlHfbDr2yvL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199731; c=relaxed/simple;
	bh=CBc2kzp2cLiyBDAsoHFZwjStsCOSoAkqKV8eLimN+Bs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBxK0waB1OPHPjMT4YNp2lWNsx958WyWjYKFYD7a8Lj9Ll+VtEQ4LxSAwN9a6cG574KlS2ndoZD/U0Ol2cWKOB89QNb0lBaLJLCNm9uY3S7RyqteLfjOf9ZUQShkuJH84fBipRrEU9h/VgQ+LlxJvw7Cp2DHa1OrF5Pwb2VNGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UzY9oOAV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UzY9oOAV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773199728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BkXLClQUU8w0wnskhp4GdaxiVv8TlkTxcou152kjx2o=;
	b=UzY9oOAVY9e/FtZdf14V9oosRVQiTWxrhi39gbbMvj4tgp/jWTXTFPKb7+GejUWyaciHaS
	KLKtbVbgrOJG01CiNYrZI48YFpluiqcxZML68siv84g+uYRcWzn4FplYzVPRTm3eANRG4m
	1Z3MzKhsUQibqRGa0tNCFkltzZWA50M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-UyjycRUJPJSHaTDfLbOHqQ-1; Tue,
 10 Mar 2026 23:28:46 -0400
X-MC-Unique: UyjycRUJPJSHaTDfLbOHqQ-1
X-Mimecast-MFC-AGG-ID: UyjycRUJPJSHaTDfLbOHqQ_1773199725
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1473180034E;
	Wed, 11 Mar 2026 03:28:45 +0000 (UTC)
Received: from localhost (unknown [10.72.116.147])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D0541800576;
	Wed, 11 Mar 2026 03:28:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH V2] blk-cgroup: wait for blkcg cleanup before initializing new disk
Date: Wed, 11 Mar 2026 11:28:37 +0800
Message-ID: <20260311032837.2368714-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- take wake_up_var()/wait_var_event(), suggested by Christoph

 block/blk-cgroup.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index b70096497d38..2d7b18eb7291 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -24,6 +24,7 @@
 #include <linux/backing-dev.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/wait_bit.h>
 #include <linux/atomic.h>
 #include <linux/ctype.h>
 #include <linux/resume_user_mode.h>
@@ -611,6 +612,8 @@ static void blkg_destroy_all(struct gendisk *disk)
 
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
+
+	wake_up_var(&q->root_blkg);
 }
 
 static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
@@ -1498,6 +1501,18 @@ int blkcg_init_disk(struct gendisk *disk)
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
+	wait_var_event(&q->root_blkg, !READ_ONCE(q->root_blkg));
+
 	new_blkg = blkg_alloc(&blkcg_root, disk, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
-- 
2.47.1

