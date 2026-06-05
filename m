Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463BA37FF4B
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682511; cv=none; b=KYwrnGelCw9iilpL4CUMTuuoGNHJ6iCrX+r2SAJQz+xxogOskH94WBIFH7AHiikJEr3ijUwvV/wXRnJ7ko264CsKGbfyxZkyj5lFL1lFFL83+VZf+yPZAQxTP2N+QtVqv/Qrl7QAggNCLy+E2Fek6LW5oH9vgCSF1lbFjg4+TTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682511; c=relaxed/simple;
	bh=AQTaSwWIxDymkaRskL8QUBP4oST383bwoJJNg6Yrfms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g16I8g3beFRdTyaNBoNzYwShvuT0Exq1hS7JcN9vRL41O8B5fMbEXvYIY0DV2UzArDM5i3ZqVri9bkXllMUs8ZF4AN8U6BXpSfeHc52cGv32zfl4gcM9coAPTAJZQUDgADcJbWehNaXlpqfPfkWJNsm2Jwy2xXSEdG/3cDOmKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0WHj260Y; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0WHj260Y"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gX8QP6cQgz1XM0pW;
	Fri,  5 Jun 2026 18:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1780682504; x=1783274505; bh=8H3sa
	IiwnSODNelN+zfShRIAL4DQjOa1VoaCgODedbk=; b=0WHj260YdvWDoxPXfqEXa
	P4V905VnIJP6/P9IPg/zuTy8U+J9MLMZEwNCQdbgonNAe7qE76Qya9VQw3nhFY7P
	IU0BhZOD5vGSrLbpZt96NEhXSHAf3zWEEFcW/5XKIkh7Tgwp7Qb99l0CHKeMFqnF
	7Jbi7fsg56u72JkwrJ9/J1VOEqsqQ3rTMqUhgC2tVFMR3CIAUneiOCnDiF4PMScL
	qx80b0KmjSUOr+KckorExSuSL/f0zmw6Mb1gINH1BULACDJhDR2TrkByh5xdv1WD
	wqD5yXVRTNUV9VmU/q7Eo6ryqfpCNsoQTmObzwtDvUS5XDELEil2J28WnTh+hXtS
	A==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id m5gDYPvB7iUh; Fri,  5 Jun 2026 18:01:44 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gX8QG2MkMz1XM6Jh;
	Fri,  5 Jun 2026 18:01:41 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v7 06/14] block/blk-iocost: Combine two error paths in ioc_qos_write()
Date: Fri,  5 Jun 2026 11:00:59 -0700
Message-ID: <80d4fc1ecd5eaf187c0a31c63a1033a7326d4c7e.1780682325.git.bvanassche@acm.org>
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

Reduce code duplication by combining two error paths. No functionality
has been changed.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
