Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE28913D29A
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380373; cv=none; b=fQ/cDeZGlOZLEXwXCkILBWNOwTgQ7YDQHVc0njr8h1N+cK4zdD5l9judaEdOXG9vlTJy0/JHtCWGR0c/guKuXkVufvhfE4/1Rkdw87AEz56YIb8kSy8h03RGutiLbLCgSI9gDGRLak6hqc77jevWf7LIg1PhqDQOJPc8JcP+QdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380373; c=relaxed/simple;
	bh=autjX2BFlkh5JX3T6v+m00FmZiBEezDsQc6QmV1Bz9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MyLPCSAvH6xr9dGOseSPReszALTiIKhZyVsEx9LhVpTNv3TWnalvYzbX/F1NfZY/MIJk1Ov5Xx8JYpZwilPxhyuGCCEe5zcrA+lzT5+zcWsmEyO3b03eCqt3SbDj9aoGAT6mgSHTWbz9kto+NMSQ7erlOgSRwXTGVTBNlF1NK/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s3cyoOK+; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s3cyoOK+"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YBrrg1Nytzlff02;
	Mon, 16 Dec 2024 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734380367; x=1736972368; bh=x8T0F
	ciUE7PfSXIZC03uQcBhaMy99ac/QEXSqtplfZc=; b=s3cyoOK+yjVSp8h6jHGuF
	qY/W9qotQuXl2k05br1FaAoeeU1EQ7JTqJq/aAGyVaaSGqpRHRYnwdrDcQnhiJVH
	qmuuro5hgwdCNNSp/TkJqO8cgy2D1P2uQ6LnS0Cgj8m8mD4DtUmz+P/ZVYJMPWfo
	3Z02a7ecu6kikgtLvsQSsgJw5JfULUV8bHnM2CJ1At+19QqmlWw6F6uNsffb0uV8
	4jYk9JC205htkehFfWW+dusj7O0Bqt1szNxbPTF5r6k8mC5Dv7N1/FfmA543AcLY
	/B/fewKI+SLEoNse2LNL8QpOdASLkp56KqWvkPdQoz3GrPFtPLXxkTs3ep2T5Pc2
	Q==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SmrjVZWJ_jFh; Mon, 16 Dec 2024 20:19:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YBrrH30yPzlff0n;
	Mon, 16 Dec 2024 20:19:11 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] block: Optimize blk_mq_submit_bio() for the cache hit scenario
Date: Mon, 16 Dec 2024 12:19:00 -0800
Message-ID: <20241216201901.2670237-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241216201901.2670237-1-bvanassche@acm.org>
References: <20241216201901.2670237-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Help the CPU branch predictor in case of a cache hit by handling the cach=
e
hit scenario first.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7ee21346a41e..8d2aab4d9ba9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3102,12 +3102,12 @@ void blk_mq_submit_bio(struct bio *bio)
 		goto queue_exit;
=20
 new_request:
-	if (!rq) {
+	if (rq) {
+		blk_mq_use_cached_rq(rq, plug, bio);
+	} else {
 		rq =3D blk_mq_get_new_requests(q, plug, bio, nr_segs);
 		if (unlikely(!rq))
 			goto queue_exit;
-	} else {
-		blk_mq_use_cached_rq(rq, plug, bio);
 	}
=20
 	trace_block_getrq(bio);
