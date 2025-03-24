Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39B625E803
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824189; cv=none; b=dYCzmqK2mqDwd2N6ALx5k1oP05IlZpQ+ZXvnU74B576yX9vb33vkDbC0GdDVxRfB8xstKBFG42+rBTo27vG34vmOFWnriIhPBzKTmsc/ZhPAyAxegNrPpSrJ4pVoziELpIxVFdmJaAwlV9/W0Z4PIhfezpVse1G58PxGZ16dG2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824189; c=relaxed/simple;
	bh=3VQP8QrUOIIwajKyFHtuRMaz0C71iELsRyxCdeoHKys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=edVY6L62SECi+UaL+jDGNmFhi17VMQgDp5vtpqciZBaki/omU13CIXG6rZBQgEW628+/oZ0DpEW7HEwOpQ05XKVyKedxMTtEA2DfWU2TQ6/MrjzDB32gmsT8sQrbd9m4P68WIiX4dxnbROGxcKcDREcK4cXappGfRS2BaCvW2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lxgs5FrP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lxgs5FrP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3DtPrn6H+vWOnlzt0Bp5tz3DDc4MgcDhKRqX779nAY=;
	b=Lxgs5FrPF67kb5KeWX3kuI1vR+NlbncRISPlI8D49viDw3J5iW5Kp4jaY/m1OSrsa9JkD/
	bNHb6O0phaUNtewtfWE6N3i6pL2OH8TK6L16fCUyi0MWJEvGgcHEv0F6VkN7Sp5t4pmqBl
	Ga0HdBCoKxsAvinqHh/jxbLKS4mbuQw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-puVNZkwPNHC1dR7iZxPXqg-1; Mon,
 24 Mar 2025 09:49:43 -0400
X-MC-Unique: puVNZkwPNHC1dR7iZxPXqg-1
X-Mimecast-MFC-AGG-ID: puVNZkwPNHC1dR7iZxPXqg_1742824182
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7751218001FB;
	Mon, 24 Mar 2025 13:49:42 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2453E19560AF;
	Mon, 24 Mar 2025 13:49:40 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/8] ublk: add segment parameter
Date: Mon, 24 Mar 2025 21:48:59 +0800
Message-ID: <20250324134905.766777-5-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-1-ming.lei@redhat.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

IO split is usually bad in io_uring world, since -EAGAIN is caused and
IO handling may have to fallback to io-wq, this way does hurt performance.

ublk starts to support zero copy recently, for avoiding unnecessary IO
split, ublk driver's segment limit should be aligned with backend
device's segment limit.

Another reason is that io_buffer_register_bvec() needs to allocate bvecs,
which number is aligned with ublk request segment number, so that big
memory allocation can be avoided by setting reasonable max_segments limit.

So add segment parameter for providing ublk server chance to align
segment limit with backend, and keep it reasonable from implementation
viewpoint.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c      | 15 ++++++++++++++-
 include/uapi/linux/ublk_cmd.h |  9 +++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index acb6aed7be75..53a463681a41 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -74,7 +74,7 @@
 #define UBLK_PARAM_TYPE_ALL                                \
 	(UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DISCARD | \
 	 UBLK_PARAM_TYPE_DEVT | UBLK_PARAM_TYPE_ZONED |    \
-	 UBLK_PARAM_TYPE_DMA_ALIGN)
+	 UBLK_PARAM_TYPE_DMA_ALIGN | UBLK_PARAM_TYPE_SEGMENT)
 
 struct ublk_rq_data {
 	struct kref ref;
@@ -580,6 +580,13 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
+		const struct ublk_param_segment *p = &ub->params.seg;
+
+		if (!is_power_of_2(p->seg_boundary_mask + 1))
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -2350,6 +2357,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	if (ub->params.types & UBLK_PARAM_TYPE_DMA_ALIGN)
 		lim.dma_alignment = ub->params.dma.alignment;
 
+	if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
+		lim.seg_boundary_mask = ub->params.seg.seg_boundary_mask;
+		lim.max_segment_size = ub->params.seg.max_segment_size;
+		lim.max_segments = ub->params.seg.max_segments;
+	}
+
 	if (wait_for_completion_interruptible(&ub->completion) != 0)
 		return -EINTR;
 
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 7255b36b5cf6..83c2b94251f0 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -410,6 +410,13 @@ struct ublk_param_dma_align {
 	__u8	pad[4];
 };
 
+struct ublk_param_segment {
+	__u64 	seg_boundary_mask;
+	__u32 	max_segment_size;
+	__u16 	max_segments;
+	__u8	pad[2];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -423,6 +430,7 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
 #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
+#define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
@@ -430,6 +438,7 @@ struct ublk_params {
 	struct ublk_param_devt		devt;
 	struct ublk_param_zoned	zoned;
 	struct ublk_param_dma_align	dma;
+	struct ublk_param_segment	seg;
 };
 
 #endif
-- 
2.47.0

