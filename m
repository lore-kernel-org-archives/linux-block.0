Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559CD303A0D
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813827; cv=none; b=sYUzmrF2172WCw1Rc5N9ielKlcKu9NzSe0okolKUMdgC3nn7m7ybyEJCv/R5s94PP2jLixjVaRsvcex9oJrhauqNxB3f9Da1BpT/nMi9BK9bcHhT2xpNPtT/tP1Cp+6uQAlTY+ieT24idRXmLMGUGzcQH/dF2wd4JMlGkPqwcYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813827; c=relaxed/simple;
	bh=2UEc+9eGsDDndUsVoGewLqpwT3F+JTLNmHWfTARAIBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQcpbL96NhLUC56qxdBaCspJfiCQJtn7hZ/MbZij26kkl++SnDxjwCyXnhj3cka6DG5Ve9NeiYdkaGgaU5gqKpm+3gkwkHG4UxK5ndw6nnLyfZ5D/VJm2qKsPXhr9kCTNm/F6kCQDDWwXTx+ghW3TZYM/rXqwXTlfXusnUmdOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=A/N6TpQS; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="A/N6TpQS"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d549r2SXfzltJ2D;
	Mon, 10 Nov 2025 22:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1762813823; x=1765405824; bh=+2+gH
	JaWQ1JbAaqME7oi3qPIYzK10pq4689DyyZ9pAA=; b=A/N6TpQSyEyMa/XXAZwwm
	6ofxHlBfDxm/A1mzshMefJbNFGugnKsI0otq7SyLkJ5qzzjT711AkXFel5D+zis3
	xJZABhdkRmB332Vw+Y19iYHuO+f3qEshPErm5W7byZHlSbc364lL3fzyaxUCCzqk
	Rt7Mk0BxmXDTBjmQ2iOklKCp2drMgpr1pFs+YMOxP8KePcnp9A9URIFt8CFpMRp3
	LttBuFPEl0fXxtaDra4E2hygSgIHaWwsZbvZMkxlXVFe6Fo0X9MZ1NkPVs5FXgmG
	Wwsfcjf92d4UvVa+hxyqXdvpcr6P2JjAqGRHGaGiJ04D8UsaOw50PqZR2n51WvFT
	A==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rdJaPTW2kaPT; Mon, 10 Nov 2025 22:30:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d549l31zXzlgqjP;
	Mon, 10 Nov 2025 22:30:18 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 1/4] blk-zoned: Fix a typo in a source code comment
Date: Mon, 10 Nov 2025 14:29:59 -0800
Message-ID: <20251110223003.2900613-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251110223003.2900613-1-bvanassche@acm.org>
References: <20251110223003.2900613-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove a superfluous parenthesis that was introduced by commit fa8555630b=
32
("blk-zoned: Improve the queue reference count strategy documentation").

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3791755bc6ad..57ab2b365c2d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -730,7 +730,7 @@ static inline void blk_zone_wplug_bio_io_error(struct=
 blk_zone_wplug *zwplug,
 	bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
 	bio_io_error(bio);
 	disk_put_zone_wplug(zwplug);
-	/* Drop the reference taken by disk_zone_wplug_add_bio(() */
+	/* Drop the reference taken by disk_zone_wplug_add_bio(). */
 	blk_queue_exit(q);
 }
=20
