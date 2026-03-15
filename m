Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA537757D
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595521; cv=none; b=jdu3Zax1R9oaV5mt91rC1/h6OPy47BbXQbt5+kKweP/u6b5xgmWZfiE6IoHSUFu3hWHxkbfx5a18grvNraYBHDA/qPfkCWKBT3MsTP/ID0SJlQhl5tTMn6ELXIyCyNpO3P0hhAP0AcTREj+N3lKv2bdRvVKtXL+UfHEdbKBJiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595521; c=relaxed/simple;
	bh=iKpFG0Av0hoqoOlPYCyOzyzjoAeTHTDVQHbGXDPimao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEEhIZkYW57Pwop6pC9P4pnAS8NFQZ4WBCgxAt3w0PFjDZa1YypLRNfismG5UZJKLjt092OEZBOvtJOlCEhWQ0DnfG6St5QAXRFzKWyb9+yaLcuaLopF8WsdvQVnyNjlOEvYGg9jjaNmGTMShGmw3nSWGpewfcqLUK+XudM4AIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCxyw7jc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCxyw7jc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso33227035e9.2
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 10:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773595518; x=1774200318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBcY1jNO230ersIPOAT9WM1qbuR7iZiog4/B3vVvee0=;
        b=MCxyw7jcQUketWPDXn6YA/c9jegxAxqw2iy6SMgpnMTSbNb+GM0xZxBWRWGdaLE+ve
         CmOc+fA+m2rJ6KjEb3TNyQLN4XmSZu+y+D7J9KJcGooMY3vZaeTIIRP7Lmd7e7owSF06
         PCTmLqQieGNFisw1FuPaiHPMBJtXrLAVtSd3nj8gouSxzM/nY4Ai9tLIBlIfbFayA4Sx
         BZMkyqH/F/L6bjkv3jetwXgQvNmNGmdW2EM3HbeRXej1UEIc25nKJTNjsk3u5fSC6uzx
         Y5Dk2P8R29oxRo2EUKboYLWAtgSMR3FthtptmBAeBkB7HdP86s7UN4OyieWs8s0wxIYl
         jMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773595518; x=1774200318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QBcY1jNO230ersIPOAT9WM1qbuR7iZiog4/B3vVvee0=;
        b=BX1MQdOhKsysBGM4tTe1tUK+Uj1+qnt4Aryn58OXaCtidG5BxCC2qRvMu7snVdVg6H
         8UL89xo6VJ0OB32nvfIpoBoMfGqdVbX1Y/n99m/lcx5yo0Hv/55P6GFcDyl4pXZ0BOKB
         ogdN9VBAftCVOOrp7OfMS1MthYQvfrSF8RIuvKq352YIBZX8gHylMqM8fLqFDUMgujQi
         OtWv9p1lu69EZ8I6qCO/qLYHrOB/tZYBH3Prvf9Attvs6llHmfww1U6fReayG2ic9AIb
         QXDEI+7UKDciGPqEsdMCidkN/G9Vuiy8sWfdSNk4TIy89zvLgfss7qevoHZ8agXDlTDu
         A4kA==
X-Forwarded-Encrypted: i=1; AJvYcCXJKvvp/a3qFQU7rhg6swYmKZKXfDHFflPQUE5hXaSf6zZIu0GvQGP9Zo6o1Gn4pOIvnSidc8/1Fjw6/A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVCxl9cW5prdpqJayoW3ef6LfGQMcILMaWLgXgiB5M1Q/f5QKH
	KE5X0sL2NMp9Z+FZ7X7uwVh+XAY5vUwuHAX0pJSKMEg1p4p/YG0dTKZO
X-Gm-Gg: ATEYQzykAs+cZziynWQqxcIL978J3xPgroIyNSZ3eDjitTORBvd80mgMsQToY0hiQWD
	ZbWAuTxUjW0pS3cfuHtVD3gcRRq3whOWiNkiwVwYCH+Hv8TCdyVdEb2rwXIx+qA6aphzbxOe6hW
	HXK9qADbtK3KsPb3o+pH6nbUfTNQfqJ85Me1Gci6VIKXXvT2wnxI0M2LR5kk8FMAEgpGuxwFx5v
	5w6xo18wpdFJENxfM1xs//uGVuhy0qA1qJR3qPomo8D58ftVuNupdfhSlofjo9ZHZL+GYRPGmVG
	rQV0AzXMl6eWlnCctfmIHc/HFdn2/fV6mgeFwXd6CZWWMmrXoKoj51tGVsgihNjg3mjkNFPDxzg
	+043AmH9TFwrk1KT0RL+dEyGls3xx5B3aW+6onZvmJpwE2jKcZHc6Jr3JxaO6lkvbWrSB67umeN
	+kEYYQLpHycZPHXLVJqNNpI6OyPLTR+L/ms+w=
X-Received: by 2002:a05:600c:8489:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-485566f7a2amr181338655e9.17.1773595517762;
        Sun, 15 Mar 2026 10:25:17 -0700 (PDT)
Received: from debian.lan ([171.22.84.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541aa73easm457168325e9.3.2026.03.15.10.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 10:25:17 -0700 (PDT)
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
	Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
Subject: [PATCH v2 2/3] rust: block: rnull: update to Pin<KBox<QueueData>> for PinInit
Date: Sun, 15 Mar 2026 18:25:06 +0100
Message-ID: <20260315172507.270480-3-adriangarciacasado42@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
References: <20260315172507.270480-1-adriangarciacasado42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the Rust rnull driver to use Pin<KBox<QueueData>> for queue data
allocation. This aligns the driver with the latest PinInit zero-copy
initialization abstractions in kernel 7.0 and fixes a type mismatch
with GenDiskBuilder::build().

Signed-off-by: Adrian Garcia Cicuelo <adriangarciacicuelo@gmail.com>
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

