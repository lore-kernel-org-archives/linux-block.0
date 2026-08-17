Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA99530D40E;
	Mon, 17 Aug 2026 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931824; cv=none; b=fhJl1nzeIcohRgzvuF/QFPqBoxniNZhbvcA1KcgdhEj2cvQtzEkVoLRHwhfWkYPHJ3c4tV7kwpvOeWc4GcQOKqVgepvtSlQbbLmJLG5OyZxctB+63C5t550QZwZ1tFPp3Eh+1orhYMvA0y7u14dwUOs+UlPwwSFXPAOqdiy6BD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931824; c=relaxed/simple;
	bh=q8IbhadNWU5zLc5LjYwBw591oUSb7wx1WCZlNys27n8=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=XWoa/uOHbFrbXQc1yV7Gzge4AuNwnKehw1DoD9RDgBRF2zAlSnn751U0I75G1tIGJ9SSDzjK5S1e9S5fh9frivqly9z9UySN+FdKpPF5beDYYxm8Y/vDuvvEQ8GnYW2N4lrA3fEHbiU8TpwCG6x3+JTyDUr3JIiqu5GzvLoOO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XWBCVT/2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XWBCVT/2"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D288014000AD;
	Sun, 16 Aug 2026 21:57:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 16 Aug 2026 21:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786931821; x=
	1787018221; bh=Hi3q/yrdaWC2WdHcMjgJnC0dWIKQtqbJU5mODxNF49c=; b=X
	WBCVT/232I0IO+btTmfoHWBncTRqukNsC67lfjsodXclq3FavqqGgtGg+Cyw3rwM
	mJM7Vyb2CdbTGlEhgvO/ZjceXkCoDSkUT1QCfI9I9WpT11hlLublxgWq0kPqb+c+
	a93saDQW2Mz+iKJzHBR7ZOIwh8BCuuM9fy/KHIVTFqxRHCnZaJaSPhKkk0x8M6J9
	7d0qdOz9EpiPE/BWtyCqWT7znbSuJ9CQ+4hKOGOI+gmUeTnUH57b2OvHChGWxFS9
	0fv5HK5hlm6UCxNKKeiBEKxw21hC5fb0uCl3k1WKhQuVDuDxOzfU41eg99q3Me7e
	WTTqlMtfQk+xSawcBt/Mg==
X-ME-Sender: <xms:bWqCas6D2Nc7OKhmZyfrjOx_PgPPti8nXPbSgKZo7B-4j_rsgcevaA>
    <xme:bWqCap4wO3RrPCcQTV5Jy6tbElF9K8NJnB2I37tIEA6srZdSfmOT1zHAVy2G4J9Ix
    jWZOWBSbMwRNZMCNPoERcu9qxaz6I4I3183kKlEHtwDSErGPwcBj0I>
X-ME-Received: <xmr:bWqCatr3TAPeel0w1_3HjO5M5g15np50NddXCGhnf1eBUIkQc_BykolYvIScwWb5FWJyZm_vUYPGBBHh4ULM2dctPp-Nj2CxRRA>
X-ME-Proxy-Cause: dmFkZTGCfAK01m/su+NF1u+XOa68X+pQQmWv8jlRJR8vxluyzAH4rmxRPr8AYsUrYbzztz
    qDtakIuzqtbfSZmHo29PP0RHw6kOK7iJUOnoHpPuvKppIPLYWl2UNDzIV1PYCBIBERm6bY
    QPER3HxgVtlHR7cJbNfVcsWUAu2NMPn+HPQbvSzMS3okfk4rj1XXvcXPUG6Yz1nkx5JmSF
    9EIBgbDvdHCuuDb97LLVxHSWv1827rAVWCzbOYkiQ9QXzkowWSPvAeLMSeMG2g4Su/yxWQ
    j65uySTmeWQpdSWSE0KVlk792PpPHU37J4bodh4BamE1P0wm5F6pYSr9/YKCZgQTskI6t6
    rpKYNvFNAD/5dPb1iZxANmH5B/h8FMyQrq8ua9jmvMvkpa1GKKq2eokIBYTAHPx2kDry0F
    ZTkNsMRGtZz6NXRTyU42vl+QDxT06tIwrSOY4c4Ad3ZJgy/0Kay9eKhaMfPkZaj+//bBVD
    wU8FP2pbc5sxAx2kxAyJlf2u79lHOhqo0OMpv3bcqt3SB/3LyDKe2ljll+9Ekv7c6bfuUM
    6dcPvc0AHwuVKHZloy4DBqYEOTfGsN2KTRN3zixm3jRx9SrMxYTmCopcl9JXki6WBu5qnP
    912ATshOEwFg6WY5LhuhULPfwswibhKeJ3gIfsWTt6Q8XmvYF9oh67pL6mrA
X-ME-Proxy: <xmx:bWqCaiNEH0oGrhQ_NaPZfW5lXWuNtgNIm5BsVBtn6sfyIAlV2PCXdw>
    <xmx:bWqCat1J6Ve5LyUOMqE9NTBhMuowcXTJ3Di2HvGwww512sD9Z_KEuw>
    <xmx:bWqCapC2-dEhCID7N9PNK55hQi4p_AnpdjfSlq2lN6pbjAFRyilVGQ>
    <xmx:bWqCaiJLmG9QE_zHcWWEyiQNUi3LBGNnL30L-zCeeK4OktbzvuSbaw>
    <xmx:bWqCaq1wjHdj_2QmtWulfu8p2asUwtzWCJkH16LTF_5Xl3UeAGwUMm3P>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Aug 2026 21:56:59 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    Omar Sandoval <osandov@fb.com>
Message-ID: <de6370c913402e8aef184f6560b3cd758cf99bab.1786929430.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1786929430.git.fthain@linux-m68k.org>
References: <cover.1786929430.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2 17/32] swim: Convert to blocking queue
Date: Mon, 17 Aug 2026 11:17:10 +1000
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
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index 33374498d621..8c8b157e2d74 100644
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
@@ -841,11 +838,9 @@ static int swim_floppy_init(struct platform_device *pdev)
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

