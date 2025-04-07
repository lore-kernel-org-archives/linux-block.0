Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FA324166C
	for <linux-block@vger.kernel.org>; Mon,  7 Apr 2025 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031815; cv=none; b=Xaae57sYgRGaTBdfZDVrM9AtQV78n+KdWSfpnocoUxe5XcilajXqkkJWrfUJ0d6jvh20pXAZpXMIfqvQ/bE1r1kwINCti9GSjCE/b6xnZ/04S2xicAQve4a3O5JAJSYPCFnX1F4hzvXFeKBJIMOple3/6Uu5MW6K4xoOD/JSN7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031815; c=relaxed/simple;
	bh=2jSmoEnLG1+5zyr1I86e0LB7PlUgHhh172BRGqoL5b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQaPdBioAEAQUklYh2ouSg+HUnJCEgZv6S35+Ooihj7mNEWiKO29j9b3BpuQdSZivLctUCBbHYGvQGS2pz+Y4a/QMuAwZvG4rZeGmpg8b/m+3JLsawtzvN+Hi4JsdiR4kWI3TUknbzwFCRh65gDqOxGUoqsLyFj7LlZYUizosi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYHdmu3E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYHdmu3E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744031813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nIzXq/njwHfjqQ/XccWRMo/hYNXoZ+at9NpkEzyq57E=;
	b=WYHdmu3E4qbrtAZqvwhqwA7SUAQlxDAxxqi1ADUX5NJSH8Xv5e8RB0CWySa8GKFye64ESU
	i07FWyL4TX3bRiCzRp4eDxQBxsONdbuqWI+77Jo/X3yLKbKAzjqL3wcIM+q04qJu5tKf86
	jijjRAQBzgAYYfyqu2Rh+VGgqXtlvdI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-PDL5cxREO1KZbCPJvLr7oA-1; Mon,
 07 Apr 2025 09:16:52 -0400
X-MC-Unique: PDL5cxREO1KZbCPJvLr7oA-1
X-Mimecast-MFC-AGG-ID: PDL5cxREO1KZbCPJvLr7oA_1744031810
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DFDD19560BB;
	Mon,  7 Apr 2025 13:16:50 +0000 (UTC)
Received: from localhost (unknown [10.72.120.16])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D93391955BCC;
	Mon,  7 Apr 2025 13:16:48 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 13/13] selftests: ublk: add test_stress_05.sh
Date: Mon,  7 Apr 2025 21:15:24 +0800
Message-ID: <20250407131526.1927073-14-ming.lei@redhat.com>
In-Reply-To: <20250407131526.1927073-1-ming.lei@redhat.com>
References: <20250407131526.1927073-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add test_stress_05.sh for covering removing device with recovery
enabled.

io-hang has been observed with the following patch:

https://lore.kernel.org/linux-block/20250403-ublk_timeout-v3-1-aa09f76c7451@purestorage.com/

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/Makefile         |  1 +
 .../testing/selftests/ublk/test_stress_05.sh  | 64 +++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100755 tools/testing/selftests/ublk/test_stress_05.sh

diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
index d93373384e93..dddc64036aa1 100644
--- a/tools/testing/selftests/ublk/Makefile
+++ b/tools/testing/selftests/ublk/Makefile
@@ -25,6 +25,7 @@ TEST_PROGS += test_stress_01.sh
 TEST_PROGS += test_stress_02.sh
 TEST_PROGS += test_stress_03.sh
 TEST_PROGS += test_stress_04.sh
+TEST_PROGS += test_stress_05.sh
 
 TEST_GEN_PROGS_EXTENDED = kublk
 
diff --git a/tools/testing/selftests/ublk/test_stress_05.sh b/tools/testing/selftests/ublk/test_stress_05.sh
new file mode 100755
index 000000000000..a7071b10224d
--- /dev/null
+++ b/tools/testing/selftests/ublk/test_stress_05.sh
@@ -0,0 +1,64 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
+TID="stress_05"
+ERR_CODE=0
+
+run_io_and_remove()
+{
+	local size=$1
+	local dev_id
+	local dev_pid
+	shift 1
+
+	dev_id=$(_add_ublk_dev "$@")
+	_check_add_dev $TID $?
+
+	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "run ublk IO vs. remove device(ublk add $*)"
+
+	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
+		--rw=readwrite --iodepth=128 --size="${size}" --numjobs=4 \
+		--runtime=40 --time_based > /dev/null 2>&1 &
+	sleep 4
+
+	dev_pid=$(_get_ublk_daemon_pid "$dev_id")
+	kill -9 "$dev_pid"
+
+	if ! __remove_ublk_dev_return "${dev_id}"; then
+		echo "delete dev ${dev_id} failed"
+		return 255
+	fi
+}
+
+ublk_io_and_remove()
+{
+	run_io_and_remove "$@"
+	ERR_CODE=$?
+	if [ ${ERR_CODE} -ne 0 ]; then
+		echo "$TID failure: $*"
+		_show_result $TID $ERR_CODE
+	fi
+}
+
+_prep_test "stress" "run IO and remove device with recovery enabled"
+
+_create_backfile 0 256M
+_create_backfile 1 256M
+
+for reissue in $(seq 0 1); do
+	ublk_io_and_remove 8G -t null -q 4 -g 1 -r 1 -i "$reissue" &
+	ublk_io_and_remove 256M -t loop -q 4 -g 1 -r 1 -i "$reissue" "${UBLK_BACKFILES[0]}" &
+	wait
+done
+
+if _have_feature "ZERO_COPY"; then
+	for reissue in $(seq 0 1); do
+		ublk_io_and_remove 8G -t null -q 4 -g 1 -z -r 1 -i "$reissue" &
+		ublk_io_and_remove 256M -t loop -q 4 -g 1 -z -r 1 -i "$reissue" "${UBLK_BACKFILES[1]}" &
+		wait
+	done
+fi
+
+_cleanup_test "stress"
+_show_result $TID $ERR_CODE
-- 
2.47.0

