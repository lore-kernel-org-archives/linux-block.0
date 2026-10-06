Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097AC15E5BB
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 17:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306956; cv=none; b=orstYFa3Mg21dB7hqhl9rKCdwhWsGSuO6tsPJLjsdlw6OkKv8Ac153U/DpuY5eexLYMAlOatJVENI0w96b9BoTS2CYvVYbZI0e9yE1oNO8Ud/IgqxlZTo1nHMY9f9ZCsNRVwhhd7O0XwAKtHNouz0I5FrNtch71UwSBDKOQPlLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306956; c=relaxed/simple;
	bh=udlscoQO6lt5ieBwi5A9lM5Fkjh28j/ixHjmt4ShOOA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=gTS57D2Fb3AqQKmYTVfq/MFS5z6UuaetazhHuUw+BQjgoWruEJ6pBTIrMRRLbaVsGnl+WEIU7AnIB1FfuopCdqw3uD/hTEBybNo+N3skClbGhTrDYJozPFuGBNrn3pMrqxPW6WfAhvGkCqzcKf3i86JMmn0gFlhG+Ifyg8ZdF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=EpyfxzdT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="EpyfxzdT"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533778ab0bdso9022551cf.3
        for <linux-block@vger.kernel.org>; Tue, 06 Oct 2026 10:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306954; x=1791911754; darn=vger.kernel.org;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X9CSClLeUlYDebJUwQpya4W05/MVjIaKRZATfthLkR4=;
        b=EpyfxzdTQUC+YFsLLuCPhiMo7lDkFSEkfoFgQ01kXb0iQrP8aO2SUp55569Wo5mwGr
         drKQ/JgTq1sdf5Rgwwfd+vdCPjaV/er+2Y9we1ViDkkHysuKef2DWH+JwMyDJs1hYwJF
         MFCjMmy2wThsX2PuDCdbEvfqqzqv5MFXPYv1842b62Kr8mQ4tQhMPEak0q60DT2UIQjG
         X4fBPuK3wCdHBsBnsJ7snbYMYJ1t2L5MeTpwEgfFLnl7JUNOW1RIGTlvZNdtRXRTQ1T4
         lpv1dzBq3zUUn1tfWtbRipjMZyXssgAyBZCs5f5xIrFbWyVn6V2h/iig584P2XAoZa6r
         wNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306954; x=1791911754;
        h=cc:to:subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9CSClLeUlYDebJUwQpya4W05/MVjIaKRZATfthLkR4=;
        b=udrct4CXKL5fqqiSJFv+h0vGpGLkIcNlVFoAh5++CDY+JhS279mb82ToU7+TNnfQC9
         GD9aNVYN5FiWHzvZ1NRalh7r7dlxdR8i1Ar6ENYuDd0bRCHo16dkHSSPtWqv7aSUweni
         WrNzDK53MLM+6e21XaIPBgo4N+KXHKxALKRcjAf15F67u8k/dfeI8XuHon3cqVVXlBrD
         9UAk9FkUF1opaJ4RLyu7anxxEIIa92pHKecmL1nYXc9H9G8NwJBdTn/sibGmHGnXdBUg
         snmGv2o1RaLAG0nR7KK9V3C1IHC6E0mZH1FUPodbQDjm/Xn/bL+EG1xeAobP5t/mA6NG
         yGKA==
X-Forwarded-Encrypted: i=1; AKwUvByWSeckevC4PSWP2eEp42orfmVBWDJCJQyAR77l6b18y9Vqkn89LZNOQnyvVCvPcCGaS9zhjaNvLtZokA==@vger.kernel.org
X-Gm-Message-State: AFuF++lA3zruehCuCNdbQuM3m+s+erXf41tbzNQtDpQXUrsALwUuWJdL
	5ceUb8SxDl+jbfQOzOHBJiLZ9LYXKUHWuSZ5QAwXP6eA2yEs7xiyRtPZwoUvtqphnLs=
X-Gm-Gg: AYBFou3woa3WWCf1CgXN6WaxkHLauK1UBAmLWifbiif+qhVMhcBzoXiJWuG59Xr3Aey
	nIK/NalA8wQNX440pgvoM2jDTjlNzd9xf3jCgXsEQYrfAtoWWIgX5oFlp7s7/hfOzusfwMO+pP5
	XpM9/GYJqARCnSP40jA3PS+iSgIanHoaYvub6CShWlHgEdMc/ecdIlqVy2R8trYXqoS5ip14v3i
	PGnaE5l+jZuKZ6yZXD8k3ZziYJPj9d7GCZldHSNabjLdHZRnhUyzhOF928Sa4g/NdEuZXc/coiM
	T/QHr8eFLIdHQ+w/T+yHgfXJPYW1yrAlBOtnqslpPvv/xjY9O8eDpGGv+I0j88WmtK14o9x2Fbl
	p3lz3rumigcJze4GaSJrewefyk6kX+B9MToqqfU93V/1B5LT10SmxjQQ+yCEGLNTaKmt60QtzXs
	bQNs5XQGf7CtRc2xTZExdq86c/AZ2TBwoF1hh87Bq6xz+vNNi7jL6tYOR1RCX9iQHCJEo4VVDPz
	chSyw611uBrPVw=
X-Received: by 2002:ac8:5e4e:0:b0:535:70c4:acb1 with SMTP id d75a77b69052e-53570c4b5bcmr8655501cf.70.1791306953728;
        Tue, 06 Oct 2026 10:15:53 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5357209e284sm479771cf.5.2026.10.06.10.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:15:51 -0700 (PDT)
Message-ID: <53d2ea1f34e03e73a1be52e9473fc6d692ec2194.1791303049.git.josef@toxicpanda.com>
In-Reply-To: <cover.1791303049.git.josef@toxicpanda.com>
References: <20261001125422.1364260-1-tom.leiming@gmail.com>
	<cover.1791303049.git.josef@toxicpanda.com>
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 6 Oct 2026 14:49:23 +0000
Subject: [PATCH 2/4] ublk: drop QUIESCE_DEV's wait for an idle command
To: Ming Lei <tom.leiming@gmail.com>,
    Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
    linux-block@vger.kernel.org,
    linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

ublk_wait_for_idle_io() is meant to wait until every queue has a command
whose request is not with the server, so that canceling it tells the
server about the quiesce. It never waits: blk_mq_tagset_busy_iter()
only calls ublk_count_busy_req() for started requests, and the callback
counts a request only when it is not started, so nr_busy is always 0
and every queue looks idle.

Making it count would not help either. It runs with ub->mutex held, so
a server which keeps every tag busy would hold up STOP_DEV, recovery
and its own release work for as long as the QUIESCE_DEV timeout, which
is forever by default. Drop it; nothing changes, since it never waited,
and a later patch has QUIESCE_DEV keep canceling until the server has
been told, without ub->mutex held.

The QUIESCE_DEV timeout in data[0] is unused until then.

Fixes: b465ae7b2524 ("ublk: add feature UBLK_F_QUIESCE")
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/ublk_drv.c | 75 ----------------------------------------
 1 file changed, 75 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 0bd0b95b3217..bd7126dcf92f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5338,80 +5338,9 @@ static int ublk_ctrl_set_size(struct ublk_device *ub, const struct ublksrv_ctrl_
 	return ret;
 }
 
-struct count_busy {
-	const struct ublk_queue *ubq;
-	u16 nr_busy;
-};
-
-static bool ublk_count_busy_req(struct request *rq, void *data)
-{
-	struct count_busy *idle = data;
-
-	if (!blk_mq_request_started(rq) && rq->mq_hctx->driver_data == idle->ubq)
-		idle->nr_busy += 1;
-	return true;
-}
-
-/* uring_cmd is guaranteed to be active if the associated request is idle */
-static bool ubq_has_idle_io(const struct ublk_queue *ubq)
-{
-	struct count_busy data = {
-		.ubq = ubq,
-	};
-
-	blk_mq_tagset_busy_iter(&ubq->dev->tag_set, ublk_count_busy_req, &data);
-	return data.nr_busy < ubq->q_depth;
-}
-
-/* Wait until each hw queue has at least one idle IO */
-static int ublk_wait_for_idle_io(struct ublk_device *ub,
-				 unsigned int timeout_ms)
-{
-	unsigned int elapsed = 0;
-	int ret;
-
-	/*
-	 * For UBLK_F_BATCH_IO ublk server can get notified with existing
-	 * or new fetch command, so needn't wait any more
-	 */
-	if (ublk_dev_support_batch_io(ub))
-		return 0;
-
-	while (elapsed < timeout_ms && !signal_pending(current)) {
-		u16 i, queues_cancelable = 0;
-
-		for (i = 0; i < ub->dev_info.nr_hw_queues; i++) {
-			struct ublk_queue *ubq = ublk_get_queue(ub, i);
-
-			queues_cancelable += !!ubq_has_idle_io(ubq);
-		}
-
-		/*
-		 * Each queue needs at least one active command for
-		 * notifying ublk server
-		 */
-		if (queues_cancelable == ub->dev_info.nr_hw_queues)
-			break;
-
-		msleep(UBLK_REQUEUE_DELAY_MS);
-		elapsed += UBLK_REQUEUE_DELAY_MS;
-	}
-
-	if (signal_pending(current))
-		ret = -EINTR;
-	else if (elapsed >= timeout_ms)
-		ret = -EBUSY;
-	else
-		ret = 0;
-
-	return ret;
-}
-
 static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 				 const struct ublksrv_ctrl_cmd *header)
 {
-	/* zero means wait forever */
-	u64 timeout_ms = header->data[0];
 	struct gendisk *disk;
 	bool live = true;
 	int ret = -ENODEV;
@@ -5445,10 +5374,6 @@ static int ublk_ctrl_quiesce_dev(struct ublk_device *ub,
 	blk_mq_unquiesce_queue(disk->queue);
 	mutex_unlock(&ub->cancel_mutex);
 
-	if (!timeout_ms)
-		timeout_ms = UINT_MAX;
-	ret = ublk_wait_for_idle_io(ub, timeout_ms);
-
 put_disk:
 	ublk_put_disk(disk);
 unlock:
-- 
2.55.0

