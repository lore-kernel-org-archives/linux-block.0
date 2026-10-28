Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205865;
	b=FSHSm2hNgCLNhoZsW+GTrvWL6EArpSNwWy/SHSe1g7nfGNGc5906NxvIN+uoqyqCdGOJ
	 EaqHOFOPK7d1ene+I9n79zBJDVuE70G0OZXhIzpeTXr1JUrqziyeMQ7SefztI08/1BWUO
	 vk5of+OqpsSOrvog7it77TzkCEAC08Zn+AD+DOyWNIw2VaU7FyDGjibPeQCDwqJpn/eEP
	 zp9hoUBpQOvC9ELLhiB3VTTkljAYTEFu48LJ6qgMuT9WjUal9pL6sxG1aARBrG1QzZ1Yf
	 sJn/oy8/zkO7POSIqez/nsLGuTZPCgktNJk3Er6JfVwzXawGbU09GGF4dxSjJsB7oNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TYDrW3BwijnM9IWoFVsI9Vw1jKjR1H3E9YiykFpTIvQ=;
	b=Q6nHQPXjq/uo09a6LUg8ir8dcLOl/1e0/cW9CfS5CMx+iRvNhO+z/A6PKD9CBsbxIUnu
	 rPJwLjkl1AX2AXIEamib0LGKbCPLBIcB/b//aXIErRAnfY9x2CKMTrUoYj1FEzvmdkSFT
	 tWKs9jYcNzMIbKVa7cAQRTWOUzXGm7uf/RIzXEmj1juRJ6QJj+qBJc13jjqoLMayGGigd
	 amtuM6mhFW445WE3FIgEICP9g/LR6w5awFIsxJQRVMdmkjX7YWQ4ABDlFrguZonOVuY/z
	 +H/O271PE7lInGri0z34njhIyTvO6RBpvBhbdfRKywPEzFem26CZ1tz6fCKLEZUOcOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Y6EoFd9f;
	arc=none smtp.remote-ip=209.85.210.50
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8567E606A31D
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8567E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Y6EoFd9f
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-8446af403b5so751216a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205863; x=1793810663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYDrW3BwijnM9IWoFVsI9Vw1jKjR1H3E9YiykFpTIvQ=;
        b=Y6EoFd9f23jTlRNEAYx7fsDEjUX4ojHfa53ikdVsKdN13+D0ERPo/Yx2ozv33o4lZl
         uXZIhsswXg6NbnYRTMXxEe/RMwKIvOjcLE4y1FYGHpwzGUZs/bUiWwEKtlT7rUZASdC4
         4QiW82F9o/I+4LT2Cok1QRZ17bA1oDq3sLp6NjV1zY/d15EXhJN9PRisxS+CINCDb3qz
         /xsbMns8ZbeIW0uDQBDSzrlD/dKWIXYoMgb7UBhqlC3PSORDdy4HYWs9WB9pgFp+S82P
         SpkzgbtZOdJfKYwlosffzhCOpJUnF38O++J5xhbi/ztyReW5M19bLOpmMEuvkf9qDJ/+
         2XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205863; x=1793810663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYDrW3BwijnM9IWoFVsI9Vw1jKjR1H3E9YiykFpTIvQ=;
        b=2MUp9J/JBwbzwLXoAGX9KcdorKJfDzrI6462+kQRD9zHShw78/ltt/Hffdiks38WrF
         hRvU6u3t5LGqbitv1rIybhhAoO8A+5IPwORnaDP5v2njXv+oHn/udzPsV8YBvv76rM7w
         ANbNPPPIlybRjKSP8C5JlCgZuZY47B5b8w3SoeBK4sFl3lnjyAugnLYO/99hYYS5k8TH
         tyTx0Naq8tt8cOS3RzhcnRzHWNSa2o1xijgV509fXK8NpoRqpVEsXGIm0XMOmoSehKn2
         oMcXNOKnamjc4pCIPuTbzq0SV0M8G42MxFYeukL2s3pw6GCbpdMo+HtTlDRKb3STR8Ll
         FBow==
X-Gm-Message-State: AFq9FYLBTYPOJoHWG5uWv81sSdkR+XCCI/a3KhN5JJXuFe5ZAHBl74n1
	qDaGHrbI2Z7jg93bTbkY6HTI/s+MAHsTLd2S1ra+PFfCuUugme1rbkirG46iC40E0FpP6BFF6qA
	SjYQBPRA=
X-Gm-Gg: AYBFou1E37W+qv1kMCdE46sgoxt7DEeRVqGcm513eAg5sf2REG6PWMQ3qqs8fCMmd5Z
	osb/e4l6Ko6g8wy9VmyyXJsUGlybAW8qPd/QJIbqaL/3fQno7YTAymTGenS6yD1LmQZxt0sveph
	8MZq/pQv1OB5CKiM9BcRIgwsNUEvVmI51CeQdSlgkTn2rwj65XY4kGV+YEd3rEjYWmdV9hpIWz/
	PV1G0KBIHrNFMxHUyVHQ8oPd8lxFcwv/D+ixzjPBY1rgIGz8cC+qF0yT6L62p8bWB3UUgoyxCux
	bBGoYyBuymkBqWdOUKatgSylZGhIndlqdvwyez5dXUGURATAYmneKMNCUxmDfYOEGibGBp0EyR5
	lDbe1sIoC1XMGC8ToONNCLagPvLPIpArhD7lXnKo52v0IIjkWW0owyHmRd6ho1tM/9qCuZZhclO
	b600PvaZm9xuITHtJo38AU8hH7bIv2Q5tDjTt7snf40zOqgWdpTvpKB/07E4uplUcIVML2gh7RL
	vxJT6U7O6q1HeAsjUn4R6KzZlvd95isIaI7tvg/oeNKYNCMZHYDdVwXjWShPjDnJ+wo+AA/dl5N
	FT9zpdMi59t9k1mABiwMLBdkvcw8fvaVX+7xXtaYKBPSJy3ztJmxKnvp7Zf7uMTL0CeGeZ7Q0A=
	=
X-Received: by 2002:a05:6830:310d:b0:80c:4d85:9aae with SMTP id 46e09a7af769-85ab7637231mr3844163a34.15.1793205863555;
        Wed, 28 Oct 2026 09:44:23 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/98] block: fix use-after-free of the disk in sync_bdevs()
Date: Wed, 28 Oct 2026 10:41:07 -0600
Message-ID: <20261028164415.1262013-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

sync_bdevs() holds a reference to the bdev inode while it takes
bd_disk->open_mutex. For a partition the inode doesn't keep the gendisk
alive, the device reference does: part_release() drops the disk as soon
as the last reference to the partition device is gone. A sync(2) racing
with the last close of a partition of an already deleted disk locks a
freed open_mutex.

Take a device reference before touching the disk, like
blkdev_get_no_open() does, and skip the bdev if it's on its way out.

Fixes: a8698707a183 ("block: move bd_mutex to struct gendisk")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/bdev.c b/block/bdev.c
index fac74319e9fb..cc35126e483d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1366,6 +1366,15 @@ void sync_bdevs(bool wait)
 		old_inode = inode;
 		bdev = I_BDEV(inode);
 
+		/*
+		 * The inode does not keep the gendisk of a partition alive, the
+		 * device does.
+		 */
+		if (!kobject_get_unless_zero(&bdev->bd_device.kobj)) {
+			spin_lock(&blockdev_superblock->s_inode_list_lock);
+			continue;
+		}
+
 		mutex_lock(&bdev->bd_disk->open_mutex);
 		if (!atomic_read(&bdev->bd_openers)) {
 			; /* skip */
@@ -1381,6 +1390,7 @@ void sync_bdevs(bool wait)
 			filemap_fdatawrite(inode->i_mapping);
 		}
 		mutex_unlock(&bdev->bd_disk->open_mutex);
+		put_device(&bdev->bd_device);
 
 		spin_lock(&blockdev_superblock->s_inode_list_lock);
 	}
-- 
2.56.0

