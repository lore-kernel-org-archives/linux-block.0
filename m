Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0D2459C7
	for <linux-block@vger.kernel.org>; Tue, 20 May 2025 04:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747716915; cv=none; b=fyc5Y336zgZBr589TdjgAt9um6/nz5Vfq/+kYTEL82wXT/s8wj21E4/tIkZGsabukDn1LWlko7pivOf6qkTRSOmsPvm8drSuPcdVTnc8E1/zqw7aG7g4zTAY+F123CdasVZeDDcsuDOOlA59jMDpYDO7t1WEZmmGx1jJzKfURaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747716915; c=relaxed/simple;
	bh=KvT6Hcho/+yspQaaorAkyviIWS6M0unrIgOShBsBoYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lj2XmBoj0OgCIAGrOgUzuxQFrmXAwyCwTB5ZNrlKDpT7FVeEMcktI+mqdjr+45appPD/GhgIrbQZycAE6U5q5KAoCp0K0pWU8gZf28/lTYJJmmAeSEfhm7Bb75VGq+HANVjem5N+zmTFLxUj11nQPrXZLLs07JbKjVt+LFrbcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E+ITvPAM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+ITvPAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747716912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8tRsu3WrhsEZSnMxiaezo1Uyuwah2Jiik3DfnQlyR4=;
	b=E+ITvPAMQOO2mc99TuRfkaEG0wFhL3wGjgPwlep4fr8M4RqcGYO6nYdU8a06z3wLDPwczm
	pBPxY5KTjVqKA3DoetPlBI7wIdc/aMjPCK+ULU+nVC2sqXF7iYD+p8gS+X7ih5b+hxsSnl
	KZzExdFuno7ahLNTOLinWc+AXEqXwjo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-P6HSXQdROb6NwQ5kK3eb_w-1; Tue,
 20 May 2025 00:55:11 -0400
X-MC-Unique: P6HSXQdROb6NwQ5kK3eb_w-1
X-Mimecast-MFC-AGG-ID: P6HSXQdROb6NwQ5kK3eb_w_1747716910
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F0211800446;
	Tue, 20 May 2025 04:55:10 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 34F5C30001AA;
	Tue, 20 May 2025 04:55:07 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V5 1/6] ublk: convert to refcount_t
Date: Tue, 20 May 2025 12:54:31 +0800
Message-ID: <20250520045455.515691-2-ming.lei@redhat.com>
In-Reply-To: <20250520045455.515691-1-ming.lei@redhat.com>
References: <20250520045455.515691-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Convert to refcount_t and prepare for supporting to register bvec buffer
automatically, which needs to initialize reference counter as 2, and
kref doesn't provide this interface, so convert to refcount_t.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cb612151e9a1..ae2f47dc8224 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -79,7 +79,7 @@
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
 
 struct ublk_rq_data {
-	struct kref ref;
+	refcount_t ref;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -488,7 +488,6 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 #endif
 
 static inline void __ublk_complete_rq(struct request *req);
-static void ublk_complete_rq(struct kref *ref);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
@@ -648,7 +647,7 @@ static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		kref_init(&data->ref);
+		refcount_set(&data->ref, 1);
 	}
 }
 
@@ -658,7 +657,7 @@ static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		return kref_get_unless_zero(&data->ref);
+		return refcount_inc_not_zero(&data->ref);
 	}
 
 	return true;
@@ -670,7 +669,8 @@ static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		kref_put(&data->ref, ublk_complete_rq);
+		if (refcount_dec_and_test(&data->ref))
+			__ublk_complete_rq(req);
 	} else {
 		__ublk_complete_rq(req);
 	}
@@ -1122,15 +1122,6 @@ static inline void __ublk_complete_rq(struct request *req)
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

