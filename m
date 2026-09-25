Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A9F443A9E
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790318701; cv=none; b=Kh0mWeLHbW9ofEVj5K7CtWzyiPwVqRV3ShbrKflLg66q0yV5D9h9kcjHMPy4ktatwBHvoJX0G+KqCecXdHMCgsOwS7+0yRUkTps2t0BRSeh313FdVERZA8Nk5yQsITJq+oJmHDn1xaY38FTrESs1ACjmxRRQ0ymIAYCd84vcJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790318701; c=relaxed/simple;
	bh=ZAyGGjTnqx9ID0gAuHigQpj5hlXbi5r1kLVGxRdz49Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QacgXeYxt0+AXd1v08CdOnzI/KgRcjwtyhV2G3/LoilILFu6jLIz/3kJ3uZhMn41bggOPudVNblN2q3SD5p1ZIrSiEn9uFUJZ1qsuTNBzC2zzriUnmtgrPTcgFcrHtEvEvhuQSYb1jbtIK7XHQb92E3qZAWE6UChYJSaBb32UXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SWGPynzG; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SWGPynzG"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78e1a94b8so91709a12.0
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2026 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790318699; x=1790923499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=46ObzkJeR9Z1Ibx349d8JNyWVlYaD40DttrTljPNkhM=;
        b=SWGPynzGdy+HdoC0UgwICuz8nqDS5ITbEGXn/YEpJaxx9OTvrDelIyVIzgzOux2BMm
         RFWZ/w+D2DrP7InaVU/maB282Ve4o80AHf6wKWrDn4SIWnDm9g7qaCGvb7+kNLMzwquI
         Afm9ygx71DtijiuW0uJ1PxuM5Fn1t7zUOXGCuQ+1tCdTfF7+CgX7hlptFUkUm0GV0eLm
         Lw+L/QuCm/2pVHxCAord5ZCvr2f8GkATKe9ruDLLk/OSRzb8PIpt/VdJNXeDyIU6UBnR
         Y/O9PG3hQlXmbRlNhn8DSwk+nB3F3qZoVePPaik2gL6OHUoecCZEC9BMkboi3Mxi6xZb
         CJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790318699; x=1790923499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=46ObzkJeR9Z1Ibx349d8JNyWVlYaD40DttrTljPNkhM=;
        b=Sw9sIhRybPBJiyFgkziFiSGt0HNzwuIAEmYNCLFSm+LL+jvt7dWJ24dnNs0UZitEwN
         nchcraslre2cX1G4/ltaZCZ/9sjqGInoEVOEOPPvauzN6f2ee5+CdFXYeOhU2zGadFp9
         3FL1qHlSswSxXvv/hr9jXP/PuAFR7TAsmzlOntpSpfL4249ss3R6BsnGmrTIinAtaa6l
         ktFEGYT/mDovGjWhe1p6fYaPhu4MxPzaTUviAe4QrIYLEGjS/Q3D4Lg7vEjljK6Ueyy0
         em88DyDoI2FctIONvbfuks5ksndosC0BGSUZeTwAAYTVYo3jg5ZPifwWw/d6Jeqh8nHM
         5yjQ==
X-Gm-Message-State: AFuF++lQ1/IJxO2pw8HKLpmbHb+I0NhLFnBZKAgZ8L9KgxuyGiMk0gQd
	6Lhu1XqVtj4PiTPW3Q0DI6BDJtvWvpsUHEzwRGq3GbSfcsqnooTjRLPdQbfFmflzSSDG8LVU7Zz
	zaXB6
X-Gm-Gg: AYBFou1Gr1eM6vGxV70DKhr7exhpLE4HaAjG0ipk36A3yTQ4n9/8v7I10FUFz1bEUNm
	qIvjJq+MLRh9jBotR/epH9qsXAd3g8QkWz9knJihSQYj0nFHvRJTbmHrXjQ8hdrSF657dyL0Dxw
	6RZXNL/5Yy0ZSnEEQtg+T6o+lC+Dbc5YVsQjHpgc29O4ZV5geJV/z1+AAOUf0ZFtPol8FYl/38w
	qkv84uQ/mCwbtAJrNkFyj/9lHnc+Zk4t8V7PRq6GTYj4xoT5u+WdcOB7OcVnRtfx4qb1qsrkPzP
	mHhSzEDJsR/vWmeOGRGZvNN185OIiX8qoNm9LovltfTV0apEi5s22FGHPCRqsJ8YKmkn2daO4kw
	TP3qCJomvc9Ob6CJDgmA/Orc3pnhU6HXst8ZhJEuCGz5rwlR3kv6YG+D8qmEJYgUtIO4eOkYqZk
	CDwc2CWtVoPQ+lAx/QBg6xfQUZsWs6RFfFvBYubCbDi/T2FvnVR+0KuLodL2MWGlCtS0jIv7Urf
	OQ=
X-Received: by 2002:a17:90a:c08:b0:3a0:b3f3:a2df with SMTP id 98e67ed59e1d1-3a0b3f3a396mr1192901a91.13.1790318699459;
        Thu, 24 Sep 2026 23:44:59 -0700 (PDT)
Received: from localhost ([106.38.226.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm2776224a91.1.2026.09.24.23.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 23:44:59 -0700 (PDT)
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
Subject: [PATCH v9 3/3] writeback: add tracepoints for foreign bdev writeback
Date: Fri, 25 Sep 2026 14:44:44 +0800
Message-Id: <20260925064444.3944820-4-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260925064444.3944820-1-sunjunchao@bytedance.com>
References: <20260925064444.3944820-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add track_foreign_bdev_dirty and flush_foreign_bdev to trace foreign
bdev dirty tracking and flush requests separately from the existing
foreign-wb path. Record the target device number as major:minor while
leaving the existing tracepoint interfaces unchanged.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 include/trace/events/writeback.h | 67 ++++++++++++++++++++++++++++++++
 mm/memcontrol.c                  |  3 +-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 13ee076ccd16..4a85883fb8a0 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -339,6 +339,73 @@ TRACE_EVENT(flush_foreign,
 		__entry->frn_memcg_id
 	)
 );
+
+TRACE_EVENT(track_foreign_bdev_dirty,
+
+	TP_PROTO(struct folio *folio, struct bdi_writeback *wb, dev_t dev),
+
+	TP_ARGS(folio, wb, dev),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(u64,		bdi_id)
+		__field(u64,		ino)
+		__field(u64,		cgroup_ino)
+		__field(u64,		page_cgroup_ino)
+		__field(unsigned int,	memcg_id)
+		__field(dev_t,		dev)
+	),
+
+	TP_fast_assign(
+		struct inode *inode = folio_mapping(folio)->host;
+
+		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
+		__entry->bdi_id		= wb->bdi->id;
+		__entry->ino		= inode->i_ino;
+		__entry->memcg_id	= wb->memcg_css->id;
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		__entry->dev		= dev;
+
+		rcu_read_lock();
+		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
+		rcu_read_unlock();
+	),
+
+	TP_printk("bdi %s[%llu]: ino=%llu memcg_id=%u cgroup_ino=%llu page_cgroup_ino=%llu dev=%u:%u",
+		__entry->name,
+		__entry->bdi_id,
+		__entry->ino,
+		__entry->memcg_id,
+		__entry->cgroup_ino,
+		__entry->page_cgroup_ino,
+		MAJOR(__entry->dev), MINOR(__entry->dev)
+	)
+);
+
+TRACE_EVENT(flush_foreign_bdev,
+
+	TP_PROTO(struct bdi_writeback *wb, dev_t dev),
+
+	TP_ARGS(wb, dev),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(u64,		cgroup_ino)
+		__field(dev_t,		dev)
+	),
+
+	TP_fast_assign(
+		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		__entry->dev		= dev;
+	),
+
+	TP_printk("bdi %s: cgroup_ino=%llu dev=%u:%u",
+		__entry->name,
+		__entry->cgroup_ino,
+		MAJOR(__entry->dev), MINOR(__entry->dev)
+	)
+);
 #endif
 
 DECLARE_EVENT_CLASS(writeback_write_inode_template,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 74677078f9b4..0108b4177833 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3965,7 +3965,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 	struct inode *inode = mapping->host;
 
 	if (memcg_bdev_frn_wq && sb_is_blkdev_sb(inode->i_sb)) {
-		trace_track_foreign_dirty(folio, wb);
+		trace_track_foreign_bdev_dirty(folio, wb, inode->i_rdev);
 		mem_cgroup_track_foreign_bdev(memcg, inode->i_rdev);
 		return;
 	}
@@ -4041,6 +4041,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 			 * the timestamp for a later flush.
 			 */
 			frn->at = 0;
+			trace_flush_foreign_bdev(wb, frn->dev);
 			queue_work(memcg_bdev_frn_wq, &frn->work);
 		}
 	}
-- 
2.39.5

