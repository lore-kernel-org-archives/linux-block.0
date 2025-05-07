Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A00314884C
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 04:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746592778; cv=none; b=nCtuXcgJzKPx5cWCiVL6EH7AdoUx7db6k49g7a5Y4dUUzYdtFmtNuGz7706FqaGfoVOlmkvHCLPt+6SMAe1H1Ejrc5w+skpBR6LgplleZJNm7ZR9SO1Cw52yXRontRyE5ohNc1oZPRXD8+KGeZyluryvWeg108xMbhN7cqrazdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746592778; c=relaxed/simple;
	bh=S/rLwwjo5atZqvi4mi6/0pariOS/RPtRmx1ASfKxfeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JJZGUd7RmBmKFPwVMjwL+Zhp7HKIHdKfxtZy8IMmY6iNNiXlO9dsYd35IYDXIHPdGRwqGfa/qLohsEfOAMRii1hr0kKLD6sxD3sj1n5o7a33+D/vNgVi2Kz5hunDIt70pWaclRRYMW+FedA8As2WZcc0TwWwg0TrBj4MmGxsbmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLXHiCg2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLXHiCg2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746592775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6hp80nrXRmZDp9t99nzqM1ydd3snNZp/YaCP3i5HKM=;
	b=aLXHiCg2CYPS339S77TTfXHHchVzOYWgcEaQ5WT6LgLyx1Ox9TvwL4V2Pxd970oiPXeH5p
	KasAE2aTnHTaT+fniXToXmuDu/TmAUh0MgRuCpvCX31K3ZqMnqIMFAOPQF08wXVnphM2no
	c1bbeN+2mWw0g3HsO+jbOfOLaOJU5no=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-tEykeNGsPSK8u5FblNTagQ-1; Wed,
 07 May 2025 00:39:30 -0400
X-MC-Unique: tEykeNGsPSK8u5FblNTagQ-1
X-Mimecast-MFC-AGG-ID: tEykeNGsPSK8u5FblNTagQ_1746592769
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 321721954236;
	Wed,  7 May 2025 04:39:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E920D30001A2;
	Wed,  7 May 2025 04:39:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/6] ublk: convert to refcount_t
Date: Wed,  7 May 2025 12:38:53 +0800
Message-ID: <20250507043859.2978132-3-ming.lei@redhat.com>
In-Reply-To: <20250507043859.2978132-1-ming.lei@redhat.com>
References: <20250507043859.2978132-1-ming.lei@redhat.com>
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
index 4df0a9052247..768de19cd7a5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -79,7 +79,7 @@
 	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
 
 struct ublk_rq_data {
-	struct kref ref;
+	refcount_t ref;
 };
 
 struct ublk_uring_cmd_pdu {
@@ -489,7 +489,6 @@ static blk_status_t ublk_setup_iod_zoned(struct ublk_queue *ubq,
 #endif
 
 static inline void __ublk_complete_rq(struct request *req);
-static void ublk_complete_rq(struct kref *ref);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
@@ -649,7 +648,7 @@ static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		kref_init(&data->ref);
+		refcount_set(&data->ref, 1);
 	}
 }
 
@@ -659,7 +658,7 @@ static inline bool ublk_get_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		return kref_get_unless_zero(&data->ref);
+		return refcount_inc_not_zero(&data->ref);
 	}
 
 	return true;
@@ -671,7 +670,8 @@ static inline void ublk_put_req_ref(const struct ublk_queue *ubq,
 	if (ublk_need_req_ref(ubq)) {
 		struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
-		kref_put(&data->ref, ublk_complete_rq);
+		if (refcount_dec_and_test(&data->ref))
+			__ublk_complete_rq(req);
 	} else {
 		__ublk_complete_rq(req);
 	}
@@ -1123,15 +1123,6 @@ static inline void __ublk_complete_rq(struct request *req)
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

