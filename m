Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A261EDA3C
	for <linux-block@vger.kernel.org>; Thu, 26 Jun 2025 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972950; cv=none; b=g2MFaGLybgbnVaCS3vEz9f4z5PRk0U77JynTvfsn3CKyffDGMxb86TpD6swQGIiSalIT7KZ0t+jnx50V4h6Wo0hMXVuI75eviyQhE60dYuROzu6U1n/SmgotoSkhZCoj0tSnxzUeSbe/S8K0CNCSrDjbwJjBXMSegaA1DZVSsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972950; c=relaxed/simple;
	bh=caVkVAf77kvmiT6js4QbTtUj8+3T1eWBkNuKmZYJPPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=epBKJoWtG6v3gz/dm1o6+8aACG2CvxgCuw0wL4MjgNKFaiIGIuVGh49wY78gTyVnCScClPcd7pgElHZLdwBZzw0SsWPXRi9DWfDH9MDEUZ1ClU6YFc3CC4ufXVL/OveR1OQDtf3AxmQ87ep4TM2yX53veVnEeZmDkqD+7OUSZAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=46xrxsyR; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="46xrxsyR"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bSs8g460lzm0ysj;
	Thu, 26 Jun 2025 21:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1750972946; x=1753564947; bh=5CGGMSnE9QYmXXXpTFbT7Fm8IGHCqr0HCM5
	QypM2+gk=; b=46xrxsyRbxSwgoHbr2fEDMi8WoZXZ6duWBr0H9F9PfKt22mjS+e
	2ujuFcbO8zfC9tmSRhI48bm80Ld/zgq1ZWD+iIxrbh8DLNOrR6Vbs7E/WTd6vnWE
	2Wj2c5phO+oIaP9s4ZUErcFWd9ol6C/BXetreYiWIKdgXGYwCFem+n02iPS04y1Z
	+C0e8Tq7hQlw/VQfUeokU5iRWWYtvT8J/b2KvyfKRVFBkFJ3Y1sis8eFaHdOVTVi
	YZLTSqvWcaMmH7h/GTfCOnjj918MsRmhR+2AXVwF5SNq+PdZMx7eBHGXe6s45vU9
	a2PCbct5xQNZNa3gdBRGaYmAEhqrg/bn0Bw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0aNDuTQ9AZuc; Thu, 26 Jun 2025 21:22:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bSs8c1RHrzm0gbv;
	Thu, 26 Jun 2025 21:22:23 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: Reduce the scope of a variable in __blk_mq_update_nr_hw_queues()
Date: Thu, 26 Jun 2025 14:22:01 -0700
Message-ID: <20250626212201.2271832-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Improve code readability by reducing the scope of the variable 'i'.

This patch fixes the following W=3D2 compiler warning:

block/blk-mq.c:5037:8: error: declaration shadows a local variable [-Werr=
or,-Wshadow]
 5037 |                         int i =3D prev_nr_hw_queues;
      |                             ^
block/blk-mq.c:4999:6: note: previous declaration is here
 4999 |         int i;
      |             ^

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4806b867e37d..e4202d8f68f9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4972,7 +4972,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk=
_mq_tag_set *set,
 	struct request_queue *q;
 	int prev_nr_hw_queues =3D set->nr_hw_queues;
 	unsigned int memflags;
-	int i;
=20
 	lockdep_assert_held(&set->tag_list_lock);
=20
@@ -5032,7 +5031,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk=
_mq_tag_set *set,
 	memalloc_noio_restore(memflags);
=20
 	/* Free the excess tags when nr_hw_queues shrink. */
-	for (i =3D set->nr_hw_queues; i < prev_nr_hw_queues; i++)
+	for (int i =3D set->nr_hw_queues; i < prev_nr_hw_queues; i++)
 		__blk_mq_free_map_and_rqs(set, i);
 }
=20
