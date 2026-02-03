Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6CC3A4F44
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 14:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770127981; cv=none; b=GdAyKPnQL9jsfL2hUVws2I/ruu/qTcZ8s4z/NmO5g2lZUhDfhfRud6rjIrYF+Q+pZ5Mt+re6OFBWJWoL4F0ULSn3UOKEX/g/jDp6HAy9bchOBdo+AQ8Zq7YPpP3gZeP0qfrvHMHCv001d3vdnlinnezn7MGkeBriOz8+xVA7Yv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770127981; c=relaxed/simple;
	bh=7RlcyS573VQ5uGYzpZXgAvbLBtMc8WK66jeTo0p1dEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u4EZBQZ7BhJXsJ+F5mwkftTysurtzbr/aNh/elv8J2hVR9VIU7EvdCl2Xmy6jeCIp1euuRNLUst+l7U04ryxuzAwdlqhCL5zBd6ji+u/mcsNq+58vUIgt4IePmwA1fVDJiR8jMc/V/pQH9fQ9qmC+O84H2Y1hH5p+zq+3DrHu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nwishdt0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nwishdt0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770127979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sJEv2TlFY7kRX1pL8U9xnH/aTc0GZj1kkuKxt7AjSMU=;
	b=Nwishdt0oTkcQUPI0HnoLX13d4A33hx0kLZo3gfCCsY4oBSRkbKzyn2hUNa+QQrX7NmXVR
	FnAjiW+rnDdFQQebp/HwuMXrYSpKPk3dkJrQiPFt4Zgbnd2VLmTMn5mMGY2opRCXk/7N7v
	zgRxXIECQukYcp3ypxLXGl9mPL4j2iI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-u4WCP6f_MhaZa6cDpI8f3w-1; Tue,
 03 Feb 2026 09:12:55 -0500
X-MC-Unique: u4WCP6f_MhaZa6cDpI8f3w-1
X-Mimecast-MFC-AGG-ID: u4WCP6f_MhaZa6cDpI8f3w_1770127974
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5EC0180063F;
	Tue,  3 Feb 2026 14:12:54 +0000 (UTC)
Received: from localhost (unknown [10.72.116.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0377A18008FF;
	Tue,  3 Feb 2026 14:12:52 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org,
	Jay Shin <jaeshin@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Waiman Long <longman@redhat.com>,
	coregee2000@gmail.com
Subject: [PATCH] blk-cgroup: fix UAF in __blkcg_rstat_flush()
Date: Tue,  3 Feb 2026 22:12:39 +0800
Message-ID: <20260203141239.73274-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When multiple blkgs in the same blkcg are released concurrently,
a use-after-free can occur. The race happens when one blkg's
__blkcg_rstat_flush() removes another blkg's iostat entries via
llist_del_all(). The second blkg sees an empty list and proceeds
to free itself while the first is still iterating over its entries.

Fix by deferring blkg_free() via an additional call_rcu(). The second
RCU grace period ensures any concurrent flush holding rcu_read_lock()
has completed before the blkg memory is freed.

Cc: stable@vger.kernel.org
Cc: Jay Shin <jaeshin@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Fixes: 20cb1c2fb756 ("blk-cgroup: Flush stats before releasing blkcg_gq")
Reported-by: coregee2000@gmail.com
Closes: https://lore.kernel.org/linux-block/CAHPqNmwT9oRpem3J3erS_W0uSQND47LGGSBsNxP8E6uSUish1w@mail.gmail.com/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3cffb68ba5d8..dc0cccfdca68 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -160,6 +160,20 @@ static void blkg_free(struct blkcg_gq *blkg)
 	schedule_work(&blkg->free_work);
 }
 
+/*
+ * RCU callback to free blkg after an additional grace period.
+ * This ensures any concurrent __blkcg_rstat_flush() that might have
+ * removed our iostat entries via llist_del_all() has completed.
+ */
+static void __blkg_release_free_rcu(struct rcu_head *rcu)
+{
+	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
+
+	/* release the blkcg and parent blkg refs this blkg has been holding */
+	css_put(&blkg->blkcg->css);
+	blkg_free(blkg);
+}
+
 static void __blkg_release(struct rcu_head *rcu)
 {
 	struct blkcg_gq *blkg = container_of(rcu, struct blkcg_gq, rcu_head);
@@ -178,9 +192,14 @@ static void __blkg_release(struct rcu_head *rcu)
 	for_each_possible_cpu(cpu)
 		__blkcg_rstat_flush(blkcg, cpu);
 
-	/* release the blkcg and parent blkg refs this blkg has been holding */
-	css_put(&blkg->blkcg->css);
-	blkg_free(blkg);
+	/*
+	 * Defer freeing via another call_rcu() to ensure any concurrent
+	 * __blkcg_rstat_flush() (under rcu_read_lock) that might have removed
+	 * our iostat entries via llist_del_all() has completed its iteration.
+	 * The second grace period guarantees those RCU read-side critical
+	 * sections have finished.
+	 */
+	call_rcu(&blkg->rcu_head, __blkg_release_free_rcu);
 }
 
 /*
-- 
2.47.0

