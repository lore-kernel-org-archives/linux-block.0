Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AC71CDA2E
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508167; cv=none; b=oRTDBMD1xrq5aXHaIGRlVoBAN48bUQUfWGYdDxmQl+Nck0q15qjOrFGAHZUFC7RXhGPgNjsszo+HBFdlUB8xRf8h6lbthYhxA0aIdt7vs9f2XYGm0SZ2+6Z9johL65h/WRB4s1qPq2y2bXEkFZElcQO4B2HknQnQY3HrDtB7ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508167; c=relaxed/simple;
	bh=86OKoiLCJZj7r8Eq2NNMUllCzqEppTIK+EufeTTFHqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJx1T6+Znp0NnpikjBRnv+7tUG/E41Se6/9GVBoS8y2NK/bOaxZNpvd/kCLwWk2szX50uUyCHsV0DbtoR2TfRx1TLNPPwjm2PMAm6j1HtvvrP421j43HVLvoEHWOwef/b9XxHUJnGjabNWOsNhnQ25p4hqxFBZyodekfNANv26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4pf0xPb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4pf0xPb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745508164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeHA4ntIeTQ8xH1vHyamrX0hSQcslm4cYy9keyEoeQ8=;
	b=I4pf0xPbS8YUMvV9Q66fkudZ7vcfFM5aIsTHoEb24mIHJ7IL3ug8ajxP+ZYWiBnZEFO+lq
	THrsIBpbzD5KXX2DgCxVzaUya79Nw+hkCthuKXw2YxsQcY6DtgqoJiUtxktqlgsket1ifT
	TGEeevb/+KsW79xZ2rLhehYr4bsmnTQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-148-Pq8necgEPVyFkOD8Urr4Zw-1; Thu,
 24 Apr 2025 11:22:40 -0400
X-MC-Unique: Pq8necgEPVyFkOD8Urr4Zw-1
X-Mimecast-MFC-AGG-ID: Pq8necgEPVyFkOD8Urr4Zw_1745508159
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A899195608C;
	Thu, 24 Apr 2025 15:22:39 +0000 (UTC)
Received: from localhost (unknown [10.72.116.90])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8960B18001DA;
	Thu, 24 Apr 2025 15:22:37 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 11/20] block: move queue freezing & elevator_lock into elevator_change()
Date: Thu, 24 Apr 2025 23:21:34 +0800
Message-ID: <20250424152148.1066220-12-ming.lei@redhat.com>
In-Reply-To: <20250424152148.1066220-1-ming.lei@redhat.com>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
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

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 5705f7056516..e70cd4b828a5 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -683,6 +683,8 @@ static int __elevator_change(struct request_queue *q,
 	struct elevator_type *e;
 	int ret;
 
+	lockdep_assert_held(&q->tag_set->update_nr_hwq_sema);
+
 	/* Make sure queue is not in the middle of being removed */
 	if (!blk_queue_registered(q))
 		return -ENOENT;
@@ -703,9 +705,16 @@ static int __elevator_change(struct request_queue *q,
 
 static int elevator_change(struct request_queue *q, const char *elevator_name)
 {
+	unsigned int memflags;
+	int ret = 0;
+
+	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->elevator_lock);
 	if (!q->elevator || !elevator_match(q->elevator->type, elevator_name))
-		return __elevator_change(q, elevator_name);
-	return 0;
+		ret = __elevator_change(q, elevator_name);
+	mutex_unlock(&q->elevator_lock);
+	blk_mq_unfreeze_queue(q, memflags);
+	return ret;
 }
 
 /*
@@ -741,7 +750,6 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	char elevator_name[ELV_NAME_MAX];
 	char *name;
 	int ret;
-	unsigned int memflags;
 	struct request_queue *q = disk->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
 
@@ -756,13 +764,9 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	elv_iosched_load_module(name);
 
 	down_read_nested(&set->update_nr_hwq_sema, 1);
-	memflags = blk_mq_freeze_queue(q);
-	mutex_lock(&q->elevator_lock);
 	ret = elevator_change(q, name);
 	if (!ret)
 		ret = count;
-	mutex_unlock(&q->elevator_lock);
-	blk_mq_unfreeze_queue(q, memflags);
 	up_read(&set->update_nr_hwq_sema);
 	return ret;
 }
-- 
2.47.0

