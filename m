Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E96489886
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789992439; cv=none; b=GsD1ttOoe5nQoV7aUbdlt5pwy9FAmg1dfcCv/iXymEyF9/fA2oK+feWBtYDqDyoYtvR+9RFE2QarraK7+YYCUT32nzJ0Ks7ZGMPAL+V1o1eNWwdqrmoN31FfYK3DdSeho/9b8QZofLRex63ul5bRyTd+bcCIHNL9nbWRIz6HRSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789992439; c=relaxed/simple;
	bh=NK5MrrWQV+rQZfgb6tbm/RA+jKzDKw8/WieRmRh/hLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTjTmOAGYRFwUqpuRt47R1kI5B0wUt35EnZ2OaNcTXeIUm31fENHWe61ujV1q0yzy26DVOUeWj/A32OFpY+IENyE9+4xR35uVPDo3edj3p+Fp0SmU63OOBHaeXyn3GXCN6k0aYF79hvuVClTbeZL2E0MEZ5OCkpSXEDtvZBMC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VKZwF+3X; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VKZwF+3X"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-853e2610bb4so2152631b3a.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 05:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789992437; x=1790597237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0BhgCT09QkgxSYiuPM6SIpincAZrzVbnzV7okAgnX8=;
        b=VKZwF+3XQHbfPlacjy4KX1qfTvz01/5isOOnmrQO4vdDm4gpE2mrjqoQR3EWByODzt
         /EXKLtzaAhkHCEM83lyHvfta76YDF4ZN0HZUY8fQmKc/EpmzypAcL7Ega8SaR6So3r4b
         0lk18OtkpgGR4EHGLswbBpSOWhnwLzVKCW2SFF9gAJZ5AV6LoopXDQsx7L/WSJqnakhg
         VC84FoZt5OEk9av2yPVBvP1vQZVdBdbh0tg7/RnY0ausC5xrfN8lTYg9N0CTOKavoKmj
         Shi5y8j0DPOJTeU9mI5EDylyJ7AzMZnD4dRiBLsj3c28ycMhmMr7NuBKbq49Lsh1VTTF
         hZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789992437; x=1790597237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P0BhgCT09QkgxSYiuPM6SIpincAZrzVbnzV7okAgnX8=;
        b=er/TVoCzsnmfKbxQ9C6ZKJBEJpqui5QNlNIyG/OfcV/WP4hEaYRJly4pjRUUx/9zCF
         VI73j6s8MUe9KoZomjaYsrVC8jvSocBGTlnKfL57NZKbdioyDwJRLCOO9yhVtOGFFHaL
         ZzJE+c7oQb6e9uwSwJhVY6KVpYZtZ7SpEPj1V0r/J7qVZdYY43R8qX5Ffc8J2gHFY8LM
         Ft+cI+WL56m5k7k0a2BsH0Z1kyRUKfVbuuaQ5Pj6KFfjMaA9l5lLx6UpsJNunpD2kwaj
         TbsaoxICCg8PT4b+X2ojwqNjH1dfIFAe3ZC1cSkQp6P9gmEw2js1KlAuIc3zaIJTCAYx
         iJMw==
X-Gm-Message-State: AFuF++k9BMZxFAsIviTs/kRztFR0uLfdKvOJbV9YPNZ/ozB1E5eHGk8j
	TLyAzr/QZYUZfLtSBvndljs+zbf6+I6ElgWt++xpwgChFJlAUqzHOu+84bKWBDvWWdlC9+hc5Ht
	no3AWXVU=
X-Gm-Gg: AYBFou2O+ocbCm5OIGSPH1Ft3Z0f6pGjK+deEhjVW5MJefTcMNVmqI67srNwUEiJXcI
	LSyFgRJ0nhGcqZP4NXfD5MAu4ipY2rbZo90BHscpFQ7O1yggGt0DIR5Y8IHbhK6887eUJ9E8aKz
	87E7DMmjVahCrYqROIKMCNxwwDx17WevJucfxqXNafv/q4HNORNF0VaH57HOdAHL12nshO8PRG9
	GX7vehiLQHautS/eUK2mZfapJr2mbyWZJ9y4eltZ8Zia+nQSeWHyGjG+sRNH6VdG88np8BQ8r7n
	VbHp+pKyc+95cZMf1ItZqjD2ixd2/heHWx5Z6cCEJzHAzvOONYIDCsmSvcN4ff2Wi/DD/+xH6+5
	sbr1JAhHxadKat9oGF//FxnXFJ3Dw9rQmi32m53CLmvy43AWmro1auYQkacmfkg5NRH7UeV0hNP
	yWIaDkPjY0iebuB9KimI6No4KjFqDdIwihlbY8kKWrcuA7YkJdz5LNRBTcJrPFPxqN0yJI1oqNg
	Zk=
X-Received: by 2002:a05:6a00:3d0a:b0:837:f111:b70 with SMTP id d2e1a72fcca58-87341085fb9mr17288545b3a.4.1789992437273;
        Mon, 21 Sep 2026 05:07:17 -0700 (PDT)
Received: from localhost ([106.38.226.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa108e58sm3104740b3a.48.2026.09.21.05.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:07:16 -0700 (PDT)
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
Subject: [PATCH v7 3/3] writeback: record bdev targets in foreign writeback tracepoints
Date: Mon, 21 Sep 2026 20:06:58 +0800
Message-Id: <20260921120658.1627992-4-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260921120658.1627992-1-sunjunchao@bytedance.com>
References: <20260921120658.1627992-1-sunjunchao@bytedance.com>
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
 mm/memcontrol.c                  |  7 +++++--
 2 files changed, 19 insertions(+), 10 deletions(-)

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
index 494540cf6278..6c3083fcc063 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3959,11 +3959,12 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 
 	if (memcg_bdev_frn_wq && bdev_inode &&
 	    sb_is_blkdev_sb(bdev_inode->i_sb)) {
+		trace_track_foreign_dirty(folio, wb, bdev_inode->i_rdev);
 		mem_cgroup_track_foreign_bdev(memcg, bdev_inode->i_rdev);
 		return;
 	}
 
-	trace_track_foreign_dirty(folio, wb);
+	trace_track_foreign_dirty(folio, wb, 0);
 
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
@@ -4029,6 +4030,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		if (memcg_bdev_frn_wq && time_after64(ctx->at, now - intv) &&
 		    atomic_cmpxchg(&ctx->inflight, 0, 1) == 0) {
 			ctx->at = 0;
+			trace_flush_foreign(wb, 0, 0, ctx->dev);
 			queue_work(memcg_bdev_frn_wq, &ctx->work);
 		}
 	}
@@ -4045,7 +4047,8 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
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

