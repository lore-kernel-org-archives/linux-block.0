Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194A02327A1;
	Fri, 25 Apr 2025 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745568221; cv=none; b=jpt1ie9X43BVaUpizFRvHhe+afFTS1I/9BBbw/qCmUYn49d2Hlu7DHxXSoa6PA+txSQn0eIqd/erF/QXvTmm40kOSiI4OYSN/JQ7TMwnF0dWxYAcyaFPtm2NqBkQ0qBpaAXbYbmI0/IwU0aCQGKQa3LlKM3mhQTDy6oe0LjN9oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745568221; c=relaxed/simple;
	bh=0of4Pe0B74UUX5ddSapTzsqiD760rR5Wz5g2YOMY22I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mebE0NVwMsoMMWLBidlBmAfadS1+6ts/UTnuhr64IQIRv14uBzHFh8u5ehJun3OJxIUIsPCSrMkZAaCbhdcWiPPp/99S1hjU5G1LBV5ipLEjAAD06QR9YvdD1lQ+hoZ1lFvV0iGYUXQlDj3R57oRpZKACv8IRE7Bv5Fj1DeTWVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVt/FIE7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVt/FIE7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-225477548e1so21816275ad.0;
        Fri, 25 Apr 2025 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745568219; x=1746173019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fv4DhFkRJnMG7smQDWj1JOpxtW3NapnM29vYnhj7I2o=;
        b=YVt/FIE7XIg45StWY5jxxcXnS0rAado2eh3Rrtio8SLXfb1XR36x0qKKzXeRlTBm6D
         fhebSsDHFPDTJbknUAEwZjpQNeDxtie0JZ8hnPfLJVT9P1fZD69/K59lqSz/WUK05jSy
         wc+NAQyIy6q/NdAKKFEgUQzwi7adyt/ViDXKmhVh9Y2ZRS5cikn0tLdgv0tlP4n6EtqU
         e4sD4pQvcYwXbDxy3ErIoRtaLxMtRFEj0Tr86anVjKQc5Wp+aVw3D+FAg+mOZ8lDEY3s
         WqnudKdalNzYxDWbF3IsKU1aLl8YMB+iE+niVA06knOAg5Nnf0Ys4XAXKqvzkvTUjdpd
         7Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745568219; x=1746173019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fv4DhFkRJnMG7smQDWj1JOpxtW3NapnM29vYnhj7I2o=;
        b=goVvvXRyul+ZaCfeVi8FIFzfsu8GVoDW9odNZqlMuTDDzLx2FDvcub3F6ILug+MFIw
         W+n/dqA/FpuKljRAanBVMkxG+Kn0XiBkvpN9ViS/t8ztGaWgbPN0UgzJ88fO41OOGsht
         gI+mGl2C5RPA8QgA5BImEAV/Y3jRVSOB3cJyE3vMWlEIfI92tjuLf7GyoObby3k3KJ4/
         S2nWL0qZB4XMEAq/IwG2AhQow0iONEonMmUCz46kS8ufZsPhAy14ZDNGE7M+fnBav4ff
         bTj0dQqb0Rm663Jq5vkXyapyUPPfXeXbYbYSDtIThdtphwMmg0npoQJ+JE1HLSuKeQRI
         GS6A==
X-Forwarded-Encrypted: i=1; AJvYcCXJdQwXy7tl9p66yV9Dt11VsAOPptOQA5d2ZDwqc/UBZL9lKa4pYbhoK++PoA+8KRehBR9X3ong6pFjrRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQpB4PI85ey+M/giyK7F7quDfVpi72jCYNxvxUw+CfLNdKCnG
	wWIEqTL7j4G4n+j2s+L50sTkDuE9y1ZQB3ECwIhVQ/bFjLg+q8EFr/tvApuW8QI=
X-Gm-Gg: ASbGncvGPkAThTQYkYErKLLbETorbr2pPIMw61JqaM9mFi/CoWCSHPjrQcOxCoMdpyy
	C2U/PXeLsxeYj2yQwcoIvdlrPJVKSMnY58z6k3iTEZK3nAi6hfE1xKRWk7ru/w0ctEk/ZjT++e9
	5/RY1fVgAbNCfPF2Cu6dEMZGwLiLb97n5MqWqavL9MW2mJb8W+8QHevr/K2mdagSu5rnQfCdfnH
	1bnAht/kTbLqds836S4FAMoguQCcD3m+1UA/gq2B5JMlAvIFLlz3MTTFSIAoGjjxH8QPGvSiL2L
	CIj+GyLn6wkkYvgMnFDS625y+zr8f2YsMMdux6UBOtVPiUctj5lSl6lZ97VI
X-Google-Smtp-Source: AGHT+IHV3jRIT2KOzsYhCy1v72FuGHVBf2+S6Ziyn5ch88wa8KepJnHTG4jVJZgIfksfyjntVzV6+Q==
X-Received: by 2002:a17:903:1b0f:b0:22c:35c5:e30a with SMTP id d9443c01a7336-22dbf5ecd36mr22023185ad.16.1745568219137;
        Fri, 25 Apr 2025 01:03:39 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c408:a0b5:82a7:fae4:9cf0:3b75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216bb0sm26362825ad.235.2025.04.25.01.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 01:03:38 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kevinpaul468@gmail.com
Subject: [PATCH] block: make bio_check_eod work for zero sized devices
Date: Fri, 25 Apr 2025 13:33:05 +0530
Message-Id: <20250425080305.45100-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 3eb96946f0be6bf447cbdf219aba22bc42672f92 upstream

Since the dawn of time bio_check_eod has a check for a non-zero size of
the device.  This doesn't really make any sense as we never want to send
I/O to a device that's been set to zero size, or never moved out of that.

I am a bit surprised we haven't caught this for a long time, but the
removal of the extra validation inside of zram caused syzbot to trip
over this issue recently.  I've added a Fixes tag for that commit, but
the issue really goes back way before git history.

Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 94941e3ce219..6a66f4f6912f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -515,7 +515,7 @@ static inline int bio_check_eod(struct bio *bio)
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
 
-	if (nr_sectors && maxsector &&
+	if (nr_sectors &&
 	    (nr_sectors > maxsector ||
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-- 
2.39.5

