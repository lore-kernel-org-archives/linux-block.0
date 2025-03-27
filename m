Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536120CCF4
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069129; cv=none; b=HZh29GoCa4Pji1Qt05VqjRtU039QJRX8GNYYI/c0m7MmIpgYaT2Mb43E6+zTvC7nwOJaipQVla9z7bAUpo9jCvjfICiKyd414cb6mErKHJDH/n8Q+DdvkJvIcAeCiLs9RWglWeTMqgQTACXy7AxUvg3a66/2p8q+SGKZUomSOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069129; c=relaxed/simple;
	bh=Lzk91e+bm4UrsHZFIVQqR/PpuSZp5G5Ftod5lvc4Les=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koImi2Y/cHXOAR6dAdYtdO4tWqXXElFT3F5Pzw14h7VSb3Zz9jHI3IFNsJmtxTMbVA26Ox8hrLG133vQhJ5P78ADjT2yYkFp4DXZrUBfW2F+5xsuZ6UaHSPKg2+i+G60/OIjwH74S2EhmtCXHsifWgnNWfw9Zp/H+Rc1oPWhLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eke5oBJK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eke5oBJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m0uqAm0AAlb4nG7i2N7QrnmwRlnxOyV21jQTpS1Nrc8=;
	b=Eke5oBJKQFqt0mutKU/3y7N8rvVurA2I5AfOFWGjB3F4qfaxxcsOYnb9K66jKzf+2QH4WV
	bTS21dLDuJFsldjRJT8y178iRdTXqOIi2hXkRTQpwVU29k3ZacTk9G6wQIZke4O0hzRXt7
	8vq0NbyIYA4gm9Hj2wCHDotmYtRUwJo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-wRksnLvjPWanPMVnFHDM0A-1; Thu,
 27 Mar 2025 05:52:03 -0400
X-MC-Unique: wRksnLvjPWanPMVnFHDM0A-1
X-Mimecast-MFC-AGG-ID: wRksnLvjPWanPMVnFHDM0A_1743069122
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18E7A196B378;
	Thu, 27 Mar 2025 09:52:02 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D84D11801747;
	Thu, 27 Mar 2025 09:52:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 06/11] ublk: add segment parameter
Date: Thu, 27 Mar 2025 17:51:15 +0800
Message-ID: <20250327095123.179113-7-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
 drivers/block/ublk_drv.c      | 20 +++++++++++++++++++-
 include/uapi/linux/ublk_cmd.h | 25 +++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1e11816d0b90..a5bcf3aa9d8c 100644
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
@@ -580,6 +580,18 @@ static int ublk_validate_params(const struct ublk_device *ub)
 			return -EINVAL;
 	}
 
+	if (ub->params.types & UBLK_PARAM_TYPE_SEGMENT) {
+		const struct ublk_param_segment *p = &ub->params.seg;
+
+		if (!is_power_of_2(p->seg_boundary_mask + 1))
+			return -EINVAL;
+
+		if (p->seg_boundary_mask + 1 < UBLK_MIN_SEGMENT_SIZE)
+			return -EINVAL;
+		if (p->max_segment_size < UBLK_MIN_SEGMENT_SIZE)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -2370,6 +2382,12 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
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
index 7255b36b5cf6..583b86681c93 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -410,6 +410,29 @@ struct ublk_param_dma_align {
 	__u8	pad[4];
 };
 
+#define UBLK_MIN_SEGMENT_SIZE   4096
+/*
+ * If any one of the three segment parameter is set as 0, the behavior is
+ * undefined.
+ */
+struct ublk_param_segment {
+	/*
+	 * seg_boundary_mask + 1 needs to be power_of_2(), and the sum has
+	 * to be >= UBLK_MIN_SEGMENT_SIZE(4096)
+	 */
+	__u64 	seg_boundary_mask;
+
+	/*
+	 * max_segment_size could be override by virt_boundary_mask, so be
+	 * careful when setting both.
+	 *
+	 * max_segment_size has to be >= UBLK_MIN_SEGMENT_SIZE(4096)
+	 */
+	__u32 	max_segment_size;
+	__u16 	max_segments;
+	__u8	pad[2];
+};
+
 struct ublk_params {
 	/*
 	 * Total length of parameters, userspace has to set 'len' for both
@@ -423,6 +446,7 @@ struct ublk_params {
 #define UBLK_PARAM_TYPE_DEVT            (1 << 2)
 #define UBLK_PARAM_TYPE_ZONED           (1 << 3)
 #define UBLK_PARAM_TYPE_DMA_ALIGN       (1 << 4)
+#define UBLK_PARAM_TYPE_SEGMENT         (1 << 5)
 	__u32	types;			/* types of parameter included */
 
 	struct ublk_param_basic		basic;
@@ -430,6 +454,7 @@ struct ublk_params {
 	struct ublk_param_devt		devt;
 	struct ublk_param_zoned	zoned;
 	struct ublk_param_dma_align	dma;
+	struct ublk_param_segment	seg;
 };
 
 #endif
-- 
2.47.0

