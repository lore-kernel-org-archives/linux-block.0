Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C838738E122
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691822; cv=none; b=WjgD35qoYTI40IGH0UMG3tWSrby7XI0X2fqsZzlzfajyqXFJzRrXXmbnQtHNQv/A385M7Yu05TCWsyfnUU4ZKyf9ut/UiFQ05AeLpQ3mnDWoyE9cBxzZE/MoLg8BQdr3u+uH1pSN5+5b1m1TYmAYKl/PtwunRkF/rYrtqFEfTOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691822; c=relaxed/simple;
	bh=3KE/6HY8yqHcG7/W489hxgiV4L8JPmmdsdc5Wtlvm1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCui4VMU8A+0vZ6FUSj2reqywhD7XLDj0M/vCswWrYhgNwz+cHUPHt12UmW6r/nCoLkeDsBTwHE731tfmPJSNoa0L1XsbgDl5JI7MoapxLBYLLCyCKNP/2gFHPHcBe81QyvfPpm5V0lHq5/lR6TdeR8fL3p00rM3XLo5gPPB+5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=dz9uQEPZ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="dz9uQEPZ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR654Q0qzlffvG;
	Mon, 16 Mar 2026 20:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691818; x=1776283819; bh=UYN3p
	WHjAoGH0ZpDGsfRv6ghQjDX8sbKfRXhzGHruu0=; b=dz9uQEPZ4DyJTo16AQ8d0
	DwdKgS2Vn09iPksOd1rLQchTVEwpCCar/G+ZQRbEQyV6wJilKoDa/YMuAC0IVtY9
	NG5bX17cOSatCmC2FvrDHCacGnuPx7x23EURyUyr1vpGe1HnXbubP9iHW0fzxCBF
	iOlnr0EgqNOf1W1rQtR2PPqRoC5NcXYM2pWU3pFJEWLhsyTqHMV0RLfcVCjibFnI
	/72JAhtBR34W6xySJghPe+5ymomyG8kiyfP/uWPogTiF0AYCkjIWaUZ9gynj1sv5
	Yg+TD6Pn9SRvhZud385iY/YxK+o3SEha2WTXNKuxzH4YFEr2zayY1mTKozSkypoe
	w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6mh5EShEXMCL; Mon, 16 Mar 2026 20:10:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR604zyBzlfgPY;
	Mon, 16 Mar 2026 20:10:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 10/12] zloop: Add a lock context annotations
Date: Mon, 16 Mar 2026 13:08:47 -0700
Message-ID: <20260316200901.4111651-12-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260316200901.4111651-1-bvanassche@acm.org>
References: <20260316200901.4111651-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Prepare for enabling lock context analysis by adding a lock context
annotation that is required for Clang.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/zloop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 51c043342127..b3654fd814c7 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -379,6 +379,7 @@ static void zloop_rw_complete(struct kiocb *iocb, lon=
g ret)
 }
=20
 static void zloop_rw(struct zloop_cmd *cmd)
+	__no_context_analysis /* conditional locking */
 {
 	struct request *rq =3D blk_mq_rq_from_pdu(cmd);
 	struct zloop_device *zlo =3D rq->q->queuedata;
