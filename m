Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D97924BD03
	for <linux-block@vger.kernel.org>; Tue,  9 Jun 2026 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042784; cv=none; b=UZ4zQFtEZDMiGQJpv/gne+mjAy2Wz0zF1kgW8IX8RtC4FcPoR3OBh55TFizJyvR7vPoXjAMeGzIfGAA5wj/4F0Ar0PDzCMxLsCUsX/Zj9GO6K/XKFXCdif5q/UipzySMqO2lHHTY8QdQSxcTYJBQAb0iwmdPqSS0beZABzNQUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042784; c=relaxed/simple;
	bh=Ro4dTHu38WCRK6RZLTcLCdTSPHCNtYkoEOZAbWxu974=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keJAhh1ZmXN6D/FaXfaLxeq2CZKaWNrph7qonXa/sY8sn3LWqNJ2y01Cd3fgJVpbu+xTViJ6Vm/tKNGQxCRbQY0f3qdQkV58BjEBgae/fhqY+kRhxuixiIyQGlCVf+gk8sm4aBtw/O8zA8VydebmCbBpRGR+H7pJbPJ0fUw4sdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RgB6fLKC; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RgB6fLKC"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gZjfl0XCbzlh2rF;
	Tue,  9 Jun 2026 22:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1781042778; x=1783634779; bh=rHwdN
	60DDx1iBfu5nW8ZIDtWt2ovk4jPCISuBTz1+Qk=; b=RgB6fLKCCjwg5gnuJOjIB
	W0AqY3pPJVl4Dbrzb7m12NiHkSbip+5Hdm6QQ1Q5PdSxUSZ7rDrqRb/TaoQNv+jS
	Rwi8C6Pn4sUrLGSpqwWhnMFvtz2F/I/xD4Ie0FFCCowsJiSr9QwsC7yZIb4XIqvF
	pMK0yFWnC8I+BecwpXWSy07s5Kugpctuu3/RPyoLVkBIc3ysB9bjgKl8GYJGmehA
	uLXZxkcbljy/d6qVLb259r1k2sVJDJuvGRIds/cNqzKxk3IuJRxMnQ9bdgBJBFzA
	MQXT8/jXZkHMtsElraPLaDF9RypYv79xdWVBOka7iJ3+TpLmnkRSdzIqddJe2Z/e
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id juki1lR5lgeP; Tue,  9 Jun 2026 22:06:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gZjfY5v4TzlgyH5;
	Tue,  9 Jun 2026 22:06:13 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 12/27] drbd: Convert drbd_req_state() to unconditional locking
Date: Tue,  9 Jun 2026 15:04:59 -0700
Message-ID: <f3f53e2c6d01b92091bfce447c9010b03a7debef.1781042470.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <cover.1781042470.git.bvanassche@acm.org>
References: <cover.1781042470.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/drbd/drbd_state.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_st=
ate.c
index 5aa4b1889144..171c6488283d 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -639,11 +639,12 @@ static enum drbd_state_rv drbd_req_state(struct drb=
d_device *device,
 {
 	enum drbd_state_rv rv;
=20
-	if (f & CS_SERIALIZE)
-		mutex_lock(device->state_mutex);
+	if (!(f & CS_SERIALIZE))
+		return __drbd_req_state(device, mask, val, f);
+
+	mutex_lock(device->state_mutex);
 	rv =3D __drbd_req_state(device, mask, val, f & ~CS_SERIALIZE);
-	if (f & CS_SERIALIZE)
-		mutex_unlock(device->state_mutex);
+	mutex_unlock(device->state_mutex);
=20
 	return rv;
 }
