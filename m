Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B81221727
	for <linux-block@vger.kernel.org>; Fri, 18 Apr 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744994327; cv=none; b=lB2PtlKtbh1zqWvlK0S5fF+5wi810w3mpyAP1zfsnqZYpoiE/sMloAheZH0v3UNjHBJkEDi+z0xdAZgBvMoIkPOCB9FrIIAsLyyGIZxA85txXdL5lixb4c8xl2hxAcNr7KoZ0VVZn2oG1tzVs0O/mxgppqS5iorZuUD+hmE2bdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744994327; c=relaxed/simple;
	bh=MtThmghw1w3kNZsCcx2xm97LOf7++KfeDdtlvfyijRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X6GRFq0QXBqG+u/d/qBPFSnWR4aVXfnnSymddUTjnQZckr36xPpx6/B7K6Pa2/BwYhwh7u5wdoKXW/P5cE8b3JHT/1ORFT07pzjaTiDPTYyAI+bNyUIbWuqBmvKHjchpyv2Jpq0mFEMO53Dg1eIC/VD0nW/idpCVcrJwLkbnfzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AdPnQqvC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AdPnQqvC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744994324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E7U3/0+RbpfT+xqUZlJWpiri/XSmvPo5gL6Xs2YC1xM=;
	b=AdPnQqvCmdTPCBs0rjs8Z4EYPs6xAUiXoIZCP28aBWJE4NoXjHzjyo+5/d0i24EXCxV/Vc
	wqGJto8LoVkFygFnezIpImWQbaIkuu19icoa2RGN3y9ynz6lCksr8S/EfvSQx/M/kcFKIF
	rljNrzARLYWTjDkpLX+551PEBfOn7O0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-7qbF-NAWM7utTX1qGX09-A-1; Fri,
 18 Apr 2025 12:38:39 -0400
X-MC-Unique: 7qbF-NAWM7utTX1qGX09-A-1
X-Mimecast-MFC-AGG-ID: 7qbF-NAWM7utTX1qGX09-A_1744994318
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B56D195608C;
	Fri, 18 Apr 2025 16:38:38 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 37EE719560A3;
	Fri, 18 Apr 2025 16:38:36 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 19/20] block: move hctx cpuhp add/del out of queue freezing
Date: Sat, 19 Apr 2025 00:37:00 +0800
Message-ID: <20250418163708.442085-20-ming.lei@redhat.com>
In-Reply-To: <20250418163708.442085-1-ming.lei@redhat.com>
References: <20250418163708.442085-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Move hctx cpuhp add/del out of queue freezing for not connecting freeze
lock with cpuhp locks, then lockdep warning can be avoided.

This way is safe because both needn't queue to be frozen and scheduler
switch isn't allowed.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4de3287ce6e3..72f106163466 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4950,7 +4950,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		__blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
@@ -4993,6 +4993,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
 		blk_mq_sysfs_register_hctxs(q);
 		blk_mq_debugfs_register_hctxs(q);
+
+		blk_mq_remove_hw_queues_cpuhp(q);
+		blk_mq_add_hw_queues_cpuhp(q);
 	}
 
 	/* Free the excess tags when nr_hw_queues shrink. */
-- 
2.47.0

