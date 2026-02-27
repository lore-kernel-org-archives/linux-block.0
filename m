Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B2136F414
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180510; cv=none; b=YJ3X1XRquEGOihGPWfo9k02CkGQdj8uxOkAC4A4zr4G7HgxP5mI51xi+5g6tHdKdNJdPMUULpVf4mxGeWRPSpiKCixGQjPZSERi5htZf8G4eO/Rzt6J7uINsImT93Pdbx7whkbdWUHxsJOgUf5Q/nz6LTwurFybey6uOdsHGfUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180510; c=relaxed/simple;
	bh=S+KOjpvrklh68zt1GathuTVw/1qRliOtsdPhXBFrCAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k45A8dHqJ6dvYPQNClKId3xiD/pUhAsjrWSfytVjSSegAAL3rhchyeN+wW4hZ9H7OBskovaCUn4uvOrGLzJHzCeuAxMYfpls95RmpqUyKG/GFa0sM9OBO9wEwVkAt034/Zp/oDkj2tULNxbpHTyMF4mocUq+lsf7+v/+w0R779E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Or5iyYZB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Or5iyYZB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9f2ee29aso10972635ad.1
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 00:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772180508; x=1772785308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3yf5ARvnDjqHtotIsjeKl4n8R0v3XhJ9293+3JNQB0=;
        b=Or5iyYZB5twUeGR1/x4ysy3fNf8wRF5stNFhkosAJ3SdEuHUb45atnOcZMbgCW/h1Y
         eN8xfjCor+n6/hoei5QWt6ryk+lbRewEjh2jCQNFtXW/G2nM7BJ0du1lVmSKuH6+vAOD
         qvioENEc//bUByfRlxm/s8kMpQ3R9/fLiYjWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772180508; x=1772785308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f3yf5ARvnDjqHtotIsjeKl4n8R0v3XhJ9293+3JNQB0=;
        b=s1HKHvqyVJ0QoQiwbNjly3vF6ZvPFg9omDMafMe4GXE61A7ExL22iMJWPyW9WfWroS
         HhzLeGTv/kDXxdvmdF2AxmAOl2RXmDBJcIo4u05gn4UzO1MFZDlh7reaf6SJd1Fko66Y
         zmy34z+pRh1Hc9xyFZ9ADhnTV2Hxkn3q/yhuE9TAS/5DuH/1zA0RL/X5qXoIW6r8ZO5f
         o+15zP5Zp742eNne5D865J9uSNtH9KcQXZ2mIQfCqcSFIdRp2W+zpcQIQoGpPqYs/qzH
         QNXMf9SCAQV00JtPXebbYXlZ4GiqUQ5+unyZoyidccrwZJOG8II/PkED/lHqnhZktiT2
         bElA==
X-Forwarded-Encrypted: i=1; AJvYcCV/tS19QdfJ2AXhLv9ElwrwZFXdhfK+T36VDkQnVAhIXYBb/R3hJ1TQbI+/B1yAl5RTY6YtND/GNzAZ0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ0aevk0gFi9V6U77e6wEhyDgnxZkjZW2zKCFK4SbJ26y/CLJg
	suYxtCTdMDVCAV8FQ+0TndnbkMgrsj2Zg1wsu4cV+dLx3abCDllgIkX5y+GH2j+IPQ==
X-Gm-Gg: ATEYQzyDnIDR08ov/Kr1KYi1N/S+ps2FS97TPVxLHdf9jvagQ9r63n3ZoIJqXiOGyDa
	QXhUG5zvt9hecu50/f39inmzkSXZL9FE4CCzbbKKYoVJVzCVWgDuOtNh9NVQcZ2qdULzAvV9Cq4
	+WED1Mdv1x0VpMkpQCab8Oq64QS93/jkQr2qc08Mj0w+79Kb98/gqle7W3M/pbepqJ6aNE0CqWa
	oAuLZeP7Pqzj30jaUsqGtgO/MhmVKP8w/Kp7FvB6DM/cRhYDmjWcyQnw5FRzwLodv3BVva4Gxaz
	Q5N6XWf8vRWIduGLW8M/wVR/kh7KDXTMC4OA62isZNVox1+nnVx/ZHLCA91vqVB7TlmW0R918uj
	8s3q6uibJ87mqAwaMcFlw31NMgiRT7lqXzWLs7U8kYwAyu3UPglsl8QiU+4dXU6kp7GDBV/eXI1
	Cnc6NsGwpnZiOJZ7DqYHMOWVKiAlr2rcaoe2R11eKl8GUdqyoWJHx+Xo5G2XLM8E3RcntR3LBKU
	P4twIMzz/cvxw==
X-Received: by 2002:a17:902:ce11:b0:2ad:c337:5a32 with SMTP id d9443c01a7336-2ae2e4b0d31mr18520555ad.28.1772180508256;
        Fri, 27 Feb 2026 00:21:48 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:280f:e47e:6718:7698])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69fa4fsm48796025ad.45.2026.02.27.00.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 00:21:47 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Brian Geffon <bgeffon@google.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 2/5] zram: drop ->num_active_comps
Date: Fri, 27 Feb 2026 17:21:08 +0900
Message-ID: <eb7cd3ca578320be9aff13e71298fc36e110af41.1772180459.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
In-Reply-To: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
References: <8a5d53d19a8dbd51d7d81d153676895163e0735e.1772180459.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's not entirely correct to use ->num_active_comps for
max-prio limit, as ->num_active_comps just tells the
number of configured algorithms, not the max configured
priority.  For instance, in the following theoretical
example:

    [lz4] [nil] [nil] [deflate]

->num_active_comps is 2, while the actual max-prio is 3.

Drop ->num_active_comps and use ZRAM_MAX_COMPS instead.

Suggested-by: Minchan Kim <minchan@kernel.org>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 29 ++++++++++++++++-------------
 drivers/block/zram/zram_drv.h |  1 -
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 53e0bbf9d6ec..6ca5a76c3865 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2371,6 +2371,18 @@ static int scan_slots_for_recompress(struct zram *zram, u32 mode, u32 prio_max,
 	return 0;
 }
 
+static bool highest_priority_algorithm(struct zram *zram, u32 prio)
+{
+	u32 p;
+
+	for (p = prio + 1; p < ZRAM_MAX_COMPS; p++) {
+		if (zram->comp_algs[p])
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * This function will decompress (unless it's ZRAM_HUGE) the page and then
  * attempt to compress it using provided compression algorithm priority
@@ -2478,12 +2490,11 @@ static int recompress_slot(struct zram *zram, u32 index, struct page *page,
 		 * Secondary algorithms failed to re-compress the page
 		 * in a way that would save memory.
 		 *
-		 * Mark the object incompressible if the max-priority
-		 * algorithm couldn't re-compress it.
+		 * Mark the object incompressible if the max-priority (the
+		 * last configured one) algorithm couldn't re-compress it.
 		 */
-		if (prio < zram->num_active_comps)
-			return 0;
-		set_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
+		if (highest_priority_algorithm(zram, prio))
+			set_slot_flag(zram, index, ZRAM_INCOMPRESSIBLE);
 		return 0;
 	}
 
@@ -2615,12 +2626,6 @@ static ssize_t recompress_store(struct device *dev,
 		}
 	}
 
-	prio_max = min(prio_max, (u32)zram->num_active_comps);
-	if (prio >= prio_max) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	if (prio < ZRAM_SECONDARY_COMP || prio >= ZRAM_MAX_COMPS) {
 		ret = -EINVAL;
 		goto out;
@@ -2833,7 +2838,6 @@ static void zram_destroy_comps(struct zram *zram)
 		if (!comp)
 			continue;
 		zcomp_destroy(comp);
-		zram->num_active_comps--;
 	}
 
 	for (prio = ZRAM_PRIMARY_COMP; prio < ZRAM_MAX_COMPS; prio++)
@@ -2898,7 +2902,6 @@ static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
 		}
 
 		zram->comps[prio] = comp;
-		zram->num_active_comps++;
 	}
 	zram->disksize = disksize;
 	set_capacity_and_notify(zram->disk, zram->disksize >> SECTOR_SHIFT);
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index f0de8f8218f5..08d1774c15db 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -125,7 +125,6 @@ struct zram {
 	 */
 	u64 disksize;	/* bytes */
 	const char *comp_algs[ZRAM_MAX_COMPS];
-	s8 num_active_comps;
 	/*
 	 * zram is claimed so open request will be failed
 	 */
-- 
2.53.0.473.g4a7958ca14-goog

