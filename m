Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF7E25D208
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746454754; cv=none; b=KyhMXuZyQ+6byLoPVHamuc85Sb+S/QL8HzKKSYnhM9YR385hyhztz038ldY/YdSY/I6xiyHu5L/Gd9BB87DVNgyuN5QA+EdOv055aXRM0JWkFPrZSnM/EbCfE19Ew3bS5RuX5yRZXkMIDT2ptecpb7hzlThWL8u2V4ata6ljHOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746454754; c=relaxed/simple;
	bh=ClI5HMpd7OQ5d7+l8zo+GUVYvhi4GwmS7pYWVEhEyBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lw+JTl/QBsyOCRuptX0xLJOeHhpBB9XUNUGyq+ymGWmWNKEgqUX+Htc8OEjkQez12Ew0dg8U/XyDamlMBWsXtb6g2ESftMsrUSOSijsThRdh6e5dbn+4bNUrVYJu8cgmVpAmzqPg2ZtZxO01B8Ar/ceDtmOSt7FF0SbwvqYP6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=drJ7ScdV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drJ7ScdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746454751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2n4Xhxf2eOUDZ2IqkvrE/azr4UYv8t06QVt26oHINk=;
	b=drJ7ScdV+/Qpu3YHc8o0fGOyXccqceoe4NuaTeSSlsi0e4ggp5T2HDu/VCWMPWCK3DjHkM
	2xgFp56DqAyzddqtpCQjUYLsC92kb8jyJy82TwLnYJX0mTyzk7lm6gTJZpBupNhLZeU7lf
	vyJ50tby1yasu5SER/QcJZDFERnRinA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-cfGqq0bbNAqnTINCGq7JfA-1; Mon,
 05 May 2025 10:19:09 -0400
X-MC-Unique: cfGqq0bbNAqnTINCGq7JfA-1
X-Mimecast-MFC-AGG-ID: cfGqq0bbNAqnTINCGq7JfA_1746454748
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 688A71800879;
	Mon,  5 May 2025 14:19:08 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CA39195608D;
	Mon,  5 May 2025 14:19:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V5 12/25] block: move blk_queue_registered() check into elv_iosched_store()
Date: Mon,  5 May 2025 22:17:50 +0800
Message-ID: <20250505141805.2751237-13-ming.lei@redhat.com>
In-Reply-To: <20250505141805.2751237-1-ming.lei@redhat.com>
References: <20250505141805.2751237-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move blk_queue_registered() check into elv_iosched_store() and prepare
for using elevator_change() for covering any kind of elevator change in
adding/deleting disk and updating nr_hw_queue.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 766deaf34214..4e58379c4d88 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -676,10 +676,6 @@ int elevator_switch(struct request_queue *q, const char *name)
  */
 static int elevator_change(struct request_queue *q, const char *elevator_name)
 {
-	/* Make sure queue is not in the middle of being removed */
-	if (!blk_queue_registered(q))
-		return -ENOENT;
-
 	if (q->elevator && elevator_match(q->elevator->type, elevator_name))
 		return 0;
 
@@ -708,6 +704,10 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	struct request_queue *q = disk->queue;
 	struct blk_mq_tag_set *set = q->tag_set;
 
+	/* Make sure queue is not in the middle of being removed */
+	if (!blk_queue_registered(q))
+		return -ENOENT;
+
 	/*
 	 * If the attribute needs to load a module, do it before freezing the
 	 * queue to ensure that the module file can be read when the request
-- 
2.47.0

