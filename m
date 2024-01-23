Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1556463
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 08:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705997576; cv=none; b=VSl9nd/8HbedOGIkSghuIR+Z6tDYi8dxq9RbNjf7fLiRWlRxtBsXLIJq9FT3YibIijOIRrUkTzrJVhh3kRQC4oIrv0Zkx4yrwiBw6HhaTvJu73CEko7GB/yOjdSjH04h1IQE9c/IoouNTxo6IE6oQF4vCAd3AUSX20N4K06BKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705997576; c=relaxed/simple;
	bh=R7RQ/PfRCLCtq5n5pcF6Xl5ipxi0QZFoalAKE+tfwB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jfRBncgW1oqtGBid6iNqxKDJLeTJYDgibTqckrZ/zUVAbx0T0Al+ELIJGFGi+PhnwV5aqF8+EGiBugbYEhIRKC54P3/0lQHVr/2oPDSIrYTxsc5Fp9qW8TvjXz4qNjNm3dqGuJa17AeBUWAQSK7pEDXxfbqhRcUAcOusuSXKNvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=A0D1hSU1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="A0D1hSU1"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d427518d52so28736835ad.0
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 00:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1705997574; x=1706602374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=inxZJymqVSs5ffJSXOVp5zCbMBHlALxa4MBGgugNy3w=;
        b=A0D1hSU1MCduEjtZVDWLL9LU5Tc15v33sxmMMxOfG2aAERztpLuwKI0Iy+MDB1+p4b
         aWCfZqiQrhJEJBqmt7gLewBHqXT/0irvj3kh+LmCG3th4Ret+ZFYereZTmMtLlk9kxlC
         IoQidMYULLOvEwslwfuDuVGfbuFv3HHM14zvJJNHH3L1anHVMS4fB064re7FPIayZIEC
         EbMsDBvs14Ts7t60gkSidSiDLQm0oXmvgZhYbUsjbcy+zUa+QtISh6ZYhOQh2O+fcEWb
         yE1xUjwb/95BOOwloY+7HvwncB4/0Kyaijltj1WznQB6SiErBdvL5yJ3CwyIxq7zVsax
         VhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705997574; x=1706602374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inxZJymqVSs5ffJSXOVp5zCbMBHlALxa4MBGgugNy3w=;
        b=hCUiHqQeuoTIBpG4dtJ2d0GYIcTbKZpsWODmx99JCjINLw47cJh+114krtbpMRfGD5
         mGwd1Rqi0RpX0abdtNs5AqGqHfSb7yTF4aM+7qTzq72NRWro5YB2V0k//HtjrrFMGCp3
         eFKaghafuq6Yf2KVyE6zOBhYAfQhKa3TVb9GW/vTIC1FkOOAN1ZdK/TP9/DONRL2cSbX
         wsz35xDA6OF/x+gAG1Vpz5URNclchwmnYks7zIlF0qLsSFX4E15TYRk+oSRKRUWj5uEC
         D5v0bK2v3InrOgccbbf7zr+Mztmyjr/o0fqkLWX6aUYgMTQcD/r4kCjeyDnlMG1l87vN
         oRpA==
X-Gm-Message-State: AOJu0Yxzk78ZcpAuXfd5cSYcXV5sf0TOTNWuPRLfayED2ODxZFKl/oAj
	vwt5gXQGsOWpRbK9rvgHUPZmb/Qd7kR+M+ib/2l00Ugcdw/S+LCer09hiW8ZI6s=
X-Google-Smtp-Source: AGHT+IFm8k6VzAwvXCSNbOrkx9mrdc5qgT4K4r8v61fd8ma+XY3H46IblYtRR1lMGCX/HBClqr/TBw==
X-Received: by 2002:a17:902:cec4:b0:1d7:7583:6d1c with SMTP id d4-20020a170902cec400b001d775836d1cmr88475plg.16.1705997574253;
        Tue, 23 Jan 2024 00:12:54 -0800 (PST)
Received: from ubuntu-yizhou.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902e04900b001d73f1fbdd9sm3911643plx.154.2024.01.23.00.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 00:12:53 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chunguang.xu@shopee.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] blk-throttle: Eliminate redundant checks for data direction
Date: Tue, 23 Jan 2024 16:12:48 +0800
Message-Id: <20240123081248.3752878-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

After calling throtl_peek_queued(), the data direction can be determined so
there is no need to call bio_data_dir() to check the direction again.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 block/blk-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 16f5766620a4..2ad4f6cd465b 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1098,7 +1098,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	while ((bio = throtl_peek_queued(&sq->queued[READ])) &&
 	       tg_may_dispatch(tg, bio, NULL)) {
 
-		tg_dispatch_one_bio(tg, bio_data_dir(bio));
+		tg_dispatch_one_bio(tg, READ);
 		nr_reads++;
 
 		if (nr_reads >= max_nr_reads)
@@ -1108,7 +1108,7 @@ static int throtl_dispatch_tg(struct throtl_grp *tg)
 	while ((bio = throtl_peek_queued(&sq->queued[WRITE])) &&
 	       tg_may_dispatch(tg, bio, NULL)) {
 
-		tg_dispatch_one_bio(tg, bio_data_dir(bio));
+		tg_dispatch_one_bio(tg, WRITE);
 		nr_writes++;
 
 		if (nr_writes >= max_nr_writes)
-- 
2.25.1

