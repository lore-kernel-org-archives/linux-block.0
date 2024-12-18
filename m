Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E11FBE9B
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734557000; cv=none; b=knbg99uhTdhiKZW1gyYEG5RrrQKdPzTVirHHH4OeWz96PDgE/rcs/MzLyvZ2uYCvNXHAqyw8zIfxMAv5eDrp/NpbhKXRavtQtJ7Ps5wLIAvYwy9yplyGalr8ycfLhrM0TBYXLcjh8re6c3Ua+ESj+l7VZFmz2MafiasIbqqXqk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734557000; c=relaxed/simple;
	bh=+cqSOxM/X75UnO0v7ha9edr48Mcut5PfZpDSq2W9LRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ug29bUJ1Fx7AJSKEVRrFSa6Lu73lnw3xfsZXhvLqAFSPCA/NUqv2l3QwW2FOIrwYre2KVe54oHMxUXciW1Z1ky9ugE0A3NXNiFtvaKhnA+QT+JsEBW8HWeIEnDkMNJPWFuPQdAQtaWrpvc2AhzpazrEDBxnKbwYipOnptcv7ATg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UbW3IvFP; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UbW3IvFP"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YD69C143Fzlff0B;
	Wed, 18 Dec 2024 21:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1734556988; x=1737148989; bh=NegsF
	s0MNhSV8qmX3NPaBQfPPKUDrbelZseBCfeFvcI=; b=UbW3IvFPCSN2suqSWaGbT
	WhpIGcarPpnoo1gTwp2CY5cJhrZhr7kx4gpbCzJ/Kog+iOCRNYyCOoeUyB3FOdaY
	bJ0yh1y7/o+aSR8ACl4m1JLx2J7nMl2yCKncC+dMNpEjJk6WMsrbV5cwSFCIXRgF
	f9u5Dhw7MlyBp9lv+tTdenMomIir0yQaNqE9OH4Tm+GMvoSc0upEZO73bfDHhm/s
	fIRtX8KjhJ+V0RLR90AA2CGKREDivHFBK+AVOcfXG1apiGEKDUgHNHCvqCMA1seG
	MPymVMmHuBfLeySnVcKqToz7Depq9yseKmtsx+IQ0Wt97imE8fo00NuT0xMCiQoU
	A==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2M7MqjqQpvsd; Wed, 18 Dec 2024 21:23:08 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YD6970VRDzlfflC;
	Wed, 18 Dec 2024 21:23:06 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 1/2] block: Reorder the request allocation code in blk_mq_submit_bio()
Date: Wed, 18 Dec 2024 13:22:45 -0800
Message-ID: <20241218212246.1073149-2-bvanassche@acm.org>
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

Help the CPU branch predictor in case of a cache hit by handling the cach=
e
hit scenario first.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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
