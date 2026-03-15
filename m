Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A987137B027
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773605842; cv=none; b=YUM7kH5pldUwd6r6ZSZm6emH36rsmMbo3LIIqXG3X06IAjoo1FHoV67PP3TNR08bIEJoioibsGO5XQHEHKNfXiGX+a+bf7iuads9U+2OFrUnkkww8RdX3kVPSUeAQ28MrescgGkAfn4aMwCLNDQ/Z+FpgI1JqbJlf/kkLyfkNT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773605842; c=relaxed/simple;
	bh=yxw1o5RsGgzifEgVy+t37G08vYALXyzCnGPt1gRrNDI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lX3xiqXOc3TmwdHF+IgfgUAWBIFFY3MK/tsdpYLd8+sXPTusmQMRAKHw5FXzHTKdy10ttNQKJZvh7wntLD+9QmNmXJPjCSpOFdzqvE4OAZPrkRZIIeTJ9mEMoFE4Md0dSSuTpYKH8E0Cfzl88DdnGXzAPWQHT3KwqBjpN764vnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lxs6UqEx; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lxs6UqEx"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so28259615e9.3
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773605839; x=1774210639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QAjJdat2f+Wu64a9+rtkdfODHEuD9aCaqihPGpN9D90=;
        b=Lxs6UqExeZpHk8H0SsMkU0x5kdw4+OHRU7rgzfEHHCD2nlwWruaE3D3W4MdNFik3lp
         y0WzTeybNHBacX5984G7/rQLs/X7HshvdkIBzcQ76qLQjCb87Mv0xEe5crO4y2USb3+7
         41oPreT/DupThJdCUqTLw/ViE560C+YIMQrS5E5q2NkfAt+RrIpH4e8YAk899EbDEdZV
         wZvJPyo9QoJyuyOoN8KY/2y0F63H3cLTEomcH1YlF3MdvxckHGLSgCJTZWEU+1f5i24x
         Hbh9euub4o0HU2E1dOg46iTy7Bx1DHM8nAAOxsoQWXo/QXuZLmgtV2S7dQjcT4iBTIUG
         7zjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773605839; x=1774210639;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAjJdat2f+Wu64a9+rtkdfODHEuD9aCaqihPGpN9D90=;
        b=ediFGBL9DJslQsV8vKvUziTdTsqVpH1eySaE2X9AfX/7c71zYKyLLMCww351IUnhXZ
         F+qNSukjdYn3zyDflLPKYaZQJOAmtrzNgJYDZcYVlqw8flOuFINMXpAyUcXW0GJE9a6r
         62Zg011wme+SBaufowce9bHB+Sq6B+fsG7SFglO3s24n6NLvwSZlyoC5jS9OvOBMEy/O
         Li+jqv4JVHqSC25YfXPChHWlniShbvbMkb7TbXzpdgFCSScFkj+pGXJHuoMXeAvEa+AI
         Cl5ovlAY/0NC4DxRTnCzPXTnFmJekxSra1CETxchf6HC3YhYBQoldxCp1KRCbBJmi+nC
         Sr9w==
X-Forwarded-Encrypted: i=1; AJvYcCUtqu6Oh5TKU36iwkMoOm2XdB1xSALuHlgZp81fFVFz2bxPzvVQK3o0RFAsN0AXhiuVckZFXys1N8SEkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1tXLX1xJ4rqOyoMaMRQLdZxoBREemZuRQIbu+UIlkHa5zHvw/
	eJH+ARSszMy/FU2SVUTOFq+ancSq+/KVMf7IIDIUMllG51lSA8vKdZN9
X-Gm-Gg: ATEYQzyELy+E6LPrZSn1Xv2h2OubgYLaxT8qIQ44yeVQks1z0ujytat/eZhJwwZmVn6
	02zz9fOFEn7hHmUXO0jF36aeNFXFS0onPOAZOC3eOSZ45v4Hd8r4zNlcmUeX+crCJlfSkK4ycRN
	qFoaXWYx+rE4vfSVLGSiDaHYzK+LDYh6hcbH+K/DU9UUHTgCXsOccTd6CMyoDrDvU32S2sfKZ8O
	SQDF+VojN2cViw/0bzz6xb4L3myeRTa8CoX1zZmFOCjow/9d0ITkgNYmYOjiIthhKvW0xWLrQzB
	8uyiNWAvKR19mhIP4gIIFgqu3dpL3K0PVc+1q4CHZWnkqUTnTSJHN1MrndWthb4hCZuYzE3gNZS
	K5fyHlwh4pVFl0CEwFlbFhvt+GSmNWw5paj3P4zBRBusKBHdW1L8IcsAPoOIpS9mTwQZORvV08K
	p8O8GNXA0+o6iAdLbm0Ad3YNGuS1WYCZ0fzw==
X-Received: by 2002:a05:600c:8488:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-485566d2fdcmr165056395e9.9.1773605838675;
        Sun, 15 Mar 2026 13:17:18 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm466194515e9.3.2026.03.15.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:17:18 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Boqun Feng <boqun@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v3 2/3] rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
Date: Sun, 15 Mar 2026 21:17:10 +0100
Message-ID: <20260315201713.15438-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
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

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
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

