Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A61F7580
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895021; cv=none; b=VeYLPHsvI6qynzZEao7aTSQvPAiguN+xzM0HDvOcULyCxnoC3BAi/DIBGrIGXth8Z3r3GwW509Fxb77vjIOuC6zEd5krBFLfFlaxmkId+E0pmKyvvD66nO+AXbOyGm8NbsD+sJBcr3X/rnq1PrFUHm7aYiD4SXXi9ccVABlA/t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895021; c=relaxed/simple;
	bh=QUDwfJdr46q/Ymq1xh17AeHYILNNvCU4rqsemLckQRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCUAImL3YdufnPfYuWPEWqMF8WnhvlSI5Wj72YmKxLkdVLsDH6Fk8eHZoOn/6Xqi2u6qWO/DC3TTGniF0MY+R8gJpfqfh8cUA6xOGPwTiVr2wqXX9O0XHFsYfOnG+yuoMOK8HtnuXIlgOiRVEaoR3tUZF0U305Wx7KQ8f7H3JAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=U90Mj8Rr; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="U90Mj8Rr"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bSJL24z9wzm0jwH;
	Wed, 25 Jun 2025 23:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1750895017; x=1753487018; bh=odJkK
	RjsdhiSjcCeG50hsBWJ2ezTKcGGMhRzPoD7H7o=; b=U90Mj8RrDTcvBhVCsFhNF
	4folPTdEdBphQggGMQJY9dVD1b3thgki9Qa8+h+YKhRHvDko4iPf0RjewMZ2kR9S
	jsI0lz4Ry3s1hJ2O7tVGEAEfJ9zcLdEf58z7TT6TYafbtznfIDsU7BkvSlvHiWyh
	IYT5R9wGbDVA1UmkAG3IY+6J4SqQFDmGv/6J0cth/jLJ3+Koz3wW6EMF3mD+rh5B
	+ZY9cEfs40W/IMdqxhcu6ylxRm3cLCtwnOgtToLFWEaKfS6zOotsA5FQYqEKOccj
	1l62z/YbGl9g0rqmht4jEkMbuHpwBBLoLh/aEMWW290twI1yYzHsCA4rYc21TpUf
	w==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wDlZpORqFe43; Wed, 25 Jun 2025 23:43:37 +0000 (UTC)
Received: from bvanassche-glaptop2.roam.corp.google.com (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bSJKw2QwJzm0ysf;
	Wed, 25 Jun 2025 23:43:31 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Eric Biggers <ebiggers@google.com>,
	Keith Busch <kbusch@kernel.org>,
	Christop Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/3] block: Introduce the BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS flag
Date: Wed, 25 Jun 2025 16:42:58 -0700
Message-ID: <20250625234259.1985366-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625234259.1985366-1-bvanassche@acm.org>
References: <20250625234259.1985366-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Introduce a flag that indicates whether or not bio_split_to_limits() is
called while processing a bio. Set this flag from inside
blk_mq_alloc_queue() because bio_split_to_limits() is called for all
request-based block drivers. This patch prepares for modifying when
__submit_bio() calls blk_crypto_bio_prep().

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c         | 3 ++-
 include/linux/blkdev.h | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 532acdbe9e16..ab2fbc895a98 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4411,7 +4411,8 @@ struct request_queue *blk_mq_alloc_queue(struct blk=
_mq_tag_set *set,
=20
 	if (!lim)
 		lim =3D &default_lim;
-	lim->features |=3D BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT;
+	lim->features |=3D BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
+		BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS;
 	if (set->nr_maps > HCTX_TYPE_POLL)
 		lim->features |=3D BLK_FEAT_POLL;
=20
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a51f92b6c340..108f70aa4d15 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -340,13 +340,17 @@ typedef unsigned int __bitwise blk_features_t;
 #define BLK_FEAT_ATOMIC_WRITES \
 	((__force blk_features_t)(1u << 16))
=20
+/* bio_split_to_limits() is called while processing a bio */
+#define BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS ((__force blk_features_t)(1u =
<< 17))
+
 /*
  * Flags automatically inherited when stacking limits.
  */
 #define BLK_FEAT_INHERIT_MASK \
 	(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA | BLK_FEAT_ROTATIONAL | \
 	 BLK_FEAT_STABLE_WRITES | BLK_FEAT_ZONED | \
-	 BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE)
+	 BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE | \
+	 BLK_FEAT_CALLS_BIO_SPLIT_TO_LIMITS)
=20
 /* internal flags in queue_limits.flags */
 typedef unsigned int __bitwise blk_flags_t;
