Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD759429825
	for <linux-block@vger.kernel.org>; Mon, 11 May 2026 16:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778517093; cv=none; b=Umt2DHQwNvIO9ZvLEasTpj2KeNsrxcOVmTJoNbIFiDPYoPL3upBgucSnbWCHEcYYN9a/ZSeujsVOdj/BWkNOqN2+6OhyT/Z0wwUIZ6dcsQSmsxSgRPh9ul+ryc7/CGymjROaSJBFYlQTUB2dI4FFQShWE28VrboIT9zdHb33mvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778517093; c=relaxed/simple;
	bh=+uzkYHYhHiYYszdljd+4qsNkQfdW92BwgdTvrlMN1bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIoz7D7qkgCK+lR4mTkD5vCKo6sZhvFHYgU50xzHoyeLBJHe4VX5Lj5ZEF6HMKSxnqw/bXcZnP5+b+xm3Vb7hC7qLGbTNFwZ3OoYipZjlhEZbtoHw/DHmbbWN2i7ZQ6gzVWeA/ac9xKjoaNSS5x+ISSYGhSXDJKgtNLdwlg+Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UBSbdcBo; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UBSbdcBo"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gDlbm23Hjzlh2g9;
	Mon, 11 May 2026 16:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1778517087; x=1781109088; bh=JkGeQ
	DYAhhGOVmXXQwO9LzmYQMJvgeLiZNUVFBTNsjM=; b=UBSbdcBoHCEiqopwUkdFU
	3ymgEhFIa7rRQa5a7CWfkJbr0ldWQRvmofhGDofcrXnyyoGAA7dx7pAQ2HzL1tgK
	uRAFHqN6Bbyqcg6M+1sZjF59D7XDq7t2ROYyhKFJY1Cy19T6/gNICEG+xGzlRMJQ
	O77MSKlaUqMMRw0msKGzNFEptGWCN57JolNJo5jPL4VuiACErlj4jQVyLlKYmFB+
	2L8x/M3aUlbz8+cinvFPrfehVeEVxTSNSWcEZg7pDa5NQlxaErfHAf3hTCDC9zMg
	+oQkjFBg/XIhXszHLYS3MpTPj/Q+2RukF1d/3Y9+ct1KRO4SvKeE//MqnbohRBsh
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HkFg7Pi8HOxb; Mon, 11 May 2026 16:31:27 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gDlbf2FFSzlfl8H;
	Mon, 11 May 2026 16:31:26 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v4 07/12] block/crypto: Annotate the crypto functions
Date: Mon, 11 May 2026 09:30:49 -0700
Message-ID: <20260511163100.1887263-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260511163100.1887263-1-bvanassche@acm.org>
References: <20260511163100.1887263-1-bvanassche@acm.org>
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
