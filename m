Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0C1336891
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 03:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772680562; cv=none; b=Qe22WbkmdxQmPc40rD0JI9Zb2avfldtmuoXn4BYawP6tpxd1n+LglS7lJOPQAYNPPhcDyn+6vtG4EqioRzK/Xwy6wCV0YdI0vKolnsNmh64LKT89ZTe4tyLFyiITkucvHf+zyuyR38cySqms+a43AOKNWw0a4jAlGa2ivgeGQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772680562; c=relaxed/simple;
	bh=vAhicCKhBFw0D2Kuk4YGlaniN4JY6h/zejKvfcbU5xA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEjjvCRx5isP7T+fCy2InMxGrXamz5O2a4Y1c/f7By+Cu0QQe2GSkEX1gfJCejELZR8f9I//MLJfqmK6Wf/HV7pWHY8JDmuaDR5DxiIg1wUJOIEpAcoh1AsE3+Rd1LAE7NoWt626zRRS/nEQK0sdNjg0hIMnrl/ujmTW+s6FqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWK2OrZP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWK2OrZP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772680559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rFmRtIPqOym4NhQBlz7+C6Sd8qOkc+VdN9kY9jG2U0I=;
	b=AWK2OrZP7edvneGCjkTN5pBhaGifohtRprr+Mvx8bYSrczBta1saXDlNXPCeqTCmDRjzVl
	peWuc6BMQCi9LU+kC0bg0bplTH7/nwmTR9XUtWll/U5xSfQ2rsjoDi2uLwBoWApVyrmK/C
	QajIIWdOju4/DcKBnH+tffTepf0VDAQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-bil9oxLsNzOzVnbb_IDSkw-1; Wed,
 04 Mar 2026 22:15:58 -0500
X-MC-Unique: bil9oxLsNzOzVnbb_IDSkw-1
X-Mimecast-MFC-AGG-ID: bil9oxLsNzOzVnbb_IDSkw_1772680557
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 577ED1956059;
	Thu,  5 Mar 2026 03:15:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 084601958DC5;
	Thu,  5 Mar 2026 03:15:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] block: use trylock to avoid lockdep circular dependency in sysfs
Date: Thu,  5 Mar 2026 11:15:50 +0800
Message-ID: <20260305031550.1161328-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Use trylock instead of blocking lock acquisition for update_nr_hwq_lock
in queue_requests_store() and elv_iosched_store() to avoid circular lock
dependency with kernfs active reference during concurrent disk deletion:

  update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
  kn->active -> update_nr_hwq_lock (via sysfs write path)

Return -EBUSY when the lock is not immediately available.

Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAHj4cs-em-4acsHabMdT=jJhXkCzjnprD-aQH1OgrZo4nTnmMw@mail.gmail.com/
Fixes: 626ff4f8ebcb ("blk-mq: convert to serialize updating nr_requests with update_nr_hwq_lock")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c |  8 +++++++-
 block/elevator.c  | 12 +++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index f3b1968c80ce..55a1bbfef7d4 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -78,8 +78,14 @@ queue_requests_store(struct gendisk *disk, const char *page, size_t count)
 	/*
 	 * Serialize updating nr_requests with concurrent queue_requests_store()
 	 * and switching elevator.
+	 *
+	 * Use trylock to avoid circular lock dependency with kernfs active
+	 * reference during concurrent disk deletion:
+	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
+	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
 	 */
-	down_write(&set->update_nr_hwq_lock);
+	if (!down_write_trylock(&set->update_nr_hwq_lock))
+		return -EBUSY;
 
 	if (nr == q->nr_requests)
 		goto unlock;
diff --git a/block/elevator.c b/block/elevator.c
index ebe2a1fcf011..3bcd37c2aa34 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -807,7 +807,16 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	elv_iosched_load_module(ctx.name);
 	ctx.type = elevator_find_get(ctx.name);
 
-	down_read(&set->update_nr_hwq_lock);
+	/*
+	 * Use trylock to avoid circular lock dependency with kernfs active
+	 * reference during concurrent disk deletion:
+	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
+	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
+	 */
+	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
+		ret = -EBUSY;
+		goto out;
+	}
 	if (!blk_queue_no_elv_switch(q)) {
 		ret = elevator_change(q, &ctx);
 		if (!ret)
@@ -817,6 +826,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	}
 	up_read(&set->update_nr_hwq_lock);
 
+out:
 	if (ctx.type)
 		elevator_put(ctx.type);
 	return ret;
-- 
2.47.0

