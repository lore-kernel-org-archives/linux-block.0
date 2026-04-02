Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A63CF032
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775155230; cv=none; b=OEEUdLOXI6Quad0CDhzXjdhbhc2nqabIV23XRl9LBjnfcoaa0A6rFR4Qt1qpIS0IjskUII8XADN9HgxG8a8su2BfHQgVp4+bV3ckwlfmUTBtXJMVjv3Q/188HYzWKDAD555qIuxobJiZij6fjVCJI/ZcPmzj732NfJBXuNQUQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775155230; c=relaxed/simple;
	bh=+uzkYHYhHiYYszdljd+4qsNkQfdW92BwgdTvrlMN1bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgMprJzuEuxbsmuh5GgLnzK/iJlsP4/pB4kbujN3h2yCIYp0mfiAFG5X8zVxrwUDxE1inobJRZcX/oe54DVWSDUXVhOGclxsGH5ZRLTzYhMia9U15VirTzjJyfcJWqEDXXVhyVTerHqGZqrG9Ed76TkXMwEOb9O6cFbZCf9Ns04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Apq2/OeM; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Apq2/OeM"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fmrJW3RC6zlfwHS;
	Thu,  2 Apr 2026 18:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1775155223; x=1777747224; bh=JkGeQ
	DYAhhGOVmXXQwO9LzmYQMJvgeLiZNUVFBTNsjM=; b=Apq2/OeMDOD0cQKX6hqeE
	bCQu6xyn14GIN/M6cEY5jVJugFzscy8fJDPYdyO5aZeHuwnKslcF42j1CIja+uV2
	G9EzQ9fWfBITK5RtXDv+9qF4HG15CVxlEW6PrDLJ4zO50xuw2MrPZBobHDtSdiSW
	l14LZgkA17uRBShhCOo7iebTFGSguf7g/cf3625P7j9qIQwVkFGb4dGWD8kkybak
	Tne/j+ufLmk81YxdpkKZRZ/P0PaQBtM1dViMDwqp7mBZLV1ZyZUBj8PlJLM0EwJo
	hAQJuUbxyCkYIeGcTGkgujOkA65Y//T19QZOrpLMdayPnIpla3+NmTTalA+DgRQr
	A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ee1Najz1UcCK; Thu,  2 Apr 2026 18:40:23 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fmrJP39hqzlfvqC;
	Thu,  2 Apr 2026 18:40:21 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v3 06/12] block/crypto: Annotate the crypto functions
Date: Thu,  2 Apr 2026 11:39:38 -0700
Message-ID: <20260402183950.3626956-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
In-Reply-To: <20260402183950.3626956-1-bvanassche@acm.org>
References: <20260402183950.3626956-1-bvanassche@acm.org>
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
