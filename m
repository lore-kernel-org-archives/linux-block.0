Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE292DE71B
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488785; cv=none; b=VOmygVhdJzUVUqepATgBVhqfBJw2h6AAhIvM2TxIhkBPuiCtHZuvoDxggab9FfTlJ8D/6JEi09ZHWGMC8Y2ilItCP4zqa13pfw3pJMtXy/QwBpCfkqCOLIasaHmJVlQ84DxZI0D4g6gCdkDj9UdECzRC68qUivR40f0Bu0dpoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488785; c=relaxed/simple;
	bh=3/QtZaqlm+b9XqM4dcw07iaESV2sz02sPt1V3UWwgWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7W8Co4WVlm9v16Fln7wUJom+5IjGxMU5DIBpGsYzKbY439OwippSgg616WF1Tzqu+1kKTwYiEMfGz/BYCp+ISvfFU0Nj9vEjJ49zfsjSBbnmkJWcmocRXOOMdD/j9O1QYFp9cIFWNxXisB7hrLLtEHVNYjn+fAvRJ0dqXNxXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=py3t0GVB; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="py3t0GVB"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWwb2yNnzm0Hr0;
	Wed,  2 Jul 2025 20:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751488781; x=1754080782; bh=QwhJB
	9DQ0c+LjT6k4HULKM1qnKhxWUTpD7VviwzrjKQ=; b=py3t0GVBToAdO/CVxWxWO
	SycBYiy0mYmiKnnjR+qaaYE8qsK6Hq5m7mt7VFm/kdemGajafbkQXEvZUneCGSY+
	ty3Z70arPRCmZFamugt6rkNmO+LIU2iJ+Gze5oo4xjmIBd5aL0+MTXO3MO2ojGfC
	pjx02Q1zwXR2f51C2NIndKZTB/bhVb2cN7Fl5dTnshh3ZDsB4kSJfiAqf4rAaSwO
	pfKhIQZ/xb90lr+NWC/MDP/KS+qNzzxJYQ4ygQ6vmWABsCHd8ahGwszceATcthhx
	1ZyjRClteo5nHr8aI4g3tfHCZdEzqmx83jXQqR/0df8VA5uBrIaBEYYRXMUJuXMW
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 45DQ5_bO0-Yu; Wed,  2 Jul 2025 20:39:41 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWwS0dCrzm0Hqv;
	Wed,  2 Jul 2025 20:39:35 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 8/8] mtd_blkdevs: Remove the quiesce/unquiesce calls on frozen queues
Date: Wed,  2 Jul 2025 13:38:43 -0700
Message-ID: <20250702203845.3844510-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250702203845.3844510-1-bvanassche@acm.org>
References: <20250702203845.3844510-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Because blk_mq_hw_queue_need_run() now returns false if a queue is frozen=
,
protecting request queue changes with blk_mq_quiesce_queue() and
blk_mq_unquiesce_queue() while a queue is frozen is no longer necessary.
Hence this patch that removes quiesce/unquiesce calls on frozen queues.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/mtd/mtd_blkdevs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 847c11542f02..8131b17a980e 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -420,10 +420,8 @@ int del_mtd_blktrans_dev(struct mtd_blktrans_dev *ol=
d)
 	old->rq->queuedata =3D NULL;
 	spin_unlock_irqrestore(&old->queue_lock, flags);
=20
-	/* freeze+quiesce queue to ensure all requests are flushed */
+	/* freeze the request queue to ensure all requests are flushed */
 	memflags =3D blk_mq_freeze_queue(old->rq);
-	blk_mq_quiesce_queue(old->rq);
-	blk_mq_unquiesce_queue(old->rq);
 	blk_mq_unfreeze_queue(old->rq, memflags);
=20
 	/* If the device is currently open, tell trans driver to close it,
