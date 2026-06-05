Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA59D377563
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682500; cv=none; b=olhFt/bPD6SdOA1ItrBoQtuJoMiyw2sUXlcEqUTiKcSZJaqs1a+V9HvRF2PeJKBc3epu3b8nR82gD0gSZ+SnRiaYdgPylIa1UEr5HHLFNE7T7elFY2En9RRZwLd9kYYVM0m5CWfsnJyOYC0XWs0aemKwhu7+OTUBNgkWB3b9bIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682500; c=relaxed/simple;
	bh=l7xLoxJ2PBUIUOAUygs7o/8Hxl6bQ9OKVTGx4HrAs5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDtsIcSX4f1cJifQO+r7J1xc23rDQEL45iitmy+GfDspLu0iP4ku6OUr4GzZhaT6QewIXXTaLfR23TEa0wZh0gt6mf19e3kWzZzePT4gqFPuAIduOVb65DN6uUAdFMaej+qX9QYAsoR0uAeI19mdAPtV+cdGJeo7sviQPRtfBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=j70jPCUF; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="j70jPCUF"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8QB2F8Sz1XM6Jh;
	Fri,  5 Jun 2026 18:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682494; x=1783274495; bh=JkTPS
	Wsb+s35Uq5e2xyvJfEBkbNHnSD1cBlGjjyCCO8=; b=j70jPCUFk5MF17aai/Nih
	RtjhsR2KccJZ4oAV95TRjq16BVuCWxev1pS9Vq+xC5U9gXyjOu0yTM1+0n0gnpqi
	M8BjMODndFvw0DeBEPlhZDWGtEEHJL3uMdS/X06+HmlwSfiRpOFR18PxYjKZ4yZS
	6SkCHWJ2hSGZQEnAFtOTcGIcx51Om5ZeqTJRGTsuru/lD7Tup0rDqo5odJdAGLAZ
	M3b71A2rMMDda9ODOpPtElttgeoeKZJJFp27lj2xSrZW0VlcXLrEGnznG0g1pWrV
	AzfIpp+imFvAJBH1VGzTHhVWjTheqHUgWUvd6glXZTAYJENdvIsgm5Oxct/ImeJE
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0YNDnsQ3tppH; Fri,  5 Jun 2026 18:01:34 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8Q30h8yz1XM0ny;
	Fri,  5 Jun 2026 18:01:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v7 02/14] block/bdev: Annotate the blk_holder_ops callback functions
Date: Fri,  5 Jun 2026 11:00:55 -0700
Message-ID: <be51cf81110f691ebd5868ac2f15ceb847805bc8.1780682325.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
In-Reply-To: <cover.1780682325.git.bvanassche@acm.org>
References: <cover.1780682325.git.bvanassche@acm.org>
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
