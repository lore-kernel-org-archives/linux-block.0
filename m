Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725819D8BE;
	Tue,  7 Jan 2025 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736232899; cv=none; b=Hx0Y1jxZnnH84jjdCHTr8Qa0RJtGB0hFndEFdgPvt0Zdd7TOQoUkpCa8W/mPQlHVQq1qEp1wmynM/VdzXYkQkkxCBgFKJIiVVHIHES8l2opkRiMt+Z3aOBdfrvkpaUAL7xbyJbgaXzEJlkOW5S0wQaTrnYYbyrskGkOJp6vvGEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736232899; c=relaxed/simple;
	bh=VwWIytBiyKODF8sDk0339JhmPQQShvizgIsXKmZ6Tz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CPWRzjkxqpHK2M24jYA4LNdKuDqS1oOoq7yPdoHyQxs32sAgk9g2GSQA+h6BgXW9hBjBdLF3fcfj1fj+GVboOLd+vohp5rokEhQx28dyxbhNPPH7pWuIfCcIYe8GBnJLDa1kcSNm6T7BfbmY6UowWbfS3nLaibcw9FXy5az3H1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2pAddSg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2pAddSg"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2161eb95317so227262305ad.1;
        Mon, 06 Jan 2025 22:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736232896; x=1736837696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UAGMcbItJcgVx1BJcJubscurgM31sK9kE3pcE4njB+Y=;
        b=b2pAddSgN002l1Mq1gP+XbTObxJD+eMLS1hpno2ca2a3P6bKNY7BpI6tC3nBfO1QlD
         nNlV7aT/w92LgBIZC60+iG7wKM1rwBIF6nakMqK5ip+eBW5LLFWlVlq7gwGpNIOAGa+e
         dDgkRPi6PSm4i2TYvaX3pMgReenGKPMWjK0DP9KhMuxfmSusfMOpJkXD2oMEYFnAmy27
         4XIl21Zxiz+0SXC3io3KtprfZKgj87Qy1Kxu5HRg4FtNA4aUL2JQmAdMtLdl7qPNTQFs
         Y0ibmv6wuGawig2JbMkjJ+wZSRMWktNrbUcfJOEEItBmC8Br/tNgHOC7T3i7Oxnw0VmX
         xncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736232896; x=1736837696;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAGMcbItJcgVx1BJcJubscurgM31sK9kE3pcE4njB+Y=;
        b=pVbyjpZHqVcUYyG5fu8VgM2x21PN8APzCKz5LtoGoTH3D1PSHfjTkLTcNwMJI7jp+L
         BswGIUEjJd9WCsMZkAAy5JpiqqK4Vg3geoeSqIUu1zW+IcEwACFDAyKqVw//fMaSuJ9v
         DTq4mXyKvO0Ng8tIiyY4ahp5s8Oy8VrAieH/u3LvmrvE/6fmH2iv2DWSI70Kqj73xEDF
         m0NIZ7CJWEw9IPspO1dvwLxXfqpAC8hm5nvIPwr0kIONzgIwPC5ZZXLsOMcWEvRrkRcI
         56JTvXyslqboQ8yAuLzDLCDc8OjOrbdAOU2OM5/MqZRaucHoBXUGr3g95667k0NtwDqz
         UZDw==
X-Forwarded-Encrypted: i=1; AJvYcCWElDI+tFAftsJr/+I91dg0GhtEaOGOFCiu6VZbKOAmAXTCMucnbb9y9L+Pg1NWJMY3oX9m4PR/40ZRm6kW@vger.kernel.org, AJvYcCWkl2pRXJpoSitN/+r+8ohSguXLh0fCNbehddNFIYKyoQi4f7O9+knMCLXmhqe5fyXOvEwtHgQd9KDgkA==@vger.kernel.org, AJvYcCX2HPTYrz5ouNNoEqO3+yOjBRSuLPIcn9vzNlatPsObcyz1EOmemK/pcKlTlCZAXMTCv+rGoC75@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjRQR9Ee1AhuY91VqQOOxTOX70K7kFDaJEVQcHnvvf3TfKYX6
	3cxqr9m6jMUhH1HFJo26z2Tm0B6+EahYijF6DjksZYcY30Pod5II
X-Gm-Gg: ASbGncsUaVTubYYjwtrr9aT+y1vh9mpr191r6ZWmztqGiiiM3rI18syWcn21sIUQvTW
	AOvXtslGSBcUUtvknib3ha7LeEYuHDjS88naREiNf+DX1NA6WnLON2qAHdtGP8Eqke6fKlUGX7e
	psCx8BduSekNw0/w9M8htpi3PlSW6CjtCJ3m0IxB1paTBCVC0imxY4YVc2aCCEs1j2Fc9WZajo2
	kjtTqX2B2p0dlfmP6dJZ/HhT0bCmfWurNlyHbjTlHsoyj+EeSn3YpyDT6S9I739F546w8Oqvyn4
	mbEC7WyBjic=
X-Google-Smtp-Source: AGHT+IH/rokoDHhdWH70D8pzZfQjuA3uS056hYXnmvp8qqmn4tHgv2fW5pCbgpVbtlqmIXl+0w3e8w==
X-Received: by 2002:aa7:8895:0:b0:71e:2a0:b0b8 with SMTP id d2e1a72fcca58-72abdd3c48emr83145233b3a.1.1736232896082;
        Mon, 06 Jan 2025 22:54:56 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad90b338sm32692136b3a.174.2025.01.06.22.54.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jan 2025 22:54:55 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] zram: fix potential UAF of zram table
Date: Tue,  7 Jan 2025 14:54:46 +0800
Message-ID: <20250107065446.86928-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

If zram_meta_alloc failed early, it frees allocated zram->table without
setting it NULL. Which will potentially cause zram_meta_free to access
the table if user reset an failed and uninitialized device.

Fixes: 74363ec674cb ("zram: fix uninitialized ZRAM not releasing backing device")
Cc: <stable@vger.kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 5b8e4f4171ab..70ecaee25c20 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1465,6 +1465,7 @@ static bool zram_meta_alloc(struct zram *zram, u64 disksize)
 	zram->mem_pool = zs_create_pool(zram->disk->disk_name);
 	if (!zram->mem_pool) {
 		vfree(zram->table);
+		zram->table = NULL;
 		return false;
 	}
 
-- 
2.47.1

