Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D58133372A
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876663; cv=none; b=kXt5OatGmqQEjyKxpUTrukOTERxdTcIG9aUwMKVzoqw0yMXBFY4vi1kYJ6/L41PYc0QwmvtZtDc13pDgqH+2mYBfqJVi72kAPmkDItwjWAgUBhIi/BG+BQuvp9XawfKaDsMXmGL5twDQD4gnXPQ9U3KD/rdJNidUSO2DGejnOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876663; c=relaxed/simple;
	bh=t7RigYbywTcN2UXYV9rsbxRoTZfn+gHyO46fmhgo67Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuJGWzw4MOheneSi2Ss8bC90Iz9nv2prQIrgRsXW/yrJySoZGjvIp2Vxg2AsSSA9qRSnPsnhVpQ0X1flrTPfamSqjJjHjWVr6HlGMFVCl31Xu3+Blz6cMhkc08pZHVEubTMp+9It1UwyHsKvx5ab4xTbN846WMDpYNI5b2qSDP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=af7Yv5WZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="af7Yv5WZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xQtAavvVyTyO40H4w5JGNuHyeS5PjWzhlPkBcsuzqE=;
	b=af7Yv5WZ6ChrYPAWhuzIZ5w72N3F6xnkRhuC4cC8TmCT2LOiq+XUBkFDmziVYT+bnLBM8o
	ZT8T1s0OSlBT0tVOTfJ1ZiTViCXkZ0ctWVq6gj3z6/R2BemeAn6qhZcIbfulKJvZxilG7C
	NUHEO29nolZ5uva5a/+2tZL8LhGdMrI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-UQnnNGlVNfuf3zMmO3ixww-1; Sat,
 31 Jan 2026 11:24:17 -0500
X-MC-Unique: UQnnNGlVNfuf3zMmO3ixww-1
X-Mimecast-MFC-AGG-ID: UQnnNGlVNfuf3zMmO3ixww_1769876656
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A8CC18005B0;
	Sat, 31 Jan 2026 16:24:16 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F3BE1800285;
	Sat, 31 Jan 2026 16:24:14 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/9] selftests: ublk: track created devices for per-test cleanup
Date: Sun,  1 Feb 2026 00:23:35 +0800
Message-ID: <20260131162342.13872-5-ming.lei@redhat.com>
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

Track device IDs in UBLK_DEVS array when created. Update
_cleanup_test() to only delete devices created by this test
instead of using 'del -a' which removes all devices.

This prepares for running tests concurrently where each test
should only clean up its own devices.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 0f1fdb0892b4..422882c32490 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -164,7 +164,12 @@ _check_add_dev()
 }
 
 _cleanup_test() {
-	"${UBLK_PROG}" del -a
+	if [ -f "${UBLK_TEST_DIR}/.ublk_devs" ]; then
+		while read -r dev_id; do
+			${UBLK_PROG} del -n "${dev_id}"
+		done < "${UBLK_TEST_DIR}/.ublk_devs"
+		rm -f "${UBLK_TEST_DIR}/.ublk_devs"
+	fi
 
 	_remove_files
 	rmdir ${UBLK_TEST_DIR}
@@ -205,6 +210,7 @@ _create_ublk_dev() {
 	fi
 
 	if [[ "$dev_id" =~ ^[0-9]+$ ]]; then
+		echo "$dev_id" >> "${UBLK_TEST_DIR}/.ublk_devs"
 		echo "${dev_id}"
 	else
 		return 255
@@ -276,6 +282,11 @@ _ublk_del_dev() {
 	local dev_id=$1
 
 	${UBLK_PROG} del -n "${dev_id}"
+
+	# Remove from tracking file
+	if [ -f "${UBLK_TEST_DIR}/.ublk_devs" ]; then
+		sed -i "/^${dev_id}$/d" "${UBLK_TEST_DIR}/.ublk_devs"
+	fi
 }
 
 __remove_ublk_dev_return() {
-- 
2.47.0

