Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C152505D6
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454716; cv=none; b=V+pfJzdBR60HnZVElEbguzQkShZFSfc1UYIy7XQeqfMvzx8lQwCDjKqVa1ct5opMwTM5fabYwhGe/+E5ubAadCUT/K6/klo9dwC0NEDQQ7oaLqpZDF/PwE+TeQKjq8iTxia618jVZqterHlx9cc6Md7PuOHOKd7cNP9nYE3ChHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454716; c=relaxed/simple;
	bh=LsfXwNqRpDQAyLzNaTANepclIeFuC9WRBct8a93kfw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWyWFPCeYGgIOJshMo16NL4xkbqqdinVFXarZ9z4UrET+50eIvnaSY3kNrLMf55q2d3ec8iI01HAKrsQJfXoQgi5rPQqNDqemIVY1QG9zGleJKW7Z7B2oNV98Ohw9TfrKYbHddUmpobdpCKtjDT0zFDd8w6Lbw16dTInmeDeafQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MVrjNBuB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MVrjNBuB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4dyz5GBTte5X+YCwXlGFtXtVmY2gcRgIvBXwoOgTjgQ=;
	b=MVrjNBuBA6H90wojzI8/E4KkIKbGe956N+zlZomQMVXfjyR328yeTCX5dyyymb9LKEZQTR
	OPonRjOOZ5i5EBjJiI0hprF/Vc11j+OcLgZMhiosuMxeaq+kb6jUF87cwQjsCG71y4V7S1
	JeIMYIUV7CwidhYNLmtROqWB4YWqSIk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-rklQlfjMP3imhw0HlhzFfw-1; Mon,
 05 May 2025 10:18:28 -0400
X-MC-Unique: rklQlfjMP3imhw0HlhzFfw-1
X-Mimecast-MFC-AGG-ID: rklQlfjMP3imhw0HlhzFfw_1746454706
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7780C1800988;
	Mon,  5 May 2025 14:18:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4B7F719560AB;
	Mon,  5 May 2025 14:18:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 03/25] block: don't call freeze queue in elevator_switch() and elevator_disable()
Date: Mon,  5 May 2025 22:17:41 +0800
Message-ID: <20250505141805.2751237-4-ming.lei@redhat.com>
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

Both elevator_switch() and elevator_disable() are only called from the
two code paths, in which queue is guaranteed to be frozen.

So don't call freeze queue in the two functions, also add asserts for
queue freeze.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index b4d08026b02c..5051a98dc08c 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -615,12 +615,11 @@ void elevator_init_mq(struct request_queue *q)
  */
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
-	unsigned int memflags;
 	int ret;
 
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
@@ -641,7 +640,6 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
 	if (ret) {
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
@@ -653,11 +651,9 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 void elevator_disable(struct request_queue *q)
 {
-	unsigned int memflags;
-
+	WARN_ON_ONCE(q->mq_freeze_depth == 0);
 	lockdep_assert_held(&q->elevator_lock);
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	elv_unregister_queue(q);
@@ -668,7 +664,6 @@ void elevator_disable(struct request_queue *q)
 	blk_add_trace_msg(q, "elv switch: none");
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 }
 
 /*
-- 
2.47.0

