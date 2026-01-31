Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F833C19A
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876681; cv=none; b=rsglcAD3Umr2VW1Og509cBoeKSzDjo8nQ+nsnqvZ89etLtiqTgxsYGoC0xpfBp/zulvgDHDFWGBkc0TPxxDxGFGcAAaIa8mUjr7HRE/llxDHmLGBEioHhXuS5AL/M7mlZ1j9jMBfTnkZZl/TzjUTrCn1U6SVKANjPik/1Sz/v3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876681; c=relaxed/simple;
	bh=Mi7HlBbjV8Vdn1JpQSjJ7fRseZW5EK0UUZBp8VgJm+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQzOiWBqU8/B7URjS8g140B817Bq9uBPdzWr7EmM1Lf6xxRhkDasr3KE1N/iDU39H3dzpUSNlZxjcigIoKz8/j6TfGkWj1NiR9SRZ7/yGQJfPWfWouduCYJRw9tmatAx8a/4iGFlSKBpnkKJPAPmK7gizKL5teTEOy07bvhHUB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LR0tiafj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LR0tiafj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DaJL7uvk2FPsSFQQYFvfflepbkkZyiAsYpq8gh7jREs=;
	b=LR0tiafj9DMGcA82p6xcXwK0HNCcYym+4ihxkXiNM/R6G8wVQm1/LD/1MWTmR5Y8U9dQ16
	vIGC1+tnQJ3i93zu1G5y0UM4pO7aLxYbwCFnTmPoxi9DUiRmIDO0jwYvJc8Tkmu9jd8N8a
	bUG0B1UXVa/KVME80dVPHR4VLYQssBA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-WMcAsvkqNJeV2d787b3ppQ-1; Sat,
 31 Jan 2026 11:24:34 -0500
X-MC-Unique: WMcAsvkqNJeV2d787b3ppQ-1
X-Mimecast-MFC-AGG-ID: WMcAsvkqNJeV2d787b3ppQ_1769876673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B1DA1956046;
	Sat, 31 Jan 2026 16:24:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6013019560A2;
	Sat, 31 Jan 2026 16:24:31 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 8/9] selftests: ublk: reorganize tests into integrity and recover groups
Date: Sun,  1 Feb 2026 00:23:39 +0800
Message-ID: <20260131162342.13872-9-ming.lei@redhat.com>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Move integrity-focused tests into new 'integrity' group:
- test_null_04.sh -> test_integrity_01.sh
- test_loop_08.sh -> test_integrity_02.sh

Move recovery-focused tests into new 'recover' group:
- test_generic_04.sh -> test_recover_01.sh
- test_generic_05.sh -> test_recover_02.sh
- test_generic_11.sh -> test_recover_03.sh
- test_generic_14.sh -> test_recover_04.sh

Update Makefile to reflect the reorganization.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile              | 14 ++++++++------
 .../ublk/{test_null_04.sh => test_integrity_01.sh} |  0
 .../ublk/{test_loop_08.sh => test_integrity_02.sh} |  0
 .../{test_generic_04.sh => test_recover_01.sh}     |  0
 .../{test_generic_05.sh => test_recover_02.sh}     |  0
 .../{test_generic_11.sh => test_recover_03.sh}     |  0
 .../{test_generic_14.sh => test_recover_04.sh}     |  0
 7 files changed, 8 insertions(+), 6 deletions(-)
 rename tools/testing/selftests/ublk/{test_null_04.sh => test_integrity_01.sh} (100%)
 rename tools/testing/selftests/ublk/{test_loop_08.sh => test_integrity_02.sh} (100%)
 rename tools/testing/selftests/ublk/{test_generic_04.sh => test_recover_01.sh} (100%)
 rename tools/testing/selftests/ublk/{test_generic_05.sh => test_recover_02.sh} (100%)
 rename tools/testing/selftests/ublk/{test_generic_11.sh => test_recover_03.sh} (100%)
 rename tools/testing/selftests/ublk/{test_generic_14.sh => test_recover_04.sh} (100%)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index 1ceae611acb7..a62a06e13006 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -10,18 +10,14 @@ LDLIBS += -lpthread -lm -luring
 TEST_PROGS := test_generic_01.sh
 TEST_PROGS += test_generic_02.sh
 TEST_PROGS += test_generic_03.sh
-TEST_PROGS += test_generic_04.sh
-TEST_PROGS += test_generic_05.sh
 TEST_PROGS += test_generic_06.sh
 TEST_PROGS += test_generic_07.sh
 
 TEST_PROGS += test_generic_08.sh
 TEST_PROGS += test_generic_09.sh
 TEST_PROGS += test_generic_10.sh
-TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
-TEST_PROGS += test_generic_14.sh
 TEST_PROGS += test_generic_16.sh
 
 TEST_PROGS += test_batch_01.sh
@@ -31,7 +27,6 @@ TEST_PROGS += test_batch_03.sh
 TEST_PROGS += test_null_01.sh
 TEST_PROGS += test_null_02.sh
 TEST_PROGS += test_null_03.sh
-TEST_PROGS += test_null_04.sh
 TEST_PROGS += test_loop_01.sh
 TEST_PROGS += test_loop_02.sh
 TEST_PROGS += test_loop_03.sh
@@ -39,7 +34,14 @@ TEST_PROGS += test_loop_04.sh
 TEST_PROGS += test_loop_05.sh
 TEST_PROGS += test_loop_06.sh
 TEST_PROGS += test_loop_07.sh
-TEST_PROGS += test_loop_08.sh
+
+TEST_PROGS += test_integrity_01.sh
+TEST_PROGS += test_integrity_02.sh
+
+TEST_PROGS += test_recover_01.sh
+TEST_PROGS += test_recover_02.sh
+TEST_PROGS += test_recover_03.sh
+TEST_PROGS += test_recover_04.sh
 TEST_PROGS += test_stripe_01.sh
 TEST_PROGS += test_stripe_02.sh
 TEST_PROGS += test_stripe_03.sh
diff --git a/tools/testing/selftests/ublk/test_null_04.sh b/tools/testing/selftests/ublk/test_integrity_01.sh
similarity index 100%
rename from tools/testing/selftests/ublk/test_null_04.sh
rename to tools/testing/selftests/ublk/test_integrity_01.sh
diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_integrity_02.sh
similarity index 100%
rename from tools/testing/selftests/ublk/test_loop_08.sh
rename to tools/testing/selftests/ublk/test_integrity_02.sh
diff --git a/tools/testing/selftests/ublk/test_generic_04.sh b/tools/testing/selftests/ublk/test_recover_01.sh
similarity index 100%
rename from tools/testing/selftests/ublk/test_generic_04.sh
rename to tools/testing/selftests/ublk/test_recover_01.sh
diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_recover_02.sh
similarity index 100%
rename from tools/testing/selftests/ublk/test_generic_05.sh
rename to tools/testing/selftests/ublk/test_recover_02.sh
diff --git a/tools/testing/selftests/ublk/test_generic_11.sh b/tools/testing/selftests/ublk/test_recover_03.sh
similarity index 100%
rename from tools/testing/selftests/ublk/test_generic_11.sh
rename to tools/testing/selftests/ublk/test_recover_03.sh
diff --git a/tools/testing/selftests/ublk/test_generic_14.sh b/tools/testing/selftests/ublk/test_recover_04.sh
similarity index 100%
rename from tools/testing/selftests/ublk/test_generic_14.sh
rename to tools/testing/selftests/ublk/test_recover_04.sh
-- 
2.47.0

