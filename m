Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09EC37FF4B
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 08:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774858742; cv=none; b=o/6ov5VOzBlg2oibdBgxfXso6bUITFcLnBp5fYjbCNTEujcc+mLMVryplxaN5sksZk31QA23dgrYK0gKLqH9mlTHJsIWChFbsV3QY/InAB4YG3A/OMgLXL0ZptBVD7CFwTjbQwYCdk+9h7oJZ49Cab9+ayzqfu73kY4xwGEkXNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774858742; c=relaxed/simple;
	bh=ZFNujjaoOl2prujahBdPwwySXfdMDd2jVP8PgDzj2QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFHMceYH1Wm9TrGeoPwhZ4aXlUzx5bVWWe36WaV1v7v/RDVZI++zhoNxu9wD+bALWz8Xe1DGbErMuKsIwrSvf7dywvNZQ+vgSeVpUzShr9I3PHwi+T44VSZe0dPrSJrv47+yiFen7OeENgjckseafGQnCMmFD1m3wlnMdXgxbbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLgBJ5qv; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLgBJ5qv"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b41b545d9so4555304f8f.2
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774858739; x=1775463539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ibGw6P9CdQJBAs5AxiPP4aAb/wVjlTjeT0sG2XRzbuU=;
        b=OLgBJ5qvG4XMmJDqWzM9T6JG5Ptp/VoKURwmS8mbT/JMmEIJJufTTvGND7PJ6jUk/6
         xnpKvZJXFVrBFLQTOPfcsGNk+cKvUJOvSWGiYzO54OV45vzZzsm1iozlY011W6k6JicI
         ZV55kqx53H2Eic+SE6o9xrC7OGaeqk+KJvulCihX8YviI7/TNBWIbkusi3jLkzzdntwQ
         zs/2mhZES/icMS46cK/OOnY7QyWsUyRzyv0f5UXAG2RIS6EoGNQHkYzY8LgwGnWj4fEA
         eoco1ACQQL4lqEhfckYeOir7drIqIrlx+EtEWdDO+pf29he+cOkeO4YeSV1bkU9PcnYG
         XceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774858739; x=1775463539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibGw6P9CdQJBAs5AxiPP4aAb/wVjlTjeT0sG2XRzbuU=;
        b=KkIXAOxvAwKR5+luCdzCCXMlT0Xq2ljosZhCgZAw564XYL7d1t63nbVtvIcf0cklRu
         RZIXU2hDEGGoSrfWM8qy8oqcGn2QcWiAgVwJ+3Lle7YP0WwqYSfYpKwy6LdTZvVqtF2T
         etdJVdckjzg/Kv5dzMNtgIv/U9SKbPFBLOMR6sD8WgNZxVzRCHpncvSry0jMN2YeB/vM
         0VS7I+gBCpho4jXDH9F8U18kUkoYAnszAz9RSUaib0O8Io3+Pk0rxYz2HebgqDNOZsbv
         1d/Qi1npJtEJPGJlG2W1kyRrveBQ8rM7heBci1nLvgBc4oSizr8RbxDVV4lHTD5EILgb
         tAkg==
X-Gm-Message-State: AOJu0YxwowLvISLNmFtJBaTTvu2E0b4TyLGlbv012W85gHH1OVu0ntiU
	01DoFo1OxJpnm4D6pvlUX3XaD0pr0sSLudvapGAWMlGsFGmR1xOK4zrIhw84vQ==
X-Gm-Gg: ATEYQzwiAWcOnFnqoZazWkh+AecSdvt48DtbgywMBMaOxBHI5SLjU6yH9M8rdycFUG0
	Oq8Tv3REvzuj2j/pU1r/uoqNk8+IQ4n97fiLe6Lvk80vHgYx4SgtMuePqw8sm/LUV6zKcEhRvj4
	FwLWC0hhCj8b/WOh2kJsXhC9F6hOgt0QUVgQframjB7lLl4dK+HrZ8rvc2knBjIoRdu5EA9ou3x
	7/0m2vx2yhKO7NDzvC7bWKbuf31403Zhuac++YMCaBunyunA6y+1rXe3ehaHtrXqjEHdFP1UwqC
	sd/qj3rjstm2ieIviBBnx+7gTaOUzXuNCI1pfx2g1KBKXEPdW2BncXsxoV4mtiZGJ1PnGdC+Ov1
	Njyu1DKzjcx5WD4xS4P8orcsJ36TPXlwis5gzbnGYAp8BEEfTRR1vqPPcrSXL4j/Mpjaohn8AtD
	2zDZI3+OWu2ef3XBYLLKPSvMHoZG3rcp+nfJFRIg1alZ9tvKTNxrO5jOH8au5J2AuKw8EMIYJ/H
	/3bk+d3T6Pr8tgO0RoPG47qDf8xh11u5Eexgn/LMoRbHaaR5c+RD6vl9vw6F1YmX9LvHFjmgh2U
	//SOqE28IrxGs7N/W7d5
X-Received: by 2002:a05:6000:2681:b0:439:b623:a9e9 with SMTP id ffacd0b85a97d-43b9e9ea811mr17563290f8f.19.1774858738396;
        Mon, 30 Mar 2026 01:18:58 -0700 (PDT)
Received: from particle-0df3-d360 (2a02-1810-950a-eb00-f9cf-2393-cb7f-6fd9.ip6.access.telenet.be. [2a02:1810:950a:eb00:f9cf:2393:cb7f:6fd9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2580194sm15938747f8f.37.2026.03.30.01.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:18:57 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
X-Google-Original-From: Daan De Meyer <daan@amutable.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	Daan De Meyer <daan@amutable.com>
Subject: [PATCH] loop: fix partition scan race between udev and loop_reread_partitions()
Date: Mon, 30 Mar 2026 08:18:19 +0000
Message-ID: <20260330081819.652890-1-daan@amutable.com>
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

Fix this by clearing GD_NEED_PART_SCAN before sending the uevent when
LO_FLAGS_PARTSCAN is set. Since loop_reread_partitions() will perform
the authoritative partition scan, the lazy on-open scan triggered by
GD_NEED_PART_SCAN is redundant. With the flag cleared, udev opening
the device no longer triggers a scan in blkdev_get_whole(), and only
the single explicit scan from loop_reread_partitions() runs.

When LO_FLAGS_PARTSCAN is not set, GD_NEED_PART_SCAN is left as-is
since loop_reread_partitions() will not be called and GD_SUPPRESS_PART_SCAN
remains set, preventing the lazy scan path from triggering anyway.

Signed-off-by: Daan De Meyer <daan@amutable.com>
---
 drivers/block/loop.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 0000913f7efc..4e87d65c45e0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1085,9 +1085,25 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
-	if (partscan)
+	if (partscan) {
 		clear_bit(GD_SUPPRESS_PART_SCAN, &lo->lo_disk->state);
 
+		/*
+		 * disk_force_media_change() above sets GD_NEED_PART_SCAN to
+		 * trigger a partition scan on the next device open. However,
+		 * when LO_FLAGS_PARTSCAN is set, loop_reread_partitions() below
+		 * will do the scan explicitly. If we leave GD_NEED_PART_SCAN
+		 * set, the uevent we're about to send causes udev to open the
+		 * device, which triggers blkdev_get_whole() to scan first, and
+		 * then loop_reread_partitions() scans again. The second scan
+		 * drops all partitions from the first scan before re-adding
+		 * them, causing partition devices to briefly disappear. Clear
+		 * the flag to prevent this since loop_reread_partitions() will
+		 * handle the scan.
+		 */
+		clear_bit(GD_NEED_PART_SCAN, &lo->lo_disk->state);
+	}
+
 	dev_set_uevent_suppress(disk_to_dev(lo->lo_disk), 0);
 	kobject_uevent(&disk_to_dev(lo->lo_disk)->kobj, KOBJ_CHANGE);
 
-- 
2.53.0

