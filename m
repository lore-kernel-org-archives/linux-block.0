Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45C21DE89C
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994289; cv=none; b=Dga8ITODNqRu/Cwt4/fQVsdkGBx/g0ouwqEhHRkj84gj7W3CEPzqRRlx+6efjDDe4nm+kmpSIJsc50PAHNCh3Iq5Sc9QESzr0eYzPgzufZ0apTfCP/sfEMQWOwZWhTJwo2Ivm7Lc9Xo0GOFHydH47hzqOXwtEpm98t2wWuNXGLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994289; c=relaxed/simple;
	bh=6SKK5aBSXbfRkzhvP5qt7ZtaTGJJzn+Dw2+Dcr167Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syXLnSmoYrEKq87QKdBYXMLZxWq4nJp3c0KqzjN1/1+6VtkrvXXwBXmmSD1dSpNj+swvizuSFwPylWwmd3cES4curpfUl1wsSqHh0FWzdhDQ/sIhUED4dzis8Jke3T7jjlwUFtj9X7gbM5/rsOH2ckHdnGpcVBZamHKZ5WW1g64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f+y6E6Jo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+y6E6Jo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3nP66ZCaEMu96ZZQXAyvu/3haWXm8Zj+oUfUrwYzjSM=;
	b=f+y6E6JoRYGJ5N6sfwBemMC0eHHUMq5e03PexJ9mUsmXw5flrZCnSu9w2ZLJbaxr8U2moQ
	Ph7V7y2s1I2qjbyNqsljj35LsER2UXJ7b98cWISvJSXjnkr0iAuPvRHFaSz6NHtOuqCScO
	XouwwJ/HJxQ9vxPT5b4ezp7m3ek7sKQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-oPGePI3VOl6Km5_cvNioWg-1; Fri,
 18 Apr 2025 12:38:04 -0400
X-MC-Unique: oPGePI3VOl6Km5_cvNioWg-1
X-Mimecast-MFC-AGG-ID: oPGePI3VOl6Km5_cvNioWg_1744994283
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 437B318001D5;
	Fri, 18 Apr 2025 16:38:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30B6719560B0;
	Fri, 18 Apr 2025 16:38:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 10/20] block: add helper of elevator_change()
Date: Sat, 19 Apr 2025 00:36:51 +0800
Message-ID: <20250418163708.442085-11-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add elevator_change() to simplify elv_iosched_store() a bit, and the new
helper will be used for unifying all scheduler change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 44 +++++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index f4c02a6c045d..6bf3871c7164 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -53,6 +53,8 @@ static LIST_HEAD(elv_list);
  */
 #define rq_hash_key(rq)		(blk_rq_pos(rq) + blk_rq_sectors(rq))
 
+static int elevator_change(struct request_queue *q, const char *name);
+
 /*
  * Query io scheduler to see if the current process issuing bio may be
  * merged with rq.
@@ -705,6 +707,28 @@ int __elevator_change(struct request_queue *q, const char *elevator_name,
 	return ret;
 }
 
+static int elevator_change(struct request_queue *q, const char *name)
+{
+	struct blk_mq_tag_set *set = q->tag_set;
+	unsigned int memflags;
+	int ret, idx;
+
+	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
+	if (set->updating_nr_hwq) {
+		ret = -EBUSY;
+		goto exit;
+	}
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+	ret = __elevator_change(q, name, false);
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
+exit:
+	srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
+	return ret;
+}
+
 static void elv_iosched_load_module(char *elevator_name)
 {
 	struct elevator_type *found;
@@ -720,12 +744,10 @@ static void elv_iosched_load_module(char *elevator_name)
 ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 			  size_t count)
 {
+	struct request_queue *q = disk->queue;
 	char elevator_name[ELV_NAME_MAX];
 	char *name;
-	int ret, idx;
-	unsigned int memflags;
-	struct request_queue *q = disk->queue;
-	struct blk_mq_tag_set *set = q->tag_set;
+	int ret;
 
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
@@ -737,21 +759,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 
 	elv_iosched_load_module(name);
 
-	idx = srcu_read_lock(&set->update_nr_hwq_srcu);
-	if (set->updating_nr_hwq) {
-		ret = -EBUSY;
-		goto exit;
-	}
-
-	memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->elevator_lock);
-	ret = __elevator_change(q, name, false);
+	ret = elevator_change(q, name);
 	if (!ret)
 		ret = count;
-	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
-exit:
-	srcu_read_unlock(&set->update_nr_hwq_srcu, idx);
 	return ret;
 }
 
-- 
2.47.0

