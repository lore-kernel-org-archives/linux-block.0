Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDE428A40C
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744291924; cv=none; b=ZPzIcXtIWR5Io58DoZC9BaHj24xSHcTV3Sz0CiV8lwwUVGwBtC1PYaTciWNcKcUvA25NnFbGNrUr+vWtpBBhrwHN8h0Mbg3c55ROBOr42nmLr6OGk8fpmWwDRjUvw/ZYzQRpMoNP4cB7J8+cmunLMLTByMt2VdK2IqqUjWeyN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744291924; c=relaxed/simple;
	bh=VB1M2mV5t8p1L3diMbdJnyvVVpKTN9mVy/v0Ym5r2Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbcNcShg/16sPG375JmU0e0mcl4wABXi8ZqtNBt6jihK/GmkPcCQHJSplUzTx1E57fw5lQLmw1YliPtrf7I4Mxr3nlOviRc69LEjb2osd6SwxhccouZMVjbptmMaok2HS4Und+5Eoy2iyyUzEcSLIUAbow7VKTjsQAlSn0eJWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HgYDMC2Z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgYDMC2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744291921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cymcRY9iDUYr6d17XwcfJiNspOFwnByYtZxgrOE3+hs=;
	b=HgYDMC2Z+ipcBlSPsxhde98oD6m4Xkf1k3C5Ltp/ooytcz0hNvHRkRzYZOXAZnFzNEPUzo
	9yhKZAzM8LgQr5x+GqA2VRYdAif/Ntt3uCXd0xDXWZjXDxrToO9NDL2oLvU6U/+yKNDW/9
	BDy0AmxFRNNk3DMdvOed45O0RM8jUz8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-Cyb6U6YhNNW0pWNPjMdEMA-1; Thu,
 10 Apr 2025 09:31:58 -0400
X-MC-Unique: Cyb6U6YhNNW0pWNPjMdEMA-1
X-Mimecast-MFC-AGG-ID: Cyb6U6YhNNW0pWNPjMdEMA_1744291915
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5834180035C;
	Thu, 10 Apr 2025 13:31:55 +0000 (UTC)
Received: from localhost (unknown [10.72.120.20])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A22C1955DCE;
	Thu, 10 Apr 2025 13:31:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 14/15] block: move hctx cpuhp add/del out of queue freezing
Date: Thu, 10 Apr 2025 21:30:26 +0800
Message-ID: <20250410133029.2487054-15-ming.lei@redhat.com>
In-Reply-To: <20250410133029.2487054-1-ming.lei@redhat.com>
References: <20250410133029.2487054-1-ming.lei@redhat.com>
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
index 812dfe759b89..d721e55c0844 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4951,7 +4951,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		__blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
 			int i = prev_nr_hw_queues;
@@ -4990,6 +4990,9 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
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

