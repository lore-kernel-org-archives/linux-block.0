Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46548A2B6
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 12:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791806807; cv=none; b=W6fC57yp01KVUunvDsNpNnyTb/akMnGENx9BFj2P/JFrLPCkyuwft8bCQXZTqPwIBSMZoV+WaWXD64VJoN7XhXkCGZ6rc+DNSLbKo9X5pS/O5NdU0fR9hi40Ft9N4AhFmILBBUnDYS7srKSJS7033+aty/jPo3owJHr41m+rZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791806807; c=relaxed/simple;
	bh=8oH4TL7RAbryPBAVqMIJN9TJPC564BJuwxMAzKfRubo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mrAXc3WZ7iqAeMaisGYjZ0jdOUJbqjdUUFvYlfpOa/bXRfcQUWa+doR4qVERzXPAXxqfFC9FMW8J81ARLcu0hvkmcy9rmug2e5lawSwgUjiSQ/K66i0uTUvcdInaobKN0CBmAOe9PVvhbYGgvd33WotYkrylICV6LwDSI64Giv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IDaYsVY9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IDaYsVY9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a7fecf8440so846637a91.1
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 05:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791806802; x=1792411602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DGD6iaaJXJ3iIdLAE1x/VkAzNUZDtkUZz0KaCdzwHZw=;
        b=IDaYsVY9VJ8CUC/hjiZTf87bPbAxzYRT3GKQokIKJJ/MofHeeKIyP4R23h667WXhO6
         gZyWDV1ddrGbyPFkQrGz+xWH2aWo+kcVCMgcgmpSk11kuWaWEK8295S0WG68Z/MUVGiM
         VgFGmIVbcYYZULXgGemZY98QtDMk6EbFLwSBZTzuhd+DOyv0tDTfs7gNcJGClOFFIFy9
         uJTqrW3Q+ajktHToQHreui4JQkKLT5tmIsiADmIOadLUIF7mRZXworQtj18oAurt3xh2
         3OZhAt4PKdj75fvTZPIc2cQxRUf5BkDsDxyhKvnezjJdv7oR1Q4renjFDYrnFxayYOBe
         6XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791806802; x=1792411602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGD6iaaJXJ3iIdLAE1x/VkAzNUZDtkUZz0KaCdzwHZw=;
        b=FGkHC9gIM8pOS0SHMD+u7wvyIVGSrzAin4AcwcXIDdxedk1hyE8TzEhsqd4N/1zl+H
         PYNqxJzL41ICZQGhxV9lZ1PZrd6zBKNK4Aq47uV9oeUSBLv/pA1xiGwlF7wKrNklziI6
         7oCTZ2TvfLI4Yg51d71SaigO8LnEwrEer8Y4pkzMugTkQD/Dtnu3dwo2g9ucUj6REm8S
         Gtk1zxFUqpDQxOz5Gg7M+cYDUn4cKvZ/SRwmUYS7oTXoYJ9KQKl9lz0p74/NAJzg1PCJ
         cIHTPkEkuwIZgji0klJ/pt810KVcSFCNeP2eb9m2nbMzrkAXcp+5CPSe/LWpqbCHpVNw
         2x5Q==
X-Gm-Message-State: AFq9FYIw3L1bUSivCwGBkN6Z2JtFhGnWPRTljg//awjF4NbOzr33p8bL
	JXIY6K+goj0FCsIwv4GQnxTdVQbjI9wu57+XFZy6CJt7KWGHHTQdcY4X
X-Gm-Gg: AYBFou1DGTAS49gdfJ7uIhQI39U+BFfi1qkYfWyTCGMqdovKrYeHa6hwK4Atj3wztlY
	jgPxmeEv7swXoXKfO3qKAbuKzAM1Aqy1GMcyLg+sh9IwV/toich2glQsntHYH2FvThfgPanLfg+
	3eMTapTis3peoEbaJn/OSVhAvI7Ta4wm/rbWIilEvwzuIKgZd2GN4W0O73awcaf/qbNMwqDYW+g
	W2KJH8dzNCy3QJy/935mGcWf5j+JncP6oxzcSKvb4vy++axkP5FoFCFYvb/ubOj1qFmqnyj3jLi
	hxafnTdsxsZ9y3nx8BiXR/+Ij/L5eoU2UE1e280ClWX0heQ3AJI0yl+V7ZuMql/HmZViTCAXF/W
	QvMsXp4SB55D3q/b0CXLTaweMX3rliMYXOthemTywPgvIC7pKmOfdxauhCmEcKhQ2vrTbbMd83I
	rRkfITrCNQifLL4a0rSPqHZBh6xIF83/z9wG9rFfsMV2AN1XEEqUSAffVOaLCeRAQ54amnWQ==
X-Received: by 2002:a17:90b:1dd1:b0:3a6:fec5:c179 with SMTP id 98e67ed59e1d1-3ab3ad2b1b8mr7980498a91.41.1791806802412;
        Mon, 12 Oct 2026 05:06:42 -0700 (PDT)
Received: from thangnn-ASUS.. ([2a09:bac1:7aa0:50::3cf:23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3abdd5d09aesm6160087a91.7.2026.10.12.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:06:41 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: axboe@kernel.dk,
	willy@infradead.org,
	jack@suse.cz,
	akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v2] mm/filemap: annotate lockless reads of mapping->nrpages
Date: Mon, 12 Oct 2026 19:06:36 +0700
Message-ID: <20261012120636.16106-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mapping->nrpages is updated under the i_pages lock but is read locklessly
as a cheap "anything cached?" hint, e.g. in invalidate_bdev() and
mapping_needs_writeback(). KCSAN reports the race:

  BUG: KCSAN: data-race in __filemap_add_folio / invalidate_bdev

  read-write to 0xffff8881004c4178 of 8 bytes by task 3600 on cpu 0:
   __filemap_add_folio+0x6b7/0x910 mm/filemap.c:919
   filemap_add_folio+0x1cd/0x380
   page_cache_ra_unbounded+0x1a4/0x3a0
   ...
   blkdev_read_iter+0x21e/0x2d0
  read to 0xffff8881004c4178 of 8 bytes by task 3601 on cpu 1:
   invalidate_bdev+0x25/0x70 block/bdev.c:98
   ext4_fill_super+0x2ccb/0x37b0

The same counter also races with filemap_write_and_wait_range() through
mapping_needs_writeback().

The race is benign: a stale value only makes the caller do or skip a
harmless invalidate/flush pass. Mark the two lockless readers with
data_race().

Reported-by: syzbot+e0624b5bf72b99131402@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e0624b5bf72b99131402
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
v2: Use data_race() on the two readers instead of READ_ONCE()/WRITE_ONCE()
    pairs, as suggested by Jan Kara. v1: https://lore.kernel.org/all/20261011112940.455497-1-ngocthang2710.1999@gmail.com/

 block/bdev.c | 3 ++-
 mm/filemap.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..233750f87e6d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -95,7 +95,8 @@ void invalidate_bdev(struct block_device *bdev)
 {
 	struct address_space *mapping = bdev->bd_mapping;
 
-	if (mapping->nrpages) {
+	/* Lockless hint; a stale value only costs or skips a harmless pass */
+	if (data_race(mapping->nrpages)) {
 		invalidate_bh_lrus();
 		lru_add_drain_all();	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f55..4c9d98efb7fb 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -631,7 +631,8 @@ EXPORT_SYMBOL(filemap_fdatawait_keep_errors);
 /* Returns true if writeback might be needed or already in progress. */
 static bool mapping_needs_writeback(struct address_space *mapping)
 {
-	return mapping->nrpages;
+	/* Lockless hint; a stale value is harmless */
+	return data_race(mapping->nrpages);
 }
 
 bool filemap_range_has_writeback(struct address_space *mapping,
-- 
2.43.0

