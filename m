Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630171E8856
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292200; cv=none; b=K1VfTFsWoMh1TpqjIApw9cR9OI/RVs/g5C1Hp7Lol/2pSoVggP7Q5A1wOVqoYArc+sUQyVyIV/rsYpdPotYDrZ2LDT1nmhwN+EJquXS3u3NZb1ty+QWJcTTMbOCKD+7qTCZou/8Fpd21+DVKhgN43qqri534v3n2XXO2uHG+B0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292200; c=relaxed/simple;
	bh=xopeGar8I6d2qbQvKK+7htZZJ0sxX1mU9VTKipdNz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgEkVwghl+YPlAuFsEJ4oN4h2y0kClzRbBHhc66JIqIycJlq3LLS25gOTboGrD6O2g1OtY6tDgcYP8/xCYhInV1CUHx2RBBW2yu1BpUtHvzozQlbD6ssKiQuZdIK5nouAU7b8HT12abTyTaUD1vKUFQDAAVHF4uwJHzNgRbqKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H6MK+rNG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6MK+rNG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730292197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yGypw63MlEWNsiDIekauJsXlP0auZsXeVrPz767tCm0=;
	b=H6MK+rNGFoRDHmpy0K+rOrWL9vyds3KzmajmocIimwE5KNUtep/NugH+tZMdF2iHZu5lz1
	dXUyAjTBrwiDhIHENlCriU2Csk/16plfcX5bCffpCyKLqsQ1pML+vCw7fgMd2tepbXjzjI
	W7YrzrQ3v8x3V+I9MViAlsSEa4G/j7M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-8Zn2BNm6O7ac-zYHdYOVNw-1; Wed,
 30 Oct 2024 08:43:14 -0400
X-MC-Unique: 8Zn2BNm6O7ac-zYHdYOVNw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A804E1955BC1;
	Wed, 30 Oct 2024 12:43:12 +0000 (UTC)
Received: from localhost (unknown [10.72.116.140])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29ACF300018D;
	Wed, 30 Oct 2024 12:43:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Yi <yi1.lai@linux.intel.com>
Subject: [PATCH 5/5] block: don't verify IO lock for freeze/unfreeze in elevator_init_mq()
Date: Wed, 30 Oct 2024 20:42:37 +0800
Message-ID: <20241030124240.230610-6-ming.lei@redhat.com>
In-Reply-To: <20241030124240.230610-1-ming.lei@redhat.com>
References: <20241030124240.230610-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

elevator_init_mq() is only called at the entry of add_disk_fwnode() when
disk IO isn't allowed yet.

So not verify io lock(q->io_lockdep_map) for freeze & unfreeze in
elevator_init_mq().

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Lai Yi <yi1.lai@linux.intel.com>
Fixes: f1be1788a32e ("block: model freeze & enter queue as lock for supporting lockdep")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index f169f4bae917..a02bf911d3ca 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -598,13 +598,17 @@ void elevator_init_mq(struct request_queue *q)
 	 * drain any dispatch activities originated from passthrough
 	 * requests, then no need to quiesce queue which may add long boot
 	 * latency, especially when lots of disks are involved.
+	 *
+	 * Disk isn't added yet, so verifying queue lock only manually.
 	 */
-	blk_mq_freeze_queue(q);
+	blk_mq_freeze_queue_non_owner(q);
+	blk_freeze_acquire_lock(q, true, false);
 	blk_mq_cancel_work_sync(q);
 
 	err = blk_mq_init_sched(q, e);
 
-	blk_mq_unfreeze_queue(q);
+	blk_unfreeze_release_lock(q, true, false);
+	blk_mq_unfreeze_queue_non_owner(q);
 
 	if (err) {
 		pr_warn("\"%s\" elevator initialization failed, "
-- 
2.47.0

