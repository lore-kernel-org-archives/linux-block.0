Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C0443BDA8
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 10:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381895; cv=none; b=tskJbO+VF2RQFz43Jaw3ZzMDTDQZoylkakrfSltWlEWyCEOHPjbz+e5tkbxdrn25vailrzASR5c6qaguk+aacRW5CMrpKO3Uma2sl0iuJQtqRMVinnhM9Y6NZtIr/OYJkQtFTG6Y2j4Dp7/jUY8p3hp9kCbwxHxh3KNeTbs8S8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381895; c=relaxed/simple;
	bh=Ff4KaGAo6d0f5FAv0xjxQH70E0Aoh32KPm/lqQuB1v4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GKOpRBITzwm1cg+3GGM0XyxCAD/zTBkMCp08cOFyrsDXi5RHV9rivNWgrgxHwKQHoX81FpDjYRn55xx56w/d6eEId6u52DyZqzF6R0goHqeFtbbl6PAjGwJC2Eq7s47TwRHcl35RKm7QS88/tBguYUkXgZKRSURRZjWiP4U7ex8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S2KGBdXd; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S2KGBdXd"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so15210905ad.3
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 03:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1789381893; x=1789986693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GAJNn0bp38fgX07/g9hgwBPHQPi1l+UFyT95Gb09AgE=;
        b=S2KGBdXdovdIVZaypnJxioeoKukwFXkVOek+vbBCAsxyHoEfZzQiFTYOlTB5Nx4zhX
         /xef3nU9VxGXcJbKlBJLmJnlauTmE7HEsGid1F+Zfnzn2JjCe+CdZGherUF9xdaU/2EF
         KZepIun4k2wyEt0cdfXuwpFohWIxd778fnMqjU6NPowFMUQzyxGd/nathogt5suCZnp3
         3K/5CaIvOKuwyla4bNoa/34PLk7yqKHNey7GahAAzrSIXP5+lVjhvNBIk+qsWgjrZqb8
         xz7OM2MJ6fnKS81RVnhC0jq1HZeBd63ZSLAXPd8Bl7gOngfjrQqhjUTZqB9x3sIOfIMB
         qSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381893; x=1789986693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GAJNn0bp38fgX07/g9hgwBPHQPi1l+UFyT95Gb09AgE=;
        b=pEiifqDke+u+Vr/KSAjYQHwmfGFkcri+GRq5EEKf+0lAf+LH8IMFmQFjHq0F1BLQLI
         OIxPKSQpU4PNq7E2V4xo0aVgswWPZ1q0o2GCN4KIMsOC0cdciowTq8UsNo3raDxayk3I
         0b0XArMpBx46lQ0JM+UXEyxYQ0jqRtZ4/BJPulo7kCwcybtdIUcPFP46hH3eh4ATogeM
         Ylqk0C+cnNTr4EqPbr6XeL4qaIZQ2eLWl8vg4qEaInQ+XUJUjHctl+25gLg9X3w2ErCU
         lty+XRCPCGSC8ISnDVv4Go6gnJjlrY/qz8g6zYYK2ABn+3m7EAAH5LG725TCQ8MR5G0C
         4zmw==
X-Gm-Message-State: AFuF++la6efgb6JDBEPrZpeuUC5J/YgAh7DYjy6By8Qw8S7wo7P7ClAr
	Rt8krO6Xw/cCGddYx/foDIjXr4Izg589w10fgYMQmrYRa9u7cMQKQJHSQyyP2TfsgNWhi6l2Grq
	QKGlIFG4=
X-Gm-Gg: AYBFou2px9fSt0r6XtRcVvVUemp6iWisa0hj5k6XHHO5NIj0iCS0ek7tG9UGgVKZ6wH
	L3p4fvMMcW+lUTe/7x2sQ1aqy8sI34KjyhRhpooo8OzfVmV5mj6pCTQn3A68Q3Q4I3xRab59UXK
	TVi5MWrR39QkHk2Iomqofhla2X3uBL+ctW2798WIgMF2XquTpQO1KTtUm2klQR9QKab2+29KlRs
	ZCEgMOfAOh0+OjYGmsOMCPrNeU5B2tVebjZmfRU3JIS9U8RuPq2N0/O3awQIk5HqclslpvitW30
	hEyVYgX3m87MTBOkRvf++SLsfE1jX16G1q3BpE3oxsigbwnuSvqFazOIaboK78K+9ei+K/iFSd+
	SteSXJvnQFFPoPLF0PjrqNmbPvfsgeAu01VF/muKeQAl/bZPSpdOYnRsebcrttGOGGju4g7+c1G
	TG35TFYWa0IY95+LQEq4E5vJ9jtxZpvTIpApJhYOG69X/mhPdHtFt9Ds2lHhw667zbRWO6K14vx
	KE=
X-Received: by 2002:a17:902:d54b:b0:2d8:d4d0:792c with SMTP id d9443c01a7336-2dd6c7128bamr41635625ad.16.1789381892803;
        Mon, 14 Sep 2026 03:31:32 -0700 (PDT)
Received: from localhost ([106.38.226.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd69745cb5sm10165335ad.43.2026.09.14.03.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:31:32 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: axboe@kernel.dk,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	willy@infradead.org,
	jack@suse.cz,
	rostedt@goodmis.org,
	tj@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH v4 3/3] writeback: record bdev targets in foreign writeback tracepoints
Date: Mon, 14 Sep 2026 18:31:19 +0800
Message-Id: <20260914103119.1708452-4-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260914103119.1708452-1-sunjunchao@bytedance.com>
References: <20260914103119.1708452-1-sunjunchao@bytedance.com>
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
index aac8c893d7d2..0784f6e40aec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3938,14 +3938,15 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 	struct address_space *mapping = folio_mapping(folio);
 	struct inode *bdev_inode = mapping ? mapping->host : NULL;
 
-	trace_track_foreign_dirty(folio, wb);
-
 	if (memcg_bdev_frn_flusher && bdev_inode &&
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
@@ -4020,6 +4021,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		spin_lock_irqsave(&memcg->frn_lock, flags);
 		if (!ctx->inflight && ctx->dev) {
 			ctx->inflight = true;
+			trace_flush_foreign(wb, 0, 0, ctx->dev);
 			queue_work(memcg_bdev_frn_flusher, &ctx->work);
 		}
 		spin_unlock_irqrestore(&memcg->frn_lock, flags);
@@ -4037,7 +4039,8 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
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

