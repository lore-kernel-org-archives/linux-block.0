Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AD6AD3
	for <linux-block@vger.kernel.org>; Wed, 30 Apr 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745987832; cv=none; b=I7ewKauBr4Pgzq9l0GJcaiSWylx/DGT69jaxWCBK7Jy0OA9JlNhB9HXudGSE+gkRaV6A+1Ck8JZ+j2HUGhQYRoR6kKUHiiCynNQiHchzut94zZJIRTQjt7mvWd7B1gpAF10mH6IuBVCCr7k5CJxmpywGlQMriPP3ozrU+f9PqzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745987832; c=relaxed/simple;
	bh=TjBgdbY++2bkeKskR/zFcnFXqhEj6AFupv9i4a/SD7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSGN5KZIHPaBctCF89iE/6x5m7LJSFpoQdmczuRac30Nb4RgFtaF+1nXtZ0BmuS5clhwyNzqrl0fHmd//xbt7a0rNC7pKlf4cWxLaB0x4p8LBUs4+T1dhqz7yLSwNuL4rfe17AzIvivlYDPS0zY7sELt3KL3P3S00njtG2CnIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hzHRfXel; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hzHRfXel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745987828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40yytb+NP1vorF660QLeEVBiL5o0et5Ghkf2MddsF64=;
	b=hzHRfXelxlb5C2etXu8gBWEBUhZMRKAt96DFfaZtFi/Voz697XiYM9B/rxJV2Jz1pnd47l
	LinuAXejkCJrvzR7gBT5MkcZLy2R8NTkSctIWOCrce7hkbe+xX4syCWF+zoW+wPuMBsh9s
	wyfUlNXE9fopjOo4nNrgaD/eQDLNy54=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-UAQggM-mMi2_QunIzvGzMQ-1; Wed,
 30 Apr 2025 00:37:04 -0400
X-MC-Unique: UAQggM-mMi2_QunIzvGzMQ-1
X-Mimecast-MFC-AGG-ID: UAQggM-mMi2_QunIzvGzMQ_1745987823
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8A3C1955DC5;
	Wed, 30 Apr 2025 04:37:02 +0000 (UTC)
Received: from localhost (unknown [10.72.116.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB80219560A3;
	Wed, 30 Apr 2025 04:37:01 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 23/24] block: move hctx cpuhp add/del out of queue freezing
Date: Wed, 30 Apr 2025 12:35:25 +0800
Message-ID: <20250430043529.1950194-24-ming.lei@redhat.com>
In-Reply-To: <20250430043529.1950194-1-ming.lei@redhat.com>
References: <20250430043529.1950194-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Move hctx cpuhp add/del out of queue freezing for not connecting freeze
lock with cpuhp locks, then lockdep warning can be avoided.

This way is safe because both needn't queue to be frozen and scheduler
switch isn't allowed, with same reason for moving hctx debugfs/sysfs
register out of queue freeze.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4e6bc065c955..682d75f0a0a4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4964,7 +4964,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		__blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
@@ -4988,6 +4988,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
 		blk_mq_debugfs_register_hctxs(q);
+
+		blk_mq_remove_hw_queues_cpuhp(q);
+		blk_mq_add_hw_queues_cpuhp(q);
 	}
 	memalloc_noio_restore(memflags);
 
-- 
2.47.0

