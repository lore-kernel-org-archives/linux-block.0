Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41033B955
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876674; cv=none; b=dVEZ5TJZjBcOxfFbliqQD0z0vzB6XSus506geluN8WaJa3TDPNF4hmbpgxwtFGvzbzEkNvMLLMoJaTATNwB1eg2+jromTuhg60QHy+R8c2K9J8eDqhOF8PmYEIm74Vgl8xWP9EuB8RMNlEGU9ZV3kGCVqCZCy4/CzdCf3ImV+EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876674; c=relaxed/simple;
	bh=bQkp+fuZvPQlBfWP8krDPaJqwlhgwWgaJuNMNgSA2qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXDTN5BqIAGI+FP6jYAYcUdjPE2NPLK+1MlhhjBoLYr05yco4QFSkxZlYZpqpD6qoZFFJ8EoHrCu6RteAdLK9bXGtJ/o8Ya0UIaHMuW7PGEYerLTyo5MW+grP0K6R0+pG0PqkLWPDu5A/wear/2n1i8HCA0yLfHbLvAFhG5adaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ai4CEq2j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ai4CEq2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YopHI72cZVQ1jt2xYog+ZbjMg8H9aAdITnh9+EvACzk=;
	b=ai4CEq2j4OuYAZUedFDqT3jlC4pDbQNo/tPy4dXNzZvCGSJBdxKcsJYIvdlsQs36CX01Qg
	xkb9PmO9sHOOXbl+dlhb8s5UR5K84LWZvYjCntBoEvbCbZBSaRrFT5YjZQhI95dI+NQRE8
	jSDWHVu6x8g73AOzL3xBQVQqbBDI30Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-639-9WEpk3NJMHCDN0JZ3ZQx6w-1; Sat,
 31 Jan 2026 11:24:27 -0500
X-MC-Unique: 9WEpk3NJMHCDN0JZ3ZQx6w-1
X-Mimecast-MFC-AGG-ID: 9WEpk3NJMHCDN0JZ3ZQx6w_1769876665
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2F5F1956054;
	Sat, 31 Jan 2026 16:24:24 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE74B1955F43;
	Sat, 31 Jan 2026 16:24:23 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6/9] selftests: ublk: add _ublk_sleep helper for parallel execution
Date: Sun,  1 Feb 2026 00:23:37 +0800
Message-ID: <20260131162342.13872-7-ming.lei@redhat.com>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Add _ublk_sleep() helper function that uses different sleep times
depending on whether tests run in parallel or sequential mode.

Usage: _ublk_sleep <normal_secs> <parallel_secs>

Export JOBS variable from Makefile so test scripts can detect parallel
execution, and use _ublk_sleep in test_part_02.sh to handle the
partition scan delay (1s normal, 5s parallel).

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile        |  1 +
 tools/testing/selftests/ublk/test_common.sh  | 10 ++++++++++
 tools/testing/selftests/ublk/test_part_02.sh |  2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 37e012d3a8a7..1ceae611acb7 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -78,6 +78,7 @@ check:
 # JOBS>1: parallel execution with xargs -P
 # Usage: make run_null JOBS=4
 JOBS ?= 1
+export JOBS
 
 # Auto-detect test groups from TEST_PROGS (test_<group>_<num>.sh -> group)
 TEST_GROUPS := $(shell echo "$(TEST_PROGS)" | tr ' ' '\n' | \
diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 422882c32490..bd27a6875c1a 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -15,6 +15,16 @@ _have_program() {
 	return 1
 }
 
+# Sleep with awareness of parallel execution.
+# Usage: _ublk_sleep <normal_secs> <parallel_secs>
+_ublk_sleep() {
+	if [ "${JOBS:-1}" -gt 1 ]; then
+		sleep "$2"
+	else
+		sleep "$1"
+	fi
+}
+
 _get_disk_dev_t() {
 	local dev_id=$1
 	local dev
diff --git a/tools/testing/selftests/ublk/test_part_02.sh b/tools/testing/selftests/ublk/test_part_02.sh
index acd098deda3a..7d42ab4d6e83 100755
--- a/tools/testing/selftests/ublk/test_part_02.sh
+++ b/tools/testing/selftests/ublk/test_part_02.sh
@@ -33,7 +33,7 @@ _test_partition_scan_no_hang()
 	# The add command should return quickly because partition scan is async.
 	# Now sleep briefly to let the async partition scan work start and hit
 	# the delay in the fault_inject handler.
-	sleep 1
+	_ublk_sleep 1 5
 
 	# Kill the ublk daemon while partition scan is potentially blocked
 	# And check state transitions properly
-- 
2.47.0

