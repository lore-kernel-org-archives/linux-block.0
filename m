Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48A1A7253
	for <linux-block@vger.kernel.org>; Mon, 19 May 2025 03:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747624601; cv=none; b=H0GcT5JggQQFpsoKeYhNfkpctl5IP0WZhcxi/zo87ChVkxw55wc2WQSzLfWO/NFffzm3GTrRY/dHRksj27wc5PNvhMTM2rqyPH+pcCy+HKBOSBUew35O1TiDTthhYHk9AcO71GogDt21KapumzZYZr3Cnk0JWEUf3JdSP8tR3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747624601; c=relaxed/simple;
	bh=kBozIQ+DQn78JIsBNl2kPRlXZMe+c8FZkEx1JxdVyVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nKfk1a6BDAF4YKp6yeo18QzzxftsC3uVTVpmSiZlL+hLIO8m4nYnpUrbaU5vh7T47gp12S+dwRDCDWmAsBuSYRCzWStV7mlXOlijmBmBFSthCpnPAWySkZiJYgxJeL+BA8xgkDZQRwaQFnW+vu5PX3vNq0NMdUuMyRfdGOA2PrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HCb5FTz7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCb5FTz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747624598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X7G4rRanEhJtsda6pXaV8KssqjaPQofWrZZ5INO9RFA=;
	b=HCb5FTz78//kX17EbunEod/Qk3CcZG3O3Keasp66l2YzyGJeS/2Dty4zfSNkpPkbY8EMYB
	/t5EFuW70eVPoDcqW/edoMLMRMhgrVI71HAsvDmvVn8PN3nhCBrztFhJjB2bp05vB1eY1E
	7XK/RI+JMpfuriL4wleWQ3Shwyz6bcY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-QsipI9AuNV6QOqR0g5O8og-1; Sun,
 18 May 2025 23:16:34 -0400
X-MC-Unique: QsipI9AuNV6QOqR0g5O8og-1
X-Mimecast-MFC-AGG-ID: QsipI9AuNV6QOqR0g5O8og_1747624593
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 152341956094;
	Mon, 19 May 2025 03:16:33 +0000 (UTC)
Received: from localhost (unknown [10.72.116.129])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAB6430001AB;
	Mon, 19 May 2025 03:16:30 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jared Holzman <jholzman@nvidia.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] selftests: ublk: make IO & device removal test more stressful
Date: Mon, 19 May 2025 11:16:20 +0800
Message-ID: <20250519031620.245749-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

__run_io_and_remove() is used in several stress tests for running heavy
IO vs. removing device meantime.

However, sequential `readwrite` is taken in the fio script, which isn't
correct, we should take random IO for saturating ublk device.

Also turns out '--num_jobs=4' isn't stressful enough, so change it to
'--num_jobs=$(nproc)'.

Finally we don't cover single queue test in `test_stress_02.sh`, so add
single queue test which can trigger request tag recycling easier.

With above change the issue in #1 can be reproduced reliably in stress_02.sh.

Cc: Jared Holzman <jholzman@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link:https://lore.kernel.org/linux-block/mruqwpf4tqenkbtgezv5oxwq7ngyq24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn/ #1
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh    |  2 +-
 tools/testing/selftests/ublk/test_stress_02.sh | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index a81210ca3e99..c17fd66b73ac 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -251,7 +251,7 @@ __run_io_and_remove()
 	local kill_server=$3
 
 	fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
-		--rw=readwrite --iodepth=256 --size="${size}" --numjobs=4 \
+		--rw=randrw --norandommap --iodepth=256 --size="${size}" --numjobs="$(nproc)" \
 		--runtime=20 --time_based > /dev/null 2>&1 &
 	sleep 2
 	if [ "${kill_server}" = "yes" ]; then
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index 1a9065125ae1..4bdd921081e5 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -25,10 +25,12 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
-ublk_io_and_kill_daemon 8G -t null -q 4 &
-ublk_io_and_kill_daemon 256M -t loop -q 4 "${UBLK_BACKFILES[0]}" &
-ublk_io_and_kill_daemon 256M -t stripe -q 4 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-wait
+for nr_queue in 1 4; do
+	ublk_io_and_kill_daemon 8G -t null -q "$nr_queue" &
+	ublk_io_and_kill_daemon 256M -t loop -q "$nr_queue" "${UBLK_BACKFILES[0]}" &
+	ublk_io_and_kill_daemon 256M -t stripe -q "$nr_queue" "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+	wait
+done
 
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE
-- 
2.47.1

