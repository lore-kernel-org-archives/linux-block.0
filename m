Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E73377005
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595681; cv=none; b=enkhrEhV66MGH5lNPN8N/GAvnO9+yEuPTgvC0KL6TyhVKPmIjmIdjV7HdUKcg0WV9gZtN/pPhTfdg2KSR+DDMMA/QIbHg8V2+x5MuUdVJCfWCmNxAa36E8HOWO26oAz58CuzEVIIi+7uTyGFefcYGItf7gJNAqCdI2vVa1rJ7MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595681; c=relaxed/simple;
	bh=y8Mtr9pcqnP0vzscG2RNUti3BiDjvt7BhqDCfc6+Xhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYXHs1OqmYE39v3Cv0xNUonoCDFNynhqcBsxN7GdncFXhc4iND35HLvxsv5TC47jfQXpdM4uW2luvP1Q3Jo9zBrrBbM9x58MaYBZGiYDmcIdqY8r0J2YYQtGiZcOSeGkLyDI3boqr7qSHCBsRawI1NrmGsYQX4DdzxPb8AW7X94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7IjVq2h; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7IjVq2h"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so31637715e9.1
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595678; x=1774200478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dhH5M5FJNqVSup5S7MKNqMM3K7FwdoGd3zPkVDPQec=;
        b=B7IjVq2he/R/gxoyzIozDS4TOhCTh7tA/GbsLWYGRrUopXDRznIt7PMswdCUQaWC8T
         7Zav6qEKDiIrmBGDD6LV1VCs+MZo2OWSsvEz4uZsmUkPVZWyLJRI9dube/GW7qWVrBII
         OQRvgGYKtlzb/JfbDB70hRrP6WkNmAGhwXSV2G/DfK+RPXDD1gqcOxgUMDQf7ClGk65T
         v6SnNpJviw7xWXAdzNX2a1J8R7qTLVQGDdDrs4f9uKP7wL7m+0sgxEf/PnRCgqtVRWHb
         MZA82adK5DHXIq1KCmVWTxw5FYZ1Ar+Y8QziwfQPIaoX6dpa3UL2Ai2gMbhes6/MisG5
         3yEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595678; x=1774200478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dhH5M5FJNqVSup5S7MKNqMM3K7FwdoGd3zPkVDPQec=;
        b=GdDJs0wr2tK4hkxWd9LDR5rJVCorxFtZbSjSh5B0/Y8edHGSW9aTuZuvW6yGdC8Q53
         OZ4fExYYVdSKlBgqdGcLqj3HDt9On10UbBfKIcbfEOARCGGU2FvN2rVDVVpDBDXNxtbm
         1ybA0LY0rtdKx1MTtwCpKUd+K+eFuScRSEOsy8QZ9SABVh+FaJJGvW7zIuYN1HC/5fZ1
         HC3iRxKDHynIzB/HOF8GQirbD1Y/xi3IwV3TaJy8jb81pvRrKbMDo6gM67K36xOj+YRg
         mtcdqQi7U2W9g5HAXiM7qK4pElrHqtEDqBCWVXY1bOR2rc8XjkxXq8Wq+gDBf4l6p4xM
         iSsw==
X-Forwarded-Encrypted: i=1; AJvYcCVGkaqOoNWOmOBL/9XW3Fu9zccb57ETZTPuXYdfSn6yi6SK4r738I765kAtG/6TS961W42f1XCnJiOd0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIqYjDkgtqRSxstFXNwr1Qjlnkcym1Xxaqo2zKDgyKjosNhNki
	gMYl/PaWVbLSgrFor0Q4ECrNe7JgRZQbJs4pkzojNaMP9lvExx4KOIj2
X-Gm-Gg: ATEYQzxmzQZj5Kzk0bRqAbT7cfTqQm0Ykce8rTnPxMZxORofziuWhi8fr61J0U1wGGM
	Z4ejO8kRuFNKyCPNWAK8codse9bkn/vXeYXSIta++BWAdNyamkfePJfuqfPMc7bkqqcSCcg58nW
	P09ukSVaatsQb4CMuF66j7QDS/mKl7Cvq3nINJWFSBRORjJ4vR+7dNapfGhq52v9IoxSSHmLyYQ
	bDBzUIZ2yuE50dsAAuTiqvEniUCQRvFo3ExKr3kqMu2b5JIT2jFLYjN6KwDUtSdnWIcvBsuwbju
	Yd3FXgt75yp7XnsiGhoy790+9yuZYigkI9vpXTE/ywYoQE3GWIHt1ivbsE8X5Ra1w06AtLR+Nku
	hywYudKGPrMuMq11WGuGLopmLhCbPqAw5pZ8elRGJNUmOVm3Mk+S2WSTYyYFjk7ZEAnG4pZyHOX
	y+joEU6RZ3F2vFiTNn7ytQDz6DVeTpSQ0oE4c=
X-Received: by 2002:a05:600c:c162:b0:485:3fd1:992c with SMTP id 5b1f17b1804b1-485566d2fe7mr159704575e9.1.1773595677669;
        Sun, 15 Mar 2026 10:27:57 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6586csm73644905e9.20.2026.03.15.10.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:27:56 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 2/3] rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
Date: Sun, 15 Mar 2026 18:26:39 +0100
Message-ID: <20260315172746.270734-3-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
References: <20260315172746.270734-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the Rust rnull driver to use Pin<KBox<QueueData>> for queue data
allocation. This aligns the driver with the latest PinInit zero-copy
initialization abstractions in kernel 7.0 and fixes a type mismatch
with GenDiskBuilder::build().

Signed-off-by: Adrián García Casado <adriangarciacicuelo@gmail.com>
---
 drivers/block/rnull/rnull.rs | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715fe..23df23936 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -54,7 +54,7 @@ fn new(
     ) -> Result<GenDisk<Self>> {
         let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
 
-        let queue_data = Box::new(QueueData { irq_mode }, GFP_KERNEL)?;
+        let queue_data = Box::pin_init(QueueData { irq_mode }, GFP_KERNEL)?;
 
         gen_disk::GenDiskBuilder::new()
             .capacity_sectors(capacity_mib << (20 - block::SECTOR_SHIFT))
@@ -65,16 +65,21 @@ fn new(
     }
 }
 
+#[pin_data]
 struct QueueData {
     irq_mode: IRQMode,
 }
 
 #[vtable]
 impl Operations for NullBlkDevice {
-    type QueueData = KBox<QueueData>;
+    type QueueData = Pin<KBox<QueueData>>;
 
     #[inline(always)]
-    fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool) -> Result {
+    fn queue_rq(
+        queue_data: Pin<&QueueData>,
+        rq: ARef<mq::Request<Self>>,
+        _is_last: bool,
+    ) -> Result {
         match queue_data.irq_mode {
             IRQMode::None => mq::Request::end_ok(rq)
                 .map_err(|_e| kernel::error::code::EIO)
@@ -87,7 +92,7 @@ fn queue_rq(queue_data: &QueueData, rq: ARef<mq::Request<Self>>, _is_last: bool)
         Ok(())
     }
 
-    fn commit_rqs(_queue_data: &QueueData) {}
+    fn commit_rqs(_queue_data: Pin<&QueueData>) {}
 
     fn complete(rq: ARef<mq::Request<Self>>) {
         mq::Request::end_ok(rq)
-- 
2.47.3

