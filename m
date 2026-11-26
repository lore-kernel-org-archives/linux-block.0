Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704786;
	b=bpAUr90mvpQC2BPaTIsKqAFzuYlEW6z8LTW78pAFPBB+y41gQTxH+ifQvAohZ1bYjtSr
	 xCDqebjJVwi80JTnu8pdQjVT4m/T3U3Qk1zj1wTvIagW3isY+XIetqO7WohxpbfGNcaLI
	 8Ydd9+0PxAuRcgG7PqoBH+hFFlSb++XBm3BguHBQ7zwUJ7Vil7KgCEF5OyieXhBHfAAT4
	 KkijNfp2CtFVEsIL+IZc1L3fWLKSPTc/O9vbWyAx6wZy7hen+fvC5Wxfq5IjgD71FudiF
	 2kHM3qCg3gNucdcUes/uX9wmceC5bkYogrZIdWfiaNID3amJ9/WCpjnbTvgn8CoStSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qRPa/B8ERbaRnXSclOcrcXc2SQlwZ7vaaTwPPh0UliM=;
	b=J2e9scQ7gZAEKuGofelIXEt45rA6HsOepNQRwymziF+eeJmmFUyYdITvMDvl1kQ6rbaQ
	 CrO7sfsEms+KMGFNwMUCh7vkTxLQbt5Cpra7nmYhXh2ByuZLZ8chW/s9dmFl6oYAfmdwM
	 bHjctaFOEiWPI89U/AJ4oeCSn11g4Mo5I8j8pltas6HkI4GUFpeaEFFjWzNjCb0u/iSiy
	 vdU1C1Vwv9gVs/JdBasVnli/w4ZYRyULdT5zgXpm7JgS9AqIBZwLbYB0v1BgJTpa7F/qi
	 33IdedHKv00UV6NSc0hkIBD28hqQ7jfJNG/ymiFG8AAd2ShEEdAGaigIESzEzZ66Bug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=TJ2U6Bz0;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004C606A33D
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 14:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E004C606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=TJ2U6Bz0
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so68035735e9.3
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795704784; x=1796309584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qRPa/B8ERbaRnXSclOcrcXc2SQlwZ7vaaTwPPh0UliM=;
        b=TJ2U6Bz04qwUZdgPNp+lr2ozjrvqp7QDyf9E2kAMAGN10wwl2GwK3q0b3cXmS7iEal
         RARM6l5UNj677zLvyxws7yXUaO+Oag2VSIGAdtwO3SNs3qZ6ISvNtLg6qSI4pZ6k3NUT
         pNWL4KXck1IB5h7+lFLVKtJq599GWYkOYexodNMl9Lecy0uIx10gt4Kkepr35xyakmYN
         mv9S2STxYPpVtzNLK3oLu7xPxWBVqbebYhtQP6DOVayWlfxO6D7BqoqDTqh0/x2AobCl
         7ZPhDSay78qTyD9eZkymjiTgw39p6IiRQwJNAFdDp64s+nSjk/cG+/jgn1XryIOvf7YW
         lxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795704784; x=1796309584;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRPa/B8ERbaRnXSclOcrcXc2SQlwZ7vaaTwPPh0UliM=;
        b=XlIQFnvad5tzZ3P8bSbNU27bXjqVFDURSJ09CN1iYCUiLao6Irl5ix4MK/1qpxN5es
         Ci/GziWHWoUerVjGhLHa9on7peQkB/TuMzZFR3Sthxa1e6EkBJlzwwhyRnO9WbbOrGEY
         NCIWIQrMm59IFjkAXbYo8T/nRxJaTVFs4UX06PrFdpY9zH0rqCr8RuYzNWpf9sYXjHOF
         KgifX0Rn7in+puk+IMzO7wcqWtOQUorfvwrDTMSx5OpRwKT3cahMXyPt0S0+m1WThpxX
         4bXuz8GQagrrK7z9xWRxYu9xPOgD9cCFo1n88Sq/BZEQZj2oQDXKysOie60GkIhIlIhB
         WYPg==
X-Forwarded-Encrypted: i=1; AL+hErHiNJZVZCFUB6sbmyJYyLCNGfvBOuXOzkQh0eyPmfrouzcXtsN8caNl2MJ+6Jf0vNBS7yHueo+Tm26N2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9mU/0qmhK2uFJAPAQOwTlqlfA2RvWqKlIby5KRN2dqDVuo/pJJ
	8fETbMX0Da4BjWEY4fWWxqbyttRllAbFnhGjteHVtmlQQRpcb1S7rtbkSgKf5aS8Yqg=
X-Gm-Gg: AZFdTZef8YYKWWuziwV0tuEvnhxPEv3peTMUbHpudGJBX0adgAwP2kmmaaCdIdHhROd
	/EeIOugMR2+lJMdnvNz3qO9Es2BHQQjrFMjAogPib/T3BG/GecOGE0aG+OeMFe9cQ14dZsHfgbD
	ZCRQPjYC2HQ/RsSBFLx9lEWyymyYOHnlrGLHNUgbJLxloGlF3KVluza4DhUgfJgjiUBMbkZZM+z
	S4dXLS28LzVWQnjaGYAKgaXqh3tuvEex8uHKCuEWPJZT6hETOFuoa9Z/sEd393Jf45eQs7Ylyio
	nGOhYre+dMLqaWEyaKSyAdSWkOo9b9AtbvsLepc0OnIeBBQQXZOShkcsnO/YbwLAvKa2Uk3vRWQ
	57TBID3p1wt0O2TMJz3yI4FKT7/fa8to3rejNlIb5sM1aO0lpB53EqJ5d/CnxTPLRwPXvuGBOh9
	yxKK+ezVox+kx/CDYi41fWq0ql00+dGmr2tjv+BChi/dhF5AUBvCGcoD9jPutKdzRdsxGLBuckN
	Hwn7h30Tne4jZ21Mce/x6kmW+pFLB9GRF87ghuI8iMHQAOfaRx6pNM++k7vZ/fQdUiTT3940dcx
	QCa0O9xOTiEu6Z5U8GjRfClhOa//w3KDRY1SrZ1jFyeX/KagOXSjh5Uli0sd8b+KIRA3S7zO6A=
	=
X-Received: by 2002:a05:600c:6290:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb88824a5bmr425912685e9.13.1795704784215;
        Thu, 26 Nov 2026 06:53:04 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906c089dsm356445905e9.1.2026.11.26.06.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:53:03 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 2/4] drbd: fix lost bitmap-work wakeup on weakly ordered CPUs
Date: Thu, 26 Nov 2026 15:52:55 +0100
Message-ID: <20261126145257.592085-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
References: <20261126145257.592085-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lars Ellenberg <lars.ellenberg@linbit.com>

  drbd_queue_bitmap_io(): set_bit(BITMAP_IO); read ap_bio_cnt (req_lock)
  dec_ap_bio():           dec ap_bio_cnt;     test_bit(BITMAP_IO)

Both sites decide whether to queue the whole-bitmap work by inspecting
the same two locations in opposite order. dec_ap_bio() does not take
req_lock, so the lock gives no mutual exclusion between them. On a
weakly ordered CPU the queue-side set_bit/atomic_read store-load pair
may reorder, so both sites read the other's pre-update value and neither
queues the work. BITMAP_IO then stays set and application IO is frozen
until the connection times out.

Observed on aarch64: a source-side reconnect parks in WFBitMapS,
drbd_send_bitmap never runs (no "send bitmap stats", no WFBitMapS ->
SyncSource), database threads hang in fdatasync/writeback. Not
reproducible on x86, where set_bit() is a full barrier.

Order the BITMAP_IO store before the ap_bio_cnt load.
atomic_dec_return() already orders the dec_ap_bio() side.

Commit 22afd7ee94c1 ("drbd: Fixed race condition in
drbd_queue_bitmap_io") added the req_lock on the queue side only; it
does not close this reorder.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_int.h  | 3 +++
 drivers/block/drbd/drbd_main.c | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 40be382b24d2..20899a0d7e45 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -2213,6 +2213,9 @@ static inline void dec_ap_bio(struct drbd_device *device)
 
 	D_ASSERT(device, ap_bio >= 0);
 
+	/* atomic_dec_return() above orders this against the
+	 * set_bit(BITMAP_IO) / ap_bio_cnt read in drbd_queue_bitmap_io().
+	 */
 	if (ap_bio == 0 && test_bit(BITMAP_IO, &device->flags)) {
 		if (!test_and_set_bit(BITMAP_IO_QUEUED, &device->flags))
 			drbd_queue_work(&first_peer_device(device)->
diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index aed1d1ab6d0f..fd83fc492a79 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3497,6 +3497,14 @@ void drbd_queue_bitmap_io(struct drbd_device *device,
 
 	spin_lock_irq(&device->resource->req_lock);
 	set_bit(BITMAP_IO, &device->flags);
+	/* Pair with atomic_dec_return() in dec_ap_bio(): order this BITMAP_IO
+	 * store before the ap_bio_cnt load below. dec_ap_bio() decrements
+	 * ap_bio_cnt and then tests BITMAP_IO in the reverse order. Without
+	 * this barrier, on weakly ordered CPUs both sites may observe the
+	 * other's stale value, so neither queues the bitmap work: BITMAP_IO
+	 * stays set and application IO freezes.
+	 */
+	smp_mb__after_atomic();
 	/* don't wait for pending application IO if the caller indicates that
 	 * application IO does not conflict anyways. */
 	if (flags == BM_LOCKED_CHANGE_ALLOWED || atomic_read(&device->ap_bio_cnt) == 0) {
-- 
2.56.0

