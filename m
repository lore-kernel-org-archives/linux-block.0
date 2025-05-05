Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADFB25C81B
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454788; cv=none; b=kUPl51qUk1szwvMOjpaVWot4ZiSrP6+1HOSYDl+WJdO/1qTSvSZh+2uJ3nn8kZvD/HeD7OuovcNw9i+oy04OO3R6F3WaiMNrIsu4GVB5m+J5iXkhF6ix3j144GwhLAn0oFRbj6/FNtC76bkAwWwZ67idm3+cBIpz+Mla5HBz0Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454788; c=relaxed/simple;
	bh=IGs04UvATNuBAJuFizoJQfAc0xX9lp5Y/0Ug89JC3wU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQy03mMIzZu00hloz5nv3Xb5bwUREvCetf8fszAj07zWfYjn/IHqQ2TuTLlJd53GlIZbbh3ATN5//KpbGbUT8GL6uurJSUXNK53tYPxyuy8x9GHSJUnIzmLH3DgL5uMrjX3ozlYYdexzFwU5bGd8qdUjqbvggWMnad8sc+vEqY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tx4XnrEA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tx4XnrEA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uRy5xSmw4syu2ujBaQzF9jM67xMbkKmGFhtYAVb5eR8=;
	b=Tx4XnrEAuXDRSGYN3mw7D8MSf3Ks9NQsiy6CACAuui9C7uaWhiGP5U7XiMfxlhRYU/o9Jb
	Z4jaCmtGzWaDgindxuCC1mGghuihhAahBqwq4h/EthYENDOWxJwPMEqtOUyJ85GXaKF4WF
	T3CfKKRKjJOuyR0hfWLYxSCc+6Uu91U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-SX2eUqkeP5u-8GDVswuGGw-1; Mon,
 05 May 2025 10:19:42 -0400
X-MC-Unique: SX2eUqkeP5u-8GDVswuGGw-1
X-Mimecast-MFC-AGG-ID: SX2eUqkeP5u-8GDVswuGGw_1746454780
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EFB4180087B;
	Mon,  5 May 2025 14:19:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 736B61956094;
	Mon,  5 May 2025 14:19:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 20/25] block: add new helper for disabling elevator switch when deleting disk
Date: Mon,  5 May 2025 22:17:58 +0800
Message-ID: <20250505141805.2751237-21-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add new helper disable_elv_switch() and new flag QUEUE_FLAG_NO_ELV_SWITCH
for disabling elevator switch before deleting disk:

- originally flag QUEUE_FLAG_REGISTERED is added for preventing elevator
switch during removing disk, but this flag has been used widely for
other purposes, so add one new flag for disabling elevator switch only

- for avoiding deadlock risk, we have to move elevator queue
register/unregister out of elevator lock and queue freeze, which will be
done in next patch. However, this way adds small race window between elevator
switch and deleting ->queue_kobj, in which elevator queue register/unregister
could be run concurrently. The added helper will be used for avoiding the race
in the following patch.

- drain in-progress elevator switch before deleting disk

Suggested-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c |  1 +
 block/elevator.c       | 13 ++++++++++---
 block/genhd.c          | 13 +++++++++++++
 include/linux/blkdev.h |  3 +++
 4 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 2837a8ce8054..29b3540dd180 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -94,6 +94,7 @@ static const char *const blk_queue_flag_name[] = {
 	QUEUE_FLAG_NAME(HCTX_ACTIVE),
 	QUEUE_FLAG_NAME(SQ_SCHED),
 	QUEUE_FLAG_NAME(DISABLE_WBT_DEF),
+	QUEUE_FLAG_NAME(NO_ELV_SWITCH),
 };
 #undef QUEUE_FLAG_NAME
 
diff --git a/block/elevator.c b/block/elevator.c
index 2edaf84900fc..f7e333abefe3 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -680,6 +680,9 @@ void elevator_set_default(struct request_queue *q)
 	};
 	int err = 0;
 
+	/* now we allow to switch elevator */
+	blk_queue_flag_clear(QUEUE_FLAG_NO_ELV_SWITCH, q);
+
 	if (q->tag_set->flags & BLK_MQ_F_NO_SCHED_BY_DEFAULT)
 		return;
 
@@ -744,9 +747,13 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	elv_iosched_load_module(ctx.name);
 
 	down_read(&set->update_nr_hwq_lock);
-	ret = elevator_change(q, &ctx);
-	if (!ret)
-		ret = count;
+	if (!blk_queue_no_elv_switch(q)) {
+		ret = elevator_change(q, &ctx);
+		if (!ret)
+			ret = count;
+	} else {
+		ret = -ENOENT;
+	}
 	up_read(&set->update_nr_hwq_lock);
 	return ret;
 }
diff --git a/block/genhd.c b/block/genhd.c
index f192fe4808b9..a8cb5607b6e3 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -764,6 +764,16 @@ static void __del_gendisk(struct gendisk *disk)
 		blk_unfreeze_release_lock(q);
 }
 
+static void disable_elv_switch(struct request_queue *q)
+{
+	struct blk_mq_tag_set *set = q->tag_set;
+	WARN_ON_ONCE(!queue_is_mq(q));
+
+	down_write(&set->update_nr_hwq_lock);
+	blk_queue_flag_set(QUEUE_FLAG_NO_ELV_SWITCH, q);
+	up_write(&set->update_nr_hwq_lock);
+}
+
 /**
  * del_gendisk - remove the gendisk
  * @disk: the struct gendisk to remove
@@ -792,6 +802,9 @@ void del_gendisk(struct gendisk *disk)
 		__del_gendisk(disk);
 	} else {
 		set = disk->queue->tag_set;
+
+		disable_elv_switch(disk->queue);
+
 		memflags = memalloc_noio_save();
 		down_read(&set->update_nr_hwq_lock);
 		__del_gendisk(disk);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9c373cf0eb47..b15c53fabe9f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -645,6 +645,7 @@ enum {
 	QUEUE_FLAG_HCTX_ACTIVE,		/* at least one blk-mq hctx is active */
 	QUEUE_FLAG_SQ_SCHED,		/* single queue style io dispatch */
 	QUEUE_FLAG_DISABLE_WBT_DEF,	/* for sched to disable/enable wbt */
+	QUEUE_FLAG_NO_ELV_SWITCH,	/* can't switch elevator any more */
 	QUEUE_FLAG_MAX
 };
 
@@ -682,6 +683,8 @@ void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 	((q)->limits.features & BLK_FEAT_SKIP_TAGSET_QUIESCE)
 #define blk_queue_disable_wbt(q)	\
 	test_bit(QUEUE_FLAG_DISABLE_WBT_DEF, &(q)->queue_flags)
+#define blk_queue_no_elv_switch(q)	\
+	test_bit(QUEUE_FLAG_NO_ELV_SWITCH, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.47.0

