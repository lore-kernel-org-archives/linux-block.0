Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4333DA5B8
	for <linux-block@vger.kernel.org>; Thu, 20 Aug 2026 19:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255866; cv=none; b=sAw5r0k5Ysg7Akenbz1scPr5zzeE03Jt5aZdPFpAvST8wj36xtHYJA/4w+pythNgIeg+N7hYu4qyrs0T4a1L/qhj34v7GNPN2YbG0LWmJ4udqj2HzAz3B0txHlNUsNpRep1V3sxKRLaq7qybH/gcakCblyjttXYZvmhrmUtWdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255866; c=relaxed/simple;
	bh=baeTmcVjwYmQcFahvDzQSeCKvwX+hRqZlSTnCvC0zt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+mlEGMU/OXb5gbhjKYbheBKSQuy1WOCEwU1mARvB+N8gYfH5YeqSDVeedkzWWU0IT6kj3Cvc2SrJ4n1I2zXNBsyyV3sFZbBkx6y/mTQvKEpIOf3464NTrHAkp+gysUVNNM5gCe+S8n1BT5lM4xLx7ttgktdXVT7WQud8lpj+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zZj5flqT; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zZj5flqT"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hQvP442jGzlfsTm;
	Thu, 20 Aug 2026 19:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1787255861; x=1789847862; bh=ZPxrZ
	woadkJEyrgzB+Ij2oYzvKfpjB8SyRT4YsksT7Q=; b=zZj5flqTRQoAAY8oGQUG8
	rQqHY3BxXa3AzNNx/PSS/fiXHUz/+LPAmtsiQUBB/dS1G8n0m5o/rBl/tgqspEje
	edDTalU9xB2VaP7DZUMmmCycmeFS9WKaLikrRobs1y60zuZslnKhuBiIAAzAyLqD
	cwHzzRZoTyFJ6wAmPzM25pOEcs85aIB4eVaNm+uBfTp0MYR7JqnnfjSZjN5MSG1n
	NMq8iQlmNKb+S2qRgMaXpQ4TGT/Fks8oEaEaIOQc9XX5MCYlbBK6jptwEhNLwxpT
	M7tFoVzdoViyUSr3rhhz87rAbQAildlk+TMK4kvE9wCOJezHBwJtWKXeGkAvZn3y
	Q==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id W6p4qEr9YlV8; Thu, 20 Aug 2026 19:57:41 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (148.60.168.34.bc.googleusercontent.com [34.168.60.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hQvP01j2PzlfsVF;
	Thu, 20 Aug 2026 19:57:39 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 02/13] loop: Reorder checks in loop_validate_file()
Date: Thu, 20 Aug 2026 12:57:10 -0700
Message-ID: <de6e8e655f86b3562741df412513de84c50f0859.1787255652.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
In-Reply-To: <cover.1787255652.git.bvanassche@acm.org>
References: <cover.1787255652.git.bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Checking inode attributes after a loop that modifies the file pointer
the inode has been derived from confuses some static analyzers. Hence
swap the loop and the inode attribute check.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 36deb08ee463..4315c36d4042 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -506,6 +506,9 @@ static int loop_validate_file(struct file *file, stru=
ct block_device *bdev)
 	struct inode	*inode =3D file->f_mapping->host;
 	struct file	*f =3D file;
=20
+	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
+		return -EINVAL;
+
 	/* Avoid recursion */
 	while (is_loop_device(f)) {
 		struct loop_device *l;
@@ -522,8 +525,6 @@ static int loop_validate_file(struct file *file, stru=
ct block_device *bdev)
 		rmb();
 		f =3D l->lo_backing_file;
 	}
-	if (!S_ISREG(inode->i_mode) && !S_ISBLK(inode->i_mode))
-		return -EINVAL;
 	return 0;
 }
=20
