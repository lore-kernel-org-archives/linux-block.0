Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43342AD00
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475150; cv=none; b=Xw8mWNS7B1Wu0cssYO011rUVGUHazDb/YE32anbMAB1AKIX3XNQpfU4BNKBsuFdswNTV6eofCSZl/7dz+QCo5Osou/ihPV0CXXtH4/C6A/4X2wZSgWCdY7o1SwCy6e6U0UlO8Zn6EFOu9mySzz9dtE06c3VPut6KloKr2QI/bgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475150; c=relaxed/simple;
	bh=yuad9al0/ahMdEV7pr1/Gg2nvZWiQQli0ryGz3dB9HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nohx1OvbEG/B52D0Jf0WGXWBpQ+hHgHzWfdMkGUWOzXnk6Nt52uoWNlRhbYW6aHUqv+5p8EDVdFGOnAaqGSgHEZ8ni8sP1g9OvyslW5z/BuKT0quKlwdJKlNUoReGk5dFTUTN3CrOO6nEJa/FKZ0DX8pRlPnRhncVE55EK36RjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uq1SZJHU; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uq1SZJHU"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0p36z6tzlfpMC;
	Wed, 25 Mar 2026 21:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774475144; x=1777067145; bh=uTdD5
	k7hulA6sThcmiEwQjAbPcySm2l+uT+Yxq9MzQs=; b=uq1SZJHUnS8EJRcn/narP
	ILD3XoPWPxMHd5BgYVWjcASedkqCG+DObiDTXqoksktTqwP6rDUgElYxqPtrUAM+
	q1mXopzZzYQzDVGBuLthTbN3p976ASmi0wwiC1Fk9wETA2OJqTG9AvTA2HhfTh0y
	PmWOoLEDDEupuR5zYt9AgPE9klQLTAhAsbbfYmPpO12tmdKIFsh+tYwoqzcWkCuM
	PIaEXz7M+47CXbhluNIZBbF+GM63YkvNjNbEiEQDf2jhPL8bG5l2pQFIZspygEVh
	wfQcDbGv47e+9LjLcJncavU3LP4SDdoQC3C0IEHz/mpFYES72lkc+rvOHkSoYUBJ
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lL_1b5ykdpH7; Wed, 25 Mar 2026 21:45:44 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0nx3hR8zlgyGG;
	Wed, 25 Mar 2026 21:45:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 06/26] block/crypto: Annotate the crypto functions
Date: Wed, 25 Mar 2026 14:44:47 -0700
Message-ID: <20260325214518.2854494-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325214518.2854494-1-bvanassche@acm.org>
References: <20260325214518.2854494-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add the lock context annotations required for Clang's thread-safety
analysis.

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
