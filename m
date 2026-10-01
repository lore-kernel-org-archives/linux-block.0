Received: from mail-dy2-f14.google.com (mail-dy2-f14.google.com [74.125.229.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3544E4C49
	for <linux-block@vger.kernel.org>; Thu,  1 Oct 2026 09:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790846285; cv=none; b=CFjfkb+IHIjPyo/uCDvdnjj0GgUp2IwBTppp7Bnuzy+CeFI3XuTXrvPIsKerG97585Y7Ctchj5W5hyP+3jVUEK2ndZbcCWaI8gQQJFOxspOf0au6M/MYS0s7r0zTog/DTkVOUGvlOIM+ec+suFyXq1EhOCAXNPDSpgQNNBWCOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790846285; c=relaxed/simple;
	bh=uBbxxhS8UJD+BK4eNKFdD+LNakJ5FhtX2ZMbjB+Y76A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S3tPpuu2Io3liXHMqklCrogp0+JWVV80yU91ScELlv0PWc3TDhOcsGI8zT2Eq10v9Dy7lw2VmW5bpl3qWuBHaqRqLo/FAjesy7V+Fo97gdQGzJRKc1jWwJtStPIHWwVgO5cq2oPjY/PGuUImY8xtiMohhCUuaC38Ho5kpLR16nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jK2dHwz3; arc=none smtp.client-ip=74.125.229.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK2dHwz3"
Received: by mail-dy2-f14.google.com with SMTP id 5a478bee46e88-34daf1b9a1fso601422eec.2
        for <linux-block@vger.kernel.org>; Thu, 01 Oct 2026 02:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790846283; x=1791451083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EAlTqB8rBnuz7BdNI0Qg5KZ9ViFKAfgyyiwBoM8U1ac=;
        b=jK2dHwz3SEkUf61qLUHaPmssmQ8Yq7VDj/OYJx4LIfQAmJ3JeLcL70wgWS5X7mSjMV
         iFr/kqr6pLcC3Jsaes70rvwywfcHJB4epm004zAbtsGHEnj/XQef6F/HA9u6HToDK0v0
         6ui0ha1R+1cR4ngTHxsruGoLhmUXwFawq3XUyTu9pEn/bdjbSdLvlUPybfr8V0oUaBJq
         wkP+RKddoE98oKF1SVzCJSye/UHkUImowwuT9Gn5kRsBge34Jtkk7FYF0LS0cB/lJynI
         COuMdN0528afw7DfhQvZ/AfyMTRY7Uynu0cVJwjxMJlJ8XVhS0KnkNz2C+YbZCR7dI46
         Yi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790846283; x=1791451083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EAlTqB8rBnuz7BdNI0Qg5KZ9ViFKAfgyyiwBoM8U1ac=;
        b=BYGJelgjQddcWd/8wgD2aS0rFmCr0tUmayyjKlNQcUlqo7pKeQIR5z4gNILe2O6qiB
         xM1FfHJEX5qmZNiIBQR9ZW7v54txv7nR0NjHMyErIkzyms9lY5EYIDisTIs0tPnACuTe
         kUZozjUtiR1Ndxa3SdkUlhUo7vO4vaAcn8ov/ZFaAIr3Mj1TRpN/ADFFmOo2lAYkWoG6
         E6CqOkcfVb3Bh9FjAcQqWGuV4I2W41LzYnJw90d834wYv9Hnytzv5lK+Cs8XzshjtY7+
         GNLw6vnKWO0AEndbkd8UJkHBDS+GEkb17GoyWo+tsgPqb1kfaEs+Z1/lIBw3SCs83TUs
         uC+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwve6xey5dqYDj5dgift0yjb2yEpegvjSDWqbRoRdn+Ceo+KOCElvDIA3HpMf0oTK2y0pHEbNpJnvqbRw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJf9KMWb7rqhwKUqKqYfqD4l8WcdQupbV+PMICDPYOrpMtTBuEU
	W7Rtf0PZbaG284gCTxi6QfyzgmoCG4waqCVQikMKlnpRAd2DxlRsa4L6
X-Gm-Gg: AYBFou1JGrjCg7TO4qciqAlpsc0/B/JFDUOpg4nrlGPBjxKclpbwGOxL400DtFURx7F
	YWpWg2vG6mYmjxrw7mSIEhRp45xG3ZWb3U9IV8lT1Kym7vSI2cSXMkce2+4Fy6RZT2Qv56KU2dV
	Yi+7qjH59Ja3XgSBVphrJT9tjqxXmTicmnAvVHj+725K6AEIWdCAysBaLPQ+QfaEI5Q3BeKLixk
	8dUZ0HFDdc5kU+or76WGaSqCbfZ/JLErY+uYZjpIpRjGykwIF4qexhYCGCjFqf32+RppboYTl8i
	xwXs3s5VNKc2HkobjPFxcH/yfM1gVNzI0/e2Ee75pUXRnNSPeeCYQCpIled/3UHiQQIBgVf3xtH
	5/TsPt26/i8/ACstxY9rxmk5+LQxupTqS+wyXvqRHm5mXxzmwUKd2yMM2Go5SGYfAQ8RJYZIcuH
	r33RN5APNYKUZaxt2dZbYNWjUqorpyfnrEeZDztKisD0nnJKhUI+85PZcNYbWEDhE7pQ==
X-Received: by 2002:a05:7300:3e91:b0:33b:edf8:1919 with SMTP id 5a478bee46e88-34cdb5f6424mr3964817eec.13.1790846283176;
        Thu, 01 Oct 2026 02:18:03 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34db3750fa8sm6271798eec.11.2026.10.01.02.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 02:18:02 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 01 Oct 2026 17:17:51 +0800
Subject: [PATCH 2/2] blk-mq: drop the tag_set argument from
 blk_mq_free_rq_map/tags
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-bug-blk-mq-global-tags-srcu-v1-2-e8415da10d1b@gmail.com>
References: <20261001-bug-blk-mq-global-tags-srcu-v1-0-e8415da10d1b@gmail.com>
In-Reply-To: <20261001-bug-blk-mq-global-tags-srcu-v1-0-e8415da10d1b@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <tom.leiming@gmail.com>
Cc: Yu Kuai <yukuai@fygo.io>, Hannes Reinecke <hare@suse.de>, 
 "Martin K. Petersen" <mkp@kernel.org>, 
 "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

Commit 9ad8e5af3279 ("blk-mq: Pass tag_set to blk_mq_free_rq_map/tags")
added the argument so that both helpers could reach the tag set's
tags_srcu. Now that the SRCU instance is global, nothing uses it.
Remove it.

No functional change.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 block/blk-mq-tag.c |  2 +-
 block/blk-mq.c     | 10 +++++-----
 block/blk-mq.h     |  4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 6e01309226716..2b751bfa50e11 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -614,7 +614,7 @@ static void blk_mq_free_tags_callback(struct rcu_head *head)
 	kfree(tags);
 }
 
-void blk_mq_free_tags(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
+void blk_mq_free_tags(struct blk_mq_tags *tags)
 {
 	sbitmap_queue_free(&tags->bitmap_tags);
 	sbitmap_queue_free(&tags->breserved_tags);
diff --git a/block/blk-mq.c b/block/blk-mq.c
index f4ba1ac92a228..0c3c1481712a9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3496,14 +3496,14 @@ void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	 */
 }
 
-void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags)
+void blk_mq_free_rq_map(struct blk_mq_tags *tags)
 {
 	kfree(tags->rqs);
 	tags->rqs = NULL;
 	kfree(tags->static_rqs);
 	tags->static_rqs = NULL;
 
-	blk_mq_free_tags(set, tags);
+	blk_mq_free_tags(tags);
 }
 
 static enum hctx_type hctx_idx_to_type(struct blk_mq_tag_set *set,
@@ -3565,7 +3565,7 @@ static struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 err_free_rqs:
 	kfree(tags->rqs);
 err_free_tags:
-	blk_mq_free_tags(set, tags);
+	blk_mq_free_tags(tags);
 	return NULL;
 }
 
@@ -4118,7 +4118,7 @@ struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 
 	ret = blk_mq_alloc_rqs(set, tags, hctx_idx, depth);
 	if (ret) {
-		blk_mq_free_rq_map(set, tags);
+		blk_mq_free_rq_map(tags);
 		return NULL;
 	}
 
@@ -4146,7 +4146,7 @@ void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
 {
 	if (tags) {
 		blk_mq_free_rqs(set, tags, hctx_idx);
-		blk_mq_free_rq_map(set, tags);
+		blk_mq_free_rq_map(tags);
 	}
 }
 
diff --git a/block/blk-mq.h b/block/blk-mq.h
index e6b463da50712..1e64236d34d42 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -62,7 +62,7 @@ void blk_mq_put_rq_ref(struct request *rq);
  */
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx);
-void blk_mq_free_rq_map(struct blk_mq_tag_set *set, struct blk_mq_tags *tags);
+void blk_mq_free_rq_map(struct blk_mq_tags *tags);
 struct blk_mq_tags *blk_mq_alloc_map_and_rqs(struct blk_mq_tag_set *set,
 				unsigned int hctx_idx, unsigned int depth);
 void blk_mq_free_map_and_rqs(struct blk_mq_tag_set *set,
@@ -176,7 +176,7 @@ struct blk_mq_alloc_data {
 
 struct blk_mq_tags *blk_mq_init_tags(unsigned int nr_tags,
 		unsigned int reserved_tags, unsigned int flags, int node);
-void blk_mq_free_tags(struct blk_mq_tag_set *set, struct blk_mq_tags *tags);
+void blk_mq_free_tags(struct blk_mq_tags *tags);
 
 extern struct srcu_struct blk_mq_tags_srcu;
 

-- 
2.43.0

