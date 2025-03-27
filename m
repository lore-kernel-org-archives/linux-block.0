Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEA1FF7D1
	for <linux-block@vger.kernel.org>; Thu, 27 Mar 2025 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743069156; cv=none; b=G1U1O83teMRLt0vKQCkTVCMiI91F9t8PyagQdaq9lTpHs9ry0CeXm92jDrsmp2mW3SrjwscrVRKa+okoxMqQdHh80yCY39cRG46bNG9pHX7GNcTBM2N8Qz0TV6c+kjzjhGVfDgVPzRWomMdJZuX5ol8OAzjgCsou86XY6StYcs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743069156; c=relaxed/simple;
	bh=hQiV6RRmDBbNPxuipEl4/oEQSXT5szKUVlfDP//JuQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NI/hdogcL49ZfKSMinkVnCjXc++QeLFygVogh10+P8l7fFAYCWEFM6NCgTS0m+sAD/nBVnZaV+QNzNWCYSEyLiM9UrkARDxh+wHwvQsj/UY9bIkWOgk5OINvNs4nk2NIExQdbX/qv1EsiUyD4RHn59gelYQ7iJpdQutOFbfjiyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iOFnk6aq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iOFnk6aq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743069154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnA/tlHBAaiHAb4D7vGHol88Qw6R4cWW2mxPuN+/i9Q=;
	b=iOFnk6aqEh6tUqzh1QzgCo733rLGlqhZy8izp0rwdx762OSuCCLuZsitlb56vnQztJwsyo
	jP4/TF7vERGN+CfbU0BosqgBvyukLsDrWjePrhd9uomSWaT7Vp4pHITlHhLAQT7Fh7RKAp
	hrCTpulF1ByCZjoRPczMo5OFXWxqUlo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-2GCgxwawMhiXAkVCWPx7gw-1; Thu,
 27 Mar 2025 05:52:28 -0400
X-MC-Unique: 2GCgxwawMhiXAkVCWPx7gw-1
X-Mimecast-MFC-AGG-ID: 2GCgxwawMhiXAkVCWPx7gw_1743069147
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC78B190308B;
	Thu, 27 Mar 2025 09:52:27 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AFD619560AD;
	Thu, 27 Mar 2025 09:52:25 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 11/11] selftests: ublk: add test for checking zero copy related parameter
Date: Thu, 27 Mar 2025 17:51:20 +0800
Message-ID: <20250327095123.179113-12-ming.lei@redhat.com>
In-Reply-To: <20250327095123.179113-1-ming.lei@redhat.com>
References: <20250327095123.179113-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

ublk zero copy usually requires to set dma and segment parameter correctly,
so hard-code null target's dma & segment parameter in non-default value,
and verify if they are setup correctly by ublk driver.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/null.c           | 11 +++++++-
 .../testing/selftests/ublk/test_generic_03.sh | 28 +++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_03.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 7a8c994de244..d98680d64a2f 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -5,6 +5,7 @@ LDLIBS += -lpthread -lm -luring
 
 TEST_PROGS := test_generic_01.sh
 TEST_PROGS += test_generic_02.sh
+TEST_PROGS += test_generic_03.sh
 
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
diff --git a/tools/testing/selftests/ublk/null.c b/tools/testing/selftests/ublk/null.c
index 899875ff50fe..91fec3690d4b 100644
--- a/tools/testing/selftests/ublk/null.c
+++ b/tools/testing/selftests/ublk/null.c
@@ -17,7 +17,8 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 
 	dev->tgt.dev_size = dev_size;
 	dev->tgt.params = (struct ublk_params) {
-		.types = UBLK_PARAM_TYPE_BASIC,
+		.types = UBLK_PARAM_TYPE_BASIC | UBLK_PARAM_TYPE_DMA_ALIGN |
+			UBLK_PARAM_TYPE_SEGMENT,
 		.basic = {
 			.logical_bs_shift	= 9,
 			.physical_bs_shift	= 12,
@@ -26,6 +27,14 @@ static int ublk_null_tgt_init(const struct dev_ctx *ctx, struct ublk_dev *dev)
 			.max_sectors		= info->max_io_buf_bytes >> 9,
 			.dev_sectors		= dev_size >> 9,
 		},
+		.dma = {
+			.alignment 		= 4095,
+		},
+		.seg = {
+			.seg_boundary_mask 	= 4095,
+			.max_segment_size 	= 32 << 10,
+			.max_segments 		= 32,
+		},
 	};
 
 	if (info->flags & UBLK_F_SUPPORT_ZERO_COPY)
diff --git a/tools/testing/selftests/ublk/test_generic_03.sh b/tools/testing/selftests/ublk/test_generic_03.sh
new file mode 100755
index 000000000000..b551aa76cb0d
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_generic_03.sh
@@ -0,0 +1,28 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+
+TID="generic_03"
+ERR_CODE=0
+
+_prep_test "null" "check dma & segment limits for zero copy"
+
+dev_id=$(_add_ublk_dev -t null -z)
+_check_add_dev $TID $?
+
+sysfs_path=/sys/block/ublkb"${dev_id}"
+dma_align=$(cat "$sysfs_path"/queue/dma_alignment)
+max_segments=$(cat "$sysfs_path"/queue/max_segments)
+max_segment_size=$(cat "$sysfs_path"/queue/max_segment_size)
+if [ "$dma_align" != "4095" ]; then
+	ERR_CODE=255
+fi
+if [ "$max_segments" != "32" ]; then
+	ERR_CODE=255
+fi
+if [ "$max_segment_size" != "32768" ]; then
+	ERR_CODE=255
+fi
+_cleanup_test "null"
+_show_result $TID $ERR_CODE
-- 
2.47.0

