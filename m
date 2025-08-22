Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112681F418D
	for <linux-block@vger.kernel.org>; Fri, 22 Aug 2025 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892939; cv=none; b=S1q3HVUj2Jzh90ao6nsf4dtpAhyg1644+lixBenhorH5rB4MbEQVxKyoi8QlckjUBbu+IgweHm+MDZ9AuJA9h0DKn2feSS5/j1Qzm/KEC/Ws9PGkNzZ8/0zoNerg25mqVI1zKgtUU6xZq15Kf/1LlfYc08LJXaN/Tr1v7S+eLEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892939; c=relaxed/simple;
	bh=DUSI4ImZdDt6ahbDkCO+KwOaCIpIFcXPc7gl4eOHkRc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWTuo0KJqdzMLk+NntBUFfieyGoCEhljW0SVwngrwSDluHStJaL6elM/FLE5O94FNA+0r5oSQ5VSdr2FwBd3SlultaykxV1Mn8ja28ba3PLkkn00euWq3l0lcN+T2EUdH1GYuS7+ZRArJCmLNQSmHJ9rf+o1THv8MhtffKpd1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SrMVI/Dm; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SrMVI/Dm"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c7rgr1FmJzlsxFb;
	Fri, 22 Aug 2025 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1755892934; x=1758484935; bh=r8AHx2hr6yMpGe3GqgHbJE4bE9nrOBk1Vtm
	aAoSXsrk=; b=SrMVI/Dm87a2ujU+u7keccvu4jj0/YcHlNGIm+ZflCS0oRDM/zM
	qUN3/YgX+G55i60HMx1mzCdipPMyqEeADJmUaXZwjexrB2/cm8xMtuES/s3+xyyj
	6/SnYFLpBQ3oKIbdBcCuqXAR12HCxI64+tmN7xCaaD5Zq2xlQtQPEqEcMClx1pRP
	l7v3aDRe3LHuT82RngkKpIzbzW0RpvR9fpCuoeybxaqBNYvWFzqiXoSj3/qqCSFE
	Dihcas7ioUrfRYKQa3FaD5eE2Pa5msAMNoFCYYrQU5tsL9VGdkrJDyJvmOqrn79r
	VzB1L4tOzlOGpn4IE6h95Z3q0oFsl6Yiznw==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Y0azQ6MprIam; Fri, 22 Aug 2025 20:02:14 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c7rgj0lhJzlgqxw;
	Fri, 22 Aug 2025 20:02:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] block: Move a misplaced comment in queue_wb_lat_store()
Date: Fri, 22 Aug 2025 13:01:56 -0700
Message-ID: <20250822200157.762148-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

blk_mq_quiesce_queue() does not wait for pending I/O to finish. Freezing
a queue waits for pending I/O to finish. Hence move the comment that
refers to waiting for pending I/O above the call that freezes the
request queue. This patch moves this comment back to the position where
it was when this comment was introduced. See also commit c125311d96b1
("blk-wbt: don't maintain inflight counts if disabled").

Cc: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 97dc047b2b0b..b82cd859a844 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -608,6 +608,11 @@ static ssize_t queue_wb_lat_store(struct gendisk *di=
sk, const char *page,
 		return -EINVAL;
=20
 	memflags =3D memalloc_noio_save();
+	/*
+	 * Ensure that the queue is idled, in case the latency update
+	 * ends up either enabling or disabling wbt completely. We can't
+	 * have IO inflight if that happens.
+	 */
 	ret =3D blk_mq_freeze_queue_nomemsave_timeout(q, q->rq_timeout);
=20
 	rqos =3D wbt_rq_qos(q);
@@ -626,11 +631,6 @@ static ssize_t queue_wb_lat_store(struct gendisk *di=
sk, const char *page,
 	if (wbt_get_min_lat(q) =3D=3D val)
 		goto out;
=20
-	/*
-	 * Ensure that the queue is idled, in case the latency update
-	 * ends up either enabling or disabling wbt completely. We can't
-	 * have IO inflight if that happens.
-	 */
 	blk_mq_quiesce_queue(q);
=20
 	mutex_lock(&disk->rqos_state_mutex);
