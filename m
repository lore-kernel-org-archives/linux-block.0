Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38D3947AC
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 21:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774646055; cv=none; b=elONaOW8E1RRhjrBSXSWpiVgKKZwt8fosQwApCXBkpmpJ69oJHezVJEmUNo+jbAtpHPHXsZgPs9BlOUzVLSEshV9pcen8yozjYSqJXL6tS3DQ9OoEFQKGRpAqfeM4gknC6yCk7E/f/k4mvxhV6vpxKg4e6ENWpLUBemUszBiMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774646055; c=relaxed/simple;
	bh=txK7hE+muguZF00RPo0flSe2KqVxdhLTqRGYyelSjKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWrWrQwO09vTfWwqFcjfX3cyNO1Iz0Z4XmOpLGdH7q/Np14ONoSk3uwy733gRpBOszembVq0ENfIMhf2frwNA/ccnE2wsUg037pA0TjIX0BhZ/jGgLRFz8J/TdjYOMb3k6de1wRizi9+zXv2H65+N/D5ca8/w/okkQT+uReARUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZKxoBC/B; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZKxoBC/B"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fjD0j4bKYzlgqsP;
	Fri, 27 Mar 2026 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1774646050; x=1777238051; bh=OXWHy
	wqBLiMr6TJIuT0v9WtKTfVXemIyDY8HRqTWpdQ=; b=ZKxoBC/BtRC5FqCfI05qF
	g6tcHXl1cVFlMSTpDnF932073dYATkZ9IGPw4Av0ui/eTNxEJ363s7Uy0z0et7Wn
	hR+v4setdIjG3/9ZvWaBDUrMaD6NwO0KLFoJIqHc64DNN4bd3mHWK7jURsoiA7I3
	E1hJSMLNrY1WSdysdf7Qrcr0g6BzElDr+O9g5ujrX49SQICn4FEQAp/7unUNUnnW
	LEYw29RsEL+FfyG43BnZPsMDpRdhfLd9FKkLOYPnpIfBgC6c5KWKpbFLOpDUxYZz
	vr9P6K/kGl5zDrdHMrER67xs8k/tE0PFTZMVJvO95+Bp/KkHUzgF6uDg+sSbgUwj
	g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IHCHSBP9oUwD; Fri, 27 Mar 2026 21:14:10 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fjD0c5k7czlh2fx;
	Fri, 27 Mar 2026 21:14:08 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 4/6] block: Reduce the minimum value for the maximum DMA segment size
Date: Fri, 27 Mar 2026 14:13:44 -0700
Message-ID: <20260327211349.2239633-5-bvanassche@acm.org>
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

All block devices that are supported by the Linux kernel have a DMA engin=
e
that supports DMA segments of 4 KiB or larger. Allow smaller DMA segment
sizes because these are useful for block layer testing. Reject values bel=
ow
512 because such values would result in an excessive number of DMA
segments. Move the BLK_MIN_SEGMENT_SIZE definition into <linux/blkdev.h>.
This will allow the BLK_MIN_SEGMENT_SIZE constant to be used in the
null_blk and scsi_debug drivers.

The only code affected by this change is the following code:

	if (WARN_ON_ONCE(lim->max_segment_size < BLK_MIN_SEGMENT_SIZE))
		return -EINVAL;

Cc: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk.h            | 1 -
 include/linux/blkdev.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk.h b/block/blk.h
index 103cb1d0b9cb..b30ff8db3cac 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -23,7 +23,6 @@ struct elv_change_ctx;
 #define BLK_DEF_MAX_SECTORS_CAP	(SZ_4M >> SECTOR_SHIFT)
=20
 #define	BLK_DEV_MAX_SECTORS	(LLONG_MAX >> 9)
-#define	BLK_MIN_SEGMENT_SIZE	4096
=20
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index b8e7f42aee71..109d5fa5e190 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1311,6 +1311,7 @@ static inline bool bdev_is_partition(struct block_d=
evice *bdev)
 enum blk_default_limits {
 	BLK_MAX_SEGMENTS	=3D 128,
 	BLK_SAFE_MAX_SECTORS	=3D 255,
+	BLK_MIN_SEGMENT_SIZE	=3D 512,
 	BLK_MAX_SEGMENT_SIZE	=3D 65536,
 	BLK_SEG_BOUNDARY_MASK	=3D 0xFFFFFFFFUL,
 };
