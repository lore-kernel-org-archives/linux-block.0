Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0225A2C6
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454765; cv=none; b=Kk0yGZb0ns0zelSUpXruOUFp6JFoVCei99V89qpOqu/rRe6jDuFMPI7s7Re47uLJnBTItfUGp78qfduNEfLMywiq2loOk5DUUWp9Bvij9gqoCyD5PYuhjLr2npIPO2QkAX3KjWueGFj/w4cM9iPV54MqiXQy74vbZj/6lCmzZQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454765; c=relaxed/simple;
	bh=b5bTqQqijKeEAUTzKh+5Ux36eXFKqtL3XBMync1SMo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecvZWTAWinsm7oYKQfr8XczLYbEYk05pSqwjExzAicN2KozC08G7iX9/deICll71adJb353kIGBqk0oik95iXiXvPa53QIBCpqfoumcfypviURgyUN5/AQ4MXrjlJSQM1vcVLETBIbUKeLrXi2UdpIEykEfp+JhwbffwqTh1vp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwMvFalv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwMvFalv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ud2W0R57Jl6Fjckb9b7z3gLpqccVR23YC5ycD36srcs=;
	b=LwMvFalvAYH/c9tFjOxE7SYFWBUJE00kZrFL5OqIFmd2dPkpWRBuWmW1CtYoKa0+kt2nES
	p/1V5hF9ebXoTogkJP7mNvz4xqRhiiAPumeJnz/fIzk6uWzwms88JVDBG5w0hNA02gWotz
	9/DZ7eI7fIClEh8ihiopffPgVQjFIoQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-BH7Kynx7PgWXT1tdxdJdcA-1; Mon,
 05 May 2025 10:19:18 -0400
X-MC-Unique: BH7Kynx7PgWXT1tdxdJdcA-1
X-Mimecast-MFC-AGG-ID: BH7Kynx7PgWXT1tdxdJdcA_1746454756
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB80E195608A;
	Mon,  5 May 2025 14:19:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB6051954B00;
	Mon,  5 May 2025 14:19:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 14/25] block: move queue freezing & elevator_lock into elevator_change()
Date: Mon,  5 May 2025 22:17:52 +0800
Message-ID: <20250505141805.2751237-15-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
index cabd7a8bb76c..cb54a3791fe5 100644
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
 
 	down_read(&set->update_nr_hwq_lock);
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

