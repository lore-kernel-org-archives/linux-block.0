Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CFE1A9B4C
	for <linux-block@vger.kernel.org>; Mon,  2 Jun 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870616; cv=none; b=dHZF//yhCZr0bV+mo7yo7Hk6CmYvmeVmcSH8EJ1w6L5fc3Nep8HEmN/5o4LoQEnpL3lElsOc6HZ2/BjccccMvc/3bQfZZTNy/Wnmx56fzrQwkuCoz3mNnLYqIdihxQ5VSeHJE8RHX/6SWftZyC+KGjSm/mK1IeL+3sZgR4lO/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870616; c=relaxed/simple;
	bh=Fy8kXoS2tl5VOHJ5gtfuypbNyTwgwoHtq7g7o9O8G5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G+AIOCGkaG4NOj0bk348gmMNP+KPiPFL+09Q0+argkl1iBqimhG96MVNGhBOIixBM+/vbmq2yLxMmBTUWyjKEsrYFOyOyNkNcjy15phPh1p49NLym8TRHfn6KpN1TyhoX3CkyPOhcoWVgIY5zSB7tbDfE+euEz8VaLMZjiut5hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H5zy2v1F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H5zy2v1F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748870613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YUIEYIqCeyWVtkqFGxA7+ydBEYmbUAE9Ilajy3dbYsY=;
	b=H5zy2v1F0+Zp2InMDVNEIbQvoTeGJTCeBXvUeDs+8oRi3x+wAvgfGwRd4gzETs61MPuHJh
	q8vwFSYBUZKnwjLDCK0aPKCub4ECS4uQdtuUXA9h1Xw8O7Tucz3bPj5tlkZ/euJkOTzriZ
	glS/E9WGQWqcs409AJ1asixkXHYg1vA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-195-ooPEV3L2NrebTgSPmHAm6Q-1; Mon,
 02 Jun 2025 09:21:27 -0400
X-MC-Unique: ooPEV3L2NrebTgSPmHAm6Q-1
X-Mimecast-MFC-AGG-ID: ooPEV3L2NrebTgSPmHAm6Q_1748870486
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E30F18001D1;
	Mon,  2 Jun 2025 13:21:26 +0000 (UTC)
Received: from localhost (unknown [10.72.116.4])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20C771955F2C;
	Mon,  2 Jun 2025 13:21:24 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] selftests: ublk: cover PER_IO_DAEMON in more stress tests
Date: Mon,  2 Jun 2025 21:21:13 +0800
Message-ID: <20250602132113.1398645-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

We have stress_03, stress_04 and stress_05 for checking new feature vs.
stress IO & device removal & ublk server crash & recovery, so let the
three existing stress tests cover PER_IO_DAEMON.

Then stress_06 can be removed, since the same test function is included in
stress_03.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 .../testing/selftests/ublk/test_stress_03.sh  |  8 +++++
 .../testing/selftests/ublk/test_stress_04.sh  |  7 ++++
 .../testing/selftests/ublk/test_stress_05.sh  |  7 ++++
 .../testing/selftests/ublk/test_stress_06.sh  | 36 -------------------
 4 files changed, 22 insertions(+), 36 deletions(-)
 delete mode 100755 tools/testing/selftests/ublk/test_stress_06.sh

diff --git a/tools/testing/selftests/ublk/test_stress_03.sh b/tools/testing/selftests/ublk/test_stress_03.sh
index 7d728ce50774..6eef282d569f 100755
--- a/tools/testing/selftests/ublk/test_stress_03.sh
+++ b/tools/testing/selftests/ublk/test_stress_03.sh
@@ -41,5 +41,13 @@ if _have_feature "AUTO_BUF_REG"; then
 fi
 wait
 
+if _have_feature "PER_IO_DAEMON"; then
+	ublk_io_and_remove 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
+	ublk_io_and_remove 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_remove 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_remove 8G -t null -q 4 -z --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &
+fi
+wait
+
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
index 9bcfa64ea1f0..40d1437ca298 100755
--- a/tools/testing/selftests/ublk/test_stress_04.sh
+++ b/tools/testing/selftests/ublk/test_stress_04.sh
@@ -38,6 +38,13 @@ if _have_feature "AUTO_BUF_REG"; then
 	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
 fi
+
+if _have_feature "PER_IO_DAEMON"; then
+	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
+fi
 wait
 
 _cleanup_test "stress"
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
index bcfc904cefc6..566cfd90d192 100755
--- a/tools/testing/selftests/ublk/test_stress_05.sh
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -69,5 +69,12 @@ if _have_feature "AUTO_BUF_REG"; then
 	done
 fi
 
+if _have_feature "PER_IO_DAEMON"; then
+	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" &
+	ublk_io_and_remove 256M -t loop -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_remove 8G -t null -q 4 --nthreads 8 --per_io_tasks -r 1 -i "$reissue"  &
+fi
+wait
+
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/test_stress_06.sh b/tools/testing/selftests/ublk/test_stress_06.sh
deleted file mode 100755
index 3aee8521032e..000000000000
--- a/tools/testing/selftests/ublk/test_stress_06.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-
-. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
-TID="stress_06"
-ERR_CODE=0
-
-ublk_io_and_remove()
-{
-	run_io_and_remove "$@"
-	ERR_CODE=$?
-	if [ ${ERR_CODE} -ne 0 ]; then
-		echo "$TID failure: $*"
-		_show_result $TID $ERR_CODE
-	fi
-}
-
-if ! _have_program fio; then
-	exit "$UBLK_SKIP_CODE"
-fi
-
-_prep_test "stress" "run IO and remove device with per_io_tasks"
-
-_create_backfile 0 256M
-_create_backfile 1 128M
-_create_backfile 2 128M
-
-ublk_io_and_remove 8G -t null -q 4 --nthreads 5 --per_io_tasks &
-ublk_io_and_remove 256M -t loop -q 4 --nthreads 3 --per_io_tasks \
-        "${UBLK_BACKFILES[0]}" &
-ublk_io_and_remove 256M -t stripe -q 4 --nthreads 4 --per_io_tasks \
-        "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
-
-_cleanup_test "stress"
-_show_result $TID $ERR_CODE
-- 
2.47.1

