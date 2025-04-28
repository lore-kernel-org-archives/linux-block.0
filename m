Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DDB267AF4
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745833503; cv=none; b=V2mkaudE9Rl0jO3VQ6Y9gyylnqFuDthp5UX6DmY1XtDuYgmfPOBD5d3nyu0Y4SqaCh2HO5NtHztc0ae5RMkguduwAnK2em422Qtym6XBTy615I2Ksi9VAYaDviFNlKzDALsDlo6KN706asdMugyQJADw5LObWBZl3zh4FO5V+xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745833503; c=relaxed/simple;
	bh=4u5F4/wIhDQfBfAzaPzbbPLZ6VnPCk1PliIafV6JKt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnBpABiTV8LNLPC3A0U/9lagLeKzzCSOotBngCUZoFkeuG6RNeCNrwWQV0YFvAXkgOgX1zP7xRcPxaOzVigRkCOYiqEZ+K52+2NYRfzawHMXK8RXO2f4axvChsiyEVB+VkIaiJgK75pkH21/itAOBh4/AR6VEDDSIbbMlo4S6SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fxunqud0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fxunqud0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745833500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QP01s+NoXelB0ooV/FSKEfgslbq8CyPujrmfjLYSHV0=;
	b=Fxunqud0PIsi9UGx2O9c/oWK5hw+jYR73Xnr5+DydlVOwn73BZCUOnBg8bwDTvaWodeJWL
	N44jdcjVrqPsxjxXsy6HxJIwuQrljWYGrsE/9Q3mah14bJfGyUt0uezsN6cCW+/xKYvBoC
	hDh/g+BuSMgZn9ABPuGMCH752m7gw5k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-H6jL_4WUNAqlHRUmvbQw8Q-1; Mon,
 28 Apr 2025 05:44:57 -0400
X-MC-Unique: H6jL_4WUNAqlHRUmvbQw8Q-1
X-Mimecast-MFC-AGG-ID: H6jL_4WUNAqlHRUmvbQw8Q_1745833491
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0EF11800373;
	Mon, 28 Apr 2025 09:44:50 +0000 (UTC)
Received: from localhost (unknown [10.72.116.134])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9EB519560A3;
	Mon, 28 Apr 2025 09:44:49 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 4/7] ublk: convert to refcount_t
Date: Mon, 28 Apr 2025 17:44:15 +0800
Message-ID: <20250428094420.1584420-5-ming.lei@redhat.com>
In-Reply-To: <20250428094420.1584420-1-ming.lei@redhat.com>
References: <20250428094420.1584420-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Convert to refcount_t and prepare for supporting to register bvec buffer
automatically, which needs to initialize reference counter as 2, and
kref doesn't provide this interface, so convert to refcount_t.

Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ac56482b55f5..9cd331d12fa6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -79,7 +79,7 @@
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
 
 struct ublk_rq_data {
-	struct kref ref;
+	refcount_t ref;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -484,7 +484,6 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 #endif
 
 static inline void __ublk_complete_rq(struct request *req);
-static void ublk_complete_rq(struct kref *ref);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
@@ -644,7 +643,7 @@ static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		kref_init(&data->ref);
+		refcount_set(&data->ref, 1);
 	}
 }
 
@@ -654,7 +653,7 @@ static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		return kref_get_unless_zero(&data->ref);
+		return refcount_inc_not_zero(&data->ref);
 	}
 
 	return true;
@@ -666,7 +665,8 @@ static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		kref_put(&data->ref, ublk_complete_rq);
+		if(refcount_dec_and_test(&data->ref))
+			__ublk_complete_rq(req);
 	} else {
 		__ublk_complete_rq(req);
 	}
@@ -1124,15 +1124,6 @@ static inline void __ublk_complete_rq(struct request *req)
 	blk_mq_end_request(req, res);
 }
 
-static void ublk_complete_rq(struct kref *ref)
-{
-	struct ublk_rq_data *data = container_of(ref, struct ublk_rq_data,
-			ref);
-	struct request *req = blk_mq_rq_from_pdu(data);
-
-	__ublk_complete_rq(req);
-}
-
 static void ublk_complete_io_cmd(struct ublk_io *io, struct request *req,
 				 int res, unsigned issue_flags)
 {
-- 
2.47.0

