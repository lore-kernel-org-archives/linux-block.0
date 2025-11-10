Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729BE3019A9
	for <linux-block@vger.kernel.org>; Mon, 10 Nov 2025 22:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813835; cv=none; b=OBQwwG5hR724TfpAgdeK28Hv7t2wnq6Qz0oRrLCHUZ5U2Lu3yNLBcYPRgiuvwuGF0+rWbUDO1/XN7aqlKjClSZjRbTukyy5XpW+q3hW1xsNWiK21bLCjRGHGGNmKBaZPqwCTVQiv6lZKUfsTEB4p1pbXC4Q7/IPEQD35Wbr5ADU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813835; c=relaxed/simple;
	bh=kAQXW6hZt/3NI0SorXBa910onjBuBWD+pGw98OU7mU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TR5Afb4+GXuEpsys9fPif8DQ/6RU+p4xU6Hp8c6A5rydDqhNio0ymXLe0zO5gNHNrjuxjBcUwk+dJdcnYxouGVylkvtATUQLp2JxXpSth3EmIwBwnVYRc/xQwB0hasPLouPH99Q902qkw19z6wOn/JVj58Dm+k1i2I9Ch5bZFK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MXfaCDwl; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MXfaCDwl"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d54B05FHzzlgqjP;
	Mon, 10 Nov 2025 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1762813831; x=1765405832; bh=WPjBe
	ZLw8zL7t5Uv0I1mygyfpkNP826PHRXP+5cg/vg=; b=MXfaCDwlWM6WTSzriUlj8
	BN7YcFyzLEIu6OIDl2VMqGHKP8C9EAyOcPbXO5qFeZ0kc5tTCmZApFKOPeZdrkj4
	EeYvc3OaZpLMIIea1mcfgtcL6IWkUIB+d8fXuov/io6B5AiPqxnvAbrwHkQEKIOg
	N0rKo0+xuCXUiTyaQ7VSUPN9rFfd+UYwxhDiPumoCNDbZG3Xe4WzKhhm8wqLzoan
	XzUx913vBHE7M5MJ0Sx0QCc8ouQsaSScqhwKwBkwGX1csOvgDZH1M4spI5uO4pXt
	FXdNSmzxhzlohRgwtEwLvduSZwgPJI/jea5e1OZnHdS495vFLEGS6X6QPxuIjf3W
	w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IGuVCmSwLtqR; Mon, 10 Nov 2025 22:30:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d549w45xCzltBDC;
	Mon, 10 Nov 2025 22:30:27 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 3/4] blk-zoned: Split an if-statement
Date: Mon, 10 Nov 2025 14:30:01 -0800
Message-ID: <20251110223003.2900613-4-bvanassche@acm.org>
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

Split an if-statement and also the comment above that if-statement. This
patch makes the code slightly easier to read. No functionality has been
changed.

Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 5487d5eb2650..73c7358ec184 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1461,13 +1461,14 @@ static bool blk_zone_wplug_handle_write(struct bi=
o *bio, unsigned int nr_segs)
 	bio_set_flag(bio, BIO_ZONE_WRITE_PLUGGING);
=20
 	/*
-	 * If the zone is already plugged, add the BIO to the plug BIO list.
-	 * Do the same for REQ_NOWAIT BIOs to ensure that we will not see a
+	 * Add REQ_NOWAIT BIOs to the plug list to ensure that we will not see =
a
 	 * BLK_STS_AGAIN failure if we let the BIO execute.
-	 * Otherwise, plug and let the BIO execute.
 	 */
-	if ((zwplug->flags & BLK_ZONE_WPLUG_PLUGGED) ||
-	    (bio->bi_opf & REQ_NOWAIT))
+	if (bio->bi_opf & REQ_NOWAIT)
+		goto plug;
+
+	/* If the zone is already plugged, add the BIO to the BIO plug list. */
+	if (zwplug->flags & BLK_ZONE_WPLUG_PLUGGED)
 		goto plug;
=20
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
@@ -1476,6 +1477,7 @@ static bool blk_zone_wplug_handle_write(struct bio =
*bio, unsigned int nr_segs)
 		return true;
 	}
=20
+	/* Otherwise, plug and let the caller submit the BIO. */
 	zwplug->flags |=3D BLK_ZONE_WPLUG_PLUGGED;
=20
 	spin_unlock_irqrestore(&zwplug->lock, flags);
