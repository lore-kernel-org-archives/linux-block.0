Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3DE1FF7B4
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746619466; cv=none; b=budjM6YYsTi0M22OYgxyIao7rwWZHw+kxI22WEoU66l0Pl4mcKqcI3y/wDNBwgzYdgf8aco8swGv0/uSc7b+G/oxkU5GGyl6jFhg6pbhzIgvTutDIW3uwFE9LrEo1RRBbKs7lvHamdolABBTW4YtN5AOq3FXK8sjevB0stk46Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746619466; c=relaxed/simple;
	bh=RHV6DwAF3cBIS3Qj8g4BfW6t4rgbyAyMlxQuDgPEF6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eW4Xqtt/UVw4MZVJj7zE3VzWABcfdZGXivxx+txDISZMIknzRyXdWnc23i/GFf3th8nFrKXxFV3fqemhs624kEYXjkI/OTnYccw+lsra3dxdfRSjW+OaVTHts88Z2GprNAQ2NEitmIjCuCWCV6kOBz+Tt1btBo+X2QLlgY6bvro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JGK1fMs3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JGK1fMs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746619463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+mVFQXK6zEkidtBLklwr0Aa8nWQaiOitQfPvErp+9cw=;
	b=JGK1fMs3ksjoVrxZWO7GK4me8bEy2jlIMFEhIDLKxIxKNYW4gTaYKC6P+yIWTmgHGBzCJj
	hR93kGZNo6chTd2Pz7q3qE3A2vHdSubDmG3i0ICp9C89x+7GcfbM/IlkRkOAM0g3T+/8Hj
	XSB3fwWLNaVC/d63xVTjz8UUqAzMTnk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-IEuLtno4NiSDAeVgRq1_2w-1; Wed,
 07 May 2025 08:04:20 -0400
X-MC-Unique: IEuLtno4NiSDAeVgRq1_2w-1
X-Mimecast-MFC-AGG-ID: IEuLtno4NiSDAeVgRq1_2w_1746619459
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4153B1956046;
	Wed,  7 May 2025 12:04:19 +0000 (UTC)
Received: from localhost (unknown [10.72.116.52])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C2A61953B80;
	Wed,  7 May 2025 12:04:17 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] block: move queue quiesce into elevator_change()
Date: Wed,  7 May 2025 20:04:02 +0800
Message-ID: <20250507120406.3028670-2-ming.lei@redhat.com>
In-Reply-To: <20250507120406.3028670-1-ming.lei@redhat.com>
References: <20250507120406.3028670-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

blk_mq_freeze_queue() can't be called on quiesced queue, otherwise it may
never return if there is any queued requests.

Fix it by moving queue quiesce int elevator_change() by adding one flag to
'struct elv_change_ctx' for controlling this behavior.

Fixes: 1e44bedbc921 ("block: unifying elevator change")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 5 +----
 block/elevator.c  | 9 +++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 386374ff655b..8be2390c3c19 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -948,11 +948,8 @@ void blk_unregister_queue(struct gendisk *disk)
 		blk_mq_sysfs_unregister(disk);
 	blk_crypto_sysfs_unregister(disk);
 
-	if (queue_is_mq(q)) {
-		blk_mq_quiesce_queue(q);
+	if (queue_is_mq(q))
 		elevator_set_none(q);
-		blk_mq_unquiesce_queue(q);
-	}
 
 	mutex_lock(&q->sysfs_lock);
 	disk_unregister_independent_access_ranges(disk);
diff --git a/block/elevator.c b/block/elevator.c
index f8d72bd20610..e1386b84a415 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -49,6 +49,7 @@
 struct elv_change_ctx {
 	const char *name;
 	bool no_uevent;
+	bool quiesce_queue;
 
 	/* for unregistering old elevator */
 	struct elevator_queue *old;
@@ -658,12 +659,17 @@ static int elevator_change_done(struct request_queue *q,
  */
 static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 {
+	bool quiesce_queue = ctx->quiesce_queue;
 	unsigned int memflags;
 	int ret = 0;
 
 	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
 
+	WARN_ON_ONCE(blk_queue_quiesced(q));
+
 	memflags = blk_mq_freeze_queue(q);
+	if (quiesce_queue)
+		blk_mq_quiesce_queue(q);
 	/*
 	 * May be called before adding disk, when there isn't any FS I/O,
 	 * so freezing queue plus canceling dispatch work is enough to
@@ -678,6 +684,8 @@ static int elevator_change(struct request_queue *q, struct elv_change_ctx *ctx)
 	if (!(q->elevator && elevator_match(q->elevator->type, ctx->name)))
 		ret = elevator_switch(q, ctx);
 	mutex_unlock(&q->elevator_lock);
+	if (quiesce_queue)
+		blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
 	if (!ret)
 		ret = elevator_change_done(q, ctx);
@@ -744,6 +752,7 @@ void elevator_set_none(struct request_queue *q)
 {
 	struct elv_change_ctx ctx = {
 		.name	= "none",
+		.quiesce_queue = true,
 	};
 	int err;
 
-- 
2.47.0

