Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205906;
	b=Q0FkiYNBodezvyvD1UQr6vjGEzQBpjNHf455pCF/x9M5tIz9JfGOYzPMJvaNREt+DaC2
	 r72kLK0bVOaE8iB077FfTMz4dOdNe9g9/+2P6HNWxo1JxC5LGml7Uv+Bx3sew1t+vYCLC
	 Cfn7Ud3Kthx/t9TUTF0VDXiUTgK7A8XzG59onLSrKVlGNxQLEjvtOBHeguKJDI7KKoxS5
	 nK+vGn05MlkHVuH4C8Sp5U2hxel025K1JfY9TUsEkdlqol6CjRA3Ncg7uSeIdAcrN2HX/
	 cfUP9d8F+tDAFlJqbCPtKfLfQEvY1FqQ/l1uay3KHIApPrSb7ynOZovIpJ4eVlAPBYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205906;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P6JmYIRc1m5lC+/W4GwVrHef2rGuZVKEG5xSzUuxO2o=;
	b=zDjAE1oK+uv+UDaDY2xh9ZfHOHKtff889yQHjnHKmyfe4+Eh+fdCB4o28EXDqvqq+ByH
	 JBh5vAUMO63yLf00oRMiV0goNvAVhzWuKgKz+9H42aDn/TN7DoJFMbATiE06Mkv4tyCPg
	 5BuBLzGwcpfO3tZoNhwDvKctVWaw8QrWOwLfMP9bnGtTjpX8T7Usv51qekMk3bdv69mhJ
	 ZhIjHpqIfa7LAIUuHCt8fZiYBxzms+UKApvmJczvrkXG7E6D2rSgU42WvXDnYIvVHk1BC
	 KPpEwgCIaXM2JXvm3+pOqvDiuRTxZYbGCrbQS1HM0q9BaKtU1jTNKqfsUr+BP4//mJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kxJ3PU+R;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E809F606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E809F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kxJ3PU+R
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-84e513874f8so811884a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205905; x=1793810705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P6JmYIRc1m5lC+/W4GwVrHef2rGuZVKEG5xSzUuxO2o=;
        b=kxJ3PU+RdpFyyAi5tqpjw5U1QHqObjXGY6VaZNaBiuecim9fDqPQmID/BHVkuH+XwI
         AHbxAJgSRCB06LwSsh7yk9pQq3soQj73DCAUiJDnVsf0Y22YJ+cNIHeyws8CR4ZaJ7p/
         PPhfb6+zl+mfvrYXkFYKDj93MeiqiHumbLeik9hmOgB1Hu060YO4faRsPkNQDOlcOK3O
         kqULj5NcfT8nWmLQPZ2pOg2gRrkk+Prgz8OJmc3Od/6U53m0FDqpw9ZbX8jYq5b+LF5p
         KdNzWOzpru35n8JnOWlH7hir7n/4A8lSEd/EKp1GcnQxvl/ixGn5dkTjHy15AcwGvKno
         we3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205905; x=1793810705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P6JmYIRc1m5lC+/W4GwVrHef2rGuZVKEG5xSzUuxO2o=;
        b=Z08yHIV+CxDMxRcxWE1JbzkLwmLhpDWFJYqs7nkAXWlxgAKGS8DYLykwspEJA/EcaZ
         aoaMQVcD1Rlyc5VHnbTFqi5HeeRm6mqHfNxIFmoUf4Lb6vuixFDtt3AxJR4kz2Lm1tYn
         6p/3FFlRH6WCttmiIL0ORrEU4P1IHarulYQJGN2jMoLZkRBRN9Ws4rQ+LHoDK9pi4mrc
         HZBLRgDdwzNWEI4UkixRHse4PHSCAik0wQg+XG0/hw9NwHYGbOqt9QrYHnE+JmpLUapA
         1wpO1CVuqZWo2sGK67203lwXayfZSMVrR0DZJhHrJoXbjU3NbNUHnev22Iwq/YWh43Rv
         m3lQ==
X-Gm-Message-State: AFq9FYI4VigLQ9fLTk6xeqDiU8NWOeTshyi+ypZ2XB6I+0/H5jKgbkr5
	lEUM0MRy8Z9pZVoXN7+IsYJJsJF9YCLtINYzVmE81EZqL0+FZMh6OeZaBULLIvnD3mEJF7NrtEq
	rfTxwGY4=
X-Gm-Gg: AYBFou1E7cdkaXdYBCSUl5rUt8qAfLY/Dzr18eWjmA1Gc8+/capuX5CI1K4+qCdMNZb
	zuw6oWP2kj0hKc0g50ZGSoaqsU/FXDG4ClMli9Gbm67iyVr2+OCyi8OiWMmIyWcsVGa/3XQRIS5
	IhJHPRiaZ7efxgoZL6TBlDH+t6Nt3FOKnyODBJlBZaPC+qtMgzatmn3AdAXvgSdGztHNENDXAem
	OD2BOU0AmtnCGshfquuzz2HltNyt1n4uf3OFk19EkSJg3r+76L5S1UbTcfEE9CNs4QCZc7ZoUiF
	0sr7oY/p8oCFaVYITRRV0ZSUKTMjigh3OKiS05gcg7S3mii3MwZv21RrUreLFUU0Z86yOzwrgsh
	puWnojGVNZClKwRbba5ARAoXY0TDmZpJn23No3qEwEE7pMKz4ysgoKwyENLZQZQGwkMwxcthDm4
	BRuMNgHv/0cScRMiIpa7TFY5/w3vrM9dnenbwM43srEL5+1NXll9hhGdnoolUdyMsPEfx7Vdm6u
	Z6NwXPDWm3q/aw8TniMEmzw3MQiRbY/8jS6JhSFBGhFzqv53LOPmA9JbgJvB5UhaDcbxW0fYA1e
	JLFmgfjHBCpOLZhc3XARkNFu8XsvzhUhaepOKu/VapHmL0hcvSDvtsByN3ePjcPo0ZMw4Y15JA=
	=
X-Received: by 2002:a05:6830:2e03:b0:80a:b8da:2792 with SMTP id 46e09a7af769-85abcd3f737mr3120812a34.6.1793205904905;
        Wed, 28 Oct 2026 09:45:04 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 38/98] blk-mq: set up a queue under tag_list_lock
Date: Wed, 28 Oct 2026 10:41:41 -0600
Message-ID: <20261028164415.1262013-39-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

blk_mq_init_allocated_queue() only takes tag_list_lock at the end, when
it adds the queue to the set. Before that it sizes the queue by
set->nr_hw_queues, hands out set->tags[], maps by set->map[], and
blk_mq_map_swqueue() frees tags of the set. An update clearing the maps
at that time makes the new queue free tags that all the other queues
share. An NVMe controller reset during a namespace scan does exactly
that.

Take the lock before the first look at the set. An update can be part of
error handling, so the allocations under the lock must not wait for IO:
memalloc_noio_save(), as in add_disk_fwnode().

Fixes: 868f2f0b7206 ("blk-mq: dynamic h/w context count")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 37c8f68e23c4..458ef0970527 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4355,7 +4355,7 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 {
 	unsigned int i;
 
-	mutex_lock(&set->tag_list_lock);
+	lockdep_assert_held(&set->tag_list_lock);
 
 	/*
 	 * Check to see if we're transitioning to shared (from 1 to 2 queues).
@@ -4380,8 +4380,6 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 			blk_mq_quiesce_queue_nowait(q);
 	}
 	spin_unlock(&set->quiesce_lock);
-
-	mutex_unlock(&set->tag_list_lock);
 }
 
 /* All allocations will be freed in release handler of q->mq_kobj */
@@ -4658,6 +4656,8 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q)
 {
+	unsigned int memflags;
+
 	/* mark the queue as mq asap */
 	q->mq_ops = set->ops;
 
@@ -4676,6 +4676,16 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	INIT_LIST_HEAD(&q->unused_hctx_list);
 	spin_lock_init(&q->unused_hctx_lock);
 
+	/*
+	 * Keep blk_mq_update_nr_hw_queues() away until the queue is on
+	 * set->tag_list: it changes the number of hardware queues, the tags and
+	 * the maps, and blk_mq_map_swqueue() allocates and frees tags of the set.
+	 * An update can be part of the error handling of a driver, so it must
+	 * not have to wait for somebody who waits for I/O.
+	 */
+	memflags = memalloc_noio_save();
+	mutex_lock(&set->tag_list_lock);
+
 	blk_mq_realloc_hw_ctxs(set, q);
 	if (!q->nr_hw_queues)
 		goto err_hctxs;
@@ -4696,9 +4706,14 @@ int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
 	blk_mq_map_swqueue(q);
 	blk_mq_add_queue_tag_set(set, q);
+
+	mutex_unlock(&set->tag_list_lock);
+	memalloc_noio_restore(memflags);
 	return 0;
 
 err_hctxs:
+	mutex_unlock(&set->tag_list_lock);
+	memalloc_noio_restore(memflags);
 	blk_mq_release(q);
 err_exit:
 	q->mq_ops = NULL;
-- 
2.56.0

