Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37211E1A17
	for <linux-block@vger.kernel.org>; Fri,  9 Oct 2026 03:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514916; cv=none; b=CWdmP4R2NMwdHXns10SvAf7mWmXtYlTTkzesQMPzlKmKv0lY6Vqvb5jIz4CJ/O6Dqzg1jutKMGvI8MkMFgBd8U3z4Tw9rmmYhiVtEgywKbW37+LHoL+YRSbPVfGtm9vaB0y58/hJeSRX6pA4rO0E6t00/W4zaaBDjt/vs4Y8f3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514916; c=relaxed/simple;
	bh=fAfeaYkRoda0ScYbnl/LdL1i2AxcArp7U3fGSyNi7mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX4vlur+fptLpRwGQTAf52BE0bEa23sPRvS99RT5lcvbf8KvaRzfKU0ZI3HpejiPEjepgzMd7b0fJk1RxM0HlwdwbMpPwyG4wjHLlMauT7r5zhm18TjGgDizOvF8D07ZGIXMnjiHks5IxeaOMBP5ExvQiPLchCcM9C4zQQ/OGeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=taBkoJWU; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="taBkoJWU"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-353804b591eso270414eec.0
        for <linux-block@vger.kernel.org>; Thu, 08 Oct 2026 20:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791514914; x=1792119714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aC/g7xjWVfJaoPMEUZKtxHfBHePPvpHU5a/3ivgfcfw=;
        b=taBkoJWUdC7LUlzncUUtHUelMfWg28NmvAM5V62agkjKlGp8sEuqr/7ubu2vUxavua
         zJWeUPHFlpU6aK8NpqBBQWXVYC+o3Xl6e5GcIo9SxEKWUBRTGbcOEv6FTBNr6lu6mP5N
         Ui/BifTCz0NI7fjKU7Uh8k5yZT2epL/uqpEe2LTpPWo4/fEEcQzKT3STlULdFxNRmGEL
         J5TYvZeVOy/+yQWv54M9FjlHFBnpxUDW4JhUxSUn2hw25H32Bto1WaK0CNfR7sMAIRY4
         +RiQ0on7aZTy/MViDA/T/a7DxSdniLUC7cdtTizXzexVxAZAic0pRFxDjbzK6fEgG+7n
         kJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791514914; x=1792119714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aC/g7xjWVfJaoPMEUZKtxHfBHePPvpHU5a/3ivgfcfw=;
        b=ZgvXbEYlk4Is34SYWO47wBpCivHiiNSh3sHU56BYYIoyWlbBz98wYR4ig7TjU4XQpK
         zU6HCEN37XJtK8zxP0HrPSXV3YDmKWGvQZbrQUvU2DzvvE5RF60fbD9NuT8VSZWauuEn
         A3bNpt5GcSV5H8S3tnZyv3WrR1ut8WnKH0FZ/uT8vMfczS9aWzPYBT4GXtLe3eplMwaM
         zkvknushT5GrQscABUUjRYKCV9gugOk/VpMo6GfzZdn/vUuj2rlcFMSgZlXwyBcRQhI+
         UIbJ3c5CxLj2JZOw+NT/X5GiHsijaevkcP8tl4BZTp5OnGpkex4OXAWt0QsClAIFLCxF
         AqmA==
X-Gm-Message-State: AFq9FYIPx5UJM6+7rpokTglOqHzkaPfIwtbrFZIsIwvYui1O5ZTHzqi0
	/hLeLr1nDzN0k5/ZtxXwgj75opTDA70VPifC3PGcqQMjUUXUfEhNzcSOnjzPGsv1/wSqahhsWwg
	+qtiLpVkYdHI4eNjHIBIjONbonb+N+RIKvBmCf3+P8oufv+0FQlHUluja0g==
X-Gm-Gg: AYBFou0S+wcKlWOUkuaBe2joAC5d1l2kt0O2TI8yd/dtxDnngePa73G/OGuYeD+acHi
	hs1TQTB1L2PNmpPzqvJKUyTofhm6+c1cBs7DJa8V48Lrhyw1PDY6ESgqbGtOVW3+RfCKWPHPJ/q
	WUGU5BCIg+V8P/Dxos/yIIc6lDJaWM3pZHJWWJe+6XaLsNTWDtB5i7mgWcwws6FIf/xXf/K1tfg
	bp058pNiHL/CHQoCx9RlikFA+HInFXsfg1hOSWBjeQ2YtrDZorkDZ89hXD1T1ntQXhMETNAZn61
	+CnZp9+c9pW9byAQM7NtPwJnuEElMxFXb17Ky2fvLchAJ0JW8TQlopyoRj1x4IjAwDkardeCd9f
	UnirpnGkNf94yyEsQIRrNxC5RQEln7d3JV1bdKD8yPPXUDosIypOILBiQVnj8GX2xVszg1d7fbK
	B9PYqFNtAZU947FdISPaA90x/GKMfuMSpbLFrqJXdCEvWwXtO0YUY0pF7xP75mH89l0OXm+wrt4
	ZdtpVZjrQ==
X-Received: by 2002:a05:7301:6e98:b0:33c:e74:4624 with SMTP id 5a478bee46e88-3537e112919mr1091305eec.27.1791514913646;
        Thu, 08 Oct 2026 20:01:53 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3537cb1e02asm2427626eec.27.2026.10.08.20.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 20:01:53 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Chen <lei.chen@smartx.com>
Subject: [PATCH v1 1/4] blk-mq: remove stale comment about non-present CPU mapping
Date: Fri,  9 Oct 2026 11:01:08 +0800
Message-ID: <20261009030111.57784-2-lei.chen@smartx.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009030111.57784-1-lei.chen@smartx.com>
References: <20261009030111.57784-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 20e4d8139319 ("blk-mq: simplify queue mapping & schedule with each
possisble CPU") changed blk_mq_map_swqueue() to iterate over all possible
CPUs instead of only present CPUs, but left the comment claiming that
non-present CPUs are mapped to the first hctx.

The function now uses the tag set's CPU-to-hardware-queue maps for all
possible CPUs, without checking whether a CPU is present. Non-present
CPUs are therefore not necessarily mapped to hctx0. The fallback to
hctx0 in this function handles tag allocation failure, independently
of CPU presence.

Remove the outdated statement and retain the description of the mapping
loop.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 block/blk-mq.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a26a11c73ee3..59452b855afe 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4173,11 +4173,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx->dispatch_from = NULL;
 	}
 
-	/*
-	 * Map software to hardware queues.
-	 *
-	 * If the cpu isn't present, the cpu is mapped to first hctx.
-	 */
+	/* Map software to hardware queues. */
 	for_each_possible_cpu(i) {
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
-- 
2.43.0

