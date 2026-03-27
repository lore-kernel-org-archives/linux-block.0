Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E70393DF9
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 21:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646051; cv=none; b=cuvrnwd5CeVoG/1luVmcX/EiU+rz76BQHxMxUGyQEpzpC+iccsqU2wa+70LMadaTNPpKCfI9k/TS7lN02KTFUGr2lsBDnMzDkEonlHzkiQO+pFwTkb+0NdpNnPrpqvtmDeOdJwuxfTlN4FuFdGS+a3x0M1kcjM+UqHx2x5T8sUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646051; c=relaxed/simple;
	bh=TV4qTz+5IPiosgXLYSiTLQZoXsvcz2iX/3IT15OWXbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cY78Bswo6/6MUgxENToFN7eTbz7DNVbpzv61ouAfrbQuMafzrlZSZJA/jz5XxJcl8xnW5XXW1fZ8EhJJcFSyhvEQyGufypp1jaWxfTZak12fYZN+FCE+NY0RnP/+V6ibJ9Ed3YR0FvlpgahJkkL7ViORxzCvh1KhuMJIDQxWSkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3S4ucmM+; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3S4ucmM+"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fjD0d4BwNzlh2rh;
	Fri, 27 Mar 2026 21:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774646046; x=1777238047; bh=NXWSp
	yrUZBMamK+V0I+RKc8ny0F082KgrdvMFIyd9CA=; b=3S4ucmM+5WjeAQOQGksBG
	ihNaCTUnM3olHfBY5RziQDuqsxW3jH9kzwlkDNljSV6XwNeVL0oqB5zNAtBjMefm
	hR1ob3m8XrQQs6Y3t6QMg2BE0YDtFtppNztLSXhUcRVjGReuotS3tOg/sam6KA7f
	FnfKBD638KLZekvXQUzZp4n4DODruZMHWgzku5eraDSKomZenrhZUone2FA73/Hc
	QhoJ/5VhfnlM/mEnEpwajWdsz1n1jQLkINcH93Njzsn/XkFJaQ//1RNLBAgkSkE9
	ChRY6SubVP25MczrIK/6eoPln32ce2TF1XYsik33tVa49OWHhY4d4Tw1b9j6mHrM
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id HgoC5SXFa8iF; Fri, 27 Mar 2026 21:14:06 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fjD0X4r61zlgqsP;
	Fri, 27 Mar 2026 21:14:04 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 2/6] block: Fix the max_user_sectors lower bound
Date: Fri, 27 Mar 2026 14:13:42 -0700
Message-ID: <20260327211349.2239633-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260327211349.2239633-1-bvanassche@acm.org>
References: <20260327211349.2239633-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The lowest value that can be supported for lim->max_user_sectors is the
logical block size. This patch prepares for reducing BLK_MIN_SEGMENT_SIZE
to a value that may be less than the logical block size.

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Fixes: d690cb8ae14b ("block: add an API to atomically update queue limits=
")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 87724d30be4f..56017098d2c7 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -403,7 +403,8 @@ int blk_validate_limits(struct queue_limits *lim)
 	max_hw_sectors =3D min_not_zero(lim->max_hw_sectors,
 				lim->max_dev_sectors);
 	if (lim->max_user_sectors) {
-		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
+		if (lim->max_user_sectors <
+		    lim->logical_block_size / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors =3D min(max_hw_sectors, lim->max_user_sectors);
 	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
