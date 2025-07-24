Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84212274B5B
	for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345818; cv=none; b=fS4uVPOy3ZthZ4SiZVRQiHKk2dx9FrM+JhJs8Dksf0Z8Plui+IDUdQkd9opgxJIa/H94yqR6khDuPOiqZECBWDMYyxdbhg5qNCWQBdYWbQFPcnZyWSm5hCqAFJjvdkHPw/K8H5nGNSjwA4Sv1d0pdb/1ZeFt2xC//MmMvYRABk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345818; c=relaxed/simple;
	bh=jqF7mCGV2czF+BaeGDlzl91lppM9KaeWobxCcAu4HUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXUBRDmMSeNevoySgjdLtK21LccyoJRSxKQ2pF+OnpLCZwQnhRhNL9upFWXkkWZ0HO+6khT36hcyWdZJsXF7Gb54uwthT9imc2DE8g6NJ+OSvzrRFQ3ScOBHMmVzlhb9xpTUGDqCV+9oq+xt3Omd4qeuwBPb5wmLKpWgAJtWY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=OnBmYrt9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="OnBmYrt9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235ea292956so6029495ad.1
        for <linux-block@vger.kernel.org>; Thu, 24 Jul 2025 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753345817; x=1753950617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47jmZPI3/V8O8CJJRttybJ/xuaRQjlAB+Z8KeKvbumI=;
        b=OnBmYrt9lRAVcL/3Ck5+wl5uAYjp3O8NR3hnHCArtm/i8qnutJqmFDwoeVH9LBEn1C
         tAZueb71PBMY8XWFMILyeb5F0x8hFEvMVc3Z17sfoah5r4arBtOo7LO3f3EFnjcnnbh/
         WvC00egJ7WFd9vs/NYb5ppG6nT2YeFdneGGuScHFhFZbjNm/qg170+UsyFPxaYTNZjDu
         dqrl0o87Po+8y/DugKEFwenjM8clMn/OPwbvwNASx3l4DyJv6RHlgjyYseLOVTmze4h8
         T87b1xa+G4zsuf4U8y5UmRHTCEEAGvWPXdu0CRTd3Cet+Kba9wkv7Zyjl7uEjv4JEO10
         RLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345817; x=1753950617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47jmZPI3/V8O8CJJRttybJ/xuaRQjlAB+Z8KeKvbumI=;
        b=J0CrYlYZ6/Z4p+9LFUy41KRDnRfwXJ5snnyyoov5SVZmEy03xBQYdWc9k7UNiktvKv
         8q/r3pBbgRR30u/uDH9eO89CaTEMMFnQY09Q1sEEn53wCOzFgbLeYO+oOXqTub/8Rf+g
         AxKvPVTZRtQy9IrRTbsRttI5gyaqAktworR/X/Oc0mc6ziAtW7FqcLgpwFjyPs0fqYve
         2ndSdfaJ9zYUotkYNSsxW2sNzoh0yB7p6+EOilXemR+7JCcsrZ8eXtFyd3/TA1qMwXIc
         DsUrb5UFfRmMlJPzqSGQ1g5miwvho/mmqm6Vk2Pfmgay/dLzTPd5+gYQZCso9CFpUKI2
         AZUA==
X-Gm-Message-State: AOJu0YxP69q9y83AQl+CWcTiDKV/iLK5sxHlboKjBJvXI9AhdLWsSEmo
	D4LUAXKGiQQeJoQV7W6VSGoYLtIDUzMAJLv2uYSRapymwGPWwMqZmm7NcXeOyZjVvfw=
X-Gm-Gg: ASbGncumlDHyO1atHxhRfpPGNpLJA4wS4d+FQ6FLAFZnYiAn58jKfjwA68/wduA7dkJ
	YVAWJZAkiVMOQtLz+ZO1Ro1FAZMl8AvbRSevlLTcuseM99FlRpcpfReMqe33mKgkQ/g0lffY76O
	y5cfoP511Mc7XcHAPrL5h6/pPMyyH1jdmqesNCscilxXAp3/1ly9lKT6641qbvPk5+LkAYykfqj
	kRQ6zi+8huCT7liXGpWWwRfX/dS1TOfIn2hpZ7CfPBRkHmTRs/LgxAC121WLzv8SjVm8SxbPKJ4
	UvWdPwE7eOQAvNze6biVBQwSYsMVGygXpwYCEDemYBJXJ14aHWAp895jEBh8+xUsNRoUx0BZyAe
	gxzN6lXw=
X-Google-Smtp-Source: AGHT+IHtywVt/v6ABhIAsOPJj1ZdyBALtRbXuQPSUy7BpFp0bvl4EoD/Ksf9GHu1qJpVP+Ax91cj0Q==
X-Received: by 2002:a17:903:1b28:b0:235:f70:fd37 with SMTP id d9443c01a7336-23f9814b043mr85462555ad.19.1753345816938;
        Thu, 24 Jul 2025 01:30:16 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490683fsm10037115ad.195.2025.07.24.01.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:30:15 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
Date: Thu, 24 Jul 2025 16:30:01 +0800
Message-Id: <20250724083001.362882-4-yizhou.tang@shopee.com>
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

The symbol wb_window_usec cannot be found. Update the doc to reflect the
latest implementation, in other words, the cur_win_nsec member of struct
rq_wb.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/ABI/stable/sysfs-block | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 4ba771b56b3b..7bb4dce73eca 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -731,11 +731,11 @@ Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] If the device is registered for writeback throttling, then
 		this file shows the target minimum read latency. If this latency
-		is exceeded in a given window of time (see wb_window_usec), then
-		the writeback throttling will start scaling back writes. Writing
-		a value of '0' to this file disables the feature. Writing a
-		value of '-1' to this file resets the value to the default
-		setting.
+		is exceeded in a given window of time (see the cur_win_nsec
+		member of struct rq_wb), then the writeback throttling will
+		start scaling back writes. Writing a value of '0' to this file
+		disables the feature. Writing a value of '-1' to this file
+		resets the value to the default setting.
 
 
 What:		/sys/block/<disk>/queue/write_cache
-- 
2.25.1

