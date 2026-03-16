Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F52512C8
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 20:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691784; cv=none; b=gnLP+Xrrd828VQQdp571CGTmhDRedOyAiqFjghHzWeotSqiKbKIhfhXiwVriztsAXXRHtktovuia6VTMZXL9DF9XzPmK8VuZiSuVnd0h0oPvVsVi0gg33R8MjxcuZU5O+5TsGok/Day34Es1obGCiwy86zmKitzJWca8tNZNsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691784; c=relaxed/simple;
	bh=k62Ck2/wQTdLbkAlHH629JDDW0nG2lSyj73GluBjn/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxylWwIe5ITQH3B+2ZfUHuSyrN1NdNh7+5daAnGEJNGLFJNbz6C3E1qSnvsxgNRxbPaPS6uHxXIArrn7PXK67bmO4N4cMxMcG3nuLiHtdJTQl6vgAgf+8+4dZetOTMl071U6CKcnSjyLIS2/VieKfFkNo2SAQ5bjt4uxr0HoZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZGPBqIKO; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZGPBqIKO"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZR5L6PNszlffvM;
	Mon, 16 Mar 2026 20:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1773691780; x=1776283781; bh=gO39K
	3Ybq4VZStEdBwItbzluaXKon4hLekPV65PR9Yw=; b=ZGPBqIKOsoP9ZIIhDC3le
	NpdBVuGDQhiCPaGgugROEx9rxc/nE9xnD2NiJ86oMkxiG8gipmHzokhITrrRqAGp
	c+We38TltX2doVBPDmwXKkHP4SEFLZGqqRiZQ9jbq0NDVFlxyHw0XHWGhK0BaBcH
	IhDqSTNR/9IqXzHWwSH9jZZPslemEKQsbnNzI3W2T5zJPbk7pFoolS72oUgq/57b
	uO1LR8POvlOJZcMxdq9pTvAfWCdWGGbkGdejERH0MvNAVH3tpeJrxBCwPuw/NNyS
	wVfCSyJHP3Y3Y9c1Wau28m4rgLT20AISYc20r8CigkW5TZh8JgmlZJ5G5RkArJMG
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MKsMUn2YxL_r; Mon, 16 Mar 2026 20:09:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZR5F3QlVzlfgPq;
	Mon, 16 Mar 2026 20:09:37 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Justin Sanders <justin@coraid.com>
Subject: [PATCH v2 03/12] aoe: Add a lock context annotation
Date: Mon, 16 Mar 2026 13:08:40 -0700
Message-ID: <20260316200901.4111651-5-bvanassche@acm.org>
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

Prepare for enabling lock context analysis by adding __must_hold() where
appropriate.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/aoe/aoecmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index a4744a30a8af..54c57b9f8894 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -1193,6 +1193,7 @@ noskb:		if (buf)
  */
 static int
 ktio(int id)
+	__must_hold(&iocq[id].lock)
 {
 	struct frame *f;
 	struct list_head *pos;
