Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4439A7F2
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 04:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792125885; cv=none; b=typli/3WDAwn/vw5msHuIeJJXkPzL3QtBkSI5Mqmp/wyXpZcI9G8UeAdj/V7nof0+GMwc8JG6v/9QRcSzu111BCXqXMaKVPJ+gDeBk7DSFdc/B3TchbF85Gg/Ld9ORQDaRJbMJyy2P1gzHwqRXFpINZnGIQ6R3pqat20qR9y/r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792125885; c=relaxed/simple;
	bh=AjrjMTpYbeAK4JI6FtEtzk9rlqw3yHKLbp/+E2qvah0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCugB/53KJjHGpvod75qc1GKGIEA1cQ0F3c7LQjQ20YlzARtffrOuok5Y5ta1qvWAm+54726qLMqiiSLovNUscRHioPEC5xztgLY6zd+qcWbKf8UnbZ5/HucSaOrzGaVpHlY58+E8eEAb5NSLuieeLghJMJH2AvntHSHIojHJw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q8TjByhi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q8TjByhi"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2db80fcdf8bso35258965ad.2
        for <linux-block@vger.kernel.org>; Thu, 15 Oct 2026 21:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792125884; x=1792730684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ekUzfSCWNq1Ng7vt6OtO+4tAJn/2muvIGZQLxicYOuQ=;
        b=Q8TjByhiAeQt2n6tvRO8KD6s+dDLPFuveUuxposNl/5T5Z8yvI6jFAPFvd4k9e8gYK
         FJxUNYDKra584ewXTicTVZ4xZda+eCKRayvzAHzi2AS06uFQs3cCXzDyDBhEwmrPlKPx
         a+/xgIA979XynsDEawKVyaM3Neua+Jp0HownQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792125884; x=1792730684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ekUzfSCWNq1Ng7vt6OtO+4tAJn/2muvIGZQLxicYOuQ=;
        b=vJubw57J/W3Idg6PqgduohdlksfhblnQEAgxYUIZ/2g9hB69mc8qdD5RasIebqf+3n
         U01gPsakwMhac0YTafThK9ylgRy1Hv7uuVa7d0frDStHKXQngwnv7/gBI0UmhhRMjJ5K
         0c3ZvoaSFQ+YBVs/GI/4BUqf2c2B5XYpvAEXHNNJttIm3WAZXIJ7kOTK1dQwQoLQgmOH
         fKY6Y+AJvLLOVfeUH2q0rvSP3FBtnG2zGPv/LkTTiK12gfVM6HeZByN8V2+0bHQgQvAc
         h4CNHBaZYGz9nNeXCSwKOEjPCwVbiHHDBxAaP3zVkfBmqECJnXxKlt9uf+DuJ5gDLAQQ
         bUCQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTbcQd1xJ5xK64K7PkX/jZn+j38ZQfluLQx6jmQDgMxg8W7O8f7IaISqOR3TL2bLPlNJ1zrpxfEACCKQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYK/gebhbwdS/L4JwyUjLMIYDJB1QB/AkkpSsU+gOYbLN2U16lWB
	6XnJyhWTV5qtNB9FWgjtPAkYfNk9krTwjkufOtzkAuReVa72RYg4LvuPUAwyWsrACA==
X-Gm-Gg: AYBFou00rAbjahe9QmYypjVhpHhibtL9mdyaS4Wm5LfwCqMxlIFm+hDkgmdT39IeGMj
	R27Q/nkWrCm9pyQL7cK3pRWcTXoDU1fR+3r/ucZejVuJs/ZP8VRGoZOdXiUtGE8Q/N83wa5Po0e
	acrg7UzYPpk5wIOh2hYBOZ5fpxPGRfUO6XdUrOmCkLkhrB+dm2PwsBFMi8xzO7KbXtlJRTtWZS7
	OBqatuFrbC4HdSeuR9qE+cMo9X6RpyuicZmxyQa9hpQPjZGjAUSBpi2VLeMhYH3l6B0Hg73zaml
	dOJRPxkmHKG7IzE7BMJLayyYRYx4buad5gwlunSqjP9DzU4RJ0IAjNQdpO1q0OqEGWd3hTsVfhX
	LL6xj5dMf/KZ4CQ+tawks6a1Y5aOgZ1MX/3R//zJZfvxUBrjmCUDuJUfznKyxTj9gx7BlXFPxEh
	a6dp6rbCZ76VZJFhHaRfrqgC3Jn8t2v7pVde08cXmrBlHvi5rZ1q3CqCYUo/hz2yxuA6A+FDqCf
	CQsOkVTkFIi4Tper+DNcFt/hMOcqSUao9wyQZy0MPYd383mfnMyGAZ8x8HHkbM=
X-Received: by 2002:a17:903:1a10:b0:2e9:7b4f:b98f with SMTP id d9443c01a7336-2e97b4fbaf1mr15649355ad.6.1792125883969;
        Thu, 15 Oct 2026 21:44:43 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:a579:8b87:8304:7ac2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8b1b5esm4137235ad.67.2026.10.15.21.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:44:43 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v4 03/12] zram: zstd: do not allocate empty C/D-dictionaries
Date: Fri, 16 Oct 2026 13:44:08 +0900
Message-ID: <20261016044429.1304561-4-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
In-Reply-To: <20261016044429.1304561-1-senozhatsky@chromium.org>
References: <20261016044429.1304561-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not zstd_create_cdict_byreference() / zstd_create_ddict_byreference()
C/D dictionaries when no dictionary was provided in the first place,
because zstd still allocates internal memory for such calls (~96 KB at
default level 3, and ~160 KB at levels 9+ on x86_64).

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index 127976b5455b..b367049f131d 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -76,6 +76,9 @@ static int zstd_setup_params(struct zcomp_params *params)
 	prm = zstd_get_cparams(params->level, PAGE_SIZE,
 			       params->dict_sz);
 
+	if (!params->dict || !params->dict_sz)
+		return 0;
+
 	zp->cdict = zstd_create_cdict_byreference(params->dict,
 						  params->dict_sz,
 						  prm,
-- 
2.56.0.176.g3575e65682-goog

