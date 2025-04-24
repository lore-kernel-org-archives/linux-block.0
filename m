Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EBB1D5CC4
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508155; cv=none; b=SZD6QbPERKaDnlFdfQj0WnByXgEy8jIGjxUnHkMsnGbRYKkUC9o+gd6whErkNKFPOq1A662CGx6g/rbtiiWJOy0u4puuDrgT7QECS7bxP6zFaJviuhSWbAYgvReB6hBle4tpns0ZQHbhXx90ScvREwPqMfP7eIojfdKahCEMBsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508155; c=relaxed/simple;
	bh=kK1XX8afFstDjOweXfdt4/Qt4uEVjfo1Bzseeu6YUqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LA1p5KtPioyU+p54vjJsxK2jvCQEqBPGx0zChugCwfLcuiKXfIV03aTBuXoZ0lss+bGM5LSQdG1OYkvIlxf7WvuuJYHB+P8uIOm0y+3k1JyDDr2PsQSMwIKZfaKkVPNay9jQGuHtL9kqVrp6N2V1JmLMvghpNfwjIBRkvL1cYO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RzD8gSF3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RzD8gSF3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqMrSy9TY8HcskpDSSybrne68B3eopnHwRnf35cslwU=;
	b=RzD8gSF3y1v6suj/nobiWLi2y94ouewv3IYG1QEgCFnsrDbkr1yheLR71OiJo4V22bHZr2
	LNkiKTN8T+LSk5sRoIjDBpyYNlgfUaEGQZLtDGx/ojfrfhnULuSZuLWSFH8e7y4gSwyfkN
	adUAWEnB/mNIj62LHJoI8mAKU3GtjBY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-R5lI9mQHOZiHN7XuaS8YJA-1; Thu,
 24 Apr 2025 11:22:29 -0400
X-MC-Unique: R5lI9mQHOZiHN7XuaS8YJA-1
X-Mimecast-MFC-AGG-ID: R5lI9mQHOZiHN7XuaS8YJA_1745508147
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 48A701801A04;
	Thu, 24 Apr 2025 15:22:27 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4973719560AB;
	Thu, 24 Apr 2025 15:22:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 08/20] block: don't allow to switch elevator if updating nr_hw_queues is in-progress
Date: Thu, 24 Apr 2025 23:21:31 +0800
Message-ID: <20250424152148.1066220-9-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
path, so it can't be done if updating `nr_hw_queues` is in-progress.

Take same approach with not allowing add/del disk when updating
nr_hw_queues is in-progress, by grabbing read lock of
set->update_nr_hwq_sema.

Take the nested variant for avoiding the following false positive
splat[1], and this way is correct because:

- the read lock in elv_iosched_store() is not overlapped with the read lock
in adding/deleting disk:

- kobject attribute is only available after the kobject is added and
before it is deleted

  -> #4 (&q->q_usage_counter(queue){++++}-{0:0}:
  -> #3 (&q->limits_lock){+.+.}-{4:4}:
  -> #2 (&disk->open_mutex){+.+.}-{4:4}:
  -> #1 (&set->update_nr_hwq_lock){.+.+}-{4:4}:
  -> #0 (kn->active#103){++++}-{0:0}:

Link: https://lore.kernel.org/linux-block/aAWv3NPtNIKKvJZc@fedora/ [1]
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 4400eb8fe54f..56da6ab7691a 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -723,6 +723,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	int ret;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
@@ -734,6 +735,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
+	down_read_nested(&set->update_nr_hwq_sema, 1);
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
@@ -741,6 +743,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+	up_read(&set->update_nr_hwq_sema);
 	return ret;
 }
 
-- 
2.47.0

