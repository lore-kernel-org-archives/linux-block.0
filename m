Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049426A0A7
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420110; cv=none; b=Dx4abZ2ieWU5SkY8c5bgk/5ak1blSKcifP17deQNBo+FB7l2i0m45RD+X6/8HMTEQXJdVmhE3qhv3NH+Nd1Z42nsFVq+RA3IjcwHis+JCZ8GR67jK+r8Is86jQfXGslCnGH2FH/R0Yxh00vMFXNr45c16G/fX/6K7w4E77yBX7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420110; c=relaxed/simple;
	bh=l7xLoxJ2PBUIUOAUygs7o/8Hxl6bQ9OKVTGx4HrAs5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcA3nUAuV9Y54XW3MQ34AuCbqFW+YuOdBKwKALZOflsaZR3Gt8OmDrw8pbESQeMBUMx7XQUZZLOgNhnzvRNL9vqyG7EIbFb8HttFbCijbejrY+7msEwlaKaNNXbGff00ecMk7boAj+f9rTMp36hFEjjIF42pc8kcazA1Tuknbfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WxA4ZUSq; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WxA4ZUSq"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVHN65dpDz1XM0p7;
	Tue,  2 Jun 2026 17:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780420098; x=1783012099; bh=JkTPS
	Wsb+s35Uq5e2xyvJfEBkbNHnSD1cBlGjjyCCO8=; b=WxA4ZUSq2TvgtrlvDDi3X
	xIuCxLiPXRncSY/2ghkpur6tPoeAa2zHXuEpEkXdjGMuB4R+kqVGK3xk9W0Zc8sY
	nBDR2q0CBwmwrYvUvL3M0nyyFH1LG/Mq6bU1zqHw91zc9SpqBu4A7538MT6Z8gFq
	O/KYztHAb2XZWnoo5gNEyV1c6HjMsloyhQLYAQvxAGRV4OBXUy7CcwS+QSB0dKBr
	HbzsETrFkBwLqzIzQX325hXQcsoO8tGGbQ9iByizefal2/TwmmeKaoPvTUxAzQDU
	Ijbj/uvFQixoFhk+H9Tznmps6RtRg0dYX6jRhxSSA0e9bvJc3ReaOD4Nd/uaj4dD
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id G8nLXm5HP56R; Tue,  2 Jun 2026 17:08:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHMy2RRvz1XM0ny;
	Tue,  2 Jun 2026 17:08:14 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v6 02/14] block/bdev: Annotate the blk_holder_ops callback functions
Date: Tue,  2 Jun 2026 10:07:31 -0700
Message-ID: <1b55ee783e81812fb14e2109a368ed941f5a9cbc.1780419600.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
In-Reply-To: <cover.1780419600.git.bvanassche@acm.org>
References: <cover.1780419600.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The four callback functions in blk_holder_ops all release the
bd_holder_lock. Annotate these functions accordingly.

Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/blkdev.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 65efbd7fe1a3..57e84d59a642 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1746,22 +1746,26 @@ void blkdev_show(struct seq_file *seqf, off_t off=
set);
 #endif
=20
 struct blk_holder_ops {
-	void (*mark_dead)(struct block_device *bdev, bool surprise);
+	void (*mark_dead)(struct block_device *bdev, bool surprise)
+		__releases(&bdev->bd_holder_lock);
=20
 	/*
 	 * Sync the file system mounted on the block device.
 	 */
-	void (*sync)(struct block_device *bdev);
+	void (*sync)(struct block_device *bdev)
+		__releases(&bdev->bd_holder_lock);
=20
 	/*
 	 * Freeze the file system mounted on the block device.
 	 */
-	int (*freeze)(struct block_device *bdev);
+	int (*freeze)(struct block_device *bdev)
+		__releases(&bdev->bd_holder_lock);
=20
 	/*
 	 * Thaw the file system mounted on the block device.
 	 */
-	int (*thaw)(struct block_device *bdev);
+	int (*thaw)(struct block_device *bdev)
+		__releases(&bdev->bd_holder_lock);
 };
=20
 /*
