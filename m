Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A851D27BB
	for <linux-block@vger.kernel.org>; Mon, 16 Dec 2024 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380375; cv=none; b=aLSx7JKDpCmQDE/0Ld4uHKhPtB1eCysguxvy0q0D4M4GP06ww6tai8wXicJQsK+GSSverurtATiliwDXzPrgMstz48sqmnLFaviGMS7IBTej/IiP+Qkl7XFewwsARya9hDvmQZP6DT2kZTd5VX7GLwKUuBKSpAsZzXI5WINn3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380375; c=relaxed/simple;
	bh=r4yhyRlldxZQvTjSg5VT7tusHeCosYdPMsXc2XM2IH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATnXAa5850D9ZvARoRbrdWiAnJgRplxm+tEkFp0ZqdxcwXm+pj/I12yhjGLgNsI1iw82aGWiqJJnCLI2IlIyUzDT+ppohwop7rJW+QynHDNgiL1Bibz9DPNX0bO9goQXziuhxuH/gDH2o0FcvH3vf0rB7KJH9tw7cZvIaJ8AIL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jAVnKURy; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jAVnKURy"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YBrrg3qNCzlff0d;
	Mon, 16 Dec 2024 20:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734380368; x=1736972369; bh=WXgU9
	keKae2CapHr58UQ2Ooc/oWbipzzz7Mxz/op38c=; b=jAVnKURyvE0jPCglLHE9c
	f+PzN4glMYb61j96tpaROemXdF3mFTf5fQSKzD+OdVHTCvVH8sccQta8rjqz6q80
	vycOE6sYJlnCm+fsfPcV/rHuRzvAJsJkoUoJGAnhvmy5iKiLJS62dWcWGn6ixnW9
	K3AKY4UT2kELTIQ+z4mvBfDqaTQzQuAq10ABSPMAjJFK6qEz5AGKxc1DsooBzyO/
	Eq68bZaNqMjjnOmOhUqbnR4fzgfNvFKPh+Af+IDZXSlP1dheIEhOj4yacqEhxEPT
	ibwuvoh4yeVPpvECi3VwXl+EUGVbsnPKXCnt0RajeatRO5M0WVkcwDdZtj9slMCJ
	w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id N5Aa2D_pq_NC; Mon, 16 Dec 2024 20:19:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YBrrJ4BkVzlff0q;
	Mon, 16 Dec 2024 20:19:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/2] blk-mq: Move more error handling into blk_mq_submit_bio()
Date: Mon, 16 Dec 2024 12:19:01 -0800
Message-ID: <20241216201901.2670237-3-bvanassche@acm.org>
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

The error handling code in blk_mq_get_new_requests() cannot be understood
without knowing that this function is only called by blk_mq_submit_bio().
Hence move the code for handling blk_mq_get_new_requests() failures into
blk_mq_submit_bio().

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8d2aab4d9ba9..80eb91296142 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2971,8 +2971,6 @@ static struct request *blk_mq_get_new_requests(stru=
ct request_queue *q,
 	if (rq)
 		return rq;
 	rq_qos_cleanup(q, bio);
-	if (bio->bi_opf & REQ_NOWAIT)
-		bio_wouldblock_error(bio);
 	return NULL;
 }
=20
@@ -3106,8 +3104,11 @@ void blk_mq_submit_bio(struct bio *bio)
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
