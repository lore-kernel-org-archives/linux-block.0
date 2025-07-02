Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E22DE71B
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 20:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488774; cv=none; b=G36rpHGs4fC+ux4AneWMJdT1dwb+l12atQMGfOENmIhfolgvUM7AKcLbgczOs2KyWINSRZ7ZSJ/Iy81/VBWK82V7vZh0hZ0QfHEloSW98iZHPK3AmtF/Ds8bdPmPoKQKk0bkHVR+NKXgYWLX7U4ktCFkFkUf8q4ucJkIo4jvVpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488774; c=relaxed/simple;
	bh=OZO/8HKKp+SaLcef5lhuLy001gIk7edApf9Laf7jTU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VizfbcdQjqCRFPMLYmC6RBNQYa1HfyptqgChhg/y9n3MmoRB4VJqoCXXKW+waVy/FAAALZhzPOZlRGADQlMAXxkENSrDSVCSL22FsCY4LyOZNwmgx6QvS0iC7nvVzpb0NFHl6i2QbWq4U46iDTmc3R6jNSfI67mAs2TgwMst80s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=kkrwnLlO; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="kkrwnLlO"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bXWwL3G6Kzm0Hqt;
	Wed,  2 Jul 2025 20:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1751488768; x=1754080769; bh=LUOdQ
	qR/9S8r4eK3GJSOQfR0KEFZG3+8GRhZ+/XkQPs=; b=kkrwnLlOym8nzJYaIAeFd
	jSxAMg0pMkL+jOkoZzfPWJytxARXk14hkjK/mD9Nsh2S0O1RBe31Q5DFyyC05Ygz
	FYvrkLklTyiIlyA8f/gX/ZgZncdG+ZmB0c7qd5WbSawI185rYZXGgEUp6fHKzaRr
	8lpE0s1pKeIXUAwml0uqrVNGiwgXoiIU3w2oyt8sNsysxYoDb6KYCnMveFInyAjh
	wjIr8FzgY6SZCpch4RzQ0VTUTmdrBOIb1R9ubxm5203HcNXZoaLhZ6g6ajilAzfn
	2rvJvbGplMRQSZUADBY3MvZBUybz3AY66T5denqecHLEvy38zBPGRsZ9nO8vPM0i
	Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GHc7aLsF_-XX; Wed,  2 Jul 2025 20:39:28 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bXWwF0SpRzm0ysc;
	Wed,  2 Jul 2025 20:39:24 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Ming Lei <ming.lei@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 6/8] sunvdc: Remove the quiesce/unquiesce calls on frozen queues
Date: Wed,  2 Jul 2025 13:38:41 -0700
Message-ID: <20250702203845.3844510-7-bvanassche@acm.org>
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
 drivers/block/sunvdc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index b5727dea15bd..8e3b32bcfd8b 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1116,18 +1116,15 @@ static void vdc_queue_drain(struct vdc_port *port=
)
 	unsigned int memflags;
=20
 	/*
-	 * Mark the queue as draining, then freeze/quiesce to ensure
+	 * Mark the queue as draining, then freeze the request queue to ensure
 	 * that all existing requests are seen in ->queue_rq() and killed
 	 */
 	port->drain =3D 1;
 	spin_unlock_irq(&port->vio.lock);
=20
 	memflags =3D blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
-
 	spin_lock_irq(&port->vio.lock);
 	port->drain =3D 0;
-	blk_mq_unquiesce_queue(q);
 	blk_mq_unfreeze_queue(q, memflags);
 }
=20
