Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA50325F98B
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 02:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758854311; cv=none; b=c5C/RyNHA+5MPXz6UPEn9yeSdKggKbhRc7iVJcvLCMBGkgK2PTIECXRmuXn5dfvejO3Jx1KfqvWPS+WO2YxDSGOyNnxs+A9mPjc62EK1eeeRzYz7gNGWrGsGQb+9tYkFpEBnityBetukDGU6Cx/g8tsc0xN+5tL+V3kmq8j4qhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758854311; c=relaxed/simple;
	bh=xNC4+5vXuGIoP3AubYqeZ73I0t9q26/OKWO/Q7/2G4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SDF3PnZwrSjJjPDuY9pmx1pddxxvp42NAb06OmTjo5fA26WRDpUONOGWKcB/AXTM9WbHxSXFNdoOuvyW2IKHNhqujyVxBF6liKNwY3/bpnIJwAUq/bjciRWr7DJSIObPAHHb1EDKlLRrCsz9HQHqcu2WxNrsBfkLiWyDRm2Wk/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBXufAkO; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBXufAkO"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32eb45ab7a0so1843294a91.0
        for <linux-block@vger.kernel.org>; Thu, 25 Sep 2025 19:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758854309; x=1759459109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovDud+Upvoitt+mbnx9bJAksUkvB+hvEmFPUqVI4Vww=;
        b=OBXufAkOX9wFmt2xYTHoz3PtSp3zhL/JB/rSg2FS0vh6DYGQ5hfVFtKi62xGmKCCxs
         fQvIMcSA5OGD8urMiSBYGud4f8H4cFI4pf7ehf96mX23/hGSJ1yXN7GTsMwZhpKodmUk
         VTI2MFuNugNgkOjyyZNpvaKAefSqkIjm43uZzGLQnIy77nIFhmlxNCXnMi+DHI8fuz1E
         OOyxfXoPZDjzROb17aILbPdq09TND44ZMpuSeeq8fVIWT+ZarHEqalRkcgDG0oNv4p7z
         o8RkCTowkfeUbDyscVniApLsqSklfIautUkfJuyALQAvLXqp6qQ4Ky4clEBSH2KldbmD
         ouIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758854309; x=1759459109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovDud+Upvoitt+mbnx9bJAksUkvB+hvEmFPUqVI4Vww=;
        b=gqVn3jCdhDsIOn0WF2g5kHV8m2PzwEGnuV7V9hoFLjB1+8HkuOQ34VGhlSEfbleyfr
         /EhnVHqUvA87bB9WXtWaAqZoA+zQH1FWRTy8CdL0uYpdEB648kaz9dYN18SnVePooZlz
         HUmUO6GhTWrDezNV0K/xBaOzR4ckJ2ggU8AiDDJYmRQKy2oIZvQJar2PYHpGon9xFAYA
         KKwzKuuImi6Y3muAJhxFTcyejQ4O0rPIuhSrlSn+Jov/1VvwDedaXvp8xn5JPshHmlBp
         qh3IzOf8jhyRHxPeGIzm99D+vgBYtyFcgWrD9oimVT2RqE/Ks1+4qJH1+phhb7glzK9q
         Y2XQ==
X-Gm-Message-State: AOJu0YypVY6irF6/Qz1AGX7ipZZIegGAqBBDFC1gUJ/wt5hDPC3m5TQs
	lqC6q/7k9zcdCayPEQTX2pEYrLIvE67G3JZ8jHE44XFA9XsjM5I+MFYyAaPv9ymTqDQ=
X-Gm-Gg: ASbGnctBLshZg+NPakIuUQQr5YMo2gJubCg5hyw5+UGxI64I2wLo8uOY6jMkT6KgqAN
	KyIRm/9qiYC2rNFSxLoaSA/oWMZrcfgV2ZvnycErkcp1XzDXffCRlkhR60hpbdxO7KpctBTAvaM
	ycI2pCS5AIz5tP44L1bTJf0TF5ncPWGpDuRAsTDDOJTfufrV7YoGsnYZZJ0Jso7EAt73bvRxzu3
	6S9Ho8YVIsLgdYkTY8HLJcHwFK4jsoTqQiWCMCpRNN4Pz+nrA3pCGFX3ZqoIk+9BEh9IgebDZYv
	+BJACJ2hhbqqo4IXEcsDKpXklW173BMUecJtBTuU8NC+NHJcrneey4rlhD2wG2IVigqLIFarFiW
	+upQLvW12E1bHyAStMwCeThUJOSPtvyrNfo+tCrqeguEv33y2clnsR/7uqkiFmWnLwB4=
X-Google-Smtp-Source: AGHT+IGPME1VnyuxC/3OI/ns6Knvym9zUVDwuAUCOvZznBY1fWWY2dw18nStmCjJ/fzuATnSgkRaxQ==
X-Received: by 2002:a17:90b:3e8e:b0:32e:ca03:3ba with SMTP id 98e67ed59e1d1-3342a2c2a81mr4911872a91.22.1758854309122;
        Thu, 25 Sep 2025 19:38:29 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2073dsm7269825a91.19.2025.09.25.19.38.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 19:38:28 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH RESEND] block/mq-deadline: adjust the timeout period of the per_prio->dispatch
Date: Fri, 26 Sep 2025 10:38:18 +0800
Message-ID: <20250926023818.16223-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

Reference function started_after()
Before modification:
	Timeout for dispatch{read}: 9.5s
	started_after - 0.5s < latest_start - 10s
	9.5s < latest_start - started_after

	Timeout for dispatch{write}: 5s
	started_after - 5s < latest_start - 10s
	5s < latest_start - started_after

At this point, write requests have higher priority than read requests.

After modification:
	Timeout for dispatch{read/write}: 5s
	prio_aging_expire / 2 < latest_start - started_after

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
---
 block/mq-deadline.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..f311168f8dfe 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -672,7 +672,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	if (flags & BLK_MQ_INSERT_AT_HEAD) {
 		list_add(&rq->queuelist, &per_prio->dispatch);
-		rq->fifo_time = jiffies;
+		rq->fifo_time = jiffies + dd->fifo_expire[data_dir]
+				- dd->prio_aging_expire / 2;
 	} else {
 		deadline_add_rq_rb(per_prio, rq);
 
-- 
2.50.1 (Apple Git-155)

