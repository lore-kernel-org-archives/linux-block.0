Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80C533A9EE
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 16:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769703651; cv=none; b=GQe/7xTwgXXpEoEFzPxkrsWFQwysW/1L0RL0anTmUGj6cnkiiAuMvDmDOCJyMlk7bFV8kGgqyom+i5uOdF/Qnu2imT2w0iYPapk8VQOgozwWk6jZak6PNf23ydbnueOux+GEEocTfpqk2nFFHmUdearavq4wcAdgguWJ5Ccc+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769703651; c=relaxed/simple;
	bh=BqVSmQuPWvev/AZ0GLr9Tli+Jjt2URdSgp08t6Gwe1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWRdT4HV642BKhDcKFpDY5wXZNLvdsPGKkndOfvtJHexguu+hBu2Uvf8LP6YfX4JGoYXWGHK20J9MveCm/IdhvN7cfmk1LEKq2vR439hMbyIAIfzA1phfV/yoYWMRq2LQG0N/ZIgpdNkYWrxidKveel9EWI/31XozMeUVWIG820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OIohgNhS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OIohgNhS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769703648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eOMPfpObACjxjb1Pf++idWki8zpk3vVdNvgoi7qQA+o=;
	b=OIohgNhSgyvnaWCct68hr7VprVu462jiikjrNTPFPro51iFwRcdMW0Bo5jsAwZ0PCyZ3CT
	RafAaAUjBg3QAfZlqq6Kf55wzagG1lQ6Y2RQ2utcEKUaDbL7cxKgqhJQWf5/zbPojwSzeN
	WQ6IvtNd2wP5PMViKsBClIQL9Q2p1M4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-Nh1OGlurObawXthCw5-apA-1; Thu,
 29 Jan 2026 11:20:42 -0500
X-MC-Unique: Nh1OGlurObawXthCw5-apA-1
X-Mimecast-MFC-AGG-ID: Nh1OGlurObawXthCw5-apA_1769703641
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 27B7F18005BD;
	Thu, 29 Jan 2026 16:20:41 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2A01519560B2;
	Thu, 29 Jan 2026 16:20:39 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 8/9] selftests: ublk: mark each test start and end time in dmesg
Date: Fri, 30 Jan 2026 00:19:57 +0800
Message-ID: <20260129162001.3532311-9-ming.lei@redhat.com>
In-Reply-To: <20260129162001.3532311-1-ming.lei@redhat.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

From: Alexander Atanasov <alex@zazolabs.com>

Log test start and end time in dmesg, so generated log messages
during the test run can be linked to specific test from the test
suite.

Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
(switch to `date +%F %T`)
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index bbe031c94a29..dd4eff97610a 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -126,6 +126,7 @@ _prep_test() {
 	modprobe ublk_drv > /dev/null 2>&1
 	UBLK_TMP=$(mktemp ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
+	echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee /dev/kmsg
 }
 
 _remove_test_files()
@@ -170,6 +171,7 @@ _cleanup_test() {
 	"${UBLK_PROG}" del -a
 
 	_remove_files
+	echo "ublk selftest: $TID done at $(date '+%F %T')" | tee /dev/kmsg
 }
 
 _have_feature()
-- 
2.47.0

