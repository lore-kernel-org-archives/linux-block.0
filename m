Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178E93D9522
	for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789628489; cv=none; b=QrqschrWrbrLJHHfpveME0jmbVcCROo4v0jnAUgs7W/sL1NMrYDiN0R9cbbmowxcm8QLdvyvNO+UFZPyRGOyPQPejJqYLeWF4QlxmumKAhXbdfPEBPUu3ZRB3ZFsAWNUeqB7rgIVQ8r/HwDQ78PXlS72S16xT1pPhUln3cyhaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789628489; c=relaxed/simple;
	bh=4PMSPRmeJVSA0/LfRDquf5uYBdjnY0Aenl/yglzKIVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xj94TA6RP0W0Ns9FF92uzeypfiihzYsDhp4UkqYWrElBc8R+k+zrHFv/2XQi0MsNBHELWqcETrfV5vhYX26Os9c1T5SlDwKJ429Be5v+QOM0xPcN3n0KhjUFRbgs3bEmf1pEytuW1lb25oI9uskoZwka+Rvbg1YbDFqTojrQXz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JWES4zIx; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JWES4zIx"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccafb751so411551a91.2
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 00:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789628487; x=1790233287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWcZ32DEcvckTxaHfwF/iY9dOheOeLm1G2879tq/8J0=;
        b=JWES4zIx2ev7VXkoYCq6u/iDmSehD4/DU2Io/8RzB7moMX8URhZm06MtC3AJF+HI5f
         xubqhDl+BfNXVcZIs2mpTLmNKWA7azeyLSEG88Yc+2Us2u54ZmbTVIs5YTDrqGeIlUL3
         eqbhMX0nlWCCfxXw/H+FJ6wJT7IAqBV+XqoPGjk91XTWT+RFlQ6b8BhlNOD78kvad5wd
         voJpkmsWsZk7pil77vHz9kMXemlK29NDJpE5hjoZmImHe/y0ieaJBkAk1XDw8p4r4bOo
         sRvwMhGze8U7RZbzEePgfbzKesd/2a3+Av2K4PHPjj9kFBP+VfHsL/jrBWKjfWOI+Hf9
         S7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789628487; x=1790233287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWcZ32DEcvckTxaHfwF/iY9dOheOeLm1G2879tq/8J0=;
        b=XLnGBjmyYnAqERcUn4HrDDDY4Mb7rOLZSwWKTHUYnRXPBsV5lIHBT0RTV8KSpJY8L0
         xX13zMzlW8Uk6v9gzw5R3LgPcMLBN1fr0kzeJhy46WI6w2pU3s1prvMdAc5l/9DzLFda
         8jBn/H8KbPgxB0DIz1+92mhtNoGrb8+pYFvCrsosqXazaiQEuGTs5/uBMetO9s1xv6sF
         9EMiKx8ZdvfnIJTFdH56fYiBOmoIefarMWfV3dH0OzxgmgnOs5xSBBuNqzhXSpbFW6XX
         yzkw8qW40zPUa5mOmy/OKUFK3dSQ6jJnWTOABG68WooiouXqxNN+nnsAzIRM5NUvEkq9
         hVzA==
X-Gm-Message-State: AFuF++ly+Uy62LPuwCk08WOSqzSF4EjT0x5bbiOy/d8w5VDdCLZJTmcT
	+V5fZtaiJamhZuIuoXKg9I1TjrJw9905glLCe89IS/+9G7+J48NUZgfKCkf/CxvPDcgN0QNXaOx
	DxyHa
X-Gm-Gg: AYBFou07rRo+o2qRbptyTHePcatMYu0LUQQKxy/MpdriytmJiovLco+UXc/PwFviTlS
	qc9at0VDj8b95D3rh3Va9tS8LyU0cLJeNVYy+agdjHAa/5y+fHpaiBGVmYBwE8y+dLufS5mqp2g
	WkQnIF8jXRVF485sdjlwlFXs34Whiwn3H3YJiwoR37GMap3RSkr+bXz2mmlbuD2199Orejbowov
	bR/EiZqZCQL5SXNWrRITSO/g0Auu02UfeJFTJh+DdzN6NRCA2Zka7+vjdoPxBSEJe+ii1c1LVEf
	7DCTS3mLXghOgrn6wPVJ7lYMh8eKU1YSszIbCbXcCbm4Q48pWo8VetsL64Q9EfNQKqg07EUgQ1n
	jHCQj9Z6GBgkh2VGPOsudu6xfpcV/C9IFAQipMTW+fKrnjhmMskwVnInCeJ+SRuZQdTCepYRlLc
	6rnqUFapFGXNcpQZoyPzE+EMZsaNXwhJE8vKbG+tvaQAq7bQApKbiIvV1MsyUZ6j33h+HLG/3j5
	w==
X-Received: by 2002:a17:90b:390e:b0:39e:8d5:fcee with SMTP id 98e67ed59e1d1-39e1e4d750emr15487090a91.17.1789628487085;
        Thu, 17 Sep 2026 00:01:27 -0700 (PDT)
Received: from localhost ([106.38.226.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e361b3a39sm3418041a91.11.2026.09.17.00.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 00:01:26 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v6 3/3] writeback: record bdev targets in foreign writeback tracepoints
Date: Thu, 17 Sep 2026 15:01:19 +0800
Message-Id: <20260917070119.2648123-2-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260917065759.2643940-1-sunjunchao@bytedance.com>
References: <20260917065759.2643940-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dev to track_foreign_dirty and flush_foreign so traces can
distinguish foreign-wb tracking from the bdev-only path. Append the
field to each event and print it as major:minor; zero denotes the
normal foreign-wb path.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/trace/events/writeback.h | 22 ++++++++++++++--------
 mm/memcontrol.c                  |  9 ++++++---
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 13ee076ccd16..ffd1b8df4231 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -273,9 +273,9 @@ TRACE_EVENT(inode_switch_wbs,
 
 TRACE_EVENT(track_foreign_dirty,
 
-	TP_PROTO(struct folio *folio, struct bdi_writeback *wb),
+	TP_PROTO(struct folio *folio, struct bdi_writeback *wb, dev_t dev),
 
-	TP_ARGS(folio, wb),
+	TP_ARGS(folio, wb, dev),
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
@@ -284,6 +284,7 @@ TRACE_EVENT(track_foreign_dirty,
 		__field(u64,		cgroup_ino)
 		__field(u64,		page_cgroup_ino)
 		__field(unsigned int,	memcg_id)
+		__field(dev_t,		dev)
 	),
 
 	TP_fast_assign(
@@ -295,34 +296,37 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		__entry->dev		= dev;
 
 		rcu_read_lock();
 		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
 		rcu_read_unlock();
 	),
 
-	TP_printk("bdi %s[%llu]: ino=%llu memcg_id=%u cgroup_ino=%llu page_cgroup_ino=%llu",
+	TP_printk("bdi %s[%llu]: ino=%llu memcg_id=%u cgroup_ino=%llu page_cgroup_ino=%llu dev=%u:%u",
 		__entry->name,
 		__entry->bdi_id,
 		__entry->ino,
 		__entry->memcg_id,
 		__entry->cgroup_ino,
-		__entry->page_cgroup_ino
+		__entry->page_cgroup_ino,
+		MAJOR(__entry->dev), MINOR(__entry->dev)
 	)
 );
 
 TRACE_EVENT(flush_foreign,
 
 	TP_PROTO(struct bdi_writeback *wb, unsigned int frn_bdi_id,
-		 unsigned int frn_memcg_id),
+		 unsigned int frn_memcg_id, dev_t dev),
 
-	TP_ARGS(wb, frn_bdi_id, frn_memcg_id),
+	TP_ARGS(wb, frn_bdi_id, frn_memcg_id, dev),
 
 	TP_STRUCT__entry(
 		__array(char,		name, 32)
 		__field(u64,		cgroup_ino)
 		__field(unsigned int,	frn_bdi_id)
 		__field(unsigned int,	frn_memcg_id)
+		__field(dev_t,		dev)
 	),
 
 	TP_fast_assign(
@@ -330,13 +334,15 @@ TRACE_EVENT(flush_foreign,
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 		__entry->frn_bdi_id	= frn_bdi_id;
 		__entry->frn_memcg_id	= frn_memcg_id;
+		__entry->dev		= dev;
 	),
 
-	TP_printk("bdi %s: cgroup_ino=%llu frn_bdi_id=%u frn_memcg_id=%u",
+	TP_printk("bdi %s: cgroup_ino=%llu frn_bdi_id=%u frn_memcg_id=%u dev=%u:%u",
 		__entry->name,
 		__entry->cgroup_ino,
 		__entry->frn_bdi_id,
-		__entry->frn_memcg_id
+		__entry->frn_memcg_id,
+		MAJOR(__entry->dev), MINOR(__entry->dev)
 	)
 );
 #endif
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 55bd5d100caa..f634874bbcef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3949,14 +3949,15 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 	struct address_space *mapping = folio_mapping(folio);
 	struct inode *bdev_inode = mapping ? mapping->host : NULL;
 
-	trace_track_foreign_dirty(folio, wb);
-
 	if (memcg_bdev_frn_wq && bdev_inode &&
 	    sb_is_blkdev_sb(bdev_inode->i_sb)) {
+		trace_track_foreign_dirty(folio, wb, bdev_inode->i_rdev);
 		mem_cgroup_track_foreign_bdev(memcg, bdev_inode->i_rdev);
 		return;
 	}
 
+	trace_track_foreign_dirty(folio, wb, 0);
+
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
 	 * using it.  If not replace the oldest one which isn't being
@@ -4031,6 +4032,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		spin_lock_irqsave(&memcg->frn_lock, flags);
 		if (!ctx->inflight && ctx->dev) {
 			ctx->inflight = true;
+			trace_flush_foreign(wb, 0, 0, ctx->dev);
 			queue_work(memcg_bdev_frn_wq, &ctx->work);
 		}
 		spin_unlock_irqrestore(&memcg->frn_lock, flags);
@@ -4048,7 +4050,8 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		if (time_after64(frn->at, now - intv) &&
 		    atomic_read(&frn->done.cnt) == 1) {
 			frn->at = 0;
-			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
+			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id,
+					    0);
 			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id,
 					       WB_REASON_FOREIGN_FLUSH,
 					       &frn->done);
-- 
2.39.5

