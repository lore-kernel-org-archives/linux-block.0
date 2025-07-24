Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FE2274B52
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345812; cv=none; b=sZkVslASdm/b9XlWtcfqXMzjDWvcVJ4MQ3noZrlKr6ofXCqevP8/MAb3ZK0L1BzWIiIMtMxljBDQFg3hekQDT7djY/SJ6fnt+ivkfUvaLUALCTKoob3RsdFxkkz+3O3ti8fpJU1BDW1UVIv0yGRwSQAW3OpXYsusvKsWez1ZkLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345812; c=relaxed/simple;
	bh=HJ1q7SYvO/kv77mnITuBAFgcNAZ6IxgSZnDQS4kjSZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2mV8w64LW3k+oatnNxS/mF5Y72BPT8Ns0M8T8JkiCAotwKE+GQp9ntdNPI5QR3lt/kbeJ8aZT+gwMavqzglWnTLhyMAy5G3qIXKJKNx9FzyAv3pfH2Pb/CA+T26Qf0mQ1rUC1mzGfRsm8TH0sU20JgAbNzKlsR1uUepRKWhCVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=TmHormUZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="TmHormUZ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2353a2bc210so5940075ad.2
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753345810; x=1753950610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilRkYBOzxNvuqeCrMQ/r0JNQnGrAnxcb64klMFAHePQ=;
        b=TmHormUZubrvTIME9vFMmVvRaAAgL8+G0xHCgzOhNawqW+rgI+aQGpau+6ogFv8zWP
         uxgofs8tQGRLYpYURvC+YYZiqdnDmpsQbp7WK5TVGA5Z0MBEwWfRwIZxUpcj1juY40Zg
         9ZUEIPdFq0hrBYAuTRggyjqRu1mwJ9cD15JeKIDjrqAyxDZBOAErrp71kRtoVmcpGx1N
         yw+SSyMdHAu3CiGMnAYha8WZSezZLK0BAVWVlaFpPktVTsQraedRXchYjLpNB3GQ3gE7
         BRJnV62xOSigkkuaZfWCsDvYwskjglrN2HfOLQbJ2lVOTtQmiFlhiG3KbufnsqOWCPJe
         uekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345810; x=1753950610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilRkYBOzxNvuqeCrMQ/r0JNQnGrAnxcb64klMFAHePQ=;
        b=q3xx/dGgpOqe/zROAQS1etBa4zNJyAI03O4HOb13jCG7CeBIpcb3KjSJXVaWOswemk
         OB5+Hxuy8sP+RLYL7lmcXb5mdId+4yTGPYF2JNzdVCU3SD1Dmx1Anwnfz04+3VxroSPJ
         L+O3oRAM3Ea3q6dpbND+gQL+dyWHB4uiV/IFF2WpDks3BFw00/5JnBHrNlqGRjpfRHLV
         XOkMxwH/gW3zPcLe6DDrfM4KEckF1cNNQaRriV8iMpFM96BGSghHP36lkEsup+/bwILg
         WMhJgTwce5gjXWzbwRr3M9WKIAhczCg5/Bsm8T6Wuit5Swr3YEBYPsuqoQgGbsmj195a
         G7fw==
X-Gm-Message-State: AOJu0YzabEt2KFq40wWBB1vGYQ+ymEQIzbC9WJBD936lBqgbbDKnNGVo
	0nd4hmYTD5PThoE6mi3fDXb7hivO1kWCRwfLija+1sF0/s8+r6cdCBOuqHjjZYU5RPE=
X-Gm-Gg: ASbGnctJB0jG34OCKQc8on8REcgjGv5qGGIKMfBPPszaV7MR4XsPzgo5y3tJKxZhSTE
	VjG3t08MMOaVs6MW6La4ksgo/p97dbDLt1rvpqmd2IV9QsLzF0A3iyVQ9mjZiv0e3ykRP2rkrnM
	5PV743DwedCMpLkUTQobm5MTO7YECY+UGzxEWhcLN+/hgbxWsX7UMDQYv8Me+Mgamt3FUNNSnSY
	FkKJ0BEP0RgeJhPAdDQhuNxDnoRlRXH9JSj8rUBF6wbMwEDfj80ghpL3iZ4naw2a+zThT3WtcTE
	wnLboZNU4DvmA19ybnURpFCpcx5pkxzugN2rWgy7mMoatLfi5O9ePSnrSO0O4nJ4rJL35c6eUzl
	nTp4PAfObrzpTJIBEvQ==
X-Google-Smtp-Source: AGHT+IHhH47l0wPWn4JZ/VaU0HvCzPt2Zvz0cwZdqZrO0EddG/gLhfEw0l9jTAIpMcxtc2WYAZuoyA==
X-Received: by 2002:a17:902:f64f:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-23f9818d905mr87530275ad.16.1753345810656;
        Thu, 24 Jul 2025 01:30:10 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490683fsm10037115ad.195.2025.07.24.01.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:30:09 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 1/3] blk-wbt: Optimize wbt_done() for non-throttled writes
Date: Thu, 24 Jul 2025 16:29:59 +0800
Message-Id: <20250724083001.362882-2-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724083001.362882-1-yizhou.tang@shopee.com>
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In the current implementation, the sync_cookie and last_cookie members of
struct rq_wb are used only by read requests and not by non-throttled write
requests. Based on this, we can optimize wbt_done() by removing one if
condition check for non-throttled write requests.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-wbt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index a50d4cd55f41..30886d44f6cd 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -248,13 +248,14 @@ static void wbt_done(struct rq_qos *rqos, struct request *rq)
 	struct rq_wb *rwb = RQWB(rqos);
 
 	if (!wbt_is_tracked(rq)) {
-		if (rwb->sync_cookie == rq) {
-			rwb->sync_issue = 0;
-			rwb->sync_cookie = NULL;
-		}
+		if (wbt_is_read(rq)) {
+			if (rwb->sync_cookie == rq) {
+				rwb->sync_issue = 0;
+				rwb->sync_cookie = NULL;
+			}
 
-		if (wbt_is_read(rq))
 			wb_timestamp(rwb, &rwb->last_comp);
+		}
 	} else {
 		WARN_ON_ONCE(rq == rwb->sync_cookie);
 		__wbt_done(rqos, wbt_flags(rq));
-- 
2.25.1

