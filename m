Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7933314C4
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703630; cv=none; b=bPwlZExF9nmLhq2WCsW388y3gJRHu8gIRDxUO5TpamJ6JfHgpu4A5DSGaV8hxrEcZ2f7fcymm0ubRvuTPAAR5NoCyNM5XscCEOdwwMCCuUaeCjO7tSgDVQhHL0hj7Q6sO6MHTj7PcGe7oCgLCmHztQzuwetz2nFEqMYNvxzmThI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703630; c=relaxed/simple;
	bh=dCpjsFg6xHZLRPgjWwQw/ee9Qr5vxQ8sq8yYQeefS+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=atqfPNxnFqhvdUri9Jdi16RMubOySwtNtdhV+mn2qefnq1T13fv0riWtYSdBl0axad0DuacI1npRy1Qb/COH/+GIb+D81Yx9f+3zd9QSiksBGHVEFqhQ0Ss9rX9h33tKp2CUuYaaZbwJGzJrHc408ecYDf/AT5YzqMCOGKQ4Wig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgU2ywWb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgU2ywWb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2yPausjbnR6bRPOyu5/8itsWGg+aUNa+7zcVh9MsmA=;
	b=KgU2ywWbi2OjPDIcsgpfxmtIZqR2/5kjq7EsEfMniXyIcvRMYMyDmyYBm/BmsZKWIMuWRr
	dWNUSgi28Ja6uLCOiBWj2XssqB43lp9dpyOvIdwCTkAF9Qr0RDecnfEUoDmzbK6en6xyuv
	yJjTL56S9JhjnBR1RnVG5wlaytPxWdI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-md-fLl9KM3248A4KH-4fNA-1; Thu,
 29 Jan 2026 11:20:23 -0500
X-MC-Unique: md-fLl9KM3248A4KH-4fNA-1
X-Mimecast-MFC-AGG-ID: md-fLl9KM3248A4KH-4fNA_1769703621
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5894719560A6;
	Thu, 29 Jan 2026 16:20:21 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 672BF1955F16;
	Thu, 29 Jan 2026 16:20:20 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/9] selftests: ublk: derive TID automatically from script name
Date: Fri, 30 Jan 2026 00:19:52 +0800
Message-ID: <20260129162001.3532311-4-ming.lei@redhat.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add automatic TID derivation in test_common.sh based on the script
filename. The TID is extracted by stripping the "test_" prefix and
".sh" suffix from the script name (e.g., test_loop_01.sh -> loop_01).

This removes the need for each test script to manually define TID,
reducing boilerplate and preventing potential mismatches between
the script name and TID. Scripts can still override TID after
sourcing test_common.sh if needed.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_batch_01.sh   | 1 -
 tools/testing/selftests/ublk/test_batch_02.sh   | 1 -
 tools/testing/selftests/ublk/test_batch_03.sh   | 1 -
 tools/testing/selftests/ublk/test_common.sh     | 5 +++++
 tools/testing/selftests/ublk/test_generic_01.sh | 1 -
 tools/testing/selftests/ublk/test_generic_02.sh | 1 -
 tools/testing/selftests/ublk/test_generic_03.sh | 1 -
 tools/testing/selftests/ublk/test_generic_04.sh | 1 -
 tools/testing/selftests/ublk/test_generic_05.sh | 1 -
 tools/testing/selftests/ublk/test_generic_06.sh | 1 -
 tools/testing/selftests/ublk/test_generic_07.sh | 1 -
 tools/testing/selftests/ublk/test_generic_08.sh | 1 -
 tools/testing/selftests/ublk/test_generic_09.sh | 1 -
 tools/testing/selftests/ublk/test_generic_10.sh | 1 -
 tools/testing/selftests/ublk/test_generic_11.sh | 1 -
 tools/testing/selftests/ublk/test_generic_12.sh | 1 -
 tools/testing/selftests/ublk/test_generic_13.sh | 1 -
 tools/testing/selftests/ublk/test_generic_14.sh | 1 -
 tools/testing/selftests/ublk/test_generic_15.sh | 1 -
 tools/testing/selftests/ublk/test_generic_16.sh | 1 -
 tools/testing/selftests/ublk/test_loop_01.sh    | 1 -
 tools/testing/selftests/ublk/test_loop_02.sh    | 1 -
 tools/testing/selftests/ublk/test_loop_03.sh    | 1 -
 tools/testing/selftests/ublk/test_loop_04.sh    | 1 -
 tools/testing/selftests/ublk/test_loop_05.sh    | 1 -
 tools/testing/selftests/ublk/test_loop_06.sh    | 1 -
 tools/testing/selftests/ublk/test_loop_07.sh    | 1 -
 tools/testing/selftests/ublk/test_loop_08.sh    | 1 -
 tools/testing/selftests/ublk/test_null_01.sh    | 1 -
 tools/testing/selftests/ublk/test_null_02.sh    | 1 -
 tools/testing/selftests/ublk/test_null_03.sh    | 1 -
 tools/testing/selftests/ublk/test_null_04.sh    | 1 -
 tools/testing/selftests/ublk/test_stress_01.sh  | 1 -
 tools/testing/selftests/ublk/test_stress_02.sh  | 1 -
 tools/testing/selftests/ublk/test_stress_03.sh  | 1 -
 tools/testing/selftests/ublk/test_stress_04.sh  | 1 -
 tools/testing/selftests/ublk/test_stress_05.sh  | 1 -
 tools/testing/selftests/ublk/test_stress_06.sh  | 1 -
 tools/testing/selftests/ublk/test_stress_07.sh  | 1 -
 tools/testing/selftests/ublk/test_stress_08.sh  | 1 -
 tools/testing/selftests/ublk/test_stress_09.sh  | 1 -
 tools/testing/selftests/ublk/test_stripe_01.sh  | 1 -
 tools/testing/selftests/ublk/test_stripe_02.sh  | 1 -
 tools/testing/selftests/ublk/test_stripe_03.sh  | 1 -
 tools/testing/selftests/ublk/test_stripe_04.sh  | 1 -
 tools/testing/selftests/ublk/test_stripe_05.sh  | 1 -
 tools/testing/selftests/ublk/test_stripe_06.sh  | 1 -
 47 files changed, 5 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_batch_01.sh b/tools/testing/selftests/ublk/test_batch_01.sh
index 9fa9fff5c62f..a18fb39af8be 100755
--- a/tools/testing/selftests/ublk/test_batch_01.sh
+++ b/tools/testing/selftests/ublk/test_batch_01.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="batch_01"
 ERR_CODE=0
 
 if ! _have_feature "BATCH_IO"; then
diff --git a/tools/testing/selftests/ublk/test_batch_02.sh b/tools/testing/selftests/ublk/test_batch_02.sh
index b477f91359e1..7ca384d11987 100755
--- a/tools/testing/selftests/ublk/test_batch_02.sh
+++ b/tools/testing/selftests/ublk/test_batch_02.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="batch_02"
 ERR_CODE=0
 
 if ! _have_feature "BATCH_IO"; then
diff --git a/tools/testing/selftests/ublk/test_batch_03.sh b/tools/testing/selftests/ublk/test_batch_03.sh
index 13a2b3d3a1b9..aca9cf144b55 100755
--- a/tools/testing/selftests/ublk/test_batch_03.sh
+++ b/tools/testing/selftests/ublk/test_batch_03.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="batch_03"
 ERR_CODE=0
 
 if ! _have_feature "BATCH_IO"; then
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 7ff6ce79d62c..bbe031c94a29 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Derive TID from script name: test_<type>_<num>.sh -> <type>_<num>
+# Can be overridden in test script after sourcing this file
+TID=$(basename "$0" .sh)
+TID=${TID#test_}
+
 UBLK_SKIP_CODE=4
 
 _have_program() {
diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
index 21a31cd5491a..26cf3c7ceeb5 100755
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_01"
 ERR_CODE=0
 
 if ! _have_program bpftrace; then
diff --git a/tools/testing/selftests/ublk/test_generic_02.sh b/tools/testing/selftests/ublk/test_generic_02.sh
index 12920768b1a0..1d4b1d6e059c 100755
--- a/tools/testing/selftests/ublk/test_generic_02.sh
+++ b/tools/testing/selftests/ublk/test_generic_02.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_02"
 ERR_CODE=0
 
 if ! _have_program bpftrace; then
diff --git a/tools/testing/selftests/ublk/test_generic_03.sh b/tools/testing/selftests/ublk/test_generic_03.sh
index b551aa76cb0d..8934ea926762 100755
--- a/tools/testing/selftests/ublk/test_generic_03.sh
+++ b/tools/testing/selftests/ublk/test_generic_03.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_03"
 ERR_CODE=0
 
 _prep_test "null" "check dma & segment limits for zero copy"
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_generic_04.sh
index be2292822bbe..2672f9c40fa8 100755
--- a/tools/testing/selftests/ublk/test_generic_04.sh
+++ b/tools/testing/selftests/ublk/test_generic_04.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_04"
 ERR_CODE=0
 
 ublk_run_recover_test()
diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_generic_05.sh
index 9b7f71c16d82..bda5064bc31f 100755
--- a/tools/testing/selftests/ublk/test_generic_05.sh
+++ b/tools/testing/selftests/ublk/test_generic_05.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_05"
 ERR_CODE=0
 
 ublk_run_recover_test()
diff --git a/tools/testing/selftests/ublk/test_generic_06.sh b/tools/testing/selftests/ublk/test_generic_06.sh
index fd42062b7b76..14a05054fcd8 100755
--- a/tools/testing/selftests/ublk/test_generic_06.sh
+++ b/tools/testing/selftests/ublk/test_generic_06.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_06"
 ERR_CODE=0
 
 _prep_test "fault_inject" "fast cleanup when all I/Os of one hctx are in server"
diff --git a/tools/testing/selftests/ublk/test_generic_07.sh b/tools/testing/selftests/ublk/test_generic_07.sh
index cba86451fa5e..8dcfd8978f50 100755
--- a/tools/testing/selftests/ublk/test_generic_07.sh
+++ b/tools/testing/selftests/ublk/test_generic_07.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_07"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_generic_08.sh b/tools/testing/selftests/ublk/test_generic_08.sh
index b222f3a77e12..ce88c31d6b9c 100755
--- a/tools/testing/selftests/ublk/test_generic_08.sh
+++ b/tools/testing/selftests/ublk/test_generic_08.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_08"
 ERR_CODE=0
 
 if ! _have_feature "AUTO_BUF_REG"; then
diff --git a/tools/testing/selftests/ublk/test_generic_09.sh b/tools/testing/selftests/ublk/test_generic_09.sh
index bb6f77ca5522..744d0cdaa242 100755
--- a/tools/testing/selftests/ublk/test_generic_09.sh
+++ b/tools/testing/selftests/ublk/test_generic_09.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_09"
 ERR_CODE=0
 
 if ! _have_feature "AUTO_BUF_REG"; then
diff --git a/tools/testing/selftests/ublk/test_generic_10.sh b/tools/testing/selftests/ublk/test_generic_10.sh
index abc11c3d416b..4b4293b9081f 100755
--- a/tools/testing/selftests/ublk/test_generic_10.sh
+++ b/tools/testing/selftests/ublk/test_generic_10.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_10"
 ERR_CODE=0
 
 if ! _have_feature "UPDATE_SIZE"; then
diff --git a/tools/testing/selftests/ublk/test_generic_11.sh b/tools/testing/selftests/ublk/test_generic_11.sh
index d1f973c8c645..e0dc0b8fe5d6 100755
--- a/tools/testing/selftests/ublk/test_generic_11.sh
+++ b/tools/testing/selftests/ublk/test_generic_11.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_11"
 ERR_CODE=0
 
 ublk_run_quiesce_recover()
diff --git a/tools/testing/selftests/ublk/test_generic_12.sh b/tools/testing/selftests/ublk/test_generic_12.sh
index b4046201b4d9..54b81ddfe9f9 100755
--- a/tools/testing/selftests/ublk/test_generic_12.sh
+++ b/tools/testing/selftests/ublk/test_generic_12.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_12"
 ERR_CODE=0
 
 if ! _have_program bpftrace; then
diff --git a/tools/testing/selftests/ublk/test_generic_13.sh b/tools/testing/selftests/ublk/test_generic_13.sh
index b7aa90b1cb74..922115aa14f4 100755
--- a/tools/testing/selftests/ublk/test_generic_13.sh
+++ b/tools/testing/selftests/ublk/test_generic_13.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_13"
 ERR_CODE=0
 
 _prep_test "null" "check that feature list is complete"
diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/testing/selftests/ublk/test_generic_14.sh
index cd9b44b97c24..178443394ca5 100755
--- a/tools/testing/selftests/ublk/test_generic_14.sh
+++ b/tools/testing/selftests/ublk/test_generic_14.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_14"
 ERR_CODE=0
 
 ublk_run_recover_test()
diff --git a/tools/testing/selftests/ublk/test_generic_15.sh b/tools/testing/selftests/ublk/test_generic_15.sh
index 76379362e0a2..727d0f4610d6 100755
--- a/tools/testing/selftests/ublk/test_generic_15.sh
+++ b/tools/testing/selftests/ublk/test_generic_15.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_15"
 ERR_CODE=0
 
 _test_partition_scan_no_hang()
diff --git a/tools/testing/selftests/ublk/test_generic_16.sh b/tools/testing/selftests/ublk/test_generic_16.sh
index e08af7b685c9..42e8d2e16ec9 100755
--- a/tools/testing/selftests/ublk/test_generic_16.sh
+++ b/tools/testing/selftests/ublk/test_generic_16.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_16"
 ERR_CODE=0
 
 _prep_test "null" "stop --safe command"
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
index 833fa0dbc700..338a235fd82a 100755
--- a/tools/testing/selftests/ublk/test_loop_01.sh
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="loop_01"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
index 874568b3646b..04c52454e2ec 100755
--- a/tools/testing/selftests/ublk/test_loop_02.sh
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="loop_02"
 ERR_CODE=0
 
 _prep_test "loop" "mkfs & mount & umount"
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
index c30f797c6429..6e8f649fe93d 100755
--- a/tools/testing/selftests/ublk/test_loop_03.sh
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="loop_03"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing/selftests/ublk/test_loop_04.sh
index b01d75b3214d..9f6774ec0de6 100755
--- a/tools/testing/selftests/ublk/test_loop_04.sh
+++ b/tools/testing/selftests/ublk/test_loop_04.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="loop_04"
 ERR_CODE=0
 
 _prep_test "loop" "mkfs & mount & umount with zero copy"
diff --git a/tools/testing/selftests/ublk/test_loop_05.sh b/tools/testing/selftests/ublk/test_loop_05.sh
index de2141533074..2b8d99e007be 100755
--- a/tools/testing/selftests/ublk/test_loop_05.sh
+++ b/tools/testing/selftests/ublk/test_loop_05.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="loop_05"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_loop_06.sh b/tools/testing/selftests/ublk/test_loop_06.sh
index 1d1a8a725502..e73f6f4844db 100755
--- a/tools/testing/selftests/ublk/test_loop_06.sh
+++ b/tools/testing/selftests/ublk/test_loop_06.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="loop_06"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_loop_07.sh b/tools/testing/selftests/ublk/test_loop_07.sh
index 493f3fb611a5..264d20e7c530 100755
--- a/tools/testing/selftests/ublk/test_loop_07.sh
+++ b/tools/testing/selftests/ublk/test_loop_07.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="loop_07"
 ERR_CODE=0
 
 _prep_test "loop" "mkfs & mount & umount with user copy"
diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
index ca289cfb2ad4..2caa7ba748fb 100755
--- a/tools/testing/selftests/ublk/test_loop_08.sh
+++ b/tools/testing/selftests/ublk/test_loop_08.sh
@@ -13,7 +13,6 @@ if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
 	exit $UBLK_SKIP_CODE
 fi
 
-TID=loop_08
 
 _prep_test "loop" "end-to-end integrity"
 
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
index c2cb8f7a09fe..eebce8076530 100755
--- a/tools/testing/selftests/ublk/test_null_01.sh
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="null_01"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_null_02.sh b/tools/testing/selftests/ublk/test_null_02.sh
index 8accd35beb55..654bdff39664 100755
--- a/tools/testing/selftests/ublk/test_null_02.sh
+++ b/tools/testing/selftests/ublk/test_null_02.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="null_02"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_null_03.sh b/tools/testing/selftests/ublk/test_null_03.sh
index 0051067b4686..29cd09f06672 100755
--- a/tools/testing/selftests/ublk/test_null_03.sh
+++ b/tools/testing/selftests/ublk/test_null_03.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="null_03"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing/selftests/ublk/test_null_04.sh
index 0b0719ea33a3..7491b8c17f00 100755
--- a/tools/testing/selftests/ublk/test_null_04.sh
+++ b/tools/testing/selftests/ublk/test_null_04.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID=null_04
 
 _prep_test "null" "integrity params"
 
diff --git a/tools/testing/selftests/ublk/test_stress_01.sh b/tools/testing/selftests/ublk/test_stress_01.sh
index 7d3150f057d4..a9322ce496e9 100755
--- a/tools/testing/selftests/ublk/test_stress_01.sh
+++ b/tools/testing/selftests/ublk/test_stress_01.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_01"
 ERR_CODE=0
 
 ublk_io_and_remove()
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index 4bdd921081e5..6c114194f9c9 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_02"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index 3ed4c9b2d8c0..4e81ca0db758 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_03"
 ERR_CODE=0
 
 ublk_io_and_remove()
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index efa8dc33234b..6c6f44b172bc 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_04"
 ERR_CODE=0
 
 ublk_io_and_kill_daemon()
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index 68a194144302..7e9324de2030 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_05"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
index 37188ec2e1f7..c72e5d0b14be 100755
--- a/tools/testing/selftests/ublk/test_stress_06.sh
+++ b/tools/testing/selftests/ublk/test_stress_06.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_06"
 ERR_CODE=0
 
 ublk_io_and_remove()
diff --git a/tools/testing/selftests/ublk/test_stress_07.sh b/tools/testing/selftests/ublk/test_stress_07.sh
index fb061fc26d36..04c2764d5238 100755
--- a/tools/testing/selftests/ublk/test_stress_07.sh
+++ b/tools/testing/selftests/ublk/test_stress_07.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_07"
 ERR_CODE=0
 
 ublk_io_and_kill_daemon()
diff --git a/tools/testing/selftests/ublk/test_stress_08.sh b/tools/testing/selftests/ublk/test_stress_08.sh
index 9abb50ee3d00..37f7d204879a 100755
--- a/tools/testing/selftests/ublk/test_stress_08.sh
+++ b/tools/testing/selftests/ublk/test_stress_08.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_08"
 ERR_CODE=0
 
 ublk_io_and_remove()
diff --git a/tools/testing/selftests/ublk/test_stress_09.sh b/tools/testing/selftests/ublk/test_stress_09.sh
index 87b92b0a2410..53c1e3b2ab30 100755
--- a/tools/testing/selftests/ublk/test_stress_09.sh
+++ b/tools/testing/selftests/ublk/test_stress_09.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_09"
 ERR_CODE=0
 
 ublk_io_and_kill_daemon()
diff --git a/tools/testing/selftests/ublk/test_stripe_01.sh b/tools/testing/selftests/ublk/test_stripe_01.sh
index 4e4f0fdf3c9b..3bc821aadad8 100755
--- a/tools/testing/selftests/ublk/test_stripe_01.sh
+++ b/tools/testing/selftests/ublk/test_stripe_01.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="stripe_01"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_stripe_02.sh b/tools/testing/selftests/ublk/test_stripe_02.sh
index 5820ab2efba4..4a7d2b21a6bf 100755
--- a/tools/testing/selftests/ublk/test_stripe_02.sh
+++ b/tools/testing/selftests/ublk/test_stripe_02.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="stripe_02"
 ERR_CODE=0
 
 _prep_test "stripe" "mkfs & mount & umount"
diff --git a/tools/testing/selftests/ublk/test_stripe_03.sh b/tools/testing/selftests/ublk/test_stripe_03.sh
index 20b977e27814..a1c159d54e53 100755
--- a/tools/testing/selftests/ublk/test_stripe_03.sh
+++ b/tools/testing/selftests/ublk/test_stripe_03.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="stripe_03"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
index 1b51ed2f1d84..0c30bd6c2b3b 100755
--- a/tools/testing/selftests/ublk/test_stripe_04.sh
+++ b/tools/testing/selftests/ublk/test_stripe_04.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="stripe_04"
 ERR_CODE=0
 
 _prep_test "stripe" "mkfs & mount & umount on zero copy"
diff --git a/tools/testing/selftests/ublk/test_stripe_05.sh b/tools/testing/selftests/ublk/test_stripe_05.sh
index 05d71951d710..6ddfa88ad226 100755
--- a/tools/testing/selftests/ublk/test_stripe_05.sh
+++ b/tools/testing/selftests/ublk/test_stripe_05.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="stripe_05"
 ERR_CODE=0
 
 if ! _have_program fio; then
diff --git a/tools/testing/selftests/ublk/test_stripe_06.sh b/tools/testing/selftests/ublk/test_stripe_06.sh
index d06cac7626e2..a2c7bf4cc613 100755
--- a/tools/testing/selftests/ublk/test_stripe_06.sh
+++ b/tools/testing/selftests/ublk/test_stripe_06.sh
@@ -3,7 +3,6 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="stripe_06"
 ERR_CODE=0
 
 _prep_test "stripe" "mkfs & mount & umount on user copy"
-- 
2.47.0

