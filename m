Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D5253B6E
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031786; cv=none; b=dWS6lPWgpvZCjl7oc0+COGAMejm/wEAWqw6klpDy4RCiH/K+R6qNSkCN0rz34MHdu3ePY+eaFRELkLJJ9Fd0NtKieOcegIi1PGIlkseQiNPcVAufRklTiihaCTp1l8DgSM9IAekeNm3X4M+7izc/i4MOkS5NVX7PUyuK/fpCzMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031786; c=relaxed/simple;
	bh=qsVkYOL51lKvH0XfWtJdk1FQQIglhryTsAU+2+/B12o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MN5xvD946GcfqxXKqxJngbcLHSrcNJcymFct++ZKlX4dUuJ/tLDbWBtVlrvWk2LJGDuVH/yBPOKsgSv4DSm6aVjtY6WXNoyg2ATO872wRKhQD/o1pnwDtaRiGyfsCRkMqEUjrSXvC5N/oapqdTa73EVT96mBjaWwQupqZEwbG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YQ1MtkFy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YQ1MtkFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yl/gZSUteiYzccPTAyCdpTCGurzuRCeH+TvqdHl9gTg=;
	b=YQ1MtkFyN5F7+TWy6ulVkkboO4gMJRRrboQas8joIkK1+rn3PkblofePOl6Vzy8tTIFADU
	ryN5vPvoOkO3JiOukheDcGJpIfPKoa5ujWkUGrquVyo7+yGFzocgxhZD1VNCa7iJT0SpfJ
	WIWH5Ou6IpfPHu8j6hroVu0LGnyCwPo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-GfbUN_7pMTOPHsFrH6Neug-1; Mon,
 07 Apr 2025 09:16:22 -0400
X-MC-Unique: GfbUN_7pMTOPHsFrH6Neug-1
X-Mimecast-MFC-AGG-ID: GfbUN_7pMTOPHsFrH6Neug_1744031781
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A71219560B2;
	Mon,  7 Apr 2025 13:16:21 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D918D1828AA7;
	Mon,  7 Apr 2025 13:16:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 07/13] selftests: ublk: add two stress tests for zero copy feature
Date: Mon,  7 Apr 2025 21:15:18 +0800
Message-ID: <20250407131526.1927073-8-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add stress_03 & stress_04 for covering zero copy feature.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  2 +
 .../testing/selftests/ublk/test_stress_03.sh  | 38 +++++++++++++++++++
 .../testing/selftests/ublk/test_stress_04.sh  | 37 ++++++++++++++++++
 3 files changed, 77 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_stress_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_04.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index c7781efea0f3..7311e8f6bee7 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -21,6 +21,8 @@ TEST_PROGS += test_stripe_04.sh
 
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
+TEST_PROGS += test_stress_03.sh
+TEST_PROGS += test_stress_04.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
new file mode 100755
index 000000000000..e0854f71d35b
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -0,0 +1,38 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_03"
+ERR_CODE=0
+
+ublk_io_and_remove()
+{
+	run_io_and_remove "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+if ! _have_feature "ZERO_COPY"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stress" "run IO and remove device(zero copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_remove 8G -t null -q 4 -z &
+ublk_io_and_remove 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
+ublk_io_and_remove 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
new file mode 100755
index 000000000000..1798a98387e8
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_04"
+ERR_CODE=0
+
+ublk_io_and_kill_daemon()
+{
+	run_io_and_kill_daemon "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+if ! _have_program fio; then
+	exit "$UBLK_SKIP_CODE"
+fi
+if ! _have_feature "ZERO_COPY"; then
+	exit "$UBLK_SKIP_CODE"
+fi
+
+_prep_test "stress" "run IO and kill ublk server(zero copy)"
+
+_create_backfile 0 256M
+_create_backfile 1 128M
+_create_backfile 2 128M
+
+ublk_io_and_kill_daemon 8G -t null -q 4 -z &
+ublk_io_and_kill_daemon 256M -t loop -q 4 -z "${UBLK_BACKFILES[0]}" &
+ublk_io_and_kill_daemon 256M -t stripe -q 4 -z "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
-- 
2.47.0

