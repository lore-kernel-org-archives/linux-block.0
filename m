Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70123F58E5
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420114; cv=none; b=rZ+HKLcH66IvGX+UHDVTYO+BJukxCMU5B1qyVhJP/r9BvwQf2+BLyEvqfxGyC+MuA9Y/kwH3sACS7p52Oyp/WhwVjBlu7Imhg0anTDmbilt0qlEEpLyXtNjZlSUelN12OMTe+9Fh67mVrAU3RtjVu/5oUCoJ5MsvMT7h4dfkd20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420114; c=relaxed/simple;
	bh=3GW3ArACB+fS6bKNa8xHYCpSYOfbNTe9a+K3SyGo7Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z6PpAGRyYcdfu8NQ5Br+I0GRL38fAqGoIRNSr39xXxMerLj3SYz+rWKiKLqDPufncyzEu1xG6ZVldqT4LtfJbZTdN70O4QXVzyRTHzPHCpfGAlClDLhAouXg/Jw+s4q7TMvyPybga6heROlaT79rYoIVPnYl/4GsFsYC+mu1Zuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sw1X2n/y; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sw1X2n/y"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gVHNJ11RXz1XM0nn;
	Tue,  2 Jun 2026 17:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780420106; x=1783012107; bh=30Gd8
	/2kmfJG/Y2ycyBVLm3Z/PnAbEI8+ayjNr/GLmU=; b=sw1X2n/ywhOcjJA9/GTzx
	xoXoP8NzEeDty3mEbKMlg2/L+XqebeQToqYvL3PKAnS4AyddZqdOTqfLyc0x7IY/
	AlxLsO8hslorDRAEpRzNSX2zV3XAfqXuQCj3OHcluTRsXKi5NcL+OUMPXuqvDATc
	ytdYBeOP5J28AMtz4pVYVzcVxOQhcn3mbI7AVc54H46c9TEZuR7Y/VvInJ3EScP3
	ruXcVN3JhURHdo+jbZOjxOIIJC+0ARLbg84EUFnQG1lyUl16/lV2DBSiP3UHvBqX
	C8dvitjUL9pNwcthqJTkdlW09RZ9vjp07JISulRmlj/smIWKl3K9798emdAUaHJS
	Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JX2Fge_3bXpW; Tue,  2 Jun 2026 17:08:26 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gVHN90Lppz1XM0ny;
	Tue,  2 Jun 2026 17:08:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v6 06/14] block/blk-iocost: Combine two error paths in ioc_qos_write()
Date: Tue,  2 Jun 2026 10:07:35 -0700
Message-ID: <fe85b8a3117486e3d1fe40b16d7c9621a070499a.1780419600.git.bvanassche@acm.org>
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

Reduce code duplication by combining two error paths. No functionality
has been changed.

Suggested-by: Christoph Hellwig <hch@lst.de>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-iocost.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 3e4e28ecc21f..050bfbc6d806 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3239,7 +3239,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_fil=
e *of, char *input,
 	bool enable, user;
 	char *body, *p;
 	unsigned long memflags;
-	int ret;
+	int ret =3D 0;
=20
 	blkg_conf_init(&ctx, input);
=20
@@ -3251,14 +3251,14 @@ static ssize_t ioc_qos_write(struct kernfs_open_f=
ile *of, char *input,
 	disk =3D ctx.bdev->bd_disk;
 	if (!queue_is_mq(disk->queue)) {
 		ret =3D -EOPNOTSUPP;
-		goto err;
+		goto close_bdev;
 	}
=20
 	ioc =3D q_to_ioc(disk->queue);
 	if (!ioc) {
 		ret =3D blk_iocost_init(disk);
 		if (ret)
-			goto err;
+			goto close_bdev;
 		ioc =3D q_to_ioc(disk->queue);
 	}
=20
@@ -3362,15 +3362,15 @@ static ssize_t ioc_qos_write(struct kernfs_open_f=
ile *of, char *input,
=20
 	blk_mq_unquiesce_queue(disk->queue);
=20
+close_bdev:
 	blkg_conf_close_bdev_frozen(&ctx, memflags);
-	return nbytes;
+	return ret ?: nbytes;
+
 einval:
 	spin_unlock_irq(&ioc->lock);
 	blk_mq_unquiesce_queue(disk->queue);
 	ret =3D -EINVAL;
-err:
-	blkg_conf_close_bdev_frozen(&ctx, memflags);
-	return ret;
+	goto close_bdev;
 }
=20
 static u64 ioc_cost_model_prfill(struct seq_file *sf,
