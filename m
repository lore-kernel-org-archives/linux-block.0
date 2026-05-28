Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA09C313539
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 19:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997589; cv=none; b=I06XKBnPfe1jzryLm8x94nEKc4m3tYyL2BY2aeUREcTZ+yi969ZFPbAwzahTGNk473QFZNSw53XMFAS6y0gZvMdrTqYFse0WNdaPiptYNLrdqFZ1PMndAoHNz6QtmKgTgceJp2r9xY1ZlNPvutD19+jYKPi+3jEOeAffS64U9VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997589; c=relaxed/simple;
	bh=+uzkYHYhHiYYszdljd+4qsNkQfdW92BwgdTvrlMN1bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j82K2qa/B7mjH47IEUB7eJ1G7nrAt8zsK5BPM7IKaF3an3DQV5DhqO5QB3P3a7joDN3IOGHgUXJ3LNpToxQJ5Ra94DbUle7Wg5NKBUKmVPq8JDO+al0fgPDfjQh7MpfJ9KtouemITmdAf8cA+jTUlsRAfp9izuQSgEV/fUjFFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CxSdz6Nt; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CxSdz6Nt"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRH6r3lFXz1XM0pk;
	Thu, 28 May 2026 19:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1779997584; x=1782589585; bh=JkGeQ
	DYAhhGOVmXXQwO9LzmYQMJvgeLiZNUVFBTNsjM=; b=CxSdz6NtqIuQj2f/Bav4G
	I7nbeq8TocwaNstZbE1g6ckqFVFgbGLksugURc584sZdf/eeq2aIc4NpdhKK+Pw/
	26yeCzgLhSSDHjJbdEUMu8JJi9L6hf7Gsl8HPQbWya5ioKcDgyZBks+m1CWRce2J
	zJyWpAgvGDS4LzS/3MrbTGWSjZxUL755vw+E9KSofUxqLH/p3IsJ2ducFD+9Z2h6
	zhAYDb0JQMliU8hCJCeKrPlrbmwnNXmWb3+7WahHFMHKItaeqiCsSF8BiYZ+K6YP
	Y6rsbSKvjO9ftcrCnIPiV+3hyWNo1L9I1VViDkyIuT6BYS4VH/WuZBt1R8zNQlRR
	g==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SZW976UfVRil; Thu, 28 May 2026 19:46:24 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRH6k70XMz1XM0p3;
	Thu, 28 May 2026 19:46:22 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v5 07/12] block/crypto: Annotate the crypto functions
Date: Thu, 28 May 2026 12:45:44 -0700
Message-ID: <91f2acf006f02c42d5d418f3074a6541e79e6fce.1779997063.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1779997063.git.bvanassche@acm.org>
References: <cover.1779997063.git.bvanassche@acm.org>
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
