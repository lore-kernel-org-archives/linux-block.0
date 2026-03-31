Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7BF3845A2
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774938421; cv=none; b=V57pIGg8AXo0LYIQ6L2VWJwtozNsvrCC925rWpwXyW/2v0Z3MH3db22wEJG84f844vqB0xJJESGGsra7yKyW0KKQuYpbNuwjk3QmCpol/qT1Nhaoceu1zCEDrM2W6RWsS5SiHlVrMMgTCTuqk7B3Cr0MNjxsQEIp/YVhdXW35dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774938421; c=relaxed/simple;
	bh=o6ZNdbinZj3iv51nZmZkjpzytsjA9e4T3rhxSg04PYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pljRRTew/k1HB2BX3whlpePVV3Qou4qPH7EhwW7hJiTgzRpF5K3GW2tQ0EchDsBu32qOvCmw66RXs65t3ZkQK30Wm5xhsO9xzAtoCAa+CH/D9XTYPLv3U3DQzVhloxauG5pQyvxN6KsnR8khecMuuPa+49RBfT6EIdrFRyzowbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lJ6aASDe; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lJ6aASDe"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaed195901so23006575ad.0
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 23:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774938420; x=1775543220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iFuV2hrKChe8VPlJWziIwCmvIdRAMcpeZAmPUEU/b+E=;
        b=lJ6aASDeOrBFHB6JIViflwvwk8ZmOdGtU1oHCf5Yz5c67U4ljO1KFEtBpz0KuEEBL3
         hqoAZd8rLu1gYLPQiGYlRZUKB8sKm9+ssT6RhHh8tlT9+tymND8jUkxeY04RxbfmD9CB
         gUVFvfho2Nk21dC61FleErmAbaMgEphar22SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774938420; x=1775543220;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFuV2hrKChe8VPlJWziIwCmvIdRAMcpeZAmPUEU/b+E=;
        b=fZCIa7amkSQSgHYu52B9XiurAD/4eCiJqs/OPBq/9evUSlaw/dP6p2QYXW6dpKQxaZ
         JV3KPJI2wBJre7Lv/T+i/LRwvviY4SiTlTD7nQBQmR40PCjZGWyBUGuOHaR6sRffMAVM
         qkZp/HgKi77/Kgz8yQQ3fsdWrm4PU54ZZpG0BI0Po8fNAClwX/lUauvmqdfGf4ExeADj
         cqCQnGQ38n8K8xePXPWDgmFzBTYW0ByDAzFf16E+1F5Jyu7D8CKzwl+1Z3FcNNRIQ1+G
         gJqD0+7jsRoZJpuEGJtacfc4iPp2XGLX9lV4T2Vafl1T5UePZhY7R3qR6SK8WWyRLKFG
         0gwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxMHp/Pa/I0HI2iYssuO2HdW+9HW9rd4JqYp8Qch5NLvIE5hp3jLQPowh5IVlYndVQFLFGYPKqJZI/KQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNveSK03x73rDmhMU4XK4EBIP5G8tncFwEd57/r5p8hlsVK6Z3
	8DZQ3JMGMOKHc7DjNIYk/gPkovER+IKnw+AL5YuSpN43mRPII4t5MM/DqhvrH+gw1A==
X-Gm-Gg: ATEYQzwwiCzwV3r8yXaHGVxGNdHPCKO4GydeGAfP7iYcQ6sjFvKU1VWMWkIWtaONOvy
	zJQQUSvUywlZRh2RAyhr2K4G14Mw7u0onM10J5PW/9rYc4HZxi2NZFbHRPbqlQmTrr6GwkOR/mo
	B/puKa++cfDtEwF02m8J2/twSQl4kVVT4Mk3iZAkkVZZpJHnNT5RlrKJK2AgQ6HeHO25VZV1TtB
	ABMYMaJ+0Vx3HoTwykwah8YqbC+OBuQoc0Ga4Nf9cQfvCxnlKpfexQZCdIZmz1fWf/YLvXiH78H
	m7oOO90NxI25R/rMZPlB80mVqVFgu06fRd+okuX5zq9ieNrBb+4AdCSjlDSxaRSK6JtHIpNvJjW
	ZhbtRWh6EYDRswSLyMC1MgZMFaGLyLdmBhJ1zYTTrSlZisjZ4vaRr7eO2LH4sSyvcEs5oicUHRE
	jVGaPINE71YoErSKmi+45Cp03V24ZhJ4tUabkntZTCO6hobohcuEg6FlDKTqAfs49lmtWvUN8hH
	87kpBb+VTjRYQ==
X-Received: by 2002:a17:903:19eb:b0:2b0:5a4c:726a with SMTP id d9443c01a7336-2b0cdcd55f7mr169704795ad.43.1774938419771;
        Mon, 30 Mar 2026 23:26:59 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:90ef:61f3:1679:56f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24ddc0afbsm90813585ad.64.2026.03.30.23.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 23:26:59 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>
Cc: Richard Chang <richardycc@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: [RFC PATCH] zram: update ac_time of written back slots
Date: Tue, 31 Mar 2026 15:25:59 +0900
Message-ID: <20260331062648.596077-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes it possible to tell how long each particular
ZRAM_WB slot stays on the disk and, basically, to monitor
writeback efficiency.

Note that the patch factors out a small update_slot_ac_time()
helper, which we call on writeback completion, instead of
calling mark_slot_accessed().  The reasons being is that
mark_slot_accessed() clears ZRAM_PP_SLOT flag ahead of time,
while we want to keep that flag set as long as the slot is on
the post-processing list (unless the slot is freed concurrently).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Suggested-by: Suren Baghdasaryan <surenb@google.com>
Suggested-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5ecc4ba40e9d..dcea703a6766 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -185,15 +185,20 @@ static inline u32 get_slot_comp_priority(struct zram *zram, u32 index)
 	return prio & ZRAM_COMP_PRIORITY_MASK;
 }
 
-static void mark_slot_accessed(struct zram *zram, u32 index)
+static void update_slot_ac_time(struct zram *zram, u32 index)
 {
-	clear_slot_flag(zram, index, ZRAM_IDLE);
-	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
 #ifdef CONFIG_ZRAM_TRACK_ENTRY_ACTIME
 	zram->table[index].attr.ac_time = (u32)ktime_get_boottime_seconds();
 #endif
 }
 
+static void mark_slot_accessed(struct zram *zram, u32 index)
+{
+	clear_slot_flag(zram, index, ZRAM_IDLE);
+	clear_slot_flag(zram, index, ZRAM_PP_SLOT);
+	update_slot_ac_time(zram, index);
+}
+
 static inline void update_used_max(struct zram *zram, const unsigned long pages)
 {
 	unsigned long cur_max = atomic_long_read(&zram->stats.max_used_pages);
@@ -952,6 +957,7 @@ static int zram_writeback_complete(struct zram *zram, struct zram_wb_req *req)
 	zs_free(zram->mem_pool, get_slot_handle(zram, index));
 	set_slot_handle(zram, index, req->blk_idx);
 	set_slot_flag(zram, index, ZRAM_WB);
+	update_slot_ac_time(zram, index);
 
 out:
 	slot_unlock(zram, index);
-- 
2.53.0.1018.g2bb0e51243-goog

