Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D133B6F8
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703634; cv=none; b=d0xwoV2aULpuMI5grQRrwFEiDPGhYz5wyJ6vdT2avLcRGAAm3yNJehX8rCYD6r7XYfYzHq7daPvmCC6jJJZZXMm/VDnenWxo95SzdVN/I6GJVnbgpmC1mEFwADkN09Vhqhi+Rig+v4omEFyf4xiV0C8iId3VjT8vKlkWWDvP5Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703634; c=relaxed/simple;
	bh=dLsbHhAVulF6ryh5UdukMYgjt/4nID8XYS4Yczwn2C0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDgmD6A3Z50etgIk3iTtr+8Rnd8Qlp7yzf3QdQ8WsPrqWsjz8sCJ/zgta/yZZ6YWldc9oLJXBk+C02SlkkFnQqt8MirDoDupGhuURKs7r2ETwAItSXJ2HvbvnIv1poRon6WhJO9X7oW2wno+ack7DoT0ZYJAixK3VCdxyZrKDTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DqdOh1Fj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqdOh1Fj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WyGz04UMqFR2NX25D9q4M9slI79hjIGMDIupe/sFLU=;
	b=DqdOh1FjShXUOVp6sl0fyTpO4tsSPNvQbtkZ/xBYbdymRWo5O0YAvf5BF/6BhxDfOZE+Bq
	43IPI8xXqp/kaw4G/OKwxvbN0NXOgdn1CsxabKEv1M3PV1ZD+o67KTK52rmZh9DSORM5XI
	taFZ3H7bHXe1XYONKaAnSmBdymeG2cQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-2roCZY3iPqSh8qackWJsuw-1; Thu,
 29 Jan 2026 11:20:30 -0500
X-MC-Unique: 2roCZY3iPqSh8qackWJsuw-1
X-Mimecast-MFC-AGG-ID: 2roCZY3iPqSh8qackWJsuw_1769703629
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 326DD1800350;
	Thu, 29 Jan 2026 16:20:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 284AE3000218;
	Thu, 29 Jan 2026 16:20:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/9] selftests: ublk: rename test_generic_15 to test_part_02
Date: Fri, 30 Jan 2026 00:19:54 +0800
Message-ID: <20260129162001.3532311-6-ming.lei@redhat.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This test exercises partition scanning behavior, so move it to
the test_part_* group for consistency.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile                           | 2 +-
 .../selftests/ublk/{test_generic_15.sh => test_part_02.sh}      | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/ublk/{test_generic_15.sh => test_part_02.sh} (100%)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index bc5bd7d1381d..ca8588ed962c 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -22,7 +22,6 @@ TEST_PROGS += test_generic_11.sh
 TEST_PROGS += test_generic_12.sh
 TEST_PROGS += test_generic_13.sh
 TEST_PROGS += test_generic_14.sh
-TEST_PROGS += test_generic_15.sh
 TEST_PROGS += test_generic_16.sh
 
 TEST_PROGS += test_batch_01.sh
@@ -49,6 +48,7 @@ TEST_PROGS += test_stripe_05.sh
 TEST_PROGS += test_stripe_06.sh
 
 TEST_PROGS += test_part_01.sh
+TEST_PROGS += test_part_02.sh
 
 TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
diff --git a/tools/testing/selftests/ublk/test_generic_15.sh b/tools/testing/selftests/ublk/test_part_02.sh
similarity index 100%
rename from tools/testing/selftests/ublk/test_generic_15.sh
rename to tools/testing/selftests/ublk/test_part_02.sh
-- 
2.47.0

