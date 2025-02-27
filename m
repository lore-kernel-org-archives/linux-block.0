Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C872021ABB4
	for <linux-block@vger.kernel.org>; Thu, 27 Feb 2025 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652654; cv=none; b=qB1brEJ4gKfzqIoyLB21wSXDH4Iw7ym3s/5orttiYhYszm1QKWoGgjuegg1yf8h2AF/OQ9QdfisOWojUO27D1Uuioy3vawGOJ2CdB/NQB234w1RxWBtJpJ4A1LGrYjRd6mvAjLg4bjHRuUrZJQCgdCBtQLaoEZwqvEw0oz/+WOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652654; c=relaxed/simple;
	bh=dylsZggBFHrEm8rHUD08cwp+uS1KmHDfUp6fqALEjIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olnuMYpEpwbPFw3GIbaIsBy9QE+Hcv815O42DYfuXCSxKunLiOWsssAK+VF2cV70ULXbY0l5kOvLxaCl333odyY7yw1CQlE4i//8KBDDDgQ7Lv97Od5QHHEFGlfYMAQ2+itbqbxr38WyX+J6YD332GymiEkmnH4ZGXLgf0A2Q0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dQZqiBzA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dQZqiBzA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740652650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n1hmVroAFKtLZJxMWVffN1oCG+Um7XEbMW0OAFY4aOQ=;
	b=dQZqiBzA+UBE7P1GwtOMWc7zMCj2j4xaxXLWrav8lv1iZpi994nlRGXFP2XKLZcWwGMf7t
	b+t/6oLVW7cizhifqUMjEfOhUEN+9+qXDz0ZJejNJ2bi6Y1vPf0pTeS1202zmpEcHSUsPQ
	6nW/o7Yk29OAjYAgYQZRhLDe9mPDWYo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-ONZvO3dfOuy_NTqCgNLMAQ-1; Thu,
 27 Feb 2025 05:37:27 -0500
X-MC-Unique: ONZvO3dfOuy_NTqCgNLMAQ-1
X-Mimecast-MFC-AGG-ID: ONZvO3dfOuy_NTqCgNLMAQ_1740652646
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD9C6180036F;
	Thu, 27 Feb 2025 10:37:25 +0000 (UTC)
Received: from localhost (unknown [10.72.120.5])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9A1CE1800359;
	Thu, 27 Feb 2025 10:37:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] ublk: add DMA alignment limit
Date: Thu, 27 Feb 2025 18:37:07 +0800
Message-ID: <20250227103707.2640014-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The in-tree ublk driver doesn't need DMA alignment limit because there
is one data copy between request pages and the userspace buffer.

However, ublk is going to support zero copy, then DMA alignment limit
is required, because same IO buffer is forwarded to backend which may
have specific buffer DMA alignment limit, so the limit has to be exposed
from the frontend driver to client application.

Cc: Keith Busch <kbusch@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---

It is helpful to provide segment limit for avoiding extra
IO split, but that shouldn't a must for zero copy.

 drivers/block/ublk_drv.c      | 16 +++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  7 +++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 4f291b55c876..c505b14989cf 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -73,7 +73,8 @@
 /* All UBLK_PARAM_TYPE_* should be included here */
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
-	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED)
+	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
+	 UBLK_PARAM_TYPE_DMA_ALIGN)
 
 struct ublk_rq_data {
 	struct llist_node node;
@@ -571,6 +572,16 @@ static int ublk_validate_params(const struct ublk_device *ub)
 	else if (ublk_dev_is_zoned(ub))
 		return -EINVAL;
 
+	if (ub->params.types & UBLK_PARAM_TYPE_DMA_ALIGN) {
+		const struct ublk_param_dma_align *p = &ub->params.dma;
+
+		if (p->alignment >= PAGE_SIZE)
+			return -EINVAL;
+
+		if (!is_power_of_2(p->alignment + 1))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -2348,6 +2359,9 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	if (ub->params.basic.attrs & UBLK_ATTR_ROTATIONAL)
 		lim.features |= BLK_FEAT_ROTATIONAL;
 
+	if (ub->params.types & UBLK_PARAM_TYPE_DMA_ALIGN)
+		lim.dma_alignment = ub->params.dma.alignment;
+
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 74246c926b55..7255b36b5cf6 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -405,6 +405,11 @@ struct ublk_param_zoned {
 	__u8	reserved[20];
 };
 
+struct ublk_param_dma_align {
+	__u32	alignment;
+	__u8	pad[4];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -417,12 +422,14 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
+#define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
 	struct ublk_param_discard	discard;
 	struct ublk_param_devt		devt;
 	struct ublk_param_zoned	zoned;
+	struct ublk_param_dma_align	dma;
 };
 
 #endif
-- 
2.47.1

