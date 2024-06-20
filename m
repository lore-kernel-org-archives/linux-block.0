Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAF43D994
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873886; cv=none; b=r9jnTaUy6BXOxyqDl0bMkEHKOYPnMJFj0zyZZ6/XEG85D8+rE25LPJevg7Y/qUHNZkLrea+BxXyQ1lfyt8sXCGcP28R+7wTt73jUbcxDIUMXx5a/wvexx32Kts6Zl8cf14QAjMtniXo/qGvMBvSEUZibbWL+IPYeOS1TP0HUrxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873886; c=relaxed/simple;
	bh=R2m1iTMgAAfEnaRxsHj5OU4tT6yTo3Fl0TJXfy9fNwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8u/WKNv5Xy2noSrYanszIEF6ptWZrL2CO4PVt2LCLowvMT6lxRtc8w4H2tIt8K3uN4SKXKlIyTqS7DPR0Yozvo5z1MC97oeff6R5A1QYsRYPBgLQSBI3QK/4H6l62yGEU/pobj0a9I/W3/bZAUo1On2DGJZ3PqLaP70pHaY2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=zPn3+QHG; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="zPn3+QHG"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso557739a12.3
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 01:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1718873881; x=1719478681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nxlm73kuKE2XKIMoWmSTWrBbAjROgxfrZ4Cghh1emzY=;
        b=zPn3+QHGH3mGdt4J/BB0b0OjbkzZCjpMZIuXAHBEUuyMO46jcv/us/VID/LQQmu53x
         ttG6miwEvnq3TFTJX489y3q/VQ8fcemswjZjqWPxnaV2xNgkF6U4+C2woh07pjgwamTp
         a5M3/vTdTwc265yfigTzTOM1cLLej1d7OhC2q0ESPkR/pEpS9we3C5T/hV7SIViaRPKb
         i2xrAnR5X+CSfbyvjmuKqdTvEpBzBbBmcYDHapJnxF37T2R9mKCGDdPlSxqBwpdWVCq1
         UF5LP8qO8CKCy8bEqEHAuL1OWYAHEs6K0UWR2qG4Zj8PW8fng3u0o8AVtWSXkUaGMVA7
         5Eqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873881; x=1719478681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nxlm73kuKE2XKIMoWmSTWrBbAjROgxfrZ4Cghh1emzY=;
        b=IwwS1mN+D9VLBebFmzJJRSJDSfd06vFCa25sDRshbzcI5OatNP0rc9Ggie4IXOVaYm
         jz82wGFAEXJJm9rhADZXVK8x5CjFfU/SoARErNDVDEMfZP/unKwdJVL3eIvGilztaDsJ
         d5m79NW8VDQfXjVJJfUu1LIyYDlIwj8VVC+pmj9etFwybCXIXJdnp1yHkbxYXpyhMRgJ
         GP8OKmDpUdTdooaOn8SJ7gW0fmJQ3XzzCErNd3dN7hN3vU17QhGM5MuEhbrwCsP5xkNd
         bGEc+xzpVegAB6/yOBdljOiMN/5xxtISso9Erx4fzf/hVr93Lykg8GDv2QrTqU75qZNv
         8qpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUe6X1LTcYAAhFo0ZagbMRBYVlfAC6+1F/fU1N2h0qG9pz2W3nyGdyNV+2u/ePo5i+PLYYCJhh/lwjg6eojpVsa5msO5lqd7trDlyI=
X-Gm-Message-State: AOJu0YxI5voJ9COLfDzVmyWbwtMjJ5Iv4da4zgA2FdVUyB94tdQVnBgg
	lZj/AS+FSRPARCiUi/RaJjD3h+IS60TyhPW4A+LOS/kE2p8u/CTxORLznOSN6go=
X-Google-Smtp-Source: AGHT+IFNBPfPRC5d3WpzjNOlLtaGNXM1BXKDPBXyHCQb4RbbNdBlIV04IVIbPwWrAX9/Zw92/CFflw==
X-Received: by 2002:a50:8d5a:0:b0:57c:6740:f47c with SMTP id 4fb4d7f45d1cf-57d07eabd35mr2962176a12.27.1718873881269;
        Thu, 20 Jun 2024 01:58:01 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cbe89005asm8226647a12.10.2024.06.20.01.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 01:58:00 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	"linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org,
	Andreas Hindborg <nmi@metaspace.dk>,
	Andreas Hindborg <a.hindborg@samsung.com>
Subject: [PATCH] rust: block: do not use removed queue flag API
Date: Thu, 20 Jun 2024 10:57:21 +0200
Message-ID: <20240620085721.1218296-1-nmi@metaspace.dk>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

`blk_queue_flag_set` and `blk_queue_flag_clear` was removed in favor of a
new API. This caused a build error for Rust block device abstractions.
Thus, use the new feature passing API instead of the old removed API.

Fixes: bd4a633b6f7c ("block: move the nonrot flag to queue_limits")
Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 rust/kernel/block/mq/gen_disk.rs | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/block/mq/gen_disk.rs b/rust/kernel/block/mq/gen_disk.rs
index e06044b549e0..f548a6199847 100644
--- a/rust/kernel/block/mq/gen_disk.rs
+++ b/rust/kernel/block/mq/gen_disk.rs
@@ -100,6 +100,9 @@ pub fn build<T: Operations>(
 
         lim.logical_block_size = self.logical_block_size;
         lim.physical_block_size = self.physical_block_size;
+        if self.rotational {
+            lim.features = bindings::BLK_FEAT_ROTATIONAL;
+        }
 
         // SAFETY: `tagset.raw_tag_set()` points to a valid and initialized tag set
         let gendisk = from_err_ptr(unsafe {
@@ -152,20 +155,6 @@ pub fn build<T: Operations>(
         // operation, so we will not race.
         unsafe { bindings::set_capacity(gendisk, self.capacity_sectors) };
 
-        if !self.rotational {
-            // SAFETY: `gendisk` points to a valid and initialized instance of
-            // `struct gendisk`. This operation uses a relaxed atomic bit flip
-            // operation, so there is no race on this field.
-            unsafe { bindings::blk_queue_flag_set(bindings::QUEUE_FLAG_NONROT, (*gendisk).queue) };
-        } else {
-            // SAFETY: `gendisk` points to a valid and initialized instance of
-            // `struct gendisk`. This operation uses a relaxed atomic bit flip
-            // operation, so there is no race on this field.
-            unsafe {
-                bindings::blk_queue_flag_clear(bindings::QUEUE_FLAG_NONROT, (*gendisk).queue)
-            };
-        }
-
         crate::error::to_result(
             // SAFETY: `gendisk` points to a valid and initialized instance of
             // `struct gendisk`.

base-commit: 43ccacc7be96b71bf8c1461036034f1174be2f4d
-- 
2.45.2

