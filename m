Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBAA342517
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773775986; cv=none; b=Ye4f3VIb+OPohU/+pvsHaDpoaQTE6J9Sbjk8I3oaoEqF//6wZGi4juLGF+QWsbdaTL7QUD1PCLiXOYYFgHBNyvhUiqsgM2CNXHac9wq13Ax0r6zbdjEdeSIAPJw+bT89XnJGVPQG9VtvAYrVRLcF4BvRjG6K9G4IORZPNwypZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773775986; c=relaxed/simple;
	bh=dqp1zvmx65EDKVVEH6MHWp/Qx+PR2wL3UG9MY8FVJQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XawNj/+cnUaXtpiQk4JH+jqm73a6OXkx9cqnKRr28HH4FBERTPl2BAf0+4jAay3F5FMJEYEdftcR1wFaSfbkHXs/kMRwxhKy4prZCZrY0/km7FXW6ogwuoZULwAPEP+dV5CFLCm61qIg4iofbgugM1TqXjN6w+yYvcpBkXNfUMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhL+DQxO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhL+DQxO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486507134e4so12672375e9.0
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 12:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773775983; x=1774380783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hglc4bApGbsTPm3VNAsufBTglatoDFtPjLPG0pQ/WOA=;
        b=hhL+DQxOPzN+IH6Jd7pet6G2VSbk1lENSofHr/BDEzptrrmmURgMhXh1tX16a/RMse
         bBzbpitQUWILbRNlt5ND9nQFILWAdB6FMC/q7mhEWbIro7sQAhFrFUCMAxZfDxJFB3Y5
         b2/QgTb7oyZYHHnsHpnqYBZcct5RidFWrhuJ0G6OWdmKJvq1ZF0f5YEjM81zCwhokDzi
         U9tSWTA6IuJuha7/4tP43KFu+zUsCb8asMk8oO1l6NEe3oPzjQoaRlpd/H3PSIemidaY
         SsDPgfgb+p/A7/dVtgZFpCMBC10BynN9vHi9bUhHyOKkkGsrZ8S4rNjblw4DcWuKFqWq
         dqpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773775983; x=1774380783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hglc4bApGbsTPm3VNAsufBTglatoDFtPjLPG0pQ/WOA=;
        b=YDmRQe6CZSLKzK0z/uj9DsolRdLND/aISCMcpKR2X0TEfK33jTxAUBpUjhR9cM30gh
         ZRH1k3RKRM5u/MCG+TpClynVhaHVxIy9+VH7/WgHdv24gEnzwqAYpJ9SKVQWkQtO8jcQ
         ZdvSzISydRy42NxIozwGX9/3Hs4JOqw/xqFYqi2cra4vsjrEFSCVaVR2m1h8YyJ3y8CI
         fca5X/4sL2ibamHROhmzmPd0mWVZW0ljW1oJ2IGEoSdxwkkkqQzuJvvaGi5hAKKBkueX
         Cz9qBRrEL/dKV0/b53oT88DqrScrU26+3pInniSUGr5HSJpOHtyz4wBXQ0AKvQ+V2d5O
         r1XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmKyYZqG6IIQt8brnUTl2N57/c5zMpryTp9ueaJHbyNCGrmgOeW3zj73mCOrSiY/3NNsJsc4CDjf9Aew==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZEDFSwTpNVv7z67Fn2Dcjp5VnrqCSOHUCqkXylRAsomLHXoy
	LEcSuN1Iob6Zph+4ApvQdiM19WqupqOWQ21pFSvko9pW1STX9ygpxn0n
X-Gm-Gg: ATEYQzxFLa9FiVu0HpQXkQEm9W5NPRuqJomFAyaIrnBCZ8w4WtxoQfxpOmtjBeboIyY
	gjPZxsf430owXRQFRsh3iLVRST4Y7EzZB3z5qZI87t9kX622sdhWXULYdlgLpzJmh2CU0O6Siyq
	Q548WSWH83IFbkaO1qbP5qmigladQBy+Vz2dotvUAoqPNnO/qREkHrI2jlFDlGourL2zUqEa2xf
	nmIqCjsiDCX2ry5H5qLcrw9Z4qDscAE8/WGWFvzHIUqbulps2mt02inqBieZzdoro5CZ8yJnx2H
	AZ3lF7xlfa88exbtN/sO4lYqnbDCTapvJAi3BH3p1/Yim/5D4F4sml4zjsv/HBwM0HOLmuRv6TZ
	qI34FCSl7z45Gjj5JicSTtEhiQq+XOMQ3L+KaVepD4Rt6YsABvHdBDeP0DE5f4yD/ko8EVmQuYG
	E8qQEcBYy/IGhB0RPQOuXtwaAoCgIHJHsq3A==
X-Received: by 2002:a05:600c:34d5:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-486f4457b0fmr12446185e9.26.1773775983122;
        Tue, 17 Mar 2026 12:33:03 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48634a7ac93sm70833395e9.2.2026.03.17.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 12:33:02 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Boqun Feng <boqun@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	rust-for-linux@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adri=C3=A1n=20Garc=C3=ADa=20Casado?= <adriangarciacasado42@gmail.com>
Subject: [PATCH v4] rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
Date: Tue, 17 Mar 2026 20:32:57 +0100
Message-ID: <20260317193257.13848-1-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Utilize the pin_init! macro for QueueData initialization to correctly support in-place initialization patterns. This aligns the driver with standard Rust-for-Linux pinning practices for driver-specific queue data.

Signed-off-by: Adrián García Casado <adriangarciacasado42@gmail.com>
---
 drivers/block/rnull/rnull.rs | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/rnull/rnull.rs b/drivers/block/rnull/rnull.rs
index 0ca8715fe..11ea0696d 100644
--- a/drivers/block/rnull/rnull.rs
+++ b/drivers/block/rnull/rnull.rs
@@ -54,7 +54,7 @@ fn new(
     ) -> Result<GenDisk<Self>> {
         let tagset = Arc::pin_init(TagSet::new(1, 256, 1), GFP_KERNEL)?;
 
-        let queue_data = Box::new(QueueData { irq_mode }, GFP_KERNEL)?;
+        let queue_data = Box::pin_init(pin_init!(QueueData { irq_mode }), GFP_KERNEL)?;
 
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

