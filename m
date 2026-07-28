Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB90420485
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785231032; cv=none; b=iF+iFKiaE/KdrL0cX5kLb+hC+9necux8NP/ziLItxqh3FMcukTXt0ER3zbrNFkHMKYUbo3pTIN7cfaNGvG24ATGPgSYN3iMXQ54ZoB9iwG+7XKM1txaIeAVEyz/LBuGCPDaaTOqHsMoKxju3J98DEeUby0O0h9khRRgS5rbLPRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785231032; c=relaxed/simple;
	bh=n8MwGhJ/75pb4wpTgYDxyoaUrEFuPlhmcCBrrbftRMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RO0dugOv4rUNs2EAw+LjNiex3aEdBeI7Ki2ExrLmOAfHYigCdZeyvnqMh0iM8h4okKiHcjnDt92v+Mi+KI1O/QHEh0VUhd2ZfiXk3CQ6rxXNQiVWQByT0ena0RWNIdy942kV9D8WElzJLTopZPeO7TWvDlZa0goSvqaTlHXxkYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=behvWsYp; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="behvWsYp"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2caced6038eso10734715ad.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785231031; x=1785835831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7dyH5rulolS1I/mubT8f5+NvCip7tDn3m0HyPeyvx4=;
        b=behvWsYpx379wJgPkxFb5JBgntriUahuScpy0GAgjYxSbWJVO8bhLDK1tctolyJn5f
         26Yn0x4cMdcZ2ZHaVl0tvHsyAV2dyJwY7Dy3QdJjwRlQsQnXOm4PuXc/nRcnVY7L8RJN
         GThR8jCt5jPp530DgDkGggz44qdDpteRYZ93w1IBILYSWBWmgEdg/hV3G/JpMTa9FPSB
         Wd6B8s5IfjdLeEpLf3XRFNajajfXV4qA3wtZGBUG/uQnYI8DVAb9MUhpH5KyuEb2qrd+
         o37ITuJTZaI3rN5ju+1yX5KHIjP2PHDaKbWjsOfmywaNSicX49lcAQhQNheFOIzAIUM4
         EnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785231031; x=1785835831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7dyH5rulolS1I/mubT8f5+NvCip7tDn3m0HyPeyvx4=;
        b=eBkx04wh2aOMJm7eVUtcqxHIW6Z5fSlQvJqB03kccME6bF0gvzH2cFem+3MeJ4fZ+w
         beyFdH/7PutqVOZaq0BMNLRb17v/+phkBcsPDN9gV9y2yWQ7MtJXDnYPYNHGkcfyCr1V
         YxQS36NdpX1/LmQY37VbfK3nK4qNgaPYcQ5mHvzIdWcQ3QhZqeRO3hXfQ0pRwK0W2+qb
         OsXZdiUZYocTb/PLYtvb9MwkNPsjzeeALgOfMXuMjQ5ACe51bwt8IIMFQWgy+ah/1Gsr
         9CalfkphRgJ+HDOlmXjjT37GCCjtEYIxqz0wHv8hsiD2xqOWzC18VafK/q0khJe8qbr4
         jhDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0xOWbMECmmZ+M3HTzroVBtqYNW8FhLul/I5wxkF428jcOzA0++vUJP9SkxQRAT7H/oy6LHs27ERK2Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wAfgZhAR08GlAJwThN8FYEwJ/Z6RfN2XWnu5LkCCgvoMDq3k
	ICv7d/K9Wj3np7KO63xTisClJOeg8TjVPQNUYhFD5xS6WjV4SMdH9OUP
X-Gm-Gg: AR+sD12II9wJuv9w9gSGemNPDi9aNFtc+zi1UkGksAxmxnHMwqWM20oJDmkYTyfOtZ1
	0J39twZz2B2IIJdJkiSJfrWalBE+ihtHfPVURSvc7VnEqHOt0mtLCewKAs861ACKvH2OguvXX+T
	s7TTAiOJv1Q/lhgkDqm1rXYQes2FOKthpj46NKaX5VZrAr28Qck3rQrYCpbrSt/bUkYFL+u7CoA
	jLx0SxEGgyOnfinw7i8YWSEwOMoLOfGaYNkdaz50Z46ukcd1hv9SdsRNz7mO+/0F6IONIDhL5Cz
	7FkVEAD65rwBz6vCT1yW3g4cNWuaAUncCBwubW8Ewp+rSynvhW48rd+qYoPsnIB9HOr00oiqOrT
	dUua2PNlUUGZAgzQFPhRnWd/mq3c/pbZK3bORnW7hrJEecftCdstzS0Ky5Yl2Ki/1lwNReJu4c8
	yHfWb62Grzp8pnZMNCiWAOjc3z099aeQhazAQ0j0C/zcJvPe0=
X-Received: by 2002:a17:902:da90:b0:2cf:b23a:3e68 with SMTP id d9443c01a7336-2d015eec531mr17264045ad.25.1785231030886;
        Tue, 28 Jul 2026 02:30:30 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7f4b01sm49151225ad.71.2026.07.28.02.30.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 02:30:30 -0700 (PDT)
From: Haoqin Huang <haoqinhuang7@gmail.com>
To: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Nick Terrell <terrelln@fb.com>,
	David Sterba <dsterba@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Haoqin Huang <haoqinhuang@tencent.com>,
	Rongwei Wang <zigiwang@tencent.com>
Subject: [PATCH v2 5/5] zram: reset per-priority params when changing algorithm before init
Date: Tue, 28 Jul 2026 17:29:35 +0800
Message-ID: <20260728092935.31139-5-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260728092935.31139-1-haoqinhuang7@gmail.com>
References: <20260627070216.13511-1-haoqinhuang7@gmail.com>
 <20260728092935.31139-1-haoqinhuang7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoqin Huang <haoqinhuang@tencent.com>

Parameters validated against one algorithm may be invalid for another
(e.g. lz4 accepts level=65535 but zstd does not).  Although algorithm
changes are blocked after disksize is set, they are allowed before
device initialization.  Reset per-priority params on algorithm change
so that stale parameters do not silently carry over.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d86f4eb06d58..da2921082712 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1661,6 +1661,8 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 	zram->comp_algs[prio] = alg;
 }
 
+static void comp_params_reset(struct zram *zram, u32 prio);
+
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 {
 	const char *alg;
@@ -1681,6 +1683,7 @@ static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 	}
 
 	comp_algorithm_set(zram, prio, alg);
+	comp_params_reset(zram, prio);
 	return 0;
 }
 
-- 
2.43.7

