Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730E12F39C5
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 23:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762903766; cv=none; b=L9PFT+0kEu1wUKTqK2GQy0R8aHeoV91e6crZdye8SPR8qulKSRFXs2Ef2Kt+tZnFt9SPwl26NhcUXSX3VYFIH8zR2MC8RJTPrBk/U9uQCQgc06pi83A6unCRlwFddEhKGzpf2LitzJrfjxAMQ/G9pljl+hvgvGdPYYGe/sERwz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762903766; c=relaxed/simple;
	bh=ZZdlB8YVK4TxuzrbGsNBBBYw7h4abjuUrrCSXvIlitg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTUPlR7HHCv9Fxj9Uhhm4aJve4SHchfA7WgEFDTAntIT6+N1/0WhzKDQL9XTuleM7ZHNkvS+MWnarzgFLAxMtynxV+nQOv5Swg9Ewsl1MLzq+bYVRxKBiZ3K7m59ql465+8ViIwtdP/6/L6lyktlscCF8R23CJejD/ra4BB6qGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=i4tB6x99; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="i4tB6x99"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4d5jRR3TxNzltJQJ;
	Tue, 11 Nov 2025 23:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1762903762; x=1765495763; bh=2oRM7
	wJjXLaWtuBGFGincLFWJcGBrcH9qR/3De7hyAg=; b=i4tB6x99JKI6i6QHiCZ8W
	jzZj9FrA72+HX4BCXczYWVNn80TmdSvAiFYRxEkIlc1VcNQqKEtVTib3MVN0gVwI
	1Wd7BiGXlpmJovTuvLunC0ASXGYKBBnRC/0cq7DOFnLR8zrieaZx8y06JtzFaJJG
	NcHYnh7+HpjsxtvI4WvEKuKGo4cBLSZYS0yxWdLFO+3pmBPzHWb8IXh1+K+Ajbxw
	i/e4q/4d8tpLbuWnwCZAKc91+oqK1BRBqiVVAygrrH/VoTZGKpepjoBFAQoYZTLQ
	GlR5YABk7sMVtJMp3cx6PRkYcKFXpDhTkJEnKBIrK7NoOl5jyNc7E65SG1Qqg0HA
	w==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id s6JiQW4I_Gl2; Tue, 11 Nov 2025 23:29:22 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4d5jRL46q5zltKNV;
	Tue, 11 Nov 2025 23:29:17 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH v2 1/3] blk-zoned: Fix a typo in a source code comment
Date: Tue, 11 Nov 2025 15:29:00 -0800
Message-ID: <20251111232903.953630-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251111232903.953630-1-bvanassche@acm.org>
References: <20251111232903.953630-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Remove a superfluous parenthesis that was introduced by commit fa8555630b=
32
("blk-zoned: Improve the queue reference count strategy documentation").

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3791755bc6ad..57ab2b365c2d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -730,7 +730,7 @@ static inline void blk_zone_wplug_bio_io_error(struct=
 blk_zone_wplug *zwplug,
 	bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
 	bio_io_error(bio);
 	disk_put_zone_wplug(zwplug);
-	/* Drop the reference taken by disk_zone_wplug_add_bio(() */
+	/* Drop the reference taken by disk_zone_wplug_add_bio(). */
 	blk_queue_exit(q);
 }
=20
