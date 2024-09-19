Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9D81E
	for <linux-block@vger.kernel.org>; Thu, 19 Sep 2024 02:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726712245; cv=none; b=nwZVlmiLoSfSz5XSqWdDCF/dHMlXGa20rWccVJ7YxDq/HeW5BUyXVjXxyI7TaYG3o92h57HykH1vlJRgpShGBJYU1JRmJgybZf4LSPquta02+zj1vMttqv1IyP4YmLIBJKf/pz6NRShHNoI/vbfzyV1UL70Nt34TkdndUy7+EgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726712245; c=relaxed/simple;
	bh=yPuD4+AD7VGYkag0Hpik78840FXcFwBwuFp6JXEwyXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4iFE3qyNraEAX/xFnCKDpXbnhuunfOEYg0ozI9jSHCE77PrEqDa6XVvMHG/kIIdtdBMBMhw9/KIcPi2NPd0VNeEPEcMFdFN4HbT4sST0SYmOPAJ6+YQSSblixALHU3fGKP4B3ammWUD+kk48fBTkfqPLIILNMJfZVaBS4IbbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D9KhlAND; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D9KhlAND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726712242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0nIFMYRz8Xd869YZEZIHDVvJ0r2zjey+HCjm1wlFVWI=;
	b=D9KhlANDycspT8rKjhqFVP4rF7vj1bJfOlxksn12IQR5qfrn7rwn6zHxFGybmd3wjcEx2V
	3eJW9MzA5IMjtBV5CzD1xDAKRJ50SLuwEDgM5z4vNCOwGam7s4tDdi3EYN4ZsqeTj6U9Fd
	JwoFDiTxxJoHaUXQyMOQNUPh8ocX9EY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-eAIl4L7qPgGkOZscAIfnNA-1; Wed,
 18 Sep 2024 22:17:19 -0400
X-MC-Unique: eAIl4L7qPgGkOZscAIfnNA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B01B91955F44;
	Thu, 19 Sep 2024 02:17:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.61])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B18D1955DC7;
	Thu, 19 Sep 2024 02:17:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yang Yang <yang.yang@vivo.com>
Subject: [PATCH] lib/sbitmap: define swap_lock as raw_spinlock_t
Date: Thu, 19 Sep 2024 10:17:09 +0800
Message-ID: <20240919021709.511329-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When called from sbitmap_queue_get(), sbitmap_deferred_clear() may be run
with preempt disabled. In RT kernel, spin_lock() can sleep, then warning
of "BUG: sleeping function called from invalid context" can be triggered.

Fix it by replacing it with raw_spin_lock.

Cc: Yang Yang <yang.yang@vivo.com>
Fixes: 72d04bdcf3f7 ("sbitmap: fix io hung due to race on sbitmap_word::cleared")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/sbitmap.h | 2 +-
 lib/sbitmap.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index c09cdcc99471..189140bf11fc 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -40,7 +40,7 @@ struct sbitmap_word {
 	/**
 	 * @swap_lock: serializes simultaneous updates of ->word and ->cleared
 	 */
-	spinlock_t swap_lock;
+	raw_spinlock_t swap_lock;
 } ____cacheline_aligned_in_smp;
 
 /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 5e2e93307f0d..d3412984170c 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -65,7 +65,7 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map,
 {
 	unsigned long mask, word_mask;
 
-	guard(spinlock_irqsave)(&map->swap_lock);
+	guard(raw_spinlock_irqsave)(&map->swap_lock);
 
 	if (!map->cleared) {
 		if (depth == 0)
@@ -136,7 +136,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 	}
 
 	for (i = 0; i < sb->map_nr; i++)
-		spin_lock_init(&sb->map[i].swap_lock);
+		raw_spin_lock_init(&sb->map[i].swap_lock);
 
 	return 0;
 }
-- 
2.46.0

