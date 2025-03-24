Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AFE14F9FB
	for <linux-block@vger.kernel.org>; Mon, 24 Mar 2025 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824210; cv=none; b=gGyGp6T9P8+QoCteQQTU35g/7BNH23Bn0EfupbjiQdFHiPwQixM0dKX4PXYmw/iK/wkD2DMgFtbp0qvOYCDsXSOUajqniKh8nruUXkull8xkvXk+OTeLeO4MaeWWqW7kRWcyurGA8RNKCI6jineKopvVJ8lEm4386azw2XAbXvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824210; c=relaxed/simple;
	bh=hQiV6RRmDBbNPxuipEl4/oEQSXT5szKUVlfDP//JuQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMAwrgMW42lH/OO1ACthQQSfOSjoGRXHVrrsqU8gMuR81YAHYZqZvcbUCx9f1nqdOrJgHFKuSdX4EG6w5jl4uveTRwkFGJrphjBQgIqj5V7I0jGocRYpf5SAwBYFcfRFscff1dZqeR3HsnHDbvS+T9oBrpCWYy1khArSi/rxBbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GEaNaX0j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GEaNaX0j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742824207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnA/tlHBAaiHAb4D7vGHol88Qw6R4cWW2mxPuN+/i9Q=;
	b=GEaNaX0jzcIuOFGPRrAcWC4ZHWTNJvv71jxmiFbNs6lZKJm+vWV3DqTmXq/H7gmvo+UTVR
	gTEwmBmdIDcFgSCrcGLEh2V+p7wNHXlNeK3BQPoABpGZbB2wu/YDqTykDBABfr3CbKW1wL
	Fr9273HaUCtPk5572oqQ495TtJI9tpU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-XSbeLJaUOcqIfVSbkV8HKA-1; Mon,
 24 Mar 2025 09:50:02 -0400
X-MC-Unique: XSbeLJaUOcqIfVSbkV8HKA-1
X-Mimecast-MFC-AGG-ID: XSbeLJaUOcqIfVSbkV8HKA_1742824201
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B642C196B37F;
	Mon, 24 Mar 2025 13:50:01 +0000 (UTC)
Received: from localhost (unknown [10.72.120.24])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 792921956095;
	Mon, 24 Mar 2025 13:50:00 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Keith Busch <kbusch@kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 8/8] selftests: ublk: add test for checking zero copy related parameter
Date: Mon, 24 Mar 2025 21:49:03 +0800
Message-ID: <20250324134905.766777-9-ming.lei@redhat.com>
In-Reply-To: <20250324134905.766777-1-ming.lei@redhat.com>
References: <20250324134905.766777-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

