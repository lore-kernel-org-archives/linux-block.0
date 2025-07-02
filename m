Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776CB2E49AF
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 18:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480702; cv=none; b=ao/OLuqX0Is7V38T/LZB4f+lNv6YJ/Y1d71qm70BdKUpf5s+BJUEGQrj2XJlXwEwIsPlVT9LlLTlkq08U8mDg0XXr0YivtdLavgktOw4jGG6NsrpbNmQ+myWruZfjMu6gxFJNhVvtiVEm9M8bLykoUnxFqmExaoszQ/EvS3khsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480702; c=relaxed/simple;
	bh=STyGM6IgxKUX8VecSsyOg5MliO0cag5zC9RzXMvcDGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B44omXtjabyGiwT4ZAOASRDFqX+DyF4KQft5a3aygfNo9eyny9eval6ZMGo6XNMpV9EGTkXk7M10ft6K1eST2wkYG0aKwcV+LoBNWi7XP0DqmQs+NAZRDBa9d3RvPS2WS0ixkqaniRyHddTPlyhH5+5iiIgtDDq4T20Arm8pcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=E1tq1OEl; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="E1tq1OEl"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXSx74SWGzm0gbf;
	Wed,  2 Jul 2025 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751480698; x=1754072699; bh=q9cUG
	UVU5hZypIHHEkyM/VFhm17VhaNwiEcjrJPFDDA=; b=E1tq1OEl2DxiC5QYlYDTF
	fJai+Gv/aNCSnPzX8fWfivTyLO2TVWVf0DqKvK9xSsetn9bmKU6HPM/7b+SvPT3y
	RYB5EHmLD7stNFiNdjULt1xR0idanybAd8qTOr4IAud9sj/fsT/xJCVpxvMTtPab
	vvzAsRaJ35OJcSyWv0PTylmyxChOIT2M/7MH4cQeDgZ4ikyg/w/JU4AFGxc8c6p2
	1gpsFV4FVkxxC3rzqK8IG8CoqOp7/KcaJQU6aRcP3L9OlXCHM7nML5662Yt2YQso
	Y7DOLafTMbDv2RHfVAXXvkdT6rmfg5JvRBxqBOYnnOl8TbTbrChp5OCPBMd6iueI
	g==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N0E7D6szZYzx; Wed,  2 Jul 2025 18:24:58 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXSx32DRrzm0ysc;
	Wed,  2 Jul 2025 18:24:54 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 3/3] block: Move a misplaced comment in queue_wb_lat_store()
Date: Wed,  2 Jul 2025 11:24:30 -0700
Message-ID: <20250702182430.3764163-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702182430.3764163-1-bvanassche@acm.org>
References: <20250702182430.3764163-1-bvanassche@acm.org>
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
index c75901a55497..52766bd629f3 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -584,6 +584,11 @@ static ssize_t queue_wb_lat_store(struct gendisk *di=
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
@@ -602,11 +607,6 @@ static ssize_t queue_wb_lat_store(struct gendisk *di=
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
