Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E6E13D521
	for <linux-block@vger.kernel.org>; Sun, 13 Jul 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752417281; cv=none; b=W3bNRIE9NMwAt0CG3cUdkIevUZW/nMwNk+QIBHNOO5vjrQ/D524wJnZN5gmUObLBGgN4Eurj973D1pFWwLxDhFh1IQPo+9aLi0aUrec+5j+euqbUJZy2dyNxPjPKkNSlyPUdt4yaaipucMMMtcCvuPwsydM/Q0PBhWdZdkhTJGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752417281; c=relaxed/simple;
	bh=7ChtLtR3lnmvqLdvufiVXjtlYFqF/RUZlCC44TBzOMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bMtTyXBA5dvLPKmKeZGq0DEEACzlrhfvUsSk2rCvrrSl36XzYDQfVqvoIbABvGF7MOt+vEb2j2I+PPJEOX4jU6s4TuPbXXtaNuCyqDyo1q6D6+DHRy35zLVPi2ZhSabMWyWKQ2/ITGEe9BZ9ij2A7ZA6gsWdpAtDp1EveCAwG70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pwdphzxc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pwdphzxc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752417278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GU6hM7OvhGvbFc99x9ALx1To6sBLWI7NSzjHG6Bdcn0=;
	b=PwdphzxcV43cJt6/0/UXSCsm/vQYNJX/Qe606CF/f/tkF5l60+QmgUkoVi0D4VMIcougyC
	6PPXyOLotJqZlvk1PxBHNN+OgL0+OgNNFDvdYylHsb1WLk+uSSu2me3ENjZppSQ7XtCZqW
	OU6GzE+4JgBtJAt+hDwhaj/J2a3UOCw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-KWPCUxNAOWaumzZ6nOZvMg-1; Sun,
 13 Jul 2025 10:34:36 -0400
X-MC-Unique: KWPCUxNAOWaumzZ6nOZvMg-1
X-Mimecast-MFC-AGG-ID: KWPCUxNAOWaumzZ6nOZvMg_1752417275
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B9FE18011EF;
	Sun, 13 Jul 2025 14:34:35 +0000 (UTC)
Received: from localhost (unknown [10.72.116.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A18F30001A1;
	Sun, 13 Jul 2025 14:34:33 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 03/17] ublk: move fake timeout logic into __ublk_complete_rq()
Date: Sun, 13 Jul 2025 22:33:58 +0800
Message-ID: <20250713143415.2857561-4-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-1-ming.lei@redhat.com>
References: <20250713143415.2857561-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 7d1d8bd979c5..73c6c8d3b117 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1155,7 +1155,7 @@ static inline void __ublk_complete_rq(struct request *req)
 
 	if (blk_update_request(req, BLK_STS_OK, io->res))
 		blk_mq_requeue_request(req, true);
-	else
+	else if (likely(!blk_should_fake_timeout(req->q)))
 		__blk_mq_end_request(req, BLK_STS_OK);
 
 	return;
@@ -2237,9 +2237,6 @@ static int ublk_commit_and_fetch(const struct ublk_queue *ubq,
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

