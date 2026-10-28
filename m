Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205904;
	b=poSG5f6kZc+ielm9xFGG+b90ZoJsueQIMOCUAqHy43+UKx8vp378nvqLf6wIoz/q4/3y
	 UH3AbKuxhEeN0kRUPhY4ORuIsQmOIxwTkhbUHN43dz7x9OPYe4xUYK3YTnKCGka6fSz8m
	 S2B353mCr9eFqEO05CbFxzkddHHAsaAVHHum84viSmdESPxA9gjqedIRwA5zJqyrhYq4x
	 EiWBMuT9nBanPQ8KahrcFhyrWRxFnHUIjxjY2S3q7ArEyKJTsPBWqmMYSFZeJE4BQ/vWF
	 gJ+zynmvdEKXybnreTcpRuo7myxbYtPEDqXuhyJ9epnVgclgvCVMEzM+82GxQ7IqdGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uvtWCInHmLTirp+xZ9oGXqyvnTTnQu+9v5ANmS6MM8k=;
	b=mn/H/uhud1km46kVhY0j6Ml4NbcQK14A7NG8WV4XkNbS/NefQrKK34l/ENSz49Eqp5z/
	 aj7Mu6WjLtYd/LKju6AquZp0zYph5oJVgu2WOS4FYy72C9cURwTqtm0BWmhxYBgf4ayq0
	 lRz/Mt1Aw35GUu7mGpiMxqoIg8qfmNSptoE/OVRlBhBdcFSGNCmCZlv3C6IU9w8cZIqD3
	 S59SPOWPbC9MeJBKu+JP1TjSsoU7SyzB3qOfNz3quErRFyQDWBaLOftsa3DTvsFOwBdZ7
	 bQS1qBvQ3eLX+SkCz43TSZWqIBpK7sUq090f19iVxwnUz6jlOoEMOnub5J4bCAVtRmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KyhZkc9R;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868A5606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 868A5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KyhZkc9R
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-823b938464fso825459a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205903; x=1793810703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uvtWCInHmLTirp+xZ9oGXqyvnTTnQu+9v5ANmS6MM8k=;
        b=KyhZkc9RdChwEyz79RjzUfCmdIlsbrga7lPUMKyvLd9MRA9os3r4nwo5VEhFFxPGIB
         RViUWqzes6i/9PDkim+btlcV8KyN/Zh/TW44FYzXAOXrFD1hTheQclVqTe5dJLu9XxTK
         SzmYR8mWk3anqhKfhT7TtoueoNtzF6/NBt5mCOCkWn2LtjQiKJIOtFOsh4A8fiysGCvX
         MRUf9RLSZiyVlcu21fdVRl694/HRpJwa0Bf9k2ABDrbHTxfrHjhmoCRxgzJugxzXGbAP
         NEWCO+3kyQQI7dhAlaCIEt0leukui2SsZy4qpe5eNyQ62sLOXoRk4Q5xeNwnMaLEE4h/
         WlUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205903; x=1793810703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uvtWCInHmLTirp+xZ9oGXqyvnTTnQu+9v5ANmS6MM8k=;
        b=nypGnzTTtMLpkCJue+AuIr/y0jfVffubLGfajP6M3i6x5sfaTpTh2pOlW2cOq7Dyha
         a9+0XjDLO0wpBVT6fCBXwu51Ymlsp87xdqcnUC611N4Hns/tZyZge0jIq6e5Q1wxojW/
         slxjJi9ITfhIxf9eKDY4zue/i0NaZvY0l3CUVjMEuxNVq20m2Dyed+esMiEYms8Vt0Vk
         Oj4bSu8lCRxhXKlU06krjjMPzCBZdAvvI/sOzuvGjHUjQaQ2z62iQ8gniO/Rlm95Xg1p
         IKRcF2uLr2yQMCe8ZHCUpJUewn51U3e4D1Auy3rUOJxsMCR4zr0/w49u2cDx97hDwQB3
         GwTg==
X-Gm-Message-State: AFq9FYJZm+Cpx3ua1O04zctCTjrgAMg6C83wC8LM65NmPDGLQ0kuFOSX
	bMUIQ1tKH4JEHpyw6iryI3rX3KdTx0yVpXdTUZwSyA9NDnidjf9RIDf+d95IfeuRhXEyoi8Gkwl
	n7CAiKMg=
X-Gm-Gg: AYBFou3Oe9SP7dv5Z5xXq6Ai76s81e+XpAUGerFGTfiGielDpVdl5HSF4ECJfyWxohJ
	sWgk5Q6eRK7pEYUswH5WrT4Pgk1gczKn0n7kDI5wAMzf+/14oNSstt82BhR9wilj44tMU9rM+Iy
	wploZf/sLov6pRXwDwDVZH5IUKQGq90w/vDDb8LhjayVam1kyHjkdOjS7Fm1g3pD8K6VG+qUIAt
	z+IES5yjD/QGsVs2skLhW3AMJRo5zwgxek1OidEhBam8RlPhde7Fe5yg7zHZWiDzztHLKj1rNTL
	oEWDxCs4vq/vNEBar2a0SNAQfhmDia77pMw2ylfsnnZNoV5wM/LIS0kOxJ554qLN9G1R18CGnYL
	ubBKreD3FpeYXFUpMdnOPvCp7m9TcqT53qYqP+VyxbjEC9qpnzziTSz8Xq4vtQ0q7o3Hp6XRG7Z
	+LPHKj20vmdIb+Ohr9t/HZFmWJZZuJ/u2iXfI/UJ4E3pbMo/Ygod2JwMzBs5t9V85nYzAMuW+m1
	u2zUGEatgiDgHtLik2D+bGqGjNqa8WCc5TeGkA/bZB5LbubbDqETActgcP1OXk+0h6iP5/v9/SX
	v5SMJjkyLo6n4nH99Y69d+tl9zXhXgfuNbD/DBJur1p83HXNd5un1lw07oVMoJC9m5y/CNwHiDQ
	tOIyyofKQ2N7BiGG56Tk=
X-Received: by 2002:a05:6830:4393:b0:822:a76e:95c9 with SMTP id 46e09a7af769-85ab8cbf5e9mr2890081a34.14.1793205903631;
        Wed, 28 Oct 2026 09:45:03 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 37/98] blk-mq: exit the hctxs of a queue under tag_list_lock
Date: Wed, 28 Oct 2026 10:41:40 -0600
Message-ID: <20261028164415.1262013-38-axboe@kernel.dk>
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

blk_mq_update_nr_hw_queues() exits and replaces the hctxs of every queue
on set->tag_list under tag_list_lock. blk_mq_exit_queue() exits its
hctxs without the lock and only then takes the queue off the list, so an
update running at the same time exits them again and sets up new ones
that nobody exits. del_gendisk() is kept away by update_nr_hwq_lock,
disk_release() of a never added disk and blk_mq_destroy_queue() are not,
and nvme_alloc_ns() drops such a disk when it finds the queues frozen by
a reset.

Hold tag_list_lock for both steps.

Fixes: 630ef623ed26 ("blk-mq: Swap two calls in blk_mq_exit_queue()")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0e8449424c9a..37c8f68e23c4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4339,7 +4339,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 
-	mutex_lock(&set->tag_list_lock);
+	lockdep_assert_held(&set->tag_list_lock);
+
 	list_del_rcu(&q->tag_set_list);
 	if (list_is_singular(&set->tag_list)) {
 		/* just transitioned to unshared */
@@ -4347,7 +4348,6 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 		/* update existing queue */
 		blk_mq_update_tag_set_shared(set, false);
 	}
-	mutex_unlock(&set->tag_list_lock);
 }
 
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
@@ -4711,10 +4711,16 @@ void blk_mq_exit_queue(struct request_queue *q)
 {
 	struct blk_mq_tag_set *set = q->tag_set;
 
+	/*
+	 * As long as the queue is on set->tag_list, its hctxs belong to
+	 * blk_mq_update_nr_hw_queues() as well, which exits and replaces them.
+	 */
+	mutex_lock(&set->tag_list_lock);
 	/* Checks hctx->flags & BLK_MQ_F_TAG_QUEUE_SHARED. */
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
 	/* May clear BLK_MQ_F_TAG_QUEUE_SHARED in hctx->flags. */
 	blk_mq_del_queue_tag_set(q);
+	mutex_unlock(&set->tag_list_lock);
 }
 
 static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
-- 
2.56.0

