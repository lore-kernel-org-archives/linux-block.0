Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE49155CB3
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475114; cv=none; b=oZTaAXBVcA8TV4yJIxym7DEsfvDabq2r/i5RxjXTBBtUtABXxuXC7q9ReHnJNnI6e9UDWCggDfMwQ0McO0xC3tdc6U1KyK2/NMEEm1bvjD7Mk48XRfwxBlBfsJcI+AjCA/VGeBAzJs65SDvs5/kM1leSQ51c6slscyKp71Bn6+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475114; c=relaxed/simple;
	bh=autjX2BFlkh5JX3T6v+m00FmZiBEezDsQc6QmV1Bz9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paJySZMJB81VDHHn4nOB6h3hpW0TyVsEQtgbmi1yb/+YZnJi9EgvyZ9RlMOn/YTRZsSAb9ewlmDhgaJ+KAmK6sqA4c3HelcByHaYIqF2sPo6gj7cjuf58BkL/ZiJRdSXAEJ4H16NyBRrb7Bz3IRM3/BIs/Bq3C9l6g+EriUzfDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SBAhjhhd; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SBAhjhhd"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCWtc12lYzlfflB;
	Tue, 17 Dec 2024 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734475109; x=1737067110; bh=x8T0F
	ciUE7PfSXIZC03uQcBhaMy99ac/QEXSqtplfZc=; b=SBAhjhhdWnfhssAQRHFLy
	Ko3zFZz5EEfRfRC0PcTygSWknW5sPiv1xn679DPHMdosjicMTyvKoC8Ug8mRQ+f7
	eIpl1/gd9t4A74jeJi/bX+5sdayPcSNhbwJgKpsfER50lpDDVT+Sb27rn6hYfczL
	GZO/SK5FxBqSBZ7RXJMK1Ys/4C+PagCCIWynuLhBFHqFwN4dm9fOTCjJ0B6ct3q4
	LDSmh4jrBF1YFWB48Xb1kHM7yi8GLkCDU8VWSxujfVkfWhsFjv315GdCQJK+eHnF
	da4LETPmioNiIi5d6oF+olTzVFm4gR1WArBIgmMDEiirKWDVwjucaGfm5MkXsmqq
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Q6ebRMme55Hn; Tue, 17 Dec 2024 22:38:29 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCWtX5QH1zlff0H;
	Tue, 17 Dec 2024 22:38:28 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 1/3] block: Optimize blk_mq_submit_bio() for the cache hit scenario
Date: Tue, 17 Dec 2024 14:38:07 -0800
Message-ID: <20241217223809.683035-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241217223809.683035-1-bvanassche@acm.org>
References: <20241217223809.683035-1-bvanassche@acm.org>
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
