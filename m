Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA774EEB2
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734475115; cv=none; b=j35huMvyeelC8xs9qAxmpIaci8kzzWl/kD+1ItuIH6tvVPqGgx2mjAzfbOW8ksogvY9BrSuehNYebpgqPw5bh+Ne5rt8rmSOLM5CKx2g9wN4KgwiUzGfMlBF2plYEnOnTQZJDVtzhj0Ha82ondnIibPNJggrQBhw4kvZWDigZpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734475115; c=relaxed/simple;
	bh=z5e3lWEvJoLEjGnblQf1Vwqe+U3IY1nA30+a7+RYBG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjhAPsR0dFMQAkvLqEzFuWuC1rFHIT9+7u0A3Cu7eOmCvzcjyxYn9ltli37RUW8ABaug+Icx//6wYH+MsWNQnuJyRuRPmGPlcm6LQbxKwtGX3AUcgE7vyLhe7Pvir5/wWej7NOl6XP0cRpEfdHPlNsHQOwso9+84UycUngLcwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zJyoyMal; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zJyoyMal"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YCWtd27ZZzlff0H;
	Tue, 17 Dec 2024 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734475110; x=1737067111; bh=TPb5/
	KXYShB18AmwASozqpVFRAcEzQwxKgySnuU4wOw=; b=zJyoyMalxYjGozC/32ryz
	K03JyXq/azZxgT0g6V+O77RfxR3JrQfyhCF23C2XZS6c9GY3GX8Aretw+AF+YZzR
	wu5HAya4eFrH7mHMJpCRyfLGJTeIqHvXWLMLa/z08Y66WEDVnJfIWoMB/SrGFHGf
	qqvmKCnEBqEtS8Psf2SE1x50UdSw3pa4/CEvOOhtPsnmOU4JbLQ/bKFuIggQzZKK
	wPKb1XYaKjXHJ6PocI4DYfZaC6VNufoCet7QI5PoSarGrbXpSIeGIGHmSKnCOM0q
	eMlkkMYzRmSCJMvg6U2TuZaWSbhmrZfvufb49dLmBwKN6v7mhafSFRZLvLYi11Ok
	g==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9693UdOJPX_Z; Tue, 17 Dec 2024 22:38:30 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YCWtZ0k0Xzlff0K;
	Tue, 17 Dec 2024 22:38:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 2/3] blk-mq: Move more error handling into blk_mq_submit_bio()
Date: Tue, 17 Dec 2024 14:38:08 -0800
Message-ID: <20241217223809.683035-3-bvanassche@acm.org>
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
index 8d2aab4d9ba9..f4300e608ed8 100644
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
+	if (!rq)
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
