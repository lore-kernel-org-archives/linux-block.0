Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23585155322
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763797266; cv=none; b=RnsN60Agi3ls2wAigblQen0WdTSjOheEATkFDT/IfPl9lhc7RuDfEY3uOLetKyUP8oMFl5By7fT2BUPPOnfh+sgADUz4umhYoNr9RZN7FQYjNnDRn1NhH/kS1mvot3+haxvHCGDXhUPUAtN0kYESfcDKGN+GUG3vkT1g2xhiXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763797266; c=relaxed/simple;
	bh=qElJlRCsFrs2BiuIGEpQgPbhmv6Qt0jtFelo/Sc3eqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WO5aX2Z3sS/sXhOvh/3RHBiZRuQ8NgjZC6WXauLwAD5rzIJHUzlhvTgLWaKvO7W00CzjMfSEcv7LHxz2oaWb725yCtPQ/BN5kYC6lWjjvba72yZC0luxUa1DpN+6fhPMkP6G1VJhqB4cD7O4XwNIVHU47Ze75ThKVo1oIkfqGzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DxlxOgIu; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DxlxOgIu"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29853ec5b8cso34404005ad.3
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763797263; x=1764402063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LukW8/snVEFz9ku8flFGtdBZP5+NLLDt4ByDCK08AXY=;
        b=DxlxOgIukSzU+b8jpRVFOByvHBNKNIUyBNWRJlwVYmKPMJkv0csXwp9ZF+QfVZtuSA
         heHumVbvH2br7IPukBcS03iirWgTZosPoo9+aG39eO+/Akw+FEvaYDXwvBt8sOSnzEyB
         mipvsk73leBSsFImjJvgfEO6yfdnKmNblRpOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763797263; x=1764402063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LukW8/snVEFz9ku8flFGtdBZP5+NLLDt4ByDCK08AXY=;
        b=nbmzXx00qbNjWTVpIs9jFlp3ZnbTvFCsmNiDAR7R4yqUWjmtjAZb6GooTZnU3H9C16
         1HH1CbbM9Pcp/YU0BcLJZWVRbvBzCTVPSKPHk+5Ij7NEHBp9hheGA9cBZI8UMhzhwvg/
         uHuvgQt1tiFw9OL9tTFjXgNqIyEzniIpz3cHLccm/WZ+WCrsDeKR+CzJH90caCCKpA/Y
         yPDzyslu425dguhaTVDZa5V/ajrM4cyamlY5RT7simpVKcip0w1UqGCuCqzolqISoq/U
         BR+0AzUrU/U1/B8F42OftL4xK0J0S/rfmcQtrTcXV88f/aCVShaSkUz/VAl2OdDT363+
         k0xg==
X-Forwarded-Encrypted: i=1; AJvYcCU3QnU8uMm1j4HOm7zipcvU26mqEOAovEkBJVkk5oGLwTUhZvITxnaH18wOZkMUNimy+XJAVGFhNZJEDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVp2WHKsu7UZ72CDZLoGfcW0ndzSIZVtHS7CzMktnuNIZbo3zZ
	oAa4zrOvySSn9GLRwEY8WiGa1WQibv9MwAnvWoQSNhI5m8Udcix0AzfQ5pU1q9Irjw==
X-Gm-Gg: ASbGncsDArcuT4v2e/kqYsO+TCFbO3pu7OxImlUvM9uK2C2w+NSOTQym9gFuXGWLlua
	UYATbZSO30yE4BQlZ+g8cFvXgbYj437IWtyqYzFIAZfa/1JXrgnaeQMLlSXEmA0IYAxOlEUWDg8
	zdZ8i44X7DZoxQmYUd5J7NZdhVmUW4MxNUyZQ7pbzJiY2vYRQ1uqANjraJlcBCFXSsPwyP04EDY
	c8n0+STzJP4Cl4jCt+6gNvhlJqi1L/QBYw1SBIVFXrrWKjCpJmztmJQiXxNvLmTJRnTUosAy/vQ
	q9ELksnAbLfr1+8RfsRj6cE4SKcAsvjcJQsvct55drBTWejtZeOfaNhqbI1WwcWGMdYzuGc3Dbj
	LgndA10xWVJk6Msh6fbZcbkYEW0tU3TynxK/f7omnvZX9rWT8mOWaTdoWWvzj4j6LX/zbw/u9Dg
	KLgd4gfDQ8bKbCR49Cr2N+3cb0knjNeQA9Ta8NKO/Cg+ZaMRirnl4a4tpPpc9OSm94Pqjl3DR+L
	Q==
X-Google-Smtp-Source: AGHT+IG5fXLGOtdx1TXZEsH8pnjPldKBNeNKvpm0G0lpVW65pfoy/FrInnxHNz+d96LXs8VdsDk4Tg==
X-Received: by 2002:a17:903:19d0:b0:295:2276:6704 with SMTP id d9443c01a7336-29b6c6cdf6cmr49815225ad.51.1763797263463;
        Fri, 21 Nov 2025 23:41:03 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138628sm77771555ad.31.2025.11.21.23.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 23:41:03 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv6 6/6] zram: read slot block idx under slot lock
Date: Sat, 22 Nov 2025 16:40:29 +0900
Message-ID: <20251122074029.3948921-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251122074029.3948921-1-senozhatsky@chromium.org>
References: <20251122074029.3948921-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read slot's block id under slot-lock.  We release the
slot-lock for bdev read so, technically, slot still can
get freed in the meantime, but at least we will read
bdev block (page) that holds previous know slot data,
not from slot->handle bdev block, which can be anything
at that point.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1f7e9e914d34..3428f647d0a7 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1995,14 +1995,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		ret = zram_read_from_zspool(zram, page, index);
 		zram_slot_unlock(zram, index);
 	} else {
+		unsigned long blk_idx = zram_get_handle(zram, index);
+
 		/*
 		 * The slot should be unlocked before reading from the backing
 		 * device.
 		 */
 		zram_slot_unlock(zram, index);
-
-		ret = read_from_bdev(zram, page, zram_get_handle(zram, index),
-				     parent);
+		ret = read_from_bdev(zram, page, blk_idx, parent);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
-- 
2.52.0.460.gd25c4c69ec-goog

