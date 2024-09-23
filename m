Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8046B5;
	Mon, 23 Sep 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107909; cv=none; b=JDAdNI4LhVFdKw7S3iectQnbtagavWbEx/zLxeW/lEywO4SvzLPko6OQ6YWFtCo/oz4VW/mVdh3n4MgTKK+WTcnbITZkmOoxJlxKXWf4++ovC7A+X3J3Px1fYDYosDEFLLnRc0ipRGCeUNdQNaA/UBRdVaNa7F/mAgfdy1KUGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107909; c=relaxed/simple;
	bh=fEhRVcPxaYMwtRx0lyGrCbGbSILv25qZnDGf6Qs0OZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MdRJ109NxvvrjqdPYcNDeYXTI99z7jchQ0aAwvmxJeKpSfPAvamnrj2ru/wGkn6MZzvq884LODwSwm502UrIyFrTCB73UOSd6hwlMzCKfxgEcHxMWcxkJ65UTDzWD+qCEeCKCWEI5SObywKWthJMkLsCq56SwuWguDoJ7lCDo3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+uKG5nw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+uKG5nw"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53654dbde59so5195719e87.1;
        Mon, 23 Sep 2024 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727107905; x=1727712705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ku8xF+aBbUn/qtAv7USn+01Tze9d2RyEkOVYyjwGAHw=;
        b=M+uKG5nwC1SsMqrBBk0b3BItWXkKBRtr4xACKox6x0qPYPlpv3K6HjUmGotwgWMIWK
         2YAJIgLpjSK+FnJDERCs+pFt4xObvXyTMYRDL9i19ZFdcKCq650TAsetlDRamj++Tvtz
         WCKweLhKQdMioRgnxmv1rJLb36jsev3G/cqhFWJrKBxWTkTxMi4w536c8V1h4PzCWcwN
         grYcJncJmILRQSkxK1vtzuaQPqYsYAmbshJXjquSB+xfBPxOjVRx2z/bUVvSr0VSe8Z1
         OoK8SJCe/tp0lYXmfBZcvc7liCoRLm2QeLxz54t5vou/Oejsz3qIRfMIQk43vU6MRAIw
         KH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107905; x=1727712705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ku8xF+aBbUn/qtAv7USn+01Tze9d2RyEkOVYyjwGAHw=;
        b=WaVCuUL14rE0rAS8cagHvJXWEqm2uoWzGRmaxgBlPAYwASOxldlaekVdyLBqIg5YBq
         uAmNUDbqEWESLabJHrWkr/wlwMN2KvEzXlH+i6plA4Mh0XUdcVdaaKh7mJK5/+bb6F7I
         HBIsm351QErrO6hn8tLIht7HMlvk4ptq+wkDSnbo/MtapInB0MpxN8y48p3Ad1hxtVhO
         o/QSng+kObg49gQizL9cjn1rQRMDwvNj9PWXJ0+hhHP2jW2Ngm23ldyxcWe6F/UddXnU
         H6fg9Pc0g9R2Uu+QjvL9lS1SOtPhUXmiOvCIKT4bnxbw+fGhTRDUKlu7Ne5HKNmcq74c
         +Mng==
X-Forwarded-Encrypted: i=1; AJvYcCV8veBLmCj40mecISMBuC1tCusG39SPzcnRoTWHPdFo9iGTpqNSzoeXnxPgE0fhJ+B8t7AMecYd@vger.kernel.org, AJvYcCW31yTBfk4QqiiU1CxXRGlTFlNVUoJSw33EFpeyNNeqTmip/YoLyjtEW9v+EKmGXbGcH5pzW/rfSTigPO+J@vger.kernel.org, AJvYcCWog1kVZPEOR4+tc/l9dnyq3GCVIz58mBN3/rGisYnjrua5gCoOdbxUln2aem7TA9efwcZK6vVks+n/pw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMLtXQ34RP7bi/Qr7RFO/acsKCE1Rzt8296wb2UAoMAzoYKqpx
	cefijAY/tj66vyvlxb01oOI256SnXoWs1VUtJUik4G2ZfIGwHqk6
X-Google-Smtp-Source: AGHT+IEwzDcjUAdGbDIG15xHE9ZJ1P+fAIsTjouSD8LBVGGUmbnWMD+DCJPVf97RFph67Pbaq0UYZw==
X-Received: by 2002:a05:6512:1055:b0:530:db20:1f15 with SMTP id 2adb3069b0e04-537a68f489emr47378e87.16.1727107904443;
        Mon, 23 Sep 2024 09:11:44 -0700 (PDT)
Received: from localhost.localdomain ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5368704c2c2sm3341896e87.75.2024.09.23.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:11:44 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] zram: don't free statically defined names
Date: Mon, 23 Sep 2024 19:11:08 +0300
Message-ID: <20240923161108.991709-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change is similar to that is used in comp_algorithm_set.
default_compressor is used for ZRAM_PRIMARY_COMP only, but if
CONFIG_ZRAM_MULTI_COMP isn't set, then ZRAM_PRIMARY_COMP and
ZRAM_SECONDARY_COMP are the same.

This is detected by KASAN.

==================================================================
 Call trace:
  kfree+0x60/0x3a0
  zram_destroy_comps+0x98/0x198 [zram]
  zram_reset_device+0x22c/0x4a8 [zram]
  reset_store+0x1bc/0x2d8 [zram]
  dev_attr_store+0x44/0x80
  sysfs_kf_write+0xfc/0x188
  kernfs_fop_write_iter+0x28c/0x428
  vfs_write+0x4dc/0x9b8
  ksys_write+0x100/0x1f8
  __arm64_sys_write+0x74/0xb8
  invoke_syscall+0xd8/0x260
  el0_svc_common.constprop.0+0xb4/0x240
  do_el0_svc+0x48/0x68
  el0_svc+0x40/0xc8
  el0t_64_sync_handler+0x120/0x130
  el0t_64_sync+0x190/0x198
==================================================================

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Fixes: 684826f8271a ("zram: free secondary algorithms names")
Cc: <stable@vger.kernel.org>
---

Changes in v2:
 - removed comment from source code about freeing statically defined compression
 - removed part of KASAN report from commit description
 - added information about CONFIG_ZRAM_MULTI_COMP into commit description

 drivers/block/zram/zram_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index c3d245617083d..4a9cdb7fe8878 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2116,7 +2116,8 @@ static void zram_destroy_comps(struct zram *zram)
 	}
 
 	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
-		kfree(zram->comp_algs[prio]);
+		if (zram->comp_algs[prio] != default_compressor)
+			kfree(zram->comp_algs[prio]);
 		zram->comp_algs[prio] = NULL;
 	}
 
-- 
2.45.2

