Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6448DB3A
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 18:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792176483; cv=none; b=a1EX5a+5nl5WJJ5KelR7qh9Y4aWjPda2H7AxZ5ALsps5Ityv+QJ1BJH/+4HoRL8M+/mmQJ4QmtvoRmuRvEukG9P0U5Eh6bRP4RgjnAQaadAs+WVsAKJv/OYemn3GZmKFNMhAfUfNR+JiX/2BKJckRzPslkXU20drbJ1bYB0QkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792176483; c=relaxed/simple;
	bh=/mlGGUmh4imtXySY7AXdz4KuC8XMU5x8T9TuD7xZIic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV0C7+RfxEYdsM6/v9062+jY4QQ3vTi8OGz9aSd80lGXcpe0NKPJwzAC9JIkOltLpVciyysVpugW8E4egVPWYX+aZZDQU4Mg4fHE+Z1BA19OpGW/o+rOSp3f6WTEbKC5K3scpuqJxhlLdjskPmJgR+cx5I7uS1mRFcS727LD/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=U/cDlfZZ; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="U/cDlfZZ"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-141395927feso416808c88.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 11:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792176481; x=1792781281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s7HjfQVA5Ug4OqWpNl1Z5zod/bI4WrApAYRfZdU17cg=;
        b=U/cDlfZZcXsv84cy5ctJHrDSAaBCJFigmr7NBBo+tmYyo5xtvW3VMSAS4CHNjYawVm
         kDWZKPsqkyXXwgAd9WDxr7PhB/zsymSp+gIwWIqEB6IpJ4UVy9p4YASucP6/ieTYACm5
         nMH4zxt5lKtbU86Ea4FYREhu7193K/VSpASkbpmLOIX+RnyLFgUkaaQ+IwLJuhUcK2gW
         dPqmRIyvp4zClnN3Jbn3W2NY9oHa9J0HNmjZlFLN+TjAkaRXnLRek2YVfAxPRpj1CRZg
         pvMzcJE0BrmnSprOiWzsZjLK1d9XwGV3ed1lcMXIQpbaNpbU9TGI8ByFNXaOkcenNy7e
         gPkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792176481; x=1792781281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s7HjfQVA5Ug4OqWpNl1Z5zod/bI4WrApAYRfZdU17cg=;
        b=oOr3nkH8d1SapoxVkv5l7y4iQ2jkdJyMFFdOEJ5MtF/pxyigHZV7EY6VqqxqhPCz6n
         nJ0+aIL135JR7PwGo5OxN2peStOifSGehYmGO7ZV+SsN8OEvTtNrwWy0e/rI5vX8rNZO
         gFnokBeol7Cej2FtoOxcAUdvbM499DGXChRBHSaKB/TKpNwEbvzFpWNwU4fw/48KFN98
         TChF211UK4rHIVxP6P7avrFcXPaLriG4ChepVhO5K+NbGktZTIM4UA0x3k1k275McyqS
         67Xkgye2b9mBIxyRJjSwqbk2QPGo/n2cg5rY+UPal9vPqkKdxfYyezws6WEMFGqMpYwC
         J3sw==
X-Forwarded-Encrypted: i=1; AKwUvByiqI45D8Ri1aOFmGA/kY+gOC0NC1Qzg2K5xCsB+87zgUoT75WG84mlue4nB+vNVISn7haeaHILCkGuVw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIn904TH+XMvNsA0uFEGLX4fWErxbv6WQe07zg3syqJGF3i3X9R
	J9yIDMfi23gktSY3MBt0ek5Za6sNsY7PeiXLpL/P/ym+G9RVCLm5VWDndHsDD+iFbqk=
X-Gm-Gg: AYBFou2fmf9pSXPiS4QHAmQCUrAFunCsi+2PvLoH4wYZKFh7mUqnS4H6VW5vY2UZCon
	vfqecdLdt6nhozug1lPji5jLqm9bKNB3NXJ1INL0PiFhY2nGStqEasJPmdAEAbgDXSwQWovl8g/
	Q5qPiZ0kXfVr6iXDenD0LGZ4GqIPpc+BAgG3YlOzHOD6vkGNcvTr+LC3Z0fXzc9GjIFGBMcaOeM
	Z2yguttRek9MmYAxMBes/XPoUKSYk0SkMpzYTeNWiEuJpn3csLcaoyO6mTD71XkZhuv4suVz2TN
	kmLxVYjY9CB/Y6DZkCr8EijOmLwZBjNZCM5lH/oV+Ni4lXnkpEq/HqsosQApj3IGsnq9YsvXPje
	Ck+B6idQaWgch4VsO5La3AYwF4R/B04rYOXUZ8NheMpX7rV/lUK88WGfaAzDC3vNNjhZIfvt2ij
	R4KwI/9l07ldOmPCAqtUFlTfZCKZc70JLldWlu4j8M6lzyMujOMPXQBcvq8VhnfC8K29sPrArIc
	204AtfsgwOG3Od2Dg3eyf47OBiqPkuCxrGOMVF+Affdl571wVvs+zncuRNeYqyfPpVQWvA=
X-Received: by 2002:a05:7301:380a:b0:35a:ca1e:4d82 with SMTP id 5a478bee46e88-361a1c50083mr999407eec.20.1792176480952;
        Fri, 16 Oct 2026 11:48:00 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:85ee:eb9a:5637:424d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082784ec8sm8004502eec.22.2026.10.16.11.47.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 11:48:00 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: axboe@kernel.dk,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] blk-mq: reinsert cached request to the list
Date: Fri, 16 Oct 2026 14:47:53 -0400
Message-ID: <20261016184753.27189-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016184753.27189-1-artem@trailofbits.com>
References: <20261016184753.27189-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit b051bb6bf0a231117036aa607cadf55be8e63910 ]

A previous commit removed an optimization out of caution for a scenario
that turns out not to be real: all the "queue_exit" goto's are safe to
reinsert the request into the cached_rq's plug list as they are either
from a non-blocking path, or a successful merge that already holds the
queue reference. This optimization is most needed for small sequential
workloads that successfully merge into larger requests.

Fixes: dc278e9bf2b9 ("blk-mq: pop cached request if it is usable")
Suggested-by: Ming Lei <tom.leiming@gmail.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Link: https://patch.msgid.link/20260526153531.2365935-1-kbusch@meta.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Assisted-by: LLM
[ Backport to 6.6.y: Reinsert with rq_list_add() on each of the three
  target preparation or merge exits; the target has a single cached_rq
  list and no shared queue_exit label. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the corrective follow-up for
CVE-2026-64017 to 6.6.y.

The backport reinserts the cached request at each of the three older
preparation or merge exits. See the bracketed backport note above.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y).

Thanks,
Artem Dinaburg

 block/blk-mq.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1ad77737b27d3233489b4d9f690c9e6ab77d2130..e3fb9222c5ee00c1fa2105e1194d5f9eba831092 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3024,16 +3024,16 @@ void blk_mq_submit_bio(struct bio *bio)
 		if (unlikely(bio_may_exceed_limits(bio, &q->limits))) {
 			bio = __bio_split_to_limits(bio, &q->limits, &nr_segs);
 			if (!bio) {
-				blk_mq_free_request(rq);
+				rq_list_add(&plug->cached_rq, rq);
 				return;
 			}
 		}
 		if (!bio_integrity_prep(bio)) {
-			blk_mq_free_request(rq);
+			rq_list_add(&plug->cached_rq, rq);
 			return;
 		}
 		if (blk_mq_attempt_bio_merge(q, bio, nr_segs)) {
-			blk_mq_free_request(rq);
+			rq_list_add(&plug->cached_rq, rq);
 			return;
 		}
 		rq_qos_throttle(rq->q, bio);
