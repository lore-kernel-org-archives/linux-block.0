Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968643DB319
	for <linux-block@vger.kernel.org>; Sun, 18 Oct 2026 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295526; cv=none; b=qrnzAgiLEPS01tUdYmfX1ExynX3eAPd7wEjkL+igKQTyY39YVCvTsGM7KnC7ILkCP7WHXIIWLfd3mJudWQkZsw4rKBImRc1+/ULPuHyVa0bOk6jsxDpzKOgQrN1LX1soSh0oflISBwlJTd59WfBZIonZoXKK/RN6/rw0dGoAGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295526; c=relaxed/simple;
	bh=2L1l2WEmVkTr1X/Pc9b6FfcxdiaY29ag5fDryoDzPpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJnpCRUdOwIgvO6z9OC6wCwoCDpkqkPvwgLNKUiKAySBNQHmRBRT+xLU8e4ITMCM7aGrUD+FoVbv9zdxUsuiWG30XfoPkEfFEI/75bfWJ9zpKMEAAav/P8+xVs1uvk+q7htW5p7oPSXl960YUHUuY5RgE6adsRHs76V99HrFvCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GEtUzgK3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GEtUzgK3"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so932098a91.2
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2026 20:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792295525; x=1792900325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6B418+SzCM2Ac+ZkuhfOdHoqL+9AUQAlnO0fG1JXa14=;
        b=GEtUzgK3NQEwuOYRXTbgXpgXpcT6O3rok/7pICSBKVAwcZSfd+PVtPrJe4bhnIjNJG
         7tQAh0KBm3SFNsEAV+z8TIIerMIphmO4dlhbcuRUHA0oYYzWa6LLqvKgEY2OZbTVlKKS
         ebG3j/zbID1El1K30kDSoyo01t5728xG8sIuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295525; x=1792900325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6B418+SzCM2Ac+ZkuhfOdHoqL+9AUQAlnO0fG1JXa14=;
        b=2DiBNNU5RAfPemG1B4Pqqsxjd9zcfjf4l228hQ6R+LIXQ8573DQlgyfCsBz+Af0ANo
         J+vRIhSRXYI0YWjqQZAwLQtfhhuzUin3IzFsJ+P/agJiyHvxio2DMGX+lzV3QsPLSr/L
         KUcJ8dgvhhD1J2GiTbZRcdZBWijHnf7QT4nnxeVAf7SRWbOySRCKwPMmOZjKS3M/7Fa2
         rpiGSzbJ0FQhH/EFsfXIqsus+03+SbsL8cNqDnNMvLY+Osubw9VI81xj2p5/NHH33ros
         o5IdGor0z6GertWqIbmcnisdUmwTPT/ZE+oz7KZao0AsYwCvrG5QX4sGO89PX3XtKTdQ
         L2Pg==
X-Forwarded-Encrypted: i=1; AKwUvBzfC2C+hIX0F4Vo6xN7MlT4qfC1TtXrJZItyTyt0VCeKKLnWZPkxiT6fDg3F3+gcd9aOm2Vo1TcXTiWfg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKpUIj/RsBPwzCn1ILbdaIyYRTJlplOBu1/BKk4IsayM/6857Bb
	oKPyiNjH6PFYFzq9Xc/F1WMCPXBVLrjUtnYxrPQyRmvp6nsqFkgr3d1D2oBuyTSwGQ==
X-Gm-Gg: AYBFou05BUUKNQMQN4+EKUVWl/fIrLFsWXUuLDGiM22X7ovpn20MrrOk43uuMqvthVf
	pNAyvEdMtXxli6bwwXR+MNQiaptySQQXAejsb8q30Abnlccb1iF9LQDeybyTzW1OAZ4LnDjILiH
	Jc6nb17UYVacNbD1rRhwU+Jc/LFqtnSEGxK150lWNqfxIV6n2m8eemOWFb5z/QXPaguKAEl2M8f
	kbrKULqduR+J5wSN9msCdPRgVeXEgYyDM9S1tuxLjzk6FrwlIDJ/r6tmqXt7inH0BHkvyP0z7W2
	x0UU5EMTKnhCaqhlubSa+1Y/RJmUstzx3p52zFTKf2ZfoFB17fHIfQHOnESJP3U7U/tR1FXAR6F
	E0XaIagSm/vbz2Hh4SkWRgpxDMEiansZoU0aBXVpAh7p4RLbUy+rbrow+LLA/7lZwUfM4gDN+7e
	RJ7ioBK0NIYdgdy2ENJ5yxHxAlWuHqj12EW99o1hmQ88M/i8Hp8nfAFlI3bMGp8zg1pe7mgd1kx
	iKP9rOCC5UmL76KM+r/CQyueLDSjiObJNz6cJxowbthtY5X6fF7M7yXFx6Z/gA=
X-Received: by 2002:a17:90b:2886:b0:3a0:9fe0:3aaf with SMTP id 98e67ed59e1d1-3acef3dc81cmr3308976a91.48.1792295524943;
        Sat, 17 Oct 2026 20:52:04 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:4569:b311:f3ea:5f8d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad25d5d1b4sm253024a91.16.2026.10.17.20.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:52:03 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 08/13] zram: reset writeback state in zram_reset_device()
Date: Sun, 18 Oct 2026 12:51:10 +0900
Message-ID: <20261018035125.3120704-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261018035125.3120704-1-senozhatsky@chromium.org>
References: <20261018035125.3120704-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reset all writeback state to its initial defaults on device reset.
We used to keep writeback related data in zram->stats, which
zram_reset_device() clears, but commit 1d69a3f8ae77 ("zram: idle
writeback fixes and cleanup") moved it (along with the newly added
wb_limit_enable) to struct zram, after which neither of them was
reset anymore.  wb_batch_size and compressed_wb, which were added
later, are not reset either.

Acked-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 593fa4ae47c4..0e1aa0da11aa 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -694,6 +694,7 @@ static void reset_bdev(struct zram *zram)
 	zram->disk->fops = &zram_devops;
 	kvfree(zram->bitmap);
 	zram->bitmap = NULL;
+	zram->nr_pages = 0;
 }
 
 static ssize_t backing_dev_show(struct device *dev,
@@ -2881,6 +2882,12 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
+#ifdef CONFIG_ZRAM_WRITEBACK
+	zram->wb_limit_enable = false;
+	zram->bd_wb_limit = 0;
+	zram->wb_batch_size = 32;
+	zram->compressed_wb = false;
+#endif
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,
-- 
2.56.0.176.g3575e65682-goog

