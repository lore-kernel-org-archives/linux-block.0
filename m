Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D5535B7;
	Wed, 13 Mar 2024 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366175; cv=none; b=YE9GCwmgsWbQYKQswUfwAIHO9OsCURpYKgA82GWngwm5GGaRIo6ylI7Zjlsbk3aYu2rTFRSK0MWhYQdVNXw5/fUjGCBeh/vxq95+lfbW1f/1KBGPdoEdKFgWZvVzwFZcx3C9K6OHyJt/QqolzvPgmw1DfzeosZemQzmiUEMMwA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366175; c=relaxed/simple;
	bh=xiohMvsrascjDVtTBsfkkdTLd00QtRp/eG3o/ZtjDv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPbpDNQL+EhF77Rt25idEbxaaP0mQA0sS+ofISEligKAAdcMrrDOawfx+x1UQ9yJxEUQJGUQ4R2UpUjLIhs/4kKxzgU3Xb2W37NnL2zbJjsUsAfSzk3198eOn08VhzQTmlEnwcc6Vj6+l6ykMyCSB9FbXR9353++UXb8iv22V1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3WEJx/Y/; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3WEJx/Y/"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Tw3s90Gh7zlgVnY;
	Wed, 13 Mar 2024 21:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1710366170; x=1712958171; bh=QsRxIrFbAsE0tyCFnHMufAaG3Y3KZleW2Dr
	XUuR1ry0=; b=3WEJx/Y/VzEfiI+nfFPMGGVjKy/EfxaPejYUTr8LrrTiCQSp3Ph
	Jzb2J0OFeN0esH76c7u8OMlJn2dLTlSCzaaSdV94sTKvcYswIzY73/1FgXpwu+7a
	3hxZraOOxzWQhJf1RWylDAjFve2o8A5djDFKcjzHyltbbqWXWtbF5ko3OfE3Ea3f
	5JuheGK09few+WuoPiW0ZO/gBU9jcCY0hA+uPW/UYrA0QZvTA4QHhRWlEKregIFH
	JgHMIH4QlsVzmwA/4SRd5u22kBSFjtVSMybMioyAk97DczQ8zcPseEcNZf8Um5gm
	uT9Ipfm5HE4XOJ5rEDniJzG6nI3crZgYVuw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VR8FvFI4lSqx; Wed, 13 Mar 2024 21:42:50 +0000 (UTC)
Received: from bvanassche-linux.mtv.corp.google.com (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Tw3s42RB1zlgVnN;
	Wed, 13 Mar 2024 21:42:47 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	stable@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Zhiguo Niu <Zhiguo.Niu@unisoc.com>
Subject: [PATCH] Revert "block/mq-deadline: use correct way to throttling write requests"
Date: Wed, 13 Mar 2024 14:42:18 -0700
Message-ID: <20240313214218.1736147-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The code "max(1U, 3 * (1U << shift)  / 4)" comes from the Kyber I/O
scheduler. The Kyber I/O scheduler maintains one internal queue per hwq
and hence derives its async_depth from the number of hwq tags. Using
this approach for the mq-deadline scheduler is wrong since the
mq-deadline scheduler maintains one internal queue for all hwqs
combined. Hence this revert.

Cc: stable@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>
Cc: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Zhiguo Niu <Zhiguo.Niu@unisoc.com>
Fixes: d47f9717e5cf ("block/mq-deadline: use correct way to throttling wr=
ite requests")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index f958e79277b8..02a916ba62ee 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -646,9 +646,8 @@ static void dd_depth_updated(struct blk_mq_hw_ctx *hc=
tx)
 	struct request_queue *q =3D hctx->queue;
 	struct deadline_data *dd =3D q->elevator->elevator_data;
 	struct blk_mq_tags *tags =3D hctx->sched_tags;
-	unsigned int shift =3D tags->bitmap_tags.sb.shift;
=20
-	dd->async_depth =3D max(1U, 3 * (1U << shift)  / 4);
+	dd->async_depth =3D max(1UL, 3 * q->nr_requests / 4);
=20
 	sbitmap_queue_min_shallow_depth(&tags->bitmap_tags, dd->async_depth);
 }
