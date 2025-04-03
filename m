Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23014386D
	for <linux-block@vger.kernel.org>; Thu,  3 Apr 2025 02:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648763; cv=none; b=tUaQDLHnMsJC72y1QPijAG0VfnWRXpio5SFCRp0HhwJKJB7MVT/18usb8k+ft6++0TOnQJ7S+rd2sxfh9r5LMSoeuw8oRGM/3ZuNhzz1vinOggUMoZ2xhUMy4MbM5leL9yH2WKN5imvMI8wXSQ1D+p44VC7GJCkeshrF77Uq5sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648763; c=relaxed/simple;
	bh=7kFPsGoqQJqtRgP0ebdKl5qV7o20HrX7DUZVTE065eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddV6k4XTQyMKX52z3MnwxvJXsIRiOXxsjEcdEk4LiENmGMsH+fgc/I8PpzTfG7PLBntHnQzv48FEtIHgQblJY/4nusqd0/LP1I0kBOaxlMuex7LaAj8ZhW1wve97mzWBPA8Wd7UbKlpaM+cQU+sr5OoDRjcfSo5BzX1pn7dbtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FYy9exZi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FYy9exZi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743648759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FPyEkPcG5PRfgB6QpGzJWfaGNEOg44VgpkOHRQ4eXUs=;
	b=FYy9exZin/siKm9iP7vvF7aofRev3g7YyeIZDRDhctgwaOE/5M61Z7i2G2vZpA5s500cEC
	TdTnRA1RpbdTjNmGJRXYcM0ZAhyytky7onV1WkN7tp3ATcG5IHsoN04BypVDOlotabdldx
	DygMfWUDb5YoQfrIIUbqN1FAiB5Lyic=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-vr_gf6M8OVKIm3IkBj3NUw-1; Wed,
 02 Apr 2025 22:52:35 -0400
X-MC-Unique: vr_gf6M8OVKIm3IkBj3NUw-1
X-Mimecast-MFC-AGG-ID: vr_gf6M8OVKIm3IkBj3NUw_1743648754
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 872411955DC6;
	Thu,  3 Apr 2025 02:52:34 +0000 (UTC)
Received: from localhost (unknown [10.72.120.26])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 487951955BC2;
	Thu,  3 Apr 2025 02:52:32 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/3] block: don't call freeze queue in elevator_switch() and elevator_disable()
Date: Thu,  3 Apr 2025 10:52:09 +0800
Message-ID: <20250403025214.1274650-3-ming.lei@redhat.com>
In-Reply-To: <20250403025214.1274650-1-ming.lei@redhat.com>
References: <20250403025214.1274650-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Both elevator_switch() and elevator_disable() are called from sysfs
store and updating nr_hw_queue code paths only.

And in the two code paths, queue has been frozen already, so don't call
freeze queue in the two functions.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index b4d08026b02c..4d3a8f996c91 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -615,12 +615,10 @@ void elevator_init_mq(struct request_queue *q)
  */
 int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 {
-	unsigned int memflags;
 	int ret;
 
 	lockdep_assert_held(&q->elevator_lock);
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	if (q->elevator) {
@@ -641,7 +639,6 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 out_unfreeze:
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 
 	if (ret) {
 		pr_warn("elv: switch to \"%s\" failed, falling back to \"none\"\n",
@@ -653,11 +650,8 @@ int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 void elevator_disable(struct request_queue *q)
 {
-	unsigned int memflags;
-
 	lockdep_assert_held(&q->elevator_lock);
 
-	memflags = blk_mq_freeze_queue(q);
 	blk_mq_quiesce_queue(q);
 
 	elv_unregister_queue(q);
@@ -668,7 +662,6 @@ void elevator_disable(struct request_queue *q)
 	blk_add_trace_msg(q, "elv switch: none");
 
 	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q, memflags);
 }
 
 /*
-- 
2.47.0

