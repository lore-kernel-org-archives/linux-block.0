Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9C126BF7
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994284; cv=none; b=oEm/pf6Ttr4Pqg7Jrp1XctgssosvxpzAf930PLOC0k4b7YqpE7eF2NVwPFg3t7lAhbiNcCp1SVvb5BF2VktwdsnIY5GYAlvpyfoAr7IHAgQKFPSC3DXz3rUqAspFOEMTZf7DFl0TgcZQKht2MQmLJYi4XZncsJBtM0vqGhs4e1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994284; c=relaxed/simple;
	bh=g+vSBE1jqlmkdWoGiLfGIghNskj57xHTkyKHBmaSMbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyVjuARZMiR2cxsIxLTLsSJsJizzRRaUzDcKh+eo4Ooa3HPTk5UwqDphH77FhFoarv+I9GkeXQhgf3AMiKZaUu48y5hBFpkJ8s15qYRipD6BAC+y1YMBzH2QhhYLg18wtvBN878RMC3IjhV9yX45pbYD77PO4NldIodqWuDEwx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgfxmTu5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgfxmTu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RMsfzF7/g8xKSRVD3q2SeMGZCslRdjBJW3uL/AAP3jk=;
	b=hgfxmTu5xi51fgy4QoywOE5BevnEZYA6vUz2JjfTgLd/cKfgFtXXe88c9YPpZnYcmz3xS1
	KdcBKMzPf0/njiQA/xlbFauKIMV8ciuB/e7tgkrRtB8GGWeM6rVf66dJv45QNqy8eaFJNA
	WL8YNMM5WUbei9/TzCGtSTowxg5KN1g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-190-M_79VWycP7ySPduEoWm8ow-1; Fri,
 18 Apr 2025 12:37:56 -0400
X-MC-Unique: M_79VWycP7ySPduEoWm8ow-1
X-Mimecast-MFC-AGG-ID: M_79VWycP7ySPduEoWm8ow_1744994275
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 49518180036E;
	Fri, 18 Apr 2025 16:37:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 225761800362;
	Fri, 18 Apr 2025 16:37:53 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 08/20] block: don't allow to switch elevator if updating nr_hw_queues is in-progress
Date: Sat, 19 Apr 2025 00:36:49 +0800
Message-ID: <20250418163708.442085-9-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Elevator switch code is another `nr_hw_queue` reader in non-fast-IO code
path, so it can't be done if updating `nr_hw_queues` is in-progress.

Take same approach with not allowing add/del disk when updating
nr_hw_queues is in-progress, by holding srcu lock & check
set->updating_nr_hwq.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/mz4t4tlwiqjijw3zvqnjb7ovvvaegkqganegmmlc567tt5xj67@xal5ro544cnc/
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index d25b9cc6c509..c23912652f96 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -720,9 +720,10 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 {
 	char elevator_name[ELV_NAME_MAX];
 	char *name;
-	int ret;
+	int ret, idx;
 	unsigned int memflags;
 	struct request_queue *q = disk->queue;
+	struct blk_mq_tag_set *set = q->tag_set;
 
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
@@ -734,6 +735,12 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
+	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
+	if (set->updating_nr_hwq) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
 	memflags = blk_mq_freeze_queue(q);
 	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
@@ -741,6 +748,8 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 		ret = count;
 	mutex_unlock(&q->elevator_lock);
 	blk_mq_unfreeze_queue(q, memflags);
+exit:
+	srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
 	return ret;
 }
 
-- 
2.47.0

