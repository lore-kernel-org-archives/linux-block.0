Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84F3F54B4
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420119; cv=none; b=j+Q5QjWEmmZcPdMO/TooKjd3/Dk22kpvuJihuVGbhlygVJkOxSasu0lzcZL++I8H+akBs2+f78E5Up8F0EK8NsC4Gqqbdc+8c6QIYN81dHiOvReImSN6R5lOPFGxhizQsXELNR27f+vlmDdETH5ss6szLVfa3dzY0225tfTqVY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420119; c=relaxed/simple;
	bh=9p/R30+Qhhj9xUYxGW+3Q3VJTpEcCAy5erXAMwL6KP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pb1LUrl7XUie+ydoV4cGTb9dOTaCr5ABsXssMK+N+CHvI/yh81nVSzgsHoOdMlPQI0zR50N15RnPgkuwFRLV2Ts5NirSwBxY0R/u2gZ0waJaV7+SYf69QGphOGbbA5qDX7bPdZlbl83NpkMcb9Era58lBIU4t3y6xhSqcXlYNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CJB/PJzu; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CJB/PJzu"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVHNN2wwlz1XM0p2;
	Tue,  2 Jun 2026 17:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780420111; x=1783012112; bh=Ma1B7
	X//GgmASQcYKqZgCw6rQi2Z0Xotp4GYvxND2rk=; b=CJB/PJzuzAh/VJ9lf7sT7
	pN8pmZRkl+hPzFe9Ue8HNkN6EbrMC9h37/sK4L7uez2jsKXT0+dFALQsnp6OMlME
	Y/OF411KGP8IdZxdkoJRZKHwlF4GoAvht+Fy/Qd5sGvXkmJBL7fQIY51twAJzV5C
	eznea420nRkQ6bY4Nllu/WYnPLYB41Sl8hk08yLJp9cwDme6LOVc4CcoJfGQ6Hxg
	jBitwi0nEa5icVz40xeR/v9ykrd3zR0EOZvigqZ+cD1tyRgZyztcQTkhjii+Qe3K
	Uo6x7/KsgDxTEboIr+h7LE3HZDixiHmzI4Bos7gOxZpWuMPH4QLjCIiSNF66ic/p
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tWt0W8PPO-pg; Tue,  2 Jun 2026 17:08:31 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHNG0VXqz1XM0p0;
	Tue,  2 Jun 2026 17:08:29 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v6 08/14] block/crypto: Annotate the crypto functions
Date: Tue,  2 Jun 2026 10:07:37 -0700
Message-ID: <c71d62067a12ed7ef6bfe49a41bc0bb274273414.1780419600.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
In-Reply-To: <cover.1780419600.git.bvanassche@acm.org>
References: <cover.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the lock context annotations required for Clang's thread-safety
analysis.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-crypto-profile.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 4ac74443687a..cf447ba4a66e 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -43,6 +43,7 @@ struct blk_crypto_keyslot {
 };
=20
 static inline void blk_crypto_hw_enter(struct blk_crypto_profile *profil=
e)
+	__acquires(&profile->lock)
 {
 	/*
 	 * Calling into the driver requires profile->lock held and the device
@@ -55,6 +56,7 @@ static inline void blk_crypto_hw_enter(struct blk_crypt=
o_profile *profile)
 }
=20
 static inline void blk_crypto_hw_exit(struct blk_crypto_profile *profile=
)
+	__releases(&profile->lock)
 {
 	up_write(&profile->lock);
 	if (profile->dev)
