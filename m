Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DDD2C17A1
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769876674; cv=none; b=QdbgOG6YjqMZHFo6XUQtVjrSchHy0aNlgQ33V4l1UCUKaLz0ZRwJhr35ICpvRHBOXZ6zZBq5rPT195CWOFw3RHXCyJyyEyZpfINr3/96Yogq7fI47P8ogKpIe/cqOo0lgOnqpZlYX92v6QjlIwtf62r/BJY7AUo6XBgSh3dV/lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769876674; c=relaxed/simple;
	bh=ASdEsV3C/bgZ7w+jWeqpbRaD40n7PH520TC0ueyTGIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Awcnxw0m+Eo7xtlU4nm8G5IlmbikKbFlvLMtL0yie3dGvA53B7A1HPcPltQQNH0cEovAlymHGjP+IMWrE0RRQnswvcuC7fexr/GKHFVBlTokEp7yzstUNbxG2KF2YxaMBQRlzUf57DtT63ybCX7f+BbM/SrHPAEzmW6nml1jnDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIeUD177; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIeUD177"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769876672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWKP+FGkMLzJhL/AdU11cfpwReTpbKlgetUioMZ1JRA=;
	b=eIeUD177p6UdC9gRXKschVj1Gw+u9XnIOZKwcGOq7cUtaPYEvUGlgZNQJyD62rjotYIkel
	yD8CjQCRUrJhJLB29xWeWy+tFqHEBUmqDj8hxk9nXEpcIh4Hjn3oCri2hhFhnZmzNzCSHa
	RVavHQ0rCVLoZo2uGeWOfE59Unz9wpk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-gOVf6AJIOGSc1AUY2HCSsw-1; Sat,
 31 Jan 2026 11:24:30 -0500
X-MC-Unique: gOVf6AJIOGSc1AUY2HCSsw-1
X-Mimecast-MFC-AGG-ID: gOVf6AJIOGSc1AUY2HCSsw_1769876669
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1EABA1800451;
	Sat, 31 Jan 2026 16:24:29 +0000 (UTC)
Received: from localhost (unknown [10.72.116.22])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0A8C11800109;
	Sat, 31 Jan 2026 16:24:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/9] selftests: ublk: increase timeouts for parallel test execution
Date: Sun,  1 Feb 2026 00:23:38 +0800
Message-ID: <20260131162342.13872-8-ming.lei@redhat.com>
In-Reply-To: <20260131162342.13872-1-ming.lei@redhat.com>
References: <20260131162342.13872-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When running tests in parallel with high JOBS count (e.g., JOBS=64),
the existing timeouts can be insufficient due to system load:

- Increase state wait loops from 20/50 to 100 iterations in
  _recover_ublk_dev(), __ublk_quiesce_dev(), and __ublk_kill_daemon()
  to handle slower state transitions under heavy load

- Add --timeout=20 to udevadm settle calls to prevent indefinite
  hangs when udev event queue is overwhelmed by rapid device
  creation/deletion

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/test_common.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index bd27a6875c1a..c3afd00783a2 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -216,7 +216,7 @@ _create_ublk_dev() {
 	fi
 
 	if [ "$settle" = "yes" ]; then
-		udevadm settle
+		udevadm settle --timeout=20
 	fi
 
 	if [[ "$dev_id" =~ ^[0-9]+$ ]]; then
@@ -240,7 +240,7 @@ _recover_ublk_dev() {
 	local state
 
 	dev_id=$(_create_ublk_dev "recover" "yes" "$@")
-	for ((j=0;j<20;j++)); do
+	for ((j=0;j<100;j++)); do
 		state=$(_get_ublk_dev_state "${dev_id}")
 		[ "$state" == "LIVE" ] && break
 		sleep 1
@@ -260,7 +260,7 @@ __ublk_quiesce_dev()
 		return "$state"
 	fi
 
-	for ((j=0;j<50;j++)); do
+	for ((j=0;j<100;j++)); do
 		state=$(_get_ublk_dev_state "${dev_id}")
 		[ "$state" == "$exp_state" ] && break
 		sleep 1
@@ -279,7 +279,7 @@ __ublk_kill_daemon()
 	daemon_pid=$(_get_ublk_daemon_pid "${dev_id}")
 	state=$(_get_ublk_dev_state "${dev_id}")
 
-	for ((j=0;j<50;j++)); do
+	for ((j=0;j<100;j++)); do
 		[ "$state" == "$exp_state" ] && break
 		kill -9 "$daemon_pid" > /dev/null 2>&1
 		sleep 1
@@ -304,7 +304,7 @@ __remove_ublk_dev_return() {
 
 	_ublk_del_dev "${dev_id}"
 	local res=$?
-	udevadm settle
+	udevadm settle --timeout=20
 	return ${res}
 }
 
-- 
2.47.0

