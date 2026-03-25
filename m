Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED707396D23
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474665; cv=none; b=Intcr//deCN1a2NXTYJFIVW0rTOQEAebZPSOYRHdBlv/xqOwx1S4GuvT8ixGxfTqT4u5I3Rh5Z4Ifgq787c49aJOA3sG7/V+awiV5OVUMnmNpGPwAkPpWEZimY1PZnORPDF3QyQBuzYEgUSW2bWbIvwjW+7CjNuPUxDhw/k/gZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474665; c=relaxed/simple;
	bh=cISC55rBSnB5reuF5uZ86nRMoKVA3Uu2W1I1G53dEPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZsKpiWkEAFz0DkJM96ZZVE9INLu1Buj0jFjqQmm7fErMekb3kTp2l8djQ3lomWmqgiXVfLmeaa+LzUv4NH2j0+zH6yW4qjIn3nq6Vs3uiRzHikpVgdNPelWOVYQB6pePX8xNJUXGc0X760JWJ5oPVcHzxdAUmpdsnXxoeLNO/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=CvemgzMC; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="CvemgzMC"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fh0cf3Gryzlh2g8;
	Wed, 25 Mar 2026 21:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774474654; x=1777066655; bh=2LUs6
	6kqZSjv3I0grUSAJtvq9btQyGw74tA39S2KOho=; b=CvemgzMCG25HKmu4mfVSl
	+p5QjA4K6n305OUBrV3uQt36jQkqurN1pm29oXt7ohD/Bxc8HJ5Nnyj1eznKu1/f
	6EMVeSHAdWRFzbk2yAPEn6nEZmWeEx2kF4WVHRKWQkLRxE6SwPWm+K4Z9ZVdhMce
	CP/2hcou7MFk4ymOdJxhnsNYUKNczrsA+bbRBWUoTdOi3kbEzQmoGkg4/kyz4uGS
	/zPWJgLt0XQi6i9wIyKC0bNmJvFlqyIcLJz00MiPJ36G2tJeUmXIaiM3CnDZPX4M
	ffLgh4fRTWcNR7SF8m4DS2Ch0hhssiSu9kT9kT6tDvMgtOJII9A2MBHpw4XkvNth
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rXIMbpzypA00; Wed, 25 Mar 2026 21:37:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fh0cX6D9tzlfddp;
	Wed, 25 Mar 2026 21:37:32 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 2/5] block: Fix the max_user_sectors lower bound
Date: Wed, 25 Mar 2026 14:37:12 -0700
Message-ID: <20260325213719.2850619-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325213719.2850619-1-bvanassche@acm.org>
References: <20260325213719.2850619-1-bvanassche@acm.org>
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

Cc: Ming Lei <ming.lei@redhat.com>
Fixes: 889c57066cee ("block: make segment size limit workable for > 4K PA=
GE_SIZE")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-settings.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 87724d30be4f..13f5457f9f4e 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -403,7 +403,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	max_hw_sectors =3D min_not_zero(lim->max_hw_sectors,
 				lim->max_dev_sectors);
 	if (lim->max_user_sectors) {
-		if (lim->max_user_sectors < BLK_MIN_SEGMENT_SIZE / SECTOR_SIZE)
+		if (lim->max_user_sectors < lim->logical_block_size / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors =3D min(max_hw_sectors, lim->max_user_sectors);
 	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
