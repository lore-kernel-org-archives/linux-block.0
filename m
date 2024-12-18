Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846831FBCBE
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734556999; cv=none; b=UGcE9eW+V6wKqOq0w7O91jLV8CtAO5qUE6VlORBACWEdedeJstokRpZ6e8PMFegSm4Udq5hX0BD44WxWKi1AcVysQykGBOUxBqY4x9gAHgpcUuBN5XnG1VL4JGgGFpPiMXjKa5InxogSEfPHZx1sANuBmJI3zGpSTrTFfSgoLbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734556999; c=relaxed/simple;
	bh=ZlY/aCjoT0/KCFUt4a1EWJFaQpEqA3bZEEwpXAcfP6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD1r/c52QijCBCGCqlsgUMEq4N8ppC+PaqlLWgykxN8lgV1LKu5+J0QFfW/iyB7SgT/FUmebe9egLZYlx8lLuWOLEHIej1wn8R6bXh9qT+CymeI2ou4aT+9mta1JL4BMfPbtaw9iG6SS/g2f9Vl+mtlLbDkVyPXXTg/0Zz/hq+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Lawrirz6; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Lawrirz6"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YD69F4vPjzlfflC;
	Wed, 18 Dec 2024 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734556991; x=1737148992; bh=sKOsy
	60Rn9E7Se3sZNYAqmTqUCKvC4pKTpPs1AC/4r0=; b=Lawrirz6U+y+JKeRZ0+0o
	wsMAlN+MzCpT5xqfaxJRVbSD2YPYFEQ8pAYO26kvTYmLclStG8WMTnn0e0/0daIz
	g5/IymP7oypRtWHr/vhI0ruBRaFtWnZOHrsnc5JOnUx6gQEvS3yjC8AGcuruXQNB
	HkbxkLHYSo6a7ipG/qdssJRm1rv++/urxpdi99e2tcECzvJwtbNwIbEu7lRcl5/0
	1lo+iniHkip/g7fZHZFgEZg7oTDTAdWJZuXqiFQRDxPu6Apoc3ATxaNrNPrbAqG5
	JkKOn/9+gykyA2s6EfUMA9L8JE9Tw+n1UaTngdPI7ANRUI/ZxWwg5EEc8m5ZvF3B
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jGCZSB00hoss; Wed, 18 Dec 2024 21:23:11 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YD6993rZ0zlfflB;
	Wed, 18 Dec 2024 21:23:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 2/2] blk-mq: Move more error handling into blk_mq_submit_bio()
Date: Wed, 18 Dec 2024 13:22:46 -0800
Message-ID: <20241218212246.1073149-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241218212246.1073149-1-bvanassche@acm.org>
References: <20241218212246.1073149-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The error handling code in blk_mq_get_new_requests() cannot be understood
without knowing that this function is only called by blk_mq_submit_bio().
Hence move the code for handling blk_mq_get_new_requests() failures into
blk_mq_submit_bio().

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8d2aab4d9ba9..a83ec9368df6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2968,12 +2968,9 @@ static struct request *blk_mq_get_new_requests(str=
uct request_queue *q,
 	}
=20
 	rq =3D __blk_mq_alloc_requests(&data);
-	if (rq)
-		return rq;
-	rq_qos_cleanup(q, bio);
-	if (bio->bi_opf & REQ_NOWAIT)
-		bio_wouldblock_error(bio);
-	return NULL;
+	if (unlikely(!rq))
+		rq_qos_cleanup(q, bio);
+	return rq;
 }
=20
 /*
@@ -3106,8 +3103,11 @@ void blk_mq_submit_bio(struct bio *bio)
 		blk_mq_use_cached_rq(rq, plug, bio);
 	} else {
 		rq =3D blk_mq_get_new_requests(q, plug, bio, nr_segs);
-		if (unlikely(!rq))
+		if (unlikely(!rq)) {
+			if (bio->bi_opf & REQ_NOWAIT)
+				bio_wouldblock_error(bio);
 			goto queue_exit;
+		}
 	}
=20
 	trace_block_getrq(bio);
