Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F23BED7D
	for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 11:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868642; cv=none; b=Y5VXKRu+jO0dqES51azb8h4fGHOVf9SCW8jKPqKZUhjVQzOo3lFRi+dSpDBW4xyL+MnAFbQWDVL4Me9fD41mJkKO8CfTCxKpSchH1LdoISDznIvYySaW7rgY5lZi5XpaRgKUzrC8lBa53v1bKfd/a3Pkws6T3aAqdMwESQtwEVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868642; c=relaxed/simple;
	bh=0lqwVC1HIgt2opSItuicncR4ft5/y7a61Vfkp9tZ0qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKsCwMfVn7KUcp51i/5hMQtX6JcDlCi2velwS3crLWj/Gfmj6iAsOPFI5TUF6d436+eBSzTtCha66k4Xqey9OoDHuJlqsbdxTLINKsRV4G+uFBkEYlLK1CerdPvCXE5Ktl/a9q7XxkkA3WCYmk7GcBfDjp13yqmlAajNkz951kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTTDdEdM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTTDdEdM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fb439299so39494085e9.0
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2026 04:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774868634; x=1775473434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbB7+wEg8oN0RjFk4pVX0frZsh3Ewm3r7Nox/AIsRDk=;
        b=MTTDdEdMv5aDGwFGAEPaIxVPBfjE/Qkd9xjuoX1KF/e7RKSOWk4v0YyooAxzMopvY/
         ofZVdspSpk3OGAx8TXbIKkDDc1bzs3b16a0z96azeFsyMZ6gmLsGalKzASWP2zjUpEda
         ZwXBa4lXUm0QIyFOC3UJXr6JT4Z9wALQQN3wsIPuXP6fctJ8R/veuxdaB/xHbsfKE7M/
         2TqdElkYuLFYOuCjnJxj3DxI6gBKR4HtvcwPxvirykecJRA7kYjc11v+anbhesfGAKYK
         5Ms028FLzKW6Mki5uoHqMf1UHa7GwoGNx2KG2SZK4A5IVxH6+pFNYP5IcQBYnjMBSlFG
         tPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868634; x=1775473434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vbB7+wEg8oN0RjFk4pVX0frZsh3Ewm3r7Nox/AIsRDk=;
        b=cUgYHxWMg/gEeWTblidham/X2iICIKEk5e4rM1u7yTCd1Jp3dffGoRI9XHBFVk5NML
         /Lz+KEoyZq2bHzlCPpJSjvB6fYO8TCX8Vu6ZmWq7VdVTSAH4l8t+DoD+wXA146/siFD2
         /RkSOSH6QJeltB69i1aW721ptWUHXUT/7ej9c7nrL41cagfpxYeBZL6+GajBDEZyZAsE
         qG64fmun82uJypP+G+THoxzm6FLCaJ/04nHeyp8fQxkzt4O1a6qR0jjiIPdg4v/SDTaJ
         aPvGyEFb0aVL+ASIFWEwA6oUH2SnDaSNinCi6BrYxLXAyDo2Q64N1bHw+kxtuzQi7We4
         8nag==
X-Gm-Message-State: AOJu0Yyng417HchvjxKiBYta7R/LY0xPq8JoyW+i/ggCzSLHvSe0adQi
	GVrRyUEruu8bbQu/T+eGszr9h1VzVPALixNeA07kx8/foh+PuDFo36uAfEkqpw==
X-Gm-Gg: ATEYQzzhDYKqncgF6Nvj6ujr9GlzLXIjMwTIMRtg/NhUkHpLgxdogg889+vL3h5OMXP
	2GklvkpxlrovpdDmW3aD0xvCL4d58E+qXT0qJUYKjwfaEUrETkxkFULTKE8mQb7QbbwYlynCeBf
	xEwtOHcID8+MBwzE4vb/qOW9oDtChbgYpv1WZFxHSpiX0rtrKY4nQICpnA5YmCdj29uUys+lAu1
	zqzIR+yEGHe2OreILRBS5y88dow09dX98rwrsea+s1WriV6SOhwpBj6NGMwu4PAGjyMCFXg40pV
	KkLBfwBfdsdmUITCuE3JWMnEnqKaPeJF49mn0+KIogqWWKkO3EeOkA6USRJayGRxiaNWDIHyRte
	t5evMpFgRS7Ne9j4I0LnPed6LH6c7YuSRXd/QV9mrCyqOk0N+RV5Gz+lm/rcPnOs75pDW8J4TDZ
	ogBBgF1Qtq0y365sAAlLZJd2L2QglWEDTQsI1eLe4s6gxnpagbisp0ytqqlcF5sPufmHT+7PAzC
	pFvTD5+GrJcaOfJstptHf8Cats/KG7GLdilwX2brkiFrd+sHSbckSbyvNJJZNFA0p6b5VvxliNT
	LkS3mcKPkEzb9Q/wd/Yhxo7/yZBSwow=
X-Received: by 2002:a05:600d:e:b0:485:5812:bb9e with SMTP id 5b1f17b1804b1-48727d31801mr178115695e9.0.1774868634168;
        Mon, 30 Mar 2026 04:03:54 -0700 (PDT)
Received: from particle-0df3-d360 (2a02-1810-950a-eb00-f9cf-2393-cb7f-6fd9.ip6.access.telenet.be. [2a02:1810:950a:eb00:f9cf:2393:cb7f:6fd9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48725d9bca0sm79067425e9.2.2026.03.30.04.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:03:53 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
X-Google-Original-From: Daan De Meyer <daan@amutable.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	brauner@kernel.org,
	Daan De Meyer <daan@amutable.com>
Subject: [PATCH v2] loop: fix partition scan race between udev and loop_reread_partitions()
Date: Mon, 30 Mar 2026 11:03:10 +0000
Message-ID: <20260330110310.692144-1-daan@amutable.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330081819.652890-1-daan@amutable.com>
References: <20260330081819.652890-1-daan@amutable.com>
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

Fixes: 9f65c489b68d ("loop: raise media_change event")
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

