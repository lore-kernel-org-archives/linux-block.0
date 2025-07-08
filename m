Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5135968
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 01:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751937484; cv=none; b=LpUGQDasN56b8NcbVSCRffWkl7N2r+f51dI3VYA89JBYWxBbnEqbUIb+ng0kUwjquwh4h8Swi0fPzGYV2lvduwnpMcDXh2+0HVU0JrdqBRU3LXM86nUy5i8ByuDEblzGOLbhSJ50dUsg2eAgi/vrJql7IarhxdUK5YevJKfDzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751937484; c=relaxed/simple;
	bh=K3XARf+jV6AeD031I8vImc6iW0WsQN0XeJZL9ZmyPl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PysBzVl338hppvcXMYhwlmdYe+JJ7cpCRqRJ2znD+8Qw7wKz7ZOvscneA1rloZvi8ZZtxZaNgZwb4rwdWzYsr+3kxzm+7bXQAy82647cLsltSGFqv5FFtG4rc6eGANTwwERh8vLOb2pVYNLe3+VxhfOA68Z9kYrONVfKQWhC0a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfBXcr+r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfBXcr+r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751937481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/5TYJeLkaunnj9Ao4HOgtGiRqRHmLbWjYNA3NnJN1U=;
	b=GfBXcr+rEn7aEvCepZTFK7ggEvbRVpInAeVyCI2dvojzZLoU1KlT7kjozBd/So1iV9u4+W
	hljKin460RXPYU7I5afHswdXA/bm8uddNxWpIPOQ7PwyjcoOBQfIVRTe2Qt1dfZkrlh13c
	NedwNZ59Et5ePuFa05s4GekEINAeKdA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-3GWui5ECPEOcCZwu7emAtg-1; Mon,
 07 Jul 2025 21:17:58 -0400
X-MC-Unique: 3GWui5ECPEOcCZwu7emAtg-1
X-Mimecast-MFC-AGG-ID: 3GWui5ECPEOcCZwu7emAtg_1751937477
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50FCA1955F38;
	Tue,  8 Jul 2025 01:17:57 +0000 (UTC)
Received: from localhost (unknown [10.72.116.39])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 368E7180045B;
	Tue,  8 Jul 2025 01:17:55 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 01/16] ublk: move fake timeout logic into __ublk_complete_rq()
Date: Tue,  8 Jul 2025 09:17:28 +0800
Message-ID: <20250708011746.2193389-2-ming.lei@redhat.com>
In-Reply-To: <20250708011746.2193389-1-ming.lei@redhat.com>
References: <20250708011746.2193389-1-ming.lei@redhat.com>
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

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index a1a700c7e67a..65daa6ed3a8e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1154,7 +1154,7 @@ static inline void __ublk_complete_rq(struct request *req)
 
 	if (blk_update_request(req, BLK_STS_OK, io->res))
 		blk_mq_requeue_request(req, true);
-	else
+	else if (likely(!blk_should_fake_timeout(req->q)))
 		__blk_mq_end_request(req, BLK_STS_OK);
 
 	return;
@@ -2225,9 +2225,6 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
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

