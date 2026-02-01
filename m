Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A0319DFAB
	for <linux-block@vger.kernel.org>; Sun,  1 Feb 2026 03:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769915461; cv=none; b=LzUHYHX4sHSaVnsrZ56w6dcXUI7+OP/O8ZDGrdVNzrPpNB0x8lTJHwNS6HQyoArvoyDzsULd2MPB9BrXw5UVFQmIQK7jxhjribUuGijXqmB330g/kV3DSwOXLVHIS4Y2gmW8iBwKaCvwbQcshIrc1VaUNfL0qydII34toOKSGww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769915461; c=relaxed/simple;
	bh=kySO6kgsOnMEkK4cuGv1Ms3P4Tomt2H3oaizHdGnoxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYOtx6GX+tBO65i3wUhqFXkYUDP3kitSXZ3Ufb8C85g+cI2FS1T0riougoAUb2EPyECLUI553A/w+VzUxo8z/EiD6U4uNTPIAXoXbgRQx6dJH3318cT6Aa1jRl9LbMRwVGsDnWNZ9Pl8oQgw7jKyd4PS0OocLG2b+V0QJu8128A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ImXA4z18; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ImXA4z18"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769915458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tnaaXj0sQiuXI+9/Qo7y3kATpfkrwPsyjJgzfLgY+pw=;
	b=ImXA4z189qKXDgS5Yvxu45iVZMwM+oIGjORqNcpS98Xh3mnTF8w9F/ED8WJeoOkjtC59gf
	gM8YaJZdFlcfsYX3tb8oFg9gjVN+MR22l1P99kYwIol2zoa79vWI+foC/qXx2sB++sFvh5
	o5Ugh4f+29hIgTGJQraZvzxaAlYUvHU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-WWgii_PEODez0SnsiJnbCw-1; Sat,
 31 Jan 2026 22:10:57 -0500
X-MC-Unique: WWgii_PEODez0SnsiJnbCw-1
X-Mimecast-MFC-AGG-ID: WWgii_PEODez0SnsiJnbCw_1769915456
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B22A018005A7;
	Sun,  1 Feb 2026 03:10:55 +0000 (UTC)
Received: from localhost (unknown [10.72.116.20])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 87D551800665;
	Sun,  1 Feb 2026 03:10:54 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] selftests: ublk: organize test directories by test ID
Date: Sun,  1 Feb 2026 11:10:44 +0800
Message-ID: <20260201031044.99077-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Set UBLK_TEST_DIR to ${TMPDIR:-./ublktest-dir}/${TID}.XXXXXX to create
per-test subdirectories organized by test ID. This makes it easier to
identify and debug specific test runs.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index c3afd00783a2..163a40007910 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -129,7 +129,9 @@ _prep_test() {
 	local type=$1
 	shift 1
 	modprobe ublk_drv > /dev/null 2>&1
-	UBLK_TEST_DIR=$(mktemp -d ${TMPDIR:-.}/ublktest-dir.XXXXXX)
+	local base_dir=${TMPDIR:-./ublktest-dir}
+	mkdir -p "$base_dir"
+	UBLK_TEST_DIR=$(mktemp -d ${base_dir}/${TID}.XXXXXX)
 	UBLK_TMP=$(mktemp ${UBLK_TEST_DIR}/ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
 	echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee /dev/kmsg
-- 
2.47.1

