Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CE244238A;
	Fri,  4 Sep 2026 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514451; cv=none; b=Bm9cfEW7l9htKuhzXBCalok/8/dNcQBzNMBLi/2JRgQYS+H4mIRPB6hGw+irZTLguskJT26gPLM833HBgSHC6kv2kYgrlXDDMhsCluRZXzbzTTYPhGGYMu0prchSnDRZObI6VKzZuI3/p2nVHHHDJCyH1SMypLQyNfkaj0ChA0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514451; c=relaxed/simple;
	bh=M2U3egkupdhw8UFOtWia73vrryeA047adaHiCz27eLM=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=X0nUvPglsIpzhBs0lWDhdsJmZI0Cg5VvGgmTyFE1ibyqYil1ZYAOqDj21nZm84L2mg81iQVSaQ3Tmy8gEljLm8uzKnplML+kXmDtgYuk0+INvguEi607GjUr+SeZ2arAtQgDwlKKGHB1lVLXZ+itFpW6BGJHixrqIty9VrLftLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MojdG80f; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MojdG80f"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D11014000B4;
	Fri,  4 Sep 2026 05:34:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 04 Sep 2026 05:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514449; x=
	1788600849; bh=eKElv4anX41ZYrApDmg/UKkrc0G/g2ppT/AOlQikA5o=; b=M
	ojdG80fCWqQk7r3Jpj1Cc2IwzJkMq+yfcN8ZKXBxiPemLhbLIe4OLqcCHX7EHkWR
	jxGRRyTipQit7ZvxuIwrJZpjTt+P3NFdqltZ3m3yHYfrnHUGd5DyY+GHXOEnZugt
	q5Gc87GZIrgXW6DTDbv5iKbFRcPd2V2iexc7shImYU48s+sb1IamNdynns1wDsJ8
	QXeavOEry3Zn2iDbBIBSIFl82pI3Ki7dMqsDR8olEcKXrZuFKg77Z9AYNejj2VZ1
	J+gIHjUIHVxDkpmZkT68Ufgcv0HCaVapniYfQWZKZiTZvHrkAfkQO1/rAa9Juwc2
	BT+4Da6kRnLFbHy5Q6/iw==
X-ME-Sender: <xms:kZCaaqGVYwkUu10uR6TSIOs5vxd97oCUo9VXb3a_l1T1hX6LzXw85w>
    <xme:kZCaanVZ-eaLXRwWJfcsy0Kc3dooYs-SsEwNt7dagDdxzTrTnLEfokS5RfhNsCPT4
    3o2LzA_UAxxz6wO6NnzwGMBXYWNaGgVv_yPDW4uHO9SjikeBGtZsEUO>
X-ME-Received: <xmr:kZCaamWFKc8uycH0xkaSHhkCq95oFt_WNbKh7OX6S9cQjl4rAhO9jPgS-cin1jfKD1tUItp1eXTKjJzZlY92zRYk8oH46aqJOHM>
X-ME-Proxy-Cause: dmFkZTFgppOi7PO95ZE0LnZQ1eC/b/6lLqxZnGp9DqtQ9Lo8yqgwEaqqt+SrMvXG86zMl7
    8zj2bpNgo2LZUOH0SS23NVcO5EpAdufkCyfDnjWvzugrIG16R6Z8CTHYN3/cUrIjuOS6b6
    LZQyqVShAdi54/+IxhSgEXw35axn23t/22GgInfNw3+fh5L8VQFUMRp6TNtAk3Q6dWkhI1
    v+fUyHSYlKvUXOMhKLwkHtPgQiDd+jlDril2fPfXPa6NUI8nLwUJnnOFkRjaRLrsCodF1S
    3GV4s1mXRW7/BclwSRGhCM1O1gF4gSbpfD4TjRpw76yLj1dLDFXoaiibgm79rB7Tj4qjfg
    3H+/aagEURb3t2DnfCTbJuAgyDDW5z9G/mJ4mXOIMxz+db4um3h4tXDX6ozR/aAEYLMJ4C
    PHwOZDT2zoJ8ifIMbh/TLBcutL/9N1M91uKOH6w/fw/h0K4xd8f5bOv5zigj1rKRM8E5SQ
    N0NcUdlQd3oviXIS6SanNJVXW0aQN0SzrQGINobaUS9kZYzRoCynesxYn+eBHVA7xw8424
    3156ImJqgtJheWDwHbLv1F2lEt8tCqeFk+w+zd0aQ+S0/VPHHm56fZlYhQKur1a76EpyrI
    oJI5Kdxyv15clN5i3FrLierKIRqKwJwLmriIYWNCuPliWth3TCV3qovcvf2Q
X-ME-Proxy: <xmx:kZCaalJqVkS3MqQt7qYYmut5dszvlDmZGTkOBCHTa4wd-SySyUPouw>
    <xmx:kZCaauDFBmPbW9iVHVbonnTJ-UcpC3d9XAII6PFNGRiCJFTy-vWlGg>
    <xmx:kZCaatc1tveyTw3acljsnOeVzrEkTahQ6GCIlUUxehqA6FMnyYTxmA>
    <xmx:kZCaal1GqMKxfgPL4LZqznvI0cJ_rlE5T0qQxhhza-j8m4HdDqWEaQ>
    <xmx:kZCaaqSvfwVwv6B5lZu1nz4QVeoabADw5o3rwZC87gJU-MCsXnZbuVeu>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:34:07 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org,
    Omar Sandoval <osandov@fb.com>
Message-ID: <d06b19132ec678d6168d158e10cd63e10da45607.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 18/33] swim: Convert to blocking queue
Date: Fri, 04 Sep 2026 19:26:36 +1000
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
index 53a54a96feef..c3fbcf377d1f 100644
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
@@ -842,11 +839,9 @@ static int swim_floppy_init(struct platform_device *pdev)
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

