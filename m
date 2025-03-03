Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55604211A05
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005854; cv=none; b=U6rOPzKsid9GESB487b6337r1Anf+P+RmJRT4WIKA19tTENIMdQnQQR+PCUnyjcafXtDVguIwUrYfup9RLlzoiW0yhH1zv+10nxjzVGrPO/iUOP/fO+1/xsLCa/mk9BsT3zPoeUK3FLhwRr8WFlMEeMKiRtJ2C6BOyFQ0WkqSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005854; c=relaxed/simple;
	bh=yuCX0pCjKItWYfTkXXjha3xws1B9peMkdKmDwYsrDVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rt73GedK7X9nbCPAj9RobQXXmeYzgsMjW7nqm3uyJO4JOIPO09oFOQASgqh2KH8ekdQ5OEWwolYZt8LXicyZY93kv1NoaVcdWYv9/q62FlcsBP+JISrylByvRjzPv+fuwGSKVFtoovstOrkUoi0UcYF1TVZwZ/+kv+lg1jx0BUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fy1Dh8V1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy1Dh8V1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhDWF1mcH5ShKE+FcXGAer8edgRkzR6VpKbo2AlD2+s=;
	b=Fy1Dh8V1gFUIZpBaUD1qDttk5F1NUcyHnLvvtZUwf7sHK8SsQ/qCaFIPjrHM4y3KLg0VgI
	QE/0CjhU2bgvNqOFNdl5ZiL2fSwZEmeZxV1kyhxIL1Y1Lv0987h5b+IPhLKb4qfj+spY4P
	XCpvJaP/YjrgUSw6tstgdEG9VvNj+2I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-c1FGb191PkmbU5GWBLfu7g-1; Mon,
 03 Mar 2025 07:44:09 -0500
X-MC-Unique: c1FGb191PkmbU5GWBLfu7g-1
X-Mimecast-MFC-AGG-ID: c1FGb191PkmbU5GWBLfu7g_1741005848
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B64C01954202;
	Mon,  3 Mar 2025 12:44:07 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7216E180035F;
	Mon,  3 Mar 2025 12:44:06 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 06/11] selftests: ublk: don't pass ${dev_id} to _cleanup_test()
Date: Mon,  3 Mar 2025 20:43:16 +0800
Message-ID: <20250303124324.3563605-7-ming.lei@redhat.com>
In-Reply-To: <20250303124324.3563605-1-ming.lei@redhat.com>
References: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

More devices can be created in single tests, so simply remove all
ublk devices in _cleanup_test(), meantime remove the ${dev_id} argument
of _cleanup_test().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh  | 2 +-
 tools/testing/selftests/ublk/test_loop_01.sh | 2 +-
 tools/testing/selftests/ublk/test_loop_02.sh | 2 +-
 tools/testing/selftests/ublk/test_loop_03.sh | 2 +-
 tools/testing/selftests/ublk/test_loop_04.sh | 2 +-
 tools/testing/selftests/ublk/test_null_01.sh | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 61044cb58138..d70690281d14 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -89,7 +89,7 @@ _show_result()
 }
 
 _cleanup_test() {
-	"${UBLK_PROG}" del -n "$1"
+	"${UBLK_PROG}" del -a
 }
 
 _add_ublk_dev() {
diff --git a/tools/testing/selftests/ublk/test_loop_01.sh b/tools/testing/selftests/ublk/test_loop_01.sh
index 1d3f934dca4c..48a85796ca43 100755
--- a/tools/testing/selftests/ublk/test_loop_01.sh
+++ b/tools/testing/selftests/ublk/test_loop_01.sh
@@ -24,7 +24,7 @@ fio --name=write_and_verify \
     --bs=4k > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "${dev_id}" "loop"
+_cleanup_test "loop"
 
 _remove_backfile "$backfile_0"
 
diff --git a/tools/testing/selftests/ublk/test_loop_02.sh b/tools/testing/selftests/ublk/test_loop_02.sh
index df06b7804881..0a4b5fadbc73 100755
--- a/tools/testing/selftests/ublk/test_loop_02.sh
+++ b/tools/testing/selftests/ublk/test_loop_02.sh
@@ -15,7 +15,7 @@ dev_id=$(_add_ublk_dev -t loop "$backfile_0")
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "${dev_id}" "loop"
+_cleanup_test "loop"
 
 _remove_backfile "$backfile_0"
 
diff --git a/tools/testing/selftests/ublk/test_loop_03.sh b/tools/testing/selftests/ublk/test_loop_03.sh
index 2255b4296590..5a11356e502c 100755
--- a/tools/testing/selftests/ublk/test_loop_03.sh
+++ b/tools/testing/selftests/ublk/test_loop_03.sh
@@ -26,7 +26,7 @@ fio --name=write_and_verify \
     --bs=4k > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "${dev_id}" "loop"
+_cleanup_test "loop"
 
 _remove_backfile "$backfile_0"
 
diff --git a/tools/testing/selftests/ublk/test_loop_04.sh b/tools/testing/selftests/ublk/test_loop_04.sh
index a797b25213ec..7e0d4dd8127e 100755
--- a/tools/testing/selftests/ublk/test_loop_04.sh
+++ b/tools/testing/selftests/ublk/test_loop_04.sh
@@ -15,7 +15,7 @@ dev_id=$(_add_ublk_dev -t loop -z "$backfile_0")
 _mkfs_mount_test /dev/ublkb"${dev_id}"
 ERR_CODE=$?
 
-_cleanup_test "${dev_id}" "loop"
+_cleanup_test "loop"
 
 _remove_backfile "$backfile_0"
 
diff --git a/tools/testing/selftests/ublk/test_null_01.sh b/tools/testing/selftests/ublk/test_null_01.sh
index b048ddc4ae6f..af11e73b7df6 100755
--- a/tools/testing/selftests/ublk/test_null_01.sh
+++ b/tools/testing/selftests/ublk/test_null_01.sh
@@ -14,6 +14,6 @@ dev_id=$(_add_ublk_dev -t null)
 fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio --rw=readwrite --iodepth=32 --size=256M > /dev/null 2>&1
 ERR_CODE=$?
 
-_cleanup_test "${dev_id}" "null"
+_cleanup_test "null"
 
 _show_result $TID $ERR_CODE
-- 
2.47.0

