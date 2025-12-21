Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34F623EAB8
	for <linux-block@vger.kernel.org>; Sun, 21 Dec 2025 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766335334; cv=none; b=j9O2AlJM/WJJYChTLNSYts7cRzKt7zXe7IMMqxuDSOrvDrlj83Y+0nWc1SzeRMD0f5cLmunB0nKwI2E9YXwa9A2LMU0AagwAVnwFa3d6+BGBZyfq8u4N83754NjLuQ/vrbbWyMgSV8P3S9eGWxKF7/b8XEJCAo8nSDI3rGn33j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766335334; c=relaxed/simple;
	bh=z8qEoSZR75ixLVNP09M5Ehvkn17QwDnpn0rixWHks40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPgMXZhfBtmgyHmUtZyml82MWdA31734FVpDkqNX3Nvg5EW3gYDgo5oHglB/V1rBBLUQPtB8X0s/dU1t/TS9fGYH5Q8wYq7HuUGBYfMV7aw6zXQMMfQCIAowPQVNG9g8yMpsKUX9Z9NIqU53Ik0hzVQs5Dv0sZQme1HNwU2igbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dk5oGq5Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dk5oGq5Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766335331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdaQ/LJwYRTVPJ3DRN/BJVij5uh10+ieo3HqgJ09/04=;
	b=dk5oGq5QRPD786Yta5EcvrGrS/AOpUBOtE17o/PVW/X93G2wTNeS7FMFo2Ejr2AbWXPSCl
	Sx978ZadHg7h5bia4Ji3/Td521znEpUbGRwdTTFqLVG2CudlV8c5Sdg2gSma2n+rpgKi42
	I/pTBy9XPNd0xIH2SVSlrCKnY2ujjms=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-118-IF7G1hJwOba6wCF5YkU3rw-1; Sun,
 21 Dec 2025 11:42:06 -0500
X-MC-Unique: IF7G1hJwOba6wCF5YkU3rw-1
X-Mimecast-MFC-AGG-ID: IF7G1hJwOba6wCF5YkU3rw_1766335325
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB5BF19560B2;
	Sun, 21 Dec 2025 16:42:04 +0000 (UTC)
Received: from localhost (unknown [10.72.112.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B4CAC19560B2;
	Sun, 21 Dec 2025 16:42:03 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Yoav Cohen <yoav@nvidia.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/3] selftests/ublk: fix Makefile to rebuild on header changes
Date: Mon, 22 Dec 2025 00:41:43 +0800
Message-ID: <20251221164145.1703448-4-ming.lei@redhat.com>
In-Reply-To: <20251221164145.1703448-1-ming.lei@redhat.com>
References: <20251221164145.1703448-1-ming.lei@redhat.com>
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
 tools/testing/selftests/ublk/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index eb0e6cfb00ad..fb7b2273e563 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -53,8 +53,10 @@ TEST_GEN_PROGS_EXTENDED = kublk
 
 include ../lib.mk
 
-$(TEST_GEN_PROGS_EXTENDED): kublk.c null.c file_backed.c common.c stripe.c \
-	fault_inject.c
+LOCAL_HDRS += kublk.h ublk_dep.h utils.h
+
+$(TEST_GEN_PROGS_EXTENDED): $(LOCAL_HDRS) \
+	kublk.c null.c file_backed.c common.c stripe.c fault_inject.c
 
 check:
 	shellcheck -x -f gcc *.sh
-- 
2.47.0

