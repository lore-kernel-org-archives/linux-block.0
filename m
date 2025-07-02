Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5C1B0413
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 04:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751429049; cv=none; b=lSVT8xj8knC9u/I4/mGPuXjiEU9iAhtdh0TbRvOSi53er8TFK9/8ju0Wy/zXqERfb9QUWHMZ9Zabf6uo0YASL3pW5/kLCnRKK0ki8Z8T+/dcVqUgBUvfnT+NXs7kxhFEeqALMO9vFhWPkchRQayR7T8yUwIDhKLKtK9UXnHoE9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751429049; c=relaxed/simple;
	bh=BksNqdos3bmvCkDMDU3UcLJeHKIYQSH7EF7tP7erBpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HzZaMFKzFoxcGmXberSIxTOw3T+0WFitVR8fFkXekba8ymD3VU4xbXb+m2DhtHhCXhTs2E7VxFPfRmzmDqsP2suofOordZzG9CqEiPvF8HTH8ksdILlvNLfQ8Sqzg/6Dl/ZLhIe/mMkNvPF6g9uVsZZgvgcMYMVDv4+TuaTqgJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X+1sIeWq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X+1sIeWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751429046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pJZtS3eX+oz7Y3eW41yRszDYLsT7r39VErJ2zgHzSe0=;
	b=X+1sIeWqtg/whjtHk+yrcsbf/PjJlNqDqbAfWQw1RHCpW1vTKuS6Y7rf1l8fMbqhmQXNDM
	LVYrsRL50dk3B8KaUW+PkoQ0Xoxm/XA54D3k9iZU4Mvc09SoVAqk/oAGq8wQ2s2YNskOxO
	SfQ+Fq8dusfoBlz9H4gcLDrRUnxljeQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-l-Qqtp1sOwq9htpGt8B3Fg-1; Wed,
 02 Jul 2025 00:04:03 -0400
X-MC-Unique: l-Qqtp1sOwq9htpGt8B3Fg-1
X-Mimecast-MFC-AGG-ID: l-Qqtp1sOwq9htpGt8B3Fg_1751429041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C52B21955D4E;
	Wed,  2 Jul 2025 04:04:01 +0000 (UTC)
Received: from localhost (unknown [10.72.116.27])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8383718003FC;
	Wed,  2 Jul 2025 04:03:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 01/16] ublk: move fake timeout logic into __ublk_complete_rq()
Date: Wed,  2 Jul 2025 12:03:25 +0800
Message-ID: <20250702040344.1544077-2-ming.lei@redhat.com>
In-Reply-To: <20250702040344.1544077-1-ming.lei@redhat.com>
References: <20250702040344.1544077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Almost every block driver deals with fake timeout logic around real
request completion code.

Also the existing way may cause request reference count leak, so move the
logic into __ublk_complete_rq(), then we can skip the completion in the
last step like other drivers.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e52c2d1cb838..e2de76d78a08 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1152,7 +1152,7 @@ static inline void __ublk_complete_rq(struct request *req)
 
 	if (blk_update_request(req, BLK_STS_OK, io->res))
 		blk_mq_requeue_request(req, true);
-	else
+	else if (likely(!blk_should_fake_timeout(req->q)))
 		__blk_mq_end_request(req, BLK_STS_OK);
 
 	return;
@@ -2206,9 +2206,6 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ub_cmd->zone_append_lba;
 
-	if (unlikely(blk_should_fake_timeout(req->q)))
-		return 0;
-
 	if (ublk_need_req_ref(ubq))
 		ublk_sub_req_ref(io, req);
 	else
-- 
2.47.0

