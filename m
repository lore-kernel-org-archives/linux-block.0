Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793333835;
	b=aghhxqVYLiri1wpEpTEF6fPmH7njVVqDH9mPVvAt2RUlSH/6VEfnc92IZDWMI8/gMhFx
	 ZvY7DT+mgZJ3UUaFVF0IFFLzrdF41JClCGd2Wz7SJn+UHHAJ0Gt+ozSEa+gXLsnCgmRUq
	 KDv+ljCccm7uMdzGymhqkSY+HinNoQR/YjtOMeBg+7bHwHoFHCNmudGWuB2wiKQqUWgdJ
	 9OoMLz5wJ3EZimM0prRq4IQ8SfZ1UbF3+x9Trr6vTVOtSxROWmf3B8VjJciUFjv+jrwcg
	 1JYe3SN1M1FFE9LdUKbW25RVOJuueTHR73JtJLOXno3BFWLJaDUW1Y9XM803qRbFE/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793333835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=34dnmmkWDdF/oQw4NU5mpC/U4TyeuwFcAYBy77dBteo=;
	b=1zhLsJe3vWv+nhqRHFrm8uSLmnSgRHBTkyHfPGXakrxxiYjnoNXf+bGz6xNhvBxmxmT4
	 79VshscuRsMI2V1IsPQJv4GPFmt4NebL9FLg/4fs2BDrELVU5leX/+Ir2w0y2IMsqx8av
	 i/IQ722QWOAzS3ZGZbpJesXd8RNVePyRbA7bK8yyoilIS8ovJ3T893MjUMwTLFqd2b1tq
	 5oGiEGsf15NwVKD4TnZVJu/WNd5efQXOxxmJ+ZJKdTWroJzZXwpBk0+XLeNRH4ch9CSSQ
	 FVyWGf7ftr5991XwmaMkcj+e2n7HiVhPZpCpLcAtTlKr+SyABOnOpDAdIQW/eFJo0Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OZmzPUqV;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DC606A326
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 04:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF5DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=OZmzPUqV
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-36a1947498bso730956eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 21:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793333834; x=1793938634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=34dnmmkWDdF/oQw4NU5mpC/U4TyeuwFcAYBy77dBteo=;
        b=OZmzPUqV8JacF/fKoK38M0oLokxwF5OISQGwSkwiQvrytldIvdy2QHxVS3F16S/saO
         SFUxGH6Z0JPnX0MO+nTvOV7z46S63NNZKX3H44VmnyzB1LG6ekYM7Lbl7fieZoI16kbS
         7G2LyJrbNyj6RSYk2oV63mP3EBM2RnQeVhMI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793333834; x=1793938634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=34dnmmkWDdF/oQw4NU5mpC/U4TyeuwFcAYBy77dBteo=;
        b=FalW9D/+rEg5/9MixqbdKII8NpZvXlbE+KzSnUeexTziPlsg1NOvhgWrUugWAynStB
         SYMou/Tx2S1eff+A73dXU6ALST8Kuy2e8G/rw6mcDutKjvUQcQHjJ3M4p9L51mbBNaf7
         TgR9zkvgD4pqOViauNGUP5f2nsvQMKzR8AorEvAI06AV9e4FoBFlWtzImCgsi7X0ScFF
         7THR7uiuTx3Nu4uk/QYTyuHVQSxvCsPFz3/CeWCzqwEI7tfA8pxUFvFC2cgO5VHxwmkh
         ay5RGWBt4NBxpqEAAQ9tOwTckcuROiVEkMKPpnEo6SGNHcIEw9EVOOq+dIfW9x9jJbOC
         tSYQ==
X-Forwarded-Encrypted: i=1; AKwUvByi96MWOuPxaBbVmEk0dc1M90tYwtCEMtDGaUZ0uEz8d3Mvw0Wklh6KhWUku56lZKmpGVYEFZ+9lyqyEQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKmTRcreaRYgq0MiuSHRpMvlcnFBsAWT4fg+ZL9hxlkHIWC6LhT
	R1RAmshlH3WIb2tQSeEqlStWegDaDCXhe8cGq0Upsr31fwYZs42KZdMn/0qiZfCodw==
X-Gm-Gg: AYBFou1pLrygZwu6BeaPo4NgX5zXkFOihyNwqIAFdz6MaTqco1dqE9ErSMC7xKSaH0p
	kDMGSwizgoQF989AAEF9a5Yd7hJocqGFfKaMuMxTcyl+VmQbIlf/S+PyOp9kau5GgR0n47OjyQJ
	vCc7brAYl2C54p9uGMTLwomylW90kqnrpnZQvwSmM6FhM4A1if+iwReiNvTBJL414mFdgAQFjYW
	cdh+CzYxgLtYgBu5Do2UII8bsA9bvHEg6u0fcuMqB0No1aaxLUehj4Op05RWrmi2FD6i/970QJh
	dz9xg0UGnjNHIw7EYhJAhBH5BRvmpTB9ZwpUKIsCVZPnvLUiVKE75v2UI2IuS2S/gukdqicQgdP
	uLda+XY5IRHimHsCtJFDr7g1ORPt3T5OvNZRaMRAN07io5z8uaVWEZ9V/dkR/bd5eATPKJ2n3p2
	kUXgcbct4NwPkvA0c/6Ja/9Oiqra6w3zDl165VBwrF36jyxn0I74hP3EoE3qubkcaYBcZFLpCW3
	jjC5RHwR8ZSCjRDN+FGpCcDvleVcIKVlePtjbrRMbqB9/+iJB3TUYm1dF3Q9ChaUxQhyanJJxbO
	fGG2fnfWMZprKh7s51tdpVanGrPW6qf/h7xuWJJ2nYcrH/Nd90WD0KxaAFRTTR8a1X/UVhuGLyz
	ZZn3AsJtSYoZetRB0pw==
X-Received: by 2002:a05:7301:2511:b0:36a:1872:4b35 with SMTP id 5a478bee46e88-36a42203e6fmr1814009eec.2.1793333833628;
        Thu, 29 Oct 2026 21:17:13 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:7476:5b7a:d979:2d91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429467cdsm3329154eec.19.2026.10.29.21.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 21:17:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Josef Bacik <josef@toxicpanda.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] zram: lz4/lz4hc: accept dictionaries of more than 64 KiB
Date: Fri, 30 Oct 2026 13:16:50 +0900
Message-ID: <f2ac22a731e507e90217a5e9cf29c987ec24e2b0.1793333729.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20da9e9a5ffefd1e6875e311d3740b9f3c1061f3.1793333729.git.senozhatsky@chromium.org>
References: <20da9e9a5ffefd1e6875e311d3740b9f3c1061f3.1793333729.git.senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

From: Josef Bacik <josef@toxicpanda.com>

LZ4_loadDict() and LZ4_loadDictHC() only use the last 64KiB of a
dictionary and return how much they used, which the zram backends
take for an error.  Expect that instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/zram/backend_lz4.c   | 4 +++-
 drivers/block/zram/backend_lz4hc.c | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backend_lz4.c
index 9767482a2fea..bad648c158da 100644
--- a/drivers/block/zram/backend_lz4.c
+++ b/drivers/block/zram/backend_lz4.c
@@ -4,6 +4,7 @@
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
+#include <linux/sizes.h>
 #include <linux/vmalloc.h>
 
 #include "backend_lz4.h"
@@ -39,7 +40,8 @@ static int lz4_setup_params(struct zcomp_params *params)
 		return -ENOMEM;
 
 	ret = LZ4_loadDict(dict_stream, params->dict, params->dict_sz);
-	if (ret != params->dict_sz) {
+	/* Only the last 64 KiB of a dictionary are of use */
+	if (ret != min_t(size_t, params->dict_sz, SZ_64K)) {
 		vfree(dict_stream);
 		return -EINVAL;
 	}
diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
index 2d1364a29b27..5825c8ba78da 100644
--- a/drivers/block/zram/backend_lz4hc.c
+++ b/drivers/block/zram/backend_lz4hc.c
@@ -4,6 +4,7 @@
 
 #include <linux/kernel.h>
 #include <linux/lz4.h>
+#include <linux/sizes.h>
 #include <linux/vmalloc.h>
 
 #include "backend_lz4hc.h"
@@ -46,7 +47,8 @@ static int lz4hc_setup_params(struct zcomp_params *params)
 
 	LZ4_resetStreamHC(dict_stream, params->level);
 	ret = LZ4_loadDictHC(dict_stream, params->dict, params->dict_sz);
-	if (ret != params->dict_sz) {
+	/* Only the last 64 KiB of a dictionary are of use */
+	if (ret != min_t(size_t, params->dict_sz, SZ_64K)) {
 		vfree(dict_stream);
 		return -EINVAL;
 	}
-- 
2.56.0.317.g454f8302e1-goog

