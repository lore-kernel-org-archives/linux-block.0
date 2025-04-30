Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B7210FB
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987796; cv=none; b=nQf+FB9Jk3NwVRZsde9VNjLMnGvsOqz/zZ66+i9d7F4i5juNcm0GjE8yoPzIEYONoiap6Hxc5fo9EvVRDJvkSK7S3SSMnEHSZhX43AtK2nJtsEjxDmEXLNrs2C7xrJct5Ry+cJxCcUJvEKzXnSZWYHYq/52Sd5KPxnKsRQAK2Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987796; c=relaxed/simple;
	bh=ea29uL+XlcCQUkhX1Ht5TXKy+Chtqw/fZZdjgzzapwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jL2fv+GPAJNU9rEOy4dBoboUcmk/OqSSaFD0v3P9F9VUngjZZwctGsmZTJCHNf7h/d9GtC/bEtmV4ReX1R4sy+gY8f0vPm8RXf9smlVTGPbo5S3yaNy+DudcCRouP+gVaSO+tBlgbQqqH6w0Zrr4slF3UKy3Vduv5nwzKKTJy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b9VKTUMa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9VKTUMa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKQGHX1XUtyaB/hW7dg6IsmzJJG8CsUq2174gXjiW8U=;
	b=b9VKTUMaSHAnRiYqqllqGlbW5ooeAdxjmkBA3104C8rYs6F2kfvTPZVgMZvDjKzZrtgHIN
	G2bhYJRKhArG1biqnHad/MN5s4PR+umK6o70+m7p6Pg4CWgrYHVV4CSkyRQmvgZLMO/Tmo
	p0AtuFe7vR1vxQTO5euDrgfAlTH1Bso=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-jw_SaIMqMBK-spt5aAcImw-1; Wed,
 30 Apr 2025 00:36:27 -0400
X-MC-Unique: jw_SaIMqMBK-spt5aAcImw-1
X-Mimecast-MFC-AGG-ID: jw_SaIMqMBK-spt5aAcImw_1745987786
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E7761956094;
	Wed, 30 Apr 2025 04:36:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58DB418001DA;
	Wed, 30 Apr 2025 04:36:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 13/24] block: move queue freezing & elevator_lock into elevator_change()
Date: Wed, 30 Apr 2025 12:35:15 +0800
Message-ID: <20250430043529.1950194-14-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Move queue freezing & elevator_lock into elevator_change(), and prepare
for using elevator_change() for setting up & tearing down default elevator
too.

Also add lockdep_assert_held() in __elevator_change() because either
read or write lock is required for changing elevator.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index d7c9e1d2f305..df1f5451fc5e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -676,10 +676,19 @@ static int elevator_switch(struct request_queue *q, const char *name)
  */
 static int elevator_change(struct request_queue *q, const char *elevator_name)
 {
-	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
-		return 0;
+	unsigned int memflags;
+	int ret = 0;
 
-	return elevator_switch(q, elevator_name);
+	lockdep_assert_held(&q->tag_set->update_nr_hwq_lock);
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
+	if (!(q->elevator && elevator_match(q->elevator->type,
+				elevator_name)))
+		ret = elevator_switch(q, elevator_name);
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
+	return ret;
 }
 
 /*
@@ -718,7 +727,6 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	char elevator_name[ELV_NAME_MAX];
 	char *name;
 	int ret;
-	unsigned int memflags;
 	struct request_queue *q = disk->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
 
@@ -737,13 +745,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	elv_iosched_load_module(name);
 
 	down_read_nested(&set->update_nr_hwq_lock, 1);
-	memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
 	if (!ret)
 		ret = count;
-	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
 	up_read(&set->update_nr_hwq_lock);
 	return ret;
 }
-- 
2.47.0

