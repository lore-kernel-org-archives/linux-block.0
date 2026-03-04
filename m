Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2692F390233
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772653757; cv=none; b=VtqE6enMhFH1/eWcIupPl2nmBWBmWAF/7+dxp2230/M3jV4SVulsrrxzVZoVW/EjuGhvDQ9ZgvZBkJrZGyBnPpJeUqHkThe1z9xQXnnyctNrQg/DznksbZaQYYCGru/ZvhcJT+3R0UTtrbZGeLSrjf6Zcj1rQG4WvLK2o4T7ZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772653757; c=relaxed/simple;
	bh=3FuGJS8ISAsVCvF8u7EoV0Lr2H1Zi6aF4WjbuvzDmOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mM32C5VT6tb1/CeBLgZ+v2Tbv8QILUaOoU3RQVAJhswlnfMYYc6dK5PWSHUcpnJYEI7+3hcqZHUO4ZG5T5kqQSn09/5ey0P0xY0FdsgERTfEnDpCYvk4EJABR7SB9u10M1UWoia3rxhMFGh/YJDLD/9x2nlVuFpjM/jFSGQrh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TwcWLGzS; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TwcWLGzS"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fR3CH6gWxz1XM6Ht;
	Wed,  4 Mar 2026 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1772653752; x=1775245753; bh=tkZR8
	KtSxDNTIRo79WDOg3neXoeyQ9e4qWhn+cvHGvQ=; b=TwcWLGzS1q+47QdDba0w9
	zovt8uniOAxJOvFqw6XkX/vj2LrSQKonpg84UNf0A0UlLw75Ug+IywjuNrO439Oz
	2FmWDO/pZQdirUR5eTeenf+6qCwfie6xh2BYyjpOSSs3hlPWlh+PpclGJ/1hnuin
	IYGAqZ7rXUDL+u5jHSQjBUPdjSSb5P/lhe2+ynSMlfS5wrCvaYehPUVUXzUDW8lh
	RAGGMqtZobnzGiOgQ8np5blxYlnAzYY7b6VTnEC/+NcNvC8IXbLYXKbjv+jR6T+M
	ORACi54mcMYcEShAypNosFeN+1qpv+4+DqrraMn2cW5dcQEbtaeGV3oG4iRejxgm
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mFu3MTMkmLd6; Wed,  4 Mar 2026 19:49:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fR3CB13vcz1XM6JV;
	Wed,  4 Mar 2026 19:49:09 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Marco Elver <elver@google.com>,
	linux-block@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Justin Sanders <justin@coraid.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 04/14] aoe: Add a lock context annotation
Date: Wed,  4 Mar 2026 11:48:23 -0800
Message-ID: <20260304194843.760669-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <20260304194843.760669-1-bvanassche@acm.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ktio() unlocks and locks iocq[id].lock. Add a __must_hold() annotation
that reflects this. This annotation prevents that Clang will complain
about this function once lock context analysis is enabled.

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
