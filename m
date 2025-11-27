Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67901FC110
	for <linux-block@vger.kernel.org>; Thu, 27 Nov 2025 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764207567; cv=none; b=PBy9DWHDx5weaGim5hlLa6hgmrfSOxGcuzpgCxiC0y8vXnY5FNdxTc6Dv4clNHsSDBJSzgOw/xMg/hfWl0256d64uZB3jLZEG9kcZ58d6x3DH02FLE2v2gQtnwLVFPkt7LWSbtQ5uOsIw3Qps/eOj9dYzjgkfhmDCDY6OqbUCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764207567; c=relaxed/simple;
	bh=g3jSx/4w6cDWPzl7o1lpUOuVxLM98dW3ejVah/cLQAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AgDQAFtAon1aa4NKFonyANUPkQ+ThkN5mNnuXhsBhUCVluZT1RNau9y9wyOzlIxvd0IQ341zcgufvGLIT2cYna4OcWH8NZ2k80+hA+Klm/XcRGDUiFYeYk3a2s4VLRpmwQqIuNbgCfJfcPOSPMzEYTjNMXEW2/V8ee1yn5ByaXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZhAuy5j/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhAuy5j/"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29555b384acso4372745ad.1
        for <linux-block@vger.kernel.org>; Wed, 26 Nov 2025 17:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764207565; x=1764812365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCnWlq7jevIURFCSwoXEvm9/cfr3tSQCSjnx3b3LKRY=;
        b=ZhAuy5j/4Ohikv6kV7/aiJz4IErsADKAG1Wem/jTWcX2CAoftd/Q28Dd//sXIiCX6E
         lvU9O6T3yjKgv0eoXs0kxGqEhA/nzNYYT++TG4BCykT7ks21dkbffpKV+N6fSQP2UhvX
         oIsCY7UgoYJN3qUVujVk3FQ74gRUj1X3JGfikvJgwBM/wChJ8w5ubg8iID6MnDQPGCy/
         ZiOl4L+9Gy0m1gp/18YUMgd1iG0eucHFS+scw2dgWEvGlJOjHSBAm3vEgm0jqj0aJUY1
         Qe10LBeu3bIgtBnMIxUEFKJI+uv6+5Ch3yBKvpl6ldouRtejDxJn4lXPcZJUXIt1jkqg
         Gl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764207565; x=1764812365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nCnWlq7jevIURFCSwoXEvm9/cfr3tSQCSjnx3b3LKRY=;
        b=PwCExkzt6vfekVDOwJ2KTyGgVEbSX+NYbvzdV7R+r5M8BmyXQugC+3bfphqKxmgz9l
         uu8f2zucrGLKoPVXYDzr19fkLKJws+8KtCkkJPp+7uKvo6UKXoapSARrn1ZoKgZoGRN/
         GFjptdEu6/aVPXi67cW51WYVXzWAg8yEzrU2P2LpLOR6bCXicE1Y5dqEwaHioL1Y2AAp
         x3Sjz+Jg5oqz8vTkDbtVFS9CztxMSZ5t809NShqCGWPSd60yK5GJeGbv/+aU1ikLgTob
         FF+atnlmdNXrTm0ZoPonKxbLfd6/1bv8MghFRWItkAbQDkOofZgk0D4Ql+lEVo123ybA
         Nm0A==
X-Forwarded-Encrypted: i=1; AJvYcCVI/zCBFRK8TBMMr91s7RvsujZ4qUwVOPNQfedWXL8EDJRKK/b84l/uatV+QeMgRksZhyD5SOPJei3q3A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3RbPNR7n7zjf1LxGwNfAZJgxOvsWcXNwoE/PQr7WNB976r19
	/UFhWTLVdiKjc2C2YLqq7gOlrDKL35v31RgI1dRaGNKoL3J/VKHbX/Ew
X-Gm-Gg: ASbGnctFRkvj499CWEQB9D2LfKxIIbsyPowaE+R/1qLYvaxY8O1YgrY5tO1GR3R764u
	f0xxoSVm4mHcfPdVSQ90FHlfJVawBO4DhOnc131p7oqD5nCGNz4sH2c360x0bkJOYOGswVuxcts
	lUazwQ7TBtK1Q006/OChZlmgaklBh41hWMGIpGwipcT+1mcceDF9B6GptRZaK5s8K2OFKNzsdAe
	2GLCAdYnmvIvEmXf6VstsX4qF1i3RzvfyQ4mKK0CdpChsT6fE5y1N7WuHtTL8/xcxtXauTklLcG
	sNDeMacD7He/CQsVAePZH07Fx1B1HMOB9ATwIbeS5od2FEAwlzI/uK+bAsdsUIhpjbO2sUSgFTP
	AzHjOC1/ZwKoKYIFDTr7I2NIFzHhcH9Q/FvGwAQk2R16o+pTwidFsVn2ddViUdr+Qb0EAgsVzwM
	J0WeCKJX19esjOt9uRGTQmEje+Ldv4zmIhZ1nzbq8Snnxd3SH4
X-Google-Smtp-Source: AGHT+IHcgY20Zica4plj+qFWrR9X6753pBi84mjVsCqPXs+9BFxP6jiNd3WNMiuNknCNpTAQG7VaiQ==
X-Received: by 2002:a17:902:f788:b0:267:a1f1:9b23 with SMTP id d9443c01a7336-29b6c3e5524mr216782815ad.18.1764207564735;
        Wed, 26 Nov 2025 17:39:24 -0800 (PST)
Received: from localhost.localdomain ([101.71.133.196])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29b5b107cc2sm212427815ad.16.2025.11.26.17.39.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Nov 2025 17:39:24 -0800 (PST)
From: Fengnan Chang <fengnanchang@gmail.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	hare@suse.de,
	hch@lst.de,
	yukuai3@huawei.com
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2 2/2] blk-mq: fix potential uaf for 'queue_hw_ctx'
Date: Thu, 27 Nov 2025 09:39:08 +0800
Message-Id: <20251127013908.66118-3-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251127013908.66118-1-fengnanchang@gmail.com>
References: <20251127013908.66118-1-fengnanchang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fengnan Chang <changfengnan@bytedance.com>

This is just apply Kuai's patch in [1] with mirror changes.

blk_mq_realloc_hw_ctxs() will free the 'queue_hw_ctx'(e.g. undate
submit_queues through configfs for null_blk), while it might still be
used from other context(e.g. switch elevator to none):

t1					t2
elevator_switch
 blk_mq_unquiesce_queue
  blk_mq_run_hw_queues
   queue_for_each_hw_ctx
    // assembly code for hctx = (q)->queue_hw_ctx[i]
    mov    0x48(%rbp),%rdx -> read old queue_hw_ctx

					__blk_mq_update_nr_hw_queues
					 blk_mq_realloc_hw_ctxs
					  hctxs = q->queue_hw_ctx
					  q->queue_hw_ctx = new_hctxs
					  kfree(hctxs)
    movslq %ebx,%rax
    mov    (%rdx,%rax,8),%rdi ->uaf

This problem was found by code review, and I comfirmed that the concurrent
scenario do exist(specifically 'q->queue_hw_ctx' can be changed during
blk_mq_run_hw_queues()), however, the uaf problem hasn't been repoduced yet
without hacking the kernel.

Sicne the queue is freezed in __blk_mq_update_nr_hw_queues(), fix the
problem by protecting 'queue_hw_ctx' through rcu where it can be accessed
without grabbing 'q_usage_counter'.

[1] https://lore.kernel.org/all/20220225072053.2472431-1-yukuai3@huawei.com/

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 block/blk-mq.c         |  7 ++++++-
 block/blk-mq.h         | 11 +++++++++++
 include/linux/blk-mq.h |  2 +-
 include/linux/blkdev.h |  2 +-
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index eed12fab3484..0b8b72194003 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4524,7 +4524,12 @@ static void __blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		if (hctxs)
 			memcpy(new_hctxs, hctxs, q->nr_hw_queues *
 			       sizeof(*hctxs));
-		q->queue_hw_ctx = new_hctxs;
+		rcu_assign_pointer(q->queue_hw_ctx, new_hctxs);
+		/*
+		 * Make sure reading the old queue_hw_ctx from other
+		 * context concurrently won't trigger uaf.
+		 */
+		synchronize_rcu_expedited();
 		kfree(hctxs);
 		hctxs = new_hctxs;
 	}
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 80a3f0c2bce7..52852fab78f0 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -87,6 +87,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *
 	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
 }
 
+static inline struct blk_mq_hw_ctx *queue_hctx(struct request_queue *q, int id)
+{
+	struct blk_mq_hw_ctx *hctx;
+
+	rcu_read_lock();
+	hctx = rcu_dereference(q->queue_hw_ctx)[id];
+	rcu_read_unlock();
+
+	return hctx;
+}
+
 static inline enum hctx_type blk_mq_get_hctx_type(blk_opf_t opf)
 {
 	enum hctx_type type = HCTX_TYPE_DEFAULT;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 0795f29dd65d..484baf91fd91 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -1001,7 +1001,7 @@ static inline void *blk_mq_rq_to_pdu(struct request *rq)
 
 #define queue_for_each_hw_ctx(q, hctx, i)				\
 	for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
-	     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
+	     ({ hctx = queue_hctx((q), i); 1; }); (i)++)
 
 #define hctx_for_each_ctx(hctx, ctx, i)					\
 	for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 56328080ca09..f50f2d5eeb55 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -493,7 +493,7 @@ struct request_queue {
 
 	/* hw dispatch queues */
 	unsigned int		nr_hw_queues;
-	struct blk_mq_hw_ctx	**queue_hw_ctx;
+	struct blk_mq_hw_ctx __rcu	**queue_hw_ctx;
 
 	struct percpu_ref	q_usage_counter;
 	struct lock_class_key	io_lock_cls_key;
-- 
2.39.5 (Apple Git-154)

