Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A2377543
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682517; cv=none; b=RhIAJuOrvksT2pu/DiPPtVQzaw5om5XAKwXj4JBuZDt6jhsGdN7WfoLFk2KTufCm9Wc3155Nqjsosb5DNuc1cb/foXoK4SJR8+hiV3pNYlS5GZeCEWeWTamFabip0c7FZ6qNvSFqHKIsmQLeLd347YrP+e8ELjK4NT9GETAB81Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682517; c=relaxed/simple;
	bh=9p/R30+Qhhj9xUYxGW+3Q3VJTpEcCAy5erXAMwL6KP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH8cEt6wlSTDInX22tJWfQJwS1BE4HpqjUwIus8wo3ak1Nh1vq6V/H6vbwy/FIEq61m0NFkR2A/8V0iJCNbTg/+mCg+xlheYTZtT+5EFr5/Q29KQSePFxJy0vQR2GkZvYseY29+RCSpILetq31PSyyEKbPmsE5sMQ9fs8JeoveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ed9LYWtF; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ed9LYWtF"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8QX2Gq9z1XM0pX;
	Fri,  5 Jun 2026 18:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682511; x=1783274512; bh=Ma1B7
	X//GgmASQcYKqZgCw6rQi2Z0Xotp4GYvxND2rk=; b=ed9LYWtFW++lQcxK33FYq
	Ju/wv3lfu8evYMrp0HegVjukNYCTRcZnoMeplH571MIYYCVql0SVmBjXVKYcVkgC
	m9tXkggvZs0qikGZlJ5blMEad1qd9YkRNBjeqOM2nqxzOKfynfjd38BKRNFmFNu4
	2Pav5yoLc6/Bp/VZmkIohUdn2d1FB5L7zCUTmROiHjvO2JldVCQlzhbyhh8i8U2C
	rDbRo1CO/jzvn4Zhxd+qj/c97T3DbFeB7NMEaDRMm0la2HNF6078U1RuRC6aP4Mw
	zaybvQ/uDhz4kYDxDPrk93/VrLVnxBeTtNawreABNNADAXBh+pyGPeJ9j70db46X
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id J4oLFk7nxWQ4; Fri,  5 Jun 2026 18:01:51 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8QN4ltVz1XM0ny;
	Fri,  5 Jun 2026 18:01:48 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v7 08/14] block/crypto: Annotate the crypto functions
Date: Fri,  5 Jun 2026 11:01:01 -0700
Message-ID: <297b40e43a7f9b7d20e91a6c44b41a69d01f5c63.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
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
