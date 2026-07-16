Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825140096C;
	Thu, 16 Jul 2026 10:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784197211; cv=none; b=sMyjCEE3Opb6M1ZAyAgMopSNZpY7Zj6GBkydmOVfFwDfh2rhFdPaPjkEPXxMqd5Tv9ldE5QnpvSeV+yYsNycxOg4f9vC4IrqiNIHLrTwYyeKHaOL4Ruyj59tbeu91B+5N/QDVEHPfctrCGNngFLDHYw4v2ul7o+OHERGHZniMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784197211; c=relaxed/simple;
	bh=W+qxDMK9vjaprSkSPJrXxuBc5SyHoiKsT/9mqwPusPQ=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=kmMqeRzhQhYcbKsWHAaiw38NzKNb1UqgXR0eCnG9TsDOJLfEvFGAu20ywg+IVsrW1TG1Nlm9dGdFfDspt/uFLAoT+8qwCS7ahKcWUdFvWFAw1kYzYzfhbpJHbl96DRxI3pGj3POPmiqClE1wRbe+45/SvkDaMU2yP5yhvYzS2Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gjMEDOhA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gjMEDOhA"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 89FA3EC019D;
	Thu, 16 Jul 2026 06:20:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 16 Jul 2026 06:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784197209; x=
	1784283609; bh=KFIl1qcajTm91cZmcEXNfFqEG1xkNZjr1CSuzERE7tY=; b=g
	jMEDOhA0lG6cAtvCd+PL9XN11Ae6EuKFSPQBXBkodNzGCFlCtA7rizsnCXD8vSN+
	SFoODgX5fUj6MNvrsWQwe5D6eF5QX9vB/+A8TiQoZcQdKOsBsR9Axi+WMpTbj+cU
	JUbfLWK6xaCau41X8VIYrbzwrReV/5VXXlQpV+ZP2Ng2LqMwbuxKEz8WQRYAE2/n
	HKQVWbEIu4jNublFf/Jb7nN3+0CCQKXlGzUenRyNFc4XG9SIgrM0U1KvgLPWHjDv
	7GvoXFv3quszAi5sMvXdwb/O0SZUULRWwyhoOqMisTeUdNSBUz/bJjE/IZn4zRmL
	PeDUx0REQv9GZX8v+8ilg==
X-ME-Sender: <xms:WbBYasDI5ROa7Rvf7-GYX-Lj7cm3DXLEj5OkenLBKGQLMGcgV0B9mw>
    <xme:WbBYaqj36lxO7_DNVOfD6q50WtbOPTn0iXZQ1uvDozLews50tHHFpnsvfnp2njpvW
    cpKoV-iUxXbs6RkWvVwH7vzDVpPl99w5xGFbY1whjQV8VqRbLj_sg>
X-ME-Received: <xmr:WbBYahyzLyx7ROtM2UfzWMXPu7DvruT167Bts1zzbg1TwHWVjf5B256IU0r8GXX1sk8pi9zehmHC6UanNc5699bDTisWr7ZkzNs>
X-ME-Proxy-Cause: dmFkZTF5Vj6SMnL8eVqPH19rXSXYFY6bmUyIoIPempWpt6RoQSweRYHbiNk5m+J6sOC/Df
    QLYvSnliCZuWD1s2mWahZuN7gCKrYPBFFnsiZQIW71i1lMh/ZXBxMq0tP9aULtTK+H7/xX
    Ww9JWg1/lFcZQlPVV6Q5Bq9c9Blcib4cAYDkI8jTrr/ZPXvvNG/6NTq4K5IPCw9N9+gHtb
    isKzZAEeG45eYU42dcGWZUrYrrIbz2mg+YmDde/CburzcJqnVYm06Mx8ERUN23RPu6Q8Oh
    GsUURWluJMmbbIpIw7ihDXg/j+GrDcjAYLvJprCSezUF3CQjsj5AjdVlyTm3K3zd9zPEoI
    +kgkyaFBG1/JbQqckWV+MnZ0e4Rq0NlZ7tFtC+SHOpahN1mhOHvNnAd0khoz4ITsvFAL4H
    ELNMD3OKUlqDcPaKYH9aTlnhQrxaXfgpyRyNY0BS4td6zhMXrorxcESrimbIYFoMXGF6Is
    zDjDqlCEFQEAQ6sDNwCk08Gn+wYZx2Agpb0+xY9dttRnE8JqC/S1DEcpInFS+WafS+kFX0
    H79UsAefVJN9Ly/onXq8krt67meSvJC+RTeYWBaqFyDfKvbjkbQmdzV15sAjz1Mr7rBJPU
    hdJEDhYbU1KsArvGfOlZjcgDz7sD9WE7SCVDCHzbP4BzwG/o9YlcHzwv3upA
X-ME-Proxy: <xmx:WbBYaj1LvkMM3ajKQWZATWCA_MOKFuTBZg6VqOORchBl90b04KADjw>
    <xmx:WbBYau-r-JhEJAgVQizKFVuUQT1Zb-td718TmqcTrS23TcmWlwylqw>
    <xmx:WbBYajqkOlwiQUj14Xm4qgPLXp4whScxHRsarYW4ur99KXwlZnZV5A>
    <xmx:WbBYaoQ4fCetQmE-AuLwX101sKVHPJ6Ivevd9nhYSf6ryuVxxVjU6g>
    <xmx:WbBYand8PjdG3BTYmdHbDSxebnQ26sGwTvAsauvu3xy60fu7LJkTMVb4>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 06:20:07 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>
Cc: Laurent Vivier <laurent@vivier.eu>,
    Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    Omar Sandoval <osandov@fb.com>
Message-ID: <33f99f4aad5a482c5465bcef4d3542cbb2a51dbf.1784196135.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1784196135.git.fthain@linux-m68k.org>
References: <cover.1784196135.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH 17/31] swim: Convert to blocking queue
Date: Thu, 16 Jul 2026 20:02:15 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

These drives are slow: completing a request can take hundreds of
milliseconds. Delays are managed by disabling interrupts judiciously and
sleeping opportunistically.

As of commit e3896d77b702 ("swim: convert to blk-mq"), a spinlock is
taken in irq mode as soon as a request is issued. That lock is held for
the duration of the request. Hence the driver sleeps while holding the
lock which is forbidden.

Adopt BLK_MQ_F_BLOCKING and remove the spinlock. Use a mutex to serialize
requests from the two request queues. (The chip cannot simultaneously
process requests on both internal and external drive.)

Cc: Omar Sandoval <osandov@fb.com>
Fixes: e3896d77b702 ("swim: convert to blk-mq")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index e2a8c4ba4e39..6f93ebaaffb7 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -211,7 +211,6 @@ enum head {
 
 struct swim_priv {
 	struct swim __iomem *base;
-	spinlock_t lock;
 	int floppy_count;
 	struct floppy_state unit[FD_MAX_UNIT];
 };
@@ -537,12 +536,10 @@ static blk_status_t swim_queue_rq(struct blk_mq_hw_ctx *hctx,
 				  const struct blk_mq_queue_data *bd)
 {
 	struct floppy_state *fs = hctx->queue->queuedata;
-	struct swim_priv *swd = fs->swd;
 	struct request *req = bd->rq;
 	blk_status_t err;
 
-	if (!spin_trylock_irq(&swd->lock))
-		return BLK_STS_DEV_RESOURCE;
+	mutex_lock(&swim_mutex);
 
 	blk_mq_start_request(req);
 
@@ -560,7 +557,7 @@ static blk_status_t swim_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = BLK_STS_OK;
 out:
-	spin_unlock_irq(&swd->lock);
+	mutex_unlock(&swim_mutex);
 	return err;
 
 }
@@ -839,11 +836,9 @@ static int swim_floppy_init(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
-	spin_lock_init(&swd->lock);
-
 	for (drive = 0; drive < swd->floppy_count; drive++) {
 		err = blk_mq_alloc_sq_tag_set(&swd->unit[drive].tag_set,
-				&swim_mq_ops, 2, 0);
+				&swim_mq_ops, 2, BLK_MQ_F_BLOCKING);
 		if (err)
 			goto exit_put_disks;
 
-- 
2.52.0

