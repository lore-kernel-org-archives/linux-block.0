Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1F37E5CF
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391334; cv=none; b=nVSzc5MweosCNmL29EexlRU0yp3i63Kh9HgkBcR8YmZwqXkTZ5doOtxT2rR4Z0Q06knhFUGEAqD9VuDMSpL3cnPGQtZec851RlejSBxsOU64qFQgy6tImadLtIXO2avvzyDu2uT74j2f0XVl4Vwf5444HERVt5lzmFpzSjocLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391334; c=relaxed/simple;
	bh=7nGqUdXLkhzqgzqn9ZIyxqq/NbEURTBT8NmXn3owQr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iR72+DKm96ebFcoCZxqR098rHBScbGaiMhysr1AXeFZIqbbuBfHMBNuxup8AX/OJXqMEweIbJ9o9Ikeuln6g+q2ONzStUsLe6Pyo+jYLbb6s5cEsMY2knT1joLDkuma1XAWZthtuZBqrJ7vCABvFMVg2Thl5lhoSaxl+xYfaJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUd6P3rF; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUd6P3rF"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-38111ea8a88so1091651a91.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391330; x=1785996130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShJflXgq4bO2T2yjTVMinL4p4VKls2GUVGVA0j22m60=;
        b=IUd6P3rFnDARr/CYC1htxP5EPXykj1+Lj7yddwwe8vTtb/hUO5MvbIKUMGkgEUlqNJ
         sqJJLpVFTvyAirz75DiGOMeR2mf8ZsxSc8ECWvYJj/0zdKMc5J+8+8hMh1NbTTjQkUKj
         E2eMhhYR26l5IPA9wDWJn9ks9OlqEda9OdxJ10rDXvGR85gusyXI67q9GM5udAZKj+ND
         iCyDAJwTA+Y/XJH8n1NNHBT6tMceAR4oYQmW1W+2c+8CHPPO+BkUmWVeywheI0m5xpNe
         48vUHnULftLw2/paTsZq61e8VpQYyqKdlKn9wKrrIWvPEZgj095MdbTo9Z7TgN+XICbd
         OWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391330; x=1785996130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ShJflXgq4bO2T2yjTVMinL4p4VKls2GUVGVA0j22m60=;
        b=OjE11ACgJJy5VC20zef9EcUtOwMDu/iuc0a8nbV0M5YnzRhOAiHTKz8pnfCSiLCiTR
         6Fu9IBpuRuh5HE8gOeiYWuw4FtYVljxw9CA4SHh14D6i29/UQqbbZrTgoyBIa8i6Cl26
         VnlW3ETbuOvfTBLm6WS/gWgXyaHQcOhkSFKyxQmlQdZJnbu0n+8S0I4CEy6Kx2WPa6MO
         hQNjGcgpFAzKBF8AYyVQCcm2E//SqwauI5QGy3CRFu7lfeUuqJ98lWlR/H8VYhhKsh/U
         0aqYPAgEGs1mpFMXkk3CTtvjXu6m9T5YEZ3x+PaiFrgYBJJGP+gII0JaxuIW1pBAfAHP
         SU+Q==
X-Forwarded-Encrypted: i=1; AHgh+RoNJwJA05ikUshPhIBdIVrPaGW2NBPVWEnh+4hzu+VPUrzLa4Pk3F8m+cUs3ubRQRERxQDRWtMnRxu/Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4oO+FkuASy7yTHRRrgLZ3BltsYYolLLr1vJm9lo8l1VA+v5fo
	D5nfem+Ys+xLFQ5Q7jIt28+4Hmd0kV3lK0jqKN6AHaolv44fCMl/numTdDBjw0Nm2jA=
X-Gm-Gg: AR+sD10dN7hKV6+Tx0zpKXJXpOlA1CTmOzXxwGl6K+XPJMGZqGW+6HZuGeu0eok/LhH
	AcWHtk1vTzlO8QDe0fF7ISFTwMVpusR9g54KaHytZU4thmCsXFlZrXB5StBaxuCJODx4cH6snh4
	EFI5MtrdvXC4MPKJzVZzX3ddAIaEvZ/FnIlNnVVLFjOWorbYX4uDP9I99NSzAVMpaxSI0CN6wX7
	Ml9Tgtde2M7PkB6Ivvo42y8CPmP9VluXVCdKTHFEUexiCtkqh2JMA3HckhuHpkAyIZQ+eV3izA1
	AsNexZc3gKm9ogVB/Ksqek5buYijDhk3UdqLN2yfCxRW6CIiDLs/SYSIHEKez4JmuFhYSv95BgM
	ATbVkiJWHfAowiS4LzRCUJHiCE4H2qg1l/X6N78oIyWjXCGk6LLOoHXeW4FXuKVuMUMQ6aZi5ya
	MfaCTLT6bEudR/nNpEkdHHDmvjQ78LJ6uT+OsIBVVbT3Fo73z4p8CIAycsI+wair5f3P8XS4Cvq
	eFQfcZOigFIn74rPdqhC+8mVCkFs2va7Q==
X-Received: by 2002:a17:90b:1d0a:b0:37f:9ce3:ca95 with SMTP id 98e67ed59e1d1-38f9c032a32mr1174744a91.30.1785391330131;
        Wed, 29 Jul 2026 23:02:10 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b42d6c8sm430737a91.3.2026.07.29.23.02.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 23:02:09 -0700 (PDT)
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
Subject: [PATCH v4 4/4] zram: reset per-priority params when changing algorithm before init
Date: Thu, 30 Jul 2026 14:01:33 +0800
Message-ID: <20260730060133.80233-5-haoqinhuang7@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260730060133.80233-1-haoqinhuang7@gmail.com>
References: <20260730025240.17724-1-haoqinhuang7@gmail.com>
 <20260730060133.80233-1-haoqinhuang7@gmail.com>
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
index 0223fd83bbba..814f0af4d77d 100644
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

