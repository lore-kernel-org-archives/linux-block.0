Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FFD2FCC12
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756134884; cv=none; b=Evq7Tou1hkeRbLTWj3kS3nz62AvPwlKwResO7rU0LiahAcdWE8wGHjvFIVBALQZNOfd7H0P2eytxRJbRJ0czpZ+nLYhJATYYlqNykADsZT4NCtD1Hh4e6+Zdg4s/ZrCavd65XYlUYY7N2UREdkIubsvtVyVbXZgYIcE3v1/Xce0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756134884; c=relaxed/simple;
	bh=pOAvlFZk0NI9Geq1GmY1kzC1JSPAVjf1eO5YhPnFtxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4t2pVNGNCRrI0+WDKRM5+2szR6CdsfpxNlzYyjrc1IGgk+aC1YqcAFhZJOvk+Mi4yJAalzAMD5+7TlOh2/emtHVxxf4g9efE6z9u0JFdQs1/WnP+oVFld97sWoWnegNpentcVa2RqTtEwypCdK7AtOEGj6OLw9dXyjnQhgc6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Oe0lNYIH; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Oe0lNYIH"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c9Z8d5VKRzlgqxl;
	Mon, 25 Aug 2025 15:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1756134880; x=1758726881; bh=B1ag6zY2T04x1dJdW4GFtezkUnqHA2xypWt
	50UJVjpU=; b=Oe0lNYIHIxs3rmMaXJKYF4S2uuR8VyXBVMOtryRqcbzAYcFzYh1
	0yM817/dz+yCBXU2+JCaXz+Tm1aFvmyzJDldN8Vd04mh350Uk62YUHl98h8hXat2
	6qd2ok0DhmCLGuKN9tc7sQYP9uxWeF+NTIIOrzY5Ftb1OMpHNVGV8iwD2u/pOYWu
	xSdnUqi87vTwzBvmhDAH8nE3BLNUds2UnGW9ckuU76d5hqbH+BkpXU6Ne8V/3U48
	+m8R/XT8QXx2iv9dar9zNPxiUGF2QxdZbCb06bJYPwfA8NJY15VAkclUvFb+xj+c
	bMxs20JgfSy3Cn0xy5cgGFm+YwF+iQQTgEA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Bc8j8nFHMGWa; Mon, 25 Aug 2025 15:14:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c9Z8Y2Fy7zlgqxy;
	Mon, 25 Aug 2025 15:14:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2] block: Move a misplaced comment in queue_wb_lat_store()
Date: Mon, 25 Aug 2025 08:14:24 -0700
Message-ID: <20250825151424.1653910-1-bvanassche@acm.org>
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

Changes compared to v1: rebased on top of Jen's for-next branch.

 block/blk-sysfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 4a7f1a349998..c94b8b6ab024 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -620,6 +620,11 @@ static ssize_t queue_wb_lat_store(struct gendisk *di=
sk, const char *page,
 	if (val < -1)
 		return -EINVAL;
=20
+	/*
+	 * Ensure that the queue is idled, in case the latency update
+	 * ends up either enabling or disabling wbt completely. We can't
+	 * have IO inflight if that happens.
+	 */
 	memflags =3D blk_mq_freeze_queue(q);
=20
 	rqos =3D wbt_rq_qos(q);
@@ -638,11 +643,6 @@ static ssize_t queue_wb_lat_store(struct gendisk *di=
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
