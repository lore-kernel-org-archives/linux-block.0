Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7378E3A9623
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 10:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774954307; cv=none; b=fF3Lc9+zCHRCFhYQVQsYrJK7Ei1Vtf7TKKlyY9M8yzr/frZQ+32balB2RDFPlU/+AkecfD5xr8ILWDNElzyUOdLLN2Fq4+mOlSHBw0DCbghr7uiS7ESRN2I0trzhEHhDcBwN3xrsxkz8TNLwND5bdrC7cD2+WPKrlM+eRb7h4ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774954307; c=relaxed/simple;
	bh=logZAmhEwKcXhJIQh9W417rKWh6dBrA0tEo887f+GGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbiZYMJHKKG0Eh+nfyyUAITkf5+ar1NmdLOReUQqvF5HII5uzFPqfOQX3uLaDdS25aVfaq3wPKUCkqWaewjjeJUANZTl/ZgiqLCTSVwClX12DDRly08VQv8SmxOetckcFW6bkEiR+oK56uUsx07tcT6uZh627kNMOsG72LqGS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roi9lNdY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roi9lNdY"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso46013725e9.3
        for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 03:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774954305; x=1775559105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2myqE94HaK/hO6S/5AS19OPX8YCgfFlLAfMjQvqgXEw=;
        b=roi9lNdY9Xd8vqm5QrKSdOwk+YkjiuCwVPcWgwEZxUgHDXm/41EFvdvFS6OqT8lq7g
         XxlbtqpOD0aPbfjEI3T5eURKJsIjt/nbopP7QYcyrOFEt/s1uCLTZugghSlldmrNUHmX
         RJUmMUipHjitsykDq4ciBFCaxSjhgDb8a8zOUOqgnVeNZXePNbOLXcEcZaMi44K1NUG5
         rZRqI6Gew+0IMyZZODwUkEsro7RedHlHfHOpwDXzSC1lKA9p8ZVzJEmOLuTix8vY1QXK
         SHd81ef9V0z5/thKbVxuwbAyycpn7vQEkWfhpAXI9D95z7evJjFedq2RaOU0VF78cSDB
         q6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774954305; x=1775559105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2myqE94HaK/hO6S/5AS19OPX8YCgfFlLAfMjQvqgXEw=;
        b=RwUm+kv4QnnFdvoI/UkZ+Ev5VbrtKpPIE5FyfdGwL44KARK/cp4lrs0XGEjLFGcRN1
         +U5Rz5qka9h484nWQbfKBlepVyxwnxrxbLVzUJgzUKx+8+1CsLGuYeVdzMBoPQOb6D6P
         gkSbWCXh+FJDafSrWrO99F3Wv82FZggxJYVDhGmTgPO/qol/aK9BvDt3eL7fphvBPic0
         ghzhtJCCAouK+S5kwnV1Y2uGrpnXi/qf4JvSA5RinKBqrDCYIYAQHqydoeDqUNT8h9lY
         dlB/5RUj69YYLiAO6jiVYsHYirdV7SP8bjNy9ivrPiW2umsUiyPEhLimVe4ABDZx5yDs
         8s4Q==
X-Gm-Message-State: AOJu0YwQg4mXmzAO0/mV/qi2xGTxMpmJVuq8HkvJLrHBsuUCPmN2V6Zh
	9cogSDerB8HbwS7AKuKef/lUtsSnIscpD79SHBt+3Q26xs1Ie6hDSy27D2wTRQ48
X-Gm-Gg: ATEYQzwH/ihjYf9K1RFwUOrtoMcAmm5VtK9pTvJdVOEMnQG0MMkrfdshJlxbOk6Kwsv
	is4IWgpJza9oUHuwdJ4xeIGb3bXgodT874d6+YJNLK4IWjhbW22tf8+Rv/8qZ78XVag/I2wXeSv
	aZveQb0ivu7fD4cDTXq2yJEe7ZSZJxiHrfZsTWLqJl3qfrllnGDHbSNr4WYJmpydp7sGnQeL5v/
	7qlFRWJes7/JDAcVbmnpqvNOYsRhwU3LptBKzGsxBukrJd7QZPPTX3DFHV2e/LnoCgTotcVza5i
	G6c1GEZRHReYid4CBOSY2Gsp62FEAebOYpmFkB50J/tm2OZvuO1DrJVCT/vPCfRnhQhs3zCioCV
	DlwAeZmj/z3GFhBl7Zg5Axiu/L3t7uxtoOvirKPS0a17w+EJyAb29FN0kUMg2u/0WNhtFXO/2pu
	JepGXbMbCc8mqTBTJnuTmGB9M8H7+AXqOpAR2IwgWiKvYi31Zm0rxHcWdDvRLcyC7fuNwcM0YRb
	ylWuEQDwu5BL2cRlttD8ZAQ25DwWkkL3hBQPWwGg6eWpsoCuaUxo9dKb+y45TBUMq3vDzi0XDT8
	wlVurDbQVcFOEeak2KRe
X-Received: by 2002:a05:600c:3505:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-48727c7c6e0mr238604425e9.0.1774954304140;
        Tue, 31 Mar 2026 03:51:44 -0700 (PDT)
Received: from particle-0df3-d360 (2a02-1810-950a-eb00-f9cf-2393-cb7f-6fd9.ip6.access.telenet.be. [2a02:1810:950a:eb00:f9cf:2393:cb7f:6fd9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm24706635e9.12.2026.03.31.03.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 03:51:43 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
X-Google-Original-From: Daan De Meyer <daan@amutable.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	hch@infradead.org,
	Daan De Meyer <daan@amutable.com>
Subject: [PATCH v3 1/3] loop: fix partition scan race between udev and loop_reread_partitions()
Date: Tue, 31 Mar 2026 10:51:28 +0000
Message-ID: <20260331105130.1077599-1-daan@amutable.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When LOOP_CONFIGURE is called with LO_FLAGS_PARTSCAN, the following
sequence occurs:

  1. disk_force_media_change() sets GD_NEED_PART_SCAN
  2. Uevent suppression is lifted and a KOBJ_CHANGE uevent is sent
  3. loop_global_unlock() releases the lock
  4. loop_reread_partitions() calls bdev_disk_changed() to scan

There is a race between steps 2 and 4: when udev receives the uevent
and opens the device before loop_reread_partitions() runs,
blkdev_get_whole() in bdev.c sees GD_NEED_PART_SCAN set and calls
bdev_disk_changed() for a first scan. Then loop_reread_partitions()
does a second scan. The open_mutex serializes these two scans, but
does not prevent both from running.

The second scan in bdev_disk_changed() drops all partition devices
from the first scan (via blk_drop_partitions()) before re-adding
them, causing partition block devices to briefly disappear. This
breaks any systemd unit with BindsTo= on the partition device: systemd
observes the device going dead, fails the dependent units, and does
not retry them when the device reappears.

Fix this by removing the GD_NEED_PART_SCAN set from
disk_force_media_change() entirely. None of the current callers need
the lazy on-open partition scan triggered by this flag:

  - floppy: sets GENHD_FL_NO_PART, so disk_has_partscan() is always
    false and GD_NEED_PART_SCAN has no effect.
  - loop (loop_configure, loop_change_fd): when LO_FLAGS_PARTSCAN is
    set, loop_reread_partitions() performs an explicit scan. When not
    set, GD_SUPPRESS_PART_SCAN prevents the lazy scan path.
  - loop (__loop_clr_fd): calls bdev_disk_changed() explicitly if
    LO_FLAGS_PARTSCAN is set.
  - nbd (nbd_clear_sock_ioctl): capacity is set to zero immediately
    after; nbd manages GD_NEED_PART_SCAN explicitly elsewhere.

With GD_NEED_PART_SCAN no longer set by disk_force_media_change(),
udev opening the loop device after the uevent no longer triggers a
redundant scan in blkdev_get_whole(), and only the single explicit
scan from loop_reread_partitions() runs.

A regression test for this bug has been submitted to blktests:
https://github.com/linux-blktests/blktests/pull/240.

Fixes: 9f65c489b68d ("loop: raise media_change event")
Signed-off-by: Daan De Meyer <daan@amutable.com>
---
 block/disk-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index 9f9f9f8a2d6b..074731ecc3d2 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -290,13 +290,14 @@ EXPORT_SYMBOL(disk_check_media_change);
  * Should be called when the media changes for @disk.  Generates a uevent
  * and attempts to free all dentries and inodes and invalidates all block
  * device page cache entries in that case.
+ *
+ * Callers that need a partition re-scan should arrange for one explicitly.
  */
 void disk_force_media_change(struct gendisk *disk)
 {
 	disk_event_uevent(disk, DISK_EVENT_MEDIA_CHANGE);
 	inc_diskseq(disk);
 	bdev_mark_dead(disk->part0, true);
-	set_bit(GD_NEED_PART_SCAN, &disk->state);
 }
 EXPORT_SYMBOL_GPL(disk_force_media_change);
 
-- 
2.53.0

