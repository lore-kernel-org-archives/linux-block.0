Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137691FDA
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746751344; cv=none; b=hut00h8LzvVyDogEzXpPa09tI3jLBPbv/2+6KZP9CbRAr95Ls7VjHgoxGmjmZTz1lKFY0gm1+GJIaECwqqRJtBDvz4Vjd5zZOEPVUFk2QkdfdcV5rXDyPd3+O8cxNw+8dQIL+/Pxy4dvlZOE8i8uUyARiqDsgxK0anIEaOGcpxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746751344; c=relaxed/simple;
	bh=pvt+y7+fW+ZxlYu2afMcCbut8E+fbMBJTB9EeujHiis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhXcm222EiUgyQn919kp7mxJRNwRHA0j0/JpzIPh/qPFUui+x0fEs4gZlrb2aXIY69bYvq8DDvi79Y+TF943WqaXz9XJN8qDzb/c1Vn87HLz5ucqVVXkmXpootIoKmokAgMktgjQNbbWBuqLFNfzQ01cKmGEmvHO4truFKzmAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TxvJ5kZn; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TxvJ5kZn"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4Ztqvr42yYzlvX8B;
	Fri,  9 May 2025 00:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1746751335; x=1749343336; bh=SLJxfIgoBPHcJbR7ZZmp5xPWdsSebFNMKnP
	AMbX0xIg=; b=TxvJ5kZn6vQuwbHKuUb8EjDuW04maVvrF9Esf0k5/1Hx5VGa+9X
	Qh1EbxJM2m/EUOLfwS8GhuOUJh/u3ok35uym2mKAoroi9tYIRO7cNWGmlmeTUBpX
	AbZTvT884rGnoxlAshdX5EcQV1d3XqKYoPSrbZBCCtxAqyIlAvbZzvNKy986CjO0
	WxpIUePbB8kJXLH21u8vnXbbzeJrJ26cmk9CF29wvz+BSvPefK+UJOjIGy9MVNQK
	CM4GP1OTUOdaa30ayCawyVZsrIyPI87s0LDNntDOpFGKg6yTYKUBsDYA/DFqJUbk
	pg3E/6hg99msFpEdcA2xgsCeALS55X54spg==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id f8slYuDo-8g6; Fri,  9 May 2025 00:42:15 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4Ztqvl20Pdzlvm72;
	Fri,  9 May 2025 00:42:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH RFC] Submit split bios in order
Date: Thu,  8 May 2025 17:42:00 -0700
Message-ID: <20250509004201.424932-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If a bio is split, the bio fragments are added in reverse LBA order into
the plug list. This triggers write errors with zoned storage and
sequential writes. Fix this by preserving the LBA order when inserting in
the plug list.

This patch has been posted as an RFC because this patch changes the
complexity of inserting in the plug list from O(1) into O(n).

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 796baeccd37b..e1311264a337 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1386,6 +1386,30 @@ static inline unsigned short blk_plug_max_rq_count=
(struct blk_plug *plug)
 	return BLK_MAX_REQUEST_COUNT;
 }
=20
+/*
+ * If a bio is split, the bio fragments are submitted in opposite order.=
 Hence
+ * this function that inserts in LBA order in the plug list.
+ */
+static inline void rq_list_insert_sorted(struct rq_list *rl, struct requ=
est *rq)
+{
+	sector_t rq_pos =3D rq->bio->bi_iter.bi_sector;
+	struct request *next, *prev;
+
+	for (prev =3D NULL, next =3D rl->head; next;
+	     prev =3D next, next =3D next->rq_next)
+		if (next->q =3D=3D rq->q && rq_pos < next->bio->bi_iter.bi_sector)
+			break;
+
+	if (!prev) {
+		rq_list_add_head(rl, rq);
+	} else if (!next) {
+		rq_list_add_tail(rl, rq);
+	} else {
+		prev->rq_next =3D rq;
+		rq->rq_next =3D next;
+	}
+}
+
 static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq=
)
 {
 	struct request *last =3D rq_list_peek(&plug->mq_list);
@@ -1408,7 +1432,7 @@ static void blk_add_rq_to_plug(struct blk_plug *plu=
g, struct request *rq)
 	 */
 	if (!plug->has_elevator && (rq->rq_flags & RQF_SCHED_TAGS))
 		plug->has_elevator =3D true;
-	rq_list_add_tail(&plug->mq_list, rq);
+	rq_list_insert_sorted(&plug->mq_list, rq);
 	plug->rq_count++;
 }
=20
