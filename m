Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0D2AE8B
	for <linux-block@vger.kernel.org>; Sat, 12 Apr 2025 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744425104; cv=none; b=mPVSUu2tsLiWGjuEUEOY5QrDgqxVtbbjL991+pYRE3KsNt40BCghnHK1w6UQp1ubApYvNJbf5cHEAToI/2Swsn5EtzcWut3zvzAfEVYhhAAM/NlYvUqvl/Y2+6dVI8XyDT7YKmue2GNhJRunTZW/Cmu1KwVwuoS5zfDjxof1UIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744425104; c=relaxed/simple;
	bh=QszE5y/jDaQndEB68SWHQB6fFtJRJyTy+Xxpx0nP8cE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgUlZV3LXye9pye2DslSmWLuVCiKBrqFQIGROyKruW97hfjoUK4wKZku7nUDaBAm6M0cLWlUO3r32ztK/J/PBzavDtXS1bBRrHcVr8B9g5HArJXWo9J4t8lvCsmlIAiX8tPooMq+Z9eDubBqreBU/OsJml8QuLeZFE4Tqc3T2ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbN6sXAd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbN6sXAd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744425102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5tIBAFnb1TtE4ar8cgCwq2M/VJ2ZPiVwvk99itUjOIQ=;
	b=QbN6sXAdPvIloN5Njeh+SghbJdNU5q+yZNGOqI4KHBopXFHfuBY1LeA4WJJVoDLCKmmKOy
	EIvjYxsaGv6tjP7xqFkd0D59atnlZWcrsGkGOZFNQkHvz8wtb6iz7fMISvZO/BOX9cBCxY
	bRnWzk4HL8g98o3yv3pPMw2xlxfQJ0o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-dyEO5O6ZN4iCtIUm93bNvQ-1; Fri,
 11 Apr 2025 22:31:38 -0400
X-MC-Unique: dyEO5O6ZN4iCtIUm93bNvQ-1
X-Mimecast-MFC-AGG-ID: dyEO5O6ZN4iCtIUm93bNvQ_1744425097
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6D176195608A;
	Sat, 12 Apr 2025 02:31:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.41])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 430AD180AF7C;
	Sat, 12 Apr 2025 02:31:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 13/13] selftests: ublk: move creating UBLK_TMP into _prep_test()
Date: Sat, 12 Apr 2025 10:30:29 +0800
Message-ID: <20250412023035.2649275-14-ming.lei@redhat.com>
In-Reply-To: <20250412023035.2649275-1-ming.lei@redhat.com>
References: <20250412023035.2649275-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

test may exit early because of missing program or not having required
feature before calling _prep_test(), then $UBLK_TMP isn't cleaned.

Fix it by moving creating $UBLK_TMP into _prep_test(), any resources
created since _prep_test() will be cleaned by _cleanup_test().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index e822b2a2729a..9fc111f64576 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -114,6 +114,7 @@ _prep_test() {
 	local type=$1
 	shift 1
 	modprobe ublk_drv > /dev/null 2>&1
+	UBLK_TMP=$(mktemp ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 }
 
@@ -338,7 +339,6 @@ _ublk_test_top_dir()
 	cd "$(dirname "$0")" && pwd
 }
 
-UBLK_TMP=$(mktemp ublk_test_XXXXX)
 UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
-- 
2.47.0

