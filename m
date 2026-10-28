Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205903;
	b=Qg+kRnzoXCHUZNIFBmsu8Mmuat9A37zSIl6PzezTMpYT7xMEdLNeEBjizOn6LEcDSNzO
	 GtHJGy6v4hVNOHeZ1cpRk1kV4s0vZo+qe/PeIG2UHjs9Z9WsB663bc8Qlo3YRTNb1bZ97
	 Oue4zwAQay9o+9Gdi3SeLZ6Y9TsAkiYL2SvSTcbNu44a6nMJkpSHgOBIDI9Q9Ahlq83bj
	 LQUKZfRe6o5Bnv6fdKqZK4JsZAkpmPSSCqwHOs5yPuflk8TxvSrjGfUuzEZ44mMvMm1T0
	 C5NZ0InBxb+oul5jwRw3ppmoQfYmmn4GsqNcg1Z274IN3AF4+artEcjVpsUQAWZziFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ch5RaiGTtWV2RdNkN8JMr+IJyAZjS53acSog8PEHi20=;
	b=YaUEGYKDMKUDivFhz6mGZ+NT1PVlzfp7KQaBVOn7Tw6MFZnDiOEIaxUbUWuv3ZULQl4v
	 hN98NLWM42sh1ey5v+JigJ286aAe4rTMXxfdJRcWJrpigsiKQMj9SB4Tw0S1+aKcmVVzj
	 z5UMN7hETtB38/LdC8R6hoDHU/R1uPAQMSS+T8GxEGE7y+Neo7tHOTrPgZX+jCFncdOiL
	 k/60jePtSisR+HB3/Zzef/HAgsQFGKdc/ayu39qyolhc57fO2KKTWRXrrjULyAYWbQG94
	 no922ghb01BkcsNidZvv8I274IKIfzPYSJ8YYukA0RXo8gBJtOeC9LcDVmBdgQlQ49w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=esXQ8XSh;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E26A606A325
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E26A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=esXQ8XSh
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f84a55e31aso753987a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205902; x=1793810702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ch5RaiGTtWV2RdNkN8JMr+IJyAZjS53acSog8PEHi20=;
        b=esXQ8XShTjiaI46iIU+Wi4B1KgC31UNEi1yxZB82D05/TBhJf2LaEG6OdwFQ1LyLR4
         B6SSf3i48yDN3cu+0sfhmqww325thb1j+DZCNZ6peI0Z1bysZ0LcJ+DhObtWQgjgukqn
         OvQ3TTVM+IP7FIlGdtvRR6X1MQDdd7AAKm2J9bZuj44BdGiucyUf30XqLO9rz5SBEjKs
         NxupyYxueuv/O+9K9zQbyZlEVdnCQTfkU1YLmQoq2xe5ZP+Uf6EG9QIN3HCaoGUnxK+M
         F1cSV6G2kLzf6s70CaFM/lhhRR0Kwo+px9Cbn29kcu5t3L4CwLc5IULz+15BPNEFvRtK
         URVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205902; x=1793810702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ch5RaiGTtWV2RdNkN8JMr+IJyAZjS53acSog8PEHi20=;
        b=X5qUxMhmFKMQMG4JtrXB7sRm8At5F3IdDUKtq/cQhWjzGVZ5AK3E4dA7oGMIhWJ/Kw
         rM+Ns4kc33OatNA2zv9Dp144AJ745dLxI43JHmyVwNdmBQXsmS3CvHRlcOD3YtI/Dl6G
         JP+D2X+WLdDjj/EFxm0kCumw3DyS3GROi34LNM/2Qn9j4HExrIjap15qyxNUlSSIizB1
         7OzLvUEOnplHMEcY19WHGEG7/if5kERmL2By4YkzmUu2QjPM9SwbwxrtPLGWlTp6se5D
         HPTmluK0/2gOmiD1hJ+TbwXgmd5qdgIakGfyID+UlFIcH7S59ifpYnf/iIjrCfcY6Hub
         FIwQ==
X-Gm-Message-State: AFq9FYKdmj+6TW53Q3QU0HTixcL9Zea9Xpyc12ubnC3cw6wgMZIEmKQU
	Wly1m8KL4EdK/vuqLjcrgeHnsjx8ACNfAuUIwydOdGn6tAsBrzqK8uMSSNR0P/u7wzN1IGQNWih
	0HRKPj0s=
X-Gm-Gg: AYBFou3a7RqCG6khc2qU21E5DBdW9U3QMTTcaORj1zT/BL9Hph2WnPMSmSgca8fYwdE
	oyACBnqDFXPUi5IDs2dFclVfjzl6YAYTJ1RT0TbCH96xvgYnfLcJcekNFV31czTPfXfChVFwNzu
	ur5lOAWA0djIkLzRuQyopYW5S0gDk0iTkFbCdL1TyZNkc9pQVh6siAgiuy/53vRpMk2B9fA8aBP
	m5pww1F+RU8i8xcKt0FqW0L966tx3Xz6aSbgtxGBhuT9HB1JO67y1QgQpeKSqnTcQKx4LPDQWHH
	oo+N++8Y/O7zY0R6Fronj/98S3Jp0CsQJGalDMFWMKAY/60LZIrBHLUj8T007K4H/Rpnma7NnB0
	v2u3+0Hv9BDhkBy/ed7A9irGJYM3DAQYY2iR8Kn1BpglKfs0OiRzo+Xwn6VO5SKo5YwNw7hUyCZ
	7wL+nd47CaQsyKHDXZSbE9Widkk0to9EZi97szhJYQxPcW0mqiSPTI5PJZFmAJW/KtgIojKV3Ka
	r6IHg6UhWjehHi40/lRFhLbWMTMu9xwNWzDuWH3nYkyU3qv7kinmw2BANM8xyaqTOReQBSBOlGA
	XuNsj7cKFqWZHMGEk2+XKbG+3ir0FRet4OW0WcOaF0+ZNnHMyk2gadxMF4StItDhwkpH6W5HwQ=
	=
X-Received: by 2002:a05:6830:411a:b0:843:d5ee:5785 with SMTP id 46e09a7af769-85ac0038ca3mr2930007a34.12.1793205902456;
        Wed, 28 Oct 2026 09:45:02 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 36/98] blk-mq: quiesce a queue that joins a quiesced tag set
Date: Wed, 28 Oct 2026 10:41:39 -0600
Message-ID: <20261028164415.1262013-37-axboe@kernel.dk>
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

blk_mq_quiesce_tagset() only quiesces the queues on the list at that
moment. A queue added before blk_mq_unquiesce_tagset() runs unquiesced,
and then gets unquiesced without ever having been quiesced, which trips
the warning in blk_mq_unquiesce_queue(). NVMe gets there when a
controller fails while its namespaces are being scanned.

Count the quiesce calls in the tag set and quiesce a joining queue that
many times, under a spinlock that also serializes the two functions. It
can't be tag_list_lock, see commit 59e25ef2b413.

Fixes: 414dd48e882c ("blk-mq: add tagset quiesce interface")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c         | 22 ++++++++++++++++++++++
 include/linux/blk-mq.h |  6 ++++++
 2 files changed, 28 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6d3ea97f9a00..0e8449424c9a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -336,12 +336,15 @@ void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
+	spin_lock(&set->quiesce_lock);
+	set->quiesce_depth++;
 	rcu_read_lock();
 	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_quiesce_queue_nowait(q);
 	}
 	rcu_read_unlock();
+	spin_unlock(&set->quiesce_lock);
 
 	blk_mq_wait_quiesce_done(set);
 }
@@ -351,12 +354,16 @@ void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
 {
 	struct request_queue *q;
 
+	spin_lock(&set->quiesce_lock);
+	if (set->quiesce_depth)
+		set->quiesce_depth--;
 	rcu_read_lock();
 	list_for_each_entry_rcu(q, &set->tag_list, tag_set_list) {
 		if (!blk_queue_skip_tagset_quiesce(q))
 			blk_mq_unquiesce_queue(q);
 	}
 	rcu_read_unlock();
+	spin_unlock(&set->quiesce_lock);
 }
 EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
 
@@ -4346,6 +4353,8 @@ static void blk_mq_del_queue_tag_set(struct request_queue *q)
 static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 				     struct request_queue *q)
 {
+	unsigned int i;
+
 	mutex_lock(&set->tag_list_lock);
 
 	/*
@@ -4359,7 +4368,18 @@ static void blk_mq_add_queue_tag_set(struct blk_mq_tag_set *set,
 	}
 	if (set->flags & BLK_MQ_F_TAG_QUEUE_SHARED)
 		queue_set_hctx_shared(q, true);
+
+	/*
+	 * A queue that joins a quiesced tag set is quiesced like the others,
+	 * and blk_mq_unquiesce_tagset() finds what it is going to undo.
+	 */
+	spin_lock(&set->quiesce_lock);
 	list_add_tail_rcu(&q->tag_set_list, &set->tag_list);
+	if (!blk_queue_skip_tagset_quiesce(q)) {
+		for (i = 0; i < set->quiesce_depth; i++)
+			blk_mq_quiesce_queue_nowait(q);
+	}
+	spin_unlock(&set->quiesce_lock);
 
 	mutex_unlock(&set->tag_list_lock);
 }
@@ -4928,6 +4948,8 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 
 	mutex_init(&set->tag_list_lock);
 	INIT_LIST_HEAD(&set->tag_list);
+	spin_lock_init(&set->quiesce_lock);
+	set->quiesce_depth = 0;
 
 	return 0;
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 5e130b282b42..aa3b35405edc 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -523,6 +523,10 @@ enum hctx_type {
  * @tag_list_lock: Serializes tag_list accesses.
  * @tag_list:	   List of the request queues that use this tag set. See also
  *		   request_queue.tag_set_list.
+ * @quiesce_lock:  Serializes blk_mq_[un]quiesce_tagset() against each other
+ *		   and against a request queue being added to @tag_list.
+ * @quiesce_depth: How often blk_mq_quiesce_tagset() has been called without
+ *		   blk_mq_unquiesce_tagset().
  * @srcu:	   Use as lock when type of the request queue is blocking
  *		   (BLK_MQ_F_BLOCKING).
  * @update_nr_hwq_lock:
@@ -548,6 +552,8 @@ struct blk_mq_tag_set {
 
 	struct mutex		tag_list_lock;
 	struct list_head	tag_list;
+	spinlock_t		quiesce_lock;
+	unsigned int		quiesce_depth;
 	struct srcu_struct	*srcu;
 
 	struct rw_semaphore	update_nr_hwq_lock;
-- 
2.56.0

