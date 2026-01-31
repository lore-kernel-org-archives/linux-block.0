Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671AC33372A
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876667; cv=none; b=H9K3BikXKRUwyHQ/MJrrN/+Wcj9b3HMxulV5IZfr/MGKFky60yL2MPJx9LvqiTRIAFA/1X+TvLjreUJWxTFPl+u9jTSTkLrzZ6rgUAEeV5Vdgm2UXpXXIi0oyXdAZ7gAU6Z7mJc0j+QPfMzAEfoVMmhVoF3+4f0l0iM4jgtE65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876667; c=relaxed/simple;
	bh=tg6Gn/eHyVT6tmbnKLfmvlgQIumx5RhlAQi88PVwZHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cCEPotGdS2P71q5ERJbI+oc0ZsCmuFLNYXrCe4YCWua9d41IZ1kERalHwTjcejOEa9SMe4iSDeZiX7XXnmUpFOMFcWxa5DY8hq88KtDTUx3aGdgAu2lHqBfAraHdXiVOIWo8cVwwEkLOEKMLWyEvUnDgsVonVXTo8lSB1d+pawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SeeXsW2H; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SeeXsW2H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZAF/6zl1O9RFB+bqoOvDX+a+S7mW9ZQmKVz7lKwO/0Q=;
	b=SeeXsW2HRQJGO66vRBPhfxKx16K9PWnKsNLokZawOmJhQozcwPxVn5S5coBNbtBkGij201
	rh387CKG6ZzoPjVOZ8t/N3GaJ1uPqISGxBzwgyrx4DlBPflYT8ZAdXc++P9qp0zh0rqJjK
	1ptyilDuBBgayY6dqluuCMLENzi/os8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-7LsqMX7TO7y3RBRq11iNIw-1; Sat,
 31 Jan 2026 11:24:22 -0500
X-MC-Unique: 7LsqMX7TO7y3RBRq11iNIw-1
X-Mimecast-MFC-AGG-ID: 7LsqMX7TO7y3RBRq11iNIw_1769876660
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80198195608D;
	Sat, 31 Jan 2026 16:24:20 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 989F61800285;
	Sat, 31 Jan 2026 16:24:19 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 5/9] selftests: ublk: add group-based test targets
Date: Sun,  1 Feb 2026 00:23:36 +0800
Message-ID: <20260131162342.13872-6-ming.lei@redhat.com>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add convenient Makefile targets for running specific test groups:
- run_generic, run_batch, run_null, run_loop, run_stripe, run_stress, etc.
- run_all for running all tests

Test groups are auto-detected from TEST_PROGS using pattern matching
(test_<group>_<num>.sh -> group), and targets are generated dynamically
using define/eval templates.

Supports parallel execution via JOBS variable:
- JOBS=1 (default): sequential with kselftest TAP output
- JOBS>1: parallel execution with xargs -P

Usage examples:
  make run_null           # Sequential execution
  make run_stress JOBS=4  # Parallel with 4 jobs
  make run_all JOBS=8     # Run all tests with 8 parallel jobs

With JOBS=8, running time of `make run_all` is reduced to 2m2s from 6m5s
in my test VM.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index ca8588ed962c..37e012d3a8a7 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -72,3 +72,39 @@ $(OUTPUT)/kublk: $(filter-out $(STANDALONE_UTILS),$(wildcard *.c))
 
 check:
 	shellcheck -x -f gcc *.sh
+
+# Test groups for running subsets of tests
+# JOBS=1 (default): sequential with kselftest TAP output
+# JOBS>1: parallel execution with xargs -P
+# Usage: make run_null JOBS=4
+JOBS ?= 1
+
+# Auto-detect test groups from TEST_PROGS (test_<group>_<num>.sh -> group)
+TEST_GROUPS := $(shell echo "$(TEST_PROGS)" | tr ' ' '\n' | \
+	sed 's/test_\([^_]*\)_.*/\1/' | sort -u)
+
+# Template for group test targets
+# $(1) = group name (e.g., null, generic, stress)
+define RUN_GROUP
+run_$(1): all
+	@if [ $$(JOBS) -gt 1 ]; then \
+		echo $$(filter test_$(1)_%.sh,$$(TEST_PROGS)) | tr ' ' '\n' | \
+			xargs -P $$(JOBS) -n1 sh -c './"$$$$0"' || true; \
+	else \
+		$$(call RUN_TESTS, $$(filter test_$(1)_%.sh,$$(TEST_PROGS))); \
+	fi
+.PHONY: run_$(1)
+endef
+
+# Generate targets for each discovered test group
+$(foreach group,$(TEST_GROUPS),$(eval $(call RUN_GROUP,$(group))))
+
+# Run all tests (parallel when JOBS>1)
+run_all: all
+	@if [ $(JOBS) -gt 1 ]; then \
+		echo $(TEST_PROGS) | tr ' ' '\n' | \
+			xargs -P $(JOBS) -n1 sh -c './"$$0"' || true; \
+	else \
+		$(call RUN_TESTS, $(TEST_PROGS)); \
+	fi
+.PHONY: run_all
-- 
2.47.0

