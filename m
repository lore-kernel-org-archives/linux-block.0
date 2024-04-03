Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF40156673
	for <linux-block@vger.kernel.org>; Wed,  3 Apr 2024 21:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179453; cv=none; b=QATS2LAA+AcDqQDCM/EN1hWqLy0qoSR7fPEOOt+q3aq2WjG2ZxnW7u8U/1cXkToQCm3ho+NkdrsLKlkLc20sQxegnxNn4a+w1DW22fn/3zYtbogVVgs6h+G2qHw0OHp1Bjr1iYSf4Nk1moXtjj6es+su18XpTGzTliQu2I7Uo+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179453; c=relaxed/simple;
	bh=nZqpz72pOk7+4/Zm5d2lTIBjLHS3YZmAPe71L56cx/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hGCTlrWWzHHPFoUywC0vaTLlzZ+09uuziuEMG+Ob6woM+TTYiwO//tmMbDwfWxiTMlknJQjXqNuAUuOgTZHBDc5q2cl6yLw1poD1byaacIAiemsSxQL9dXmxWqttoexS8XAL8eCW/PAUadzk4fxoizda39SX4zErxyyBEq2ZTog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=qy2kN/nk; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="qy2kN/nk"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V8yRv6Qv2zlgTGW;
	Wed,  3 Apr 2024 21:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1712179448; x=1714771449; bh=lGTgM
	gLcbe7Ey1LYWqpRkYBZGN+D6VVmzPSny21CY0E=; b=qy2kN/nkJnMY2UE+MH0Gp
	BlATGq+z7PtgjsWRYOLumEa1dPODdv/OJ7n2QOV8G5AIpcPV6Pgc3vAieBf0oBE3
	3Hfm8MiPThrGesx1pU4MyRnvq6+pt6x1tkglse+WqEZ+hsPvJdgFiNeNQ45rI2P+
	fQbFI+2Byz2DuJIiXp5IyZmQGV9bjAjGBFceNY5aazzWj3O8chQEH11PYf8AxJgM
	eA5DsWmDfaRNcaShY4aja9VkhIpeOZloZjKnQzbx4Cn4AyUS2hHGXBnZeZnZIzLj
	tNqpn3+Bn33sf78EPied6V823E6TplX60ete6xnwI43ir60ZBvxAtw806Via+fCa
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 85BsDOsjVse9; Wed,  3 Apr 2024 21:24:08 +0000 (UTC)
Received: from bvanassche-linux.mtv.corp.google.com (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V8yRr0Bm1zlgVnF;
	Wed,  3 Apr 2024 21:24:07 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH 2/2] block/mq-deadline: Fix the tag reservation code
Date: Wed,  3 Apr 2024 14:23:54 -0700
Message-ID: <20240403212354.523925-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240403212354.523925-1-bvanassche@acm.org>
References: <20240403212354.523925-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The current tag reservation code is based on a misunderstanding of the
meaning of data->shallow_depth. Fix the tag reservation code as follows:
* By default, do not reserve any tags for synchronous requests because
  for certain use cases reserving tags reduces performance. See also
  Harshit Mogalapalli, [bug-report] Performance regression with fio
  sequential-write on a multipath setup, 2024-03-07
  (https://lore.kernel.org/linux-block/5ce2ae5d-61e2-4ede-ad55-5511126024=
01@oracle.com/)
* Reduce min_shallow_depth to one because min_shallow_depth must be less
  than or equal any shallow_depth value.
* Scale dd->async_depth from the range [1, nr_requests] to [1,
  bits_per_sbitmap_word].

Cc: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>
Fixes: 07757588e507 ("block/mq-deadline: Reserve 25% of scheduler tags fo=
r synchronous requests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 02a916ba62ee..78a8aa204c15 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -621,6 +621,20 @@ static struct request *dd_dispatch_request(struct bl=
k_mq_hw_ctx *hctx)
 	return rq;
 }
=20
+/*
+ * 'depth' is a number in the range 1..INT_MAX representing a number of
+ * requests. Scale it with a factor (1 << bt->sb.shift) / q->nr_requests=
 since
+ * 1..(1 << bt->sb.shift) is the range expected by sbitmap_get_shallow()=
.
+ * Values larger than q->nr_requests have the same effect as q->nr_reque=
sts.
+ */
+static int dd_to_word_depth(struct blk_mq_hw_ctx *hctx, unsigned int qde=
pth)
+{
+	struct sbitmap_queue *bt =3D &hctx->sched_tags->bitmap_tags;
+	const unsigned int nrr =3D hctx->queue->nr_requests;
+
+	return ((qdepth << bt->sb.shift) + nrr - 1) / nrr;
+}
+
 /*
  * Called by __blk_mq_alloc_request(). The shallow_depth value set by th=
is
  * function is used by __blk_mq_get_tag().
@@ -637,7 +651,7 @@ static void dd_limit_depth(blk_opf_t opf, struct blk_=
mq_alloc_data *data)
 	 * Throttle asynchronous requests and writes such that these requests
 	 * do not block the allocation of synchronous requests.
 	 */
-	data->shallow_depth =3D dd->async_depth;
+	data->shallow_depth =3D dd_to_word_depth(data->hctx, dd->async_depth);
 }
=20
 /* Called by blk_mq_update_nr_requests(). */
@@ -647,9 +661,9 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hc=
tx)
 	struct deadline_data *dd =3D q->elevator->elevator_data;
 	struct blk_mq_tags *tags =3D hctx->sched_tags;
=20
-	dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
+	dd->async_depth =3D q->nr_requests;
=20
-	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
+	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, 1);
 }
=20
 /* Called by blk_mq_init_hctx() and blk_mq_init_sched(). */
