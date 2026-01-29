Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D722F218E91
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 03:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656539; cv=none; b=h1NPBcWU2kxrnxZB7U58H5EINS8B9poGyJqGORPFOh9jSVkcyyXS9AbdnLBYcLWM6tCnMhCWZP2+zxINJGmbRbck4O88UfBQ2sDCHmgyzFp6xjq0py2uFqwuESi9BZEhTikWZPYQZhpeE5AO+YFSCa3QDiF6PBS4IehrmekdLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656539; c=relaxed/simple;
	bh=CJD3+PbZYUotdCRfnn+fuUJZjtpTR6alvBIYcc9a/1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiuX42ETyjgEnEMrjHyBe7PQqBsNpsegdLROuz96h0Al6JQCaVlZtsbCygrnVx2AC2+y/TMWwFa6J8lelhfN9vSv+ffMu+YCzaeDaDGwDS79rcJkeGkmQJxMSB1HFaquIKkQ/OsCe8PLPCj+84k4cgxnhC1QMfERE2m09vzbMog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yv4DDpJb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yv4DDpJb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769656536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4TQDdt7kxSh+2wErYnjyAMbg9zC4DxeCjIBk+yCXpc4=;
	b=Yv4DDpJbUkaaff289bvwwh9c5KCkWUYVUC7h0lwbPXqCFS+NZmEcDWc5fItrp1aFP2fDI6
	ui1wHZYPEnN2aizZXBveWQhsNENNXebGxYjdmkL68gkId+9iKqBuD4EQ3Y6JTgy35qtpp5
	XlA83l8Co9AxTkz3rvIdgMdTywTho+k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-vDeaRkyOPpGygyQU5F_FrQ-1; Wed,
 28 Jan 2026 22:15:33 -0500
X-MC-Unique: vDeaRkyOPpGygyQU5F_FrQ-1
X-Mimecast-MFC-AGG-ID: vDeaRkyOPpGygyQU5F_FrQ_1769656532
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E4B9019560B5;
	Thu, 29 Jan 2026 03:15:31 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AC70630001A2;
	Thu, 29 Jan 2026 03:15:29 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/5] selftests: ublk: mark each test start and end time in dmesg
Date: Thu, 29 Jan 2026 11:14:58 +0800
Message-ID: <20260129031501.3403688-5-ming.lei@redhat.com>
In-Reply-To: <20260129031501.3403688-1-ming.lei@redhat.com>
References: <20260129031501.3403688-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
index 687884cbaec1..cfe4b107f412 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -125,6 +125,7 @@ _prep_test() {
 	modprobe ublk_drv > /dev/null 2>&1
 	UBLK_TMP=$(mktemp ublk_test_XXXXX)
 	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
+	echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee /dev/kmsg
 }
 
 _remove_test_files()
@@ -169,6 +170,7 @@ _cleanup_test() {
 	"${UBLK_PROG}" del -a
 
 	_remove_files
+	echo "ublk selftest: $TID done at $(date '+%F %T')" | tee /dev/kmsg
 }
 
 _have_feature()
-- 
2.47.0

