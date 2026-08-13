Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BEC4854EC
	for <linux-block@vger.kernel.org>; Thu, 13 Aug 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637686; cv=none; b=HSteCxMe2AzYIHFfPfAO4t3W8OJCN4e9By+6hAhx09sZm0Fj8+B0zWTxfITZdMQxIAd5/zD5B9h0kIoftFWTVyzDPcjZ8xOw1b8GaljWcxaw6MAKa/slJj6Qf6DzkpqgUPSQoUm7Bq6rFQ/LhXY+wNIDIAJZ+s3dF/I4+sAE+xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637686; c=relaxed/simple;
	bh=il7WEPUWfwBprTrrUXxfSs1KV9RgOyDK3NHKPWLAP5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgyqgRo2oa9QmF+T+2F0UeTV75FCqB2XylF04V81Q4rLqdEehZA/3nSrX7HqHnXjmQ/nlGCCgYlhzQyF1T/Wd/NS8udKG8AoPtfJEgEH2xoVxoAMhlWjG50UlAP3bThk0/dzx8moMFu3HCGHtWVDb4GOR23M6zGZ2k1gNYeuhkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3jF2bBO/; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3jF2bBO/"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hLVms2JwCz1XM6JB;
	Thu, 13 Aug 2026 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1786637673; x=1789229674; bh=WOeSXgfYVmNgg0+d7yEJx+JkTm6NpRX1aY5
	idjBq7IQ=; b=3jF2bBO/9V0TuBe5D2PQ5KthacurVrKZcoDQ3MrMdbJ6y230veR
	nYTbllTBFQJ0fVdd+H5fK+5osg2H7EhL8OnCPRKB1WQKlr5fBkS1I2B9VewCU9eP
	Cu0FL1TFNKoWa8D5/vSyEHR3Nd0FGOzJTryiteXAiYLSmZDW4XFv59iibtSO5wtc
	4QrzvuFuJ0V8MQN8l5a/fBLqWU56L9PKkOrwGPy1urunLHZT2vBuUKfWm4irUCVT
	wg8qepNRZ2YxdatP0bWKdNfLOBT+nQtkw3cH7/UBBIwb83Z+5f/RB9ot2J4XWJZN
	ITuOJJ/W57zKAsReNPhWlHDdVly3r672SWg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qv1ZwYxvtjgk; Thu, 13 Aug 2026 16:14:33 +0000 (UTC)
Received: from bvanassche.c.googlers.com.com (245.199.118.34.bc.googleusercontent.com [34.118.199.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hLVmk48ydz1XM4Tn;
	Thu, 13 Aug 2026 16:14:30 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Keith Busch <kbusch@kernel.org>,
	syzbot+cc0de396bac84da51919@syzkaller.appspotmail.com,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH] loop: Fix recently introduced lock inversion
Date: Thu, 13 Aug 2026 16:14:20 +0000
Message-ID: <d919f5285d16afbec6c51ecdf201692a484566e5.1786637565.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

All block driver code except loop_set_dio() calls
queue_limits_start_update() before it freezes the request queue. Make
loop_set_dio() follow this convention. This patch fixes the following
lockdep complaint:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
7.2.0-rc5-dbg #11 Not tainted
------------------------------------------------------
losetup/2924 is trying to acquire lock:
ffff88816c76da68 (&q->limits_lock){+.+.}-{4:4}, at: loop_set_dio+0x318/0x=
720 [loop]

but task is already holding lock:
ffff88816c76d430 (&q->q_usage_counter(io)#24){++++}-{0:0}, at: blk_mq_fre=
eze_queue_nomemsave+0x1a/0x30

which lock already depends on the new lock.

Cc: Keith Busch <kbusch@kernel.org>
Fixes: 6c8dec275ccc ("loop: set dma_alignment from the backing file for d=
irect I/O")
Reported-by: syzbot+cc0de396bac84da51919@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-block/6a7d5368.d5f0ebe7.22d851.0013=
.GAE@google.com/
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8639fa34b847..6f12976035b0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1452,12 +1452,12 @@ static int loop_set_dio(struct loop_device *lo, u=
nsigned long arg)
 		vfs_fsync(lo->lo_backing_file, 0);
 	}
=20
+	lim =3D queue_limits_start_update(lo->lo_queue);
 	memflags =3D blk_mq_freeze_queue(lo->lo_queue);
 	if (use_dio)
 		lo->lo_flags |=3D LO_FLAGS_DIRECT_IO;
 	else
 		lo->lo_flags &=3D ~LO_FLAGS_DIRECT_IO;
-	lim =3D queue_limits_start_update(lo->lo_queue);
 	loop_set_dma_limit(lo, &lim);
 	queue_limits_commit_update(lo->lo_queue, &lim);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
