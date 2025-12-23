Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4F2D46B6
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766460492; cv=none; b=SFD0S6Hea4RPuWkAHPyJlMtH5HLrmf+c2UyiS7QAdYW1v1nMx06tHvHAkzx2c7RRqIIny95srJK5D7qNNmXS2yppiYU5m+wPzKQdJzMWDsKc4BkPla4mbZBx4gKWpVeXHh7F87yxuN6VLx0Nqf3C8kylKjtB1GzkGllmJlC6T8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766460492; c=relaxed/simple;
	bh=7mSXR/Hv2azo4CL35/JqVDXfK1OOLsFjwQ0/eWu60Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrfFkPPwnnHtR7gJtXtIH0E9Sbkxo9BQv4D6zSBE2UkUH9RLFFrKBOP/3N/Xn+WCqzjucK73HR+2uR26viKyk1xRn+bZpCFTA9OvsgZPBl3QLzuKsyWtnBzf7qzA5RwK1LXAiFgdozYdoPviM4MM4x9OuoLml6kVtEfjZ+cMmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbONvFVd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbONvFVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766460486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QglKSj9AFzwLnX1z95o9MmglqljdaUGAEnD4bIRVII8=;
	b=GbONvFVdv91EMcNAej3hI/3tKJTYeZgTfxQ+kvuENhK4uxNWmTKVeHdr20ViCSCHKDB0w/
	ycavGfWisXPLquEw0bhJhLTcI0bWm3yzOPCR/xLrok+V9ZEpEUcPP5e1BE0pphqPStE6gQ
	hYWkMPxTmegKpdbH8EKDi/U2Vpee+Xw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-DJWcMpyJPxSuEcTr2-01ew-1; Mon,
 22 Dec 2025 22:28:04 -0500
X-MC-Unique: DJWcMpyJPxSuEcTr2-01ew-1
X-Mimecast-MFC-AGG-ID: DJWcMpyJPxSuEcTr2-01ew_1766460483
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BCC5195F156;
	Tue, 23 Dec 2025 03:28:03 +0000 (UTC)
Received: from localhost (unknown [10.72.116.97])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B16B19560A7;
	Tue, 23 Dec 2025 03:28:02 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/3] selftests/ublk: fix Makefile to rebuild on header changes
Date: Tue, 23 Dec 2025 11:27:42 +0800
Message-ID: <20251223032744.1927434-4-ming.lei@redhat.com>
In-Reply-To: <20251223032744.1927434-1-ming.lei@redhat.com>
References: <20251223032744.1927434-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Add header dependencies to kublk build rule so that changes to
kublk.h, ublk_dep.h, or utils.h trigger a rebuild.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index eb0e6cfb00ad..06ba6fde098d 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -51,10 +51,10 @@ TEST_PROGS += test_stress_07.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
+LOCAL_HDRS += $(wildcard *.h)
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
-	fault_inject.c
+$(TEST_GEN_PROGS_EXTENDED): $(wildcard *.c)
 
 check:
 	shellcheck -x -f gcc *.sh
-- 
2.47.0

