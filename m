Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B24347BD9
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 06:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391324; cv=none; b=bZICyvajbQz6KiWVH+wAPBRJWrgCMn/LvX6P7ytN7vH7HrHrsmkRN+rZ0OIMSEB9BRu7d6ReqkoS8V+NmgF7WAZ77aPHTcUUZISempK4RVHML1/pk9SwAfyjjlqKgQLe3rVioQr9hP2QYIYAQmP6R8ah28pXR95ubVkx3zE3CgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391324; c=relaxed/simple;
	bh=JHpJYTLLB2ZMJKT2oo9BGd65bnXRYxol6hW4wZLX1bY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duni3unPWL1BJiTH6+YpUYmVtt1gbuEhSMnnd3KGqwWEv0QdtB3OwIPiwUlR0JQB8Ns1lsnbMpFLdOdRjX3V1s0Ql0NpVGutHUUvJMF+fWIT5HXcn5T5Xf2YcH/1bA+4d7kH9e5zgWPHJ3pPIlpJf7tKJmNHyQpCIXqB2/eMknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPLPYKih; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPLPYKih"
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fb1883f59so468888a91.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391318; x=1785996118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cs489M3XU7xPRIbALvrKU2CC1mfn9Hj5q9oo8bImFmY=;
        b=VPLPYKihKF9uZ8IbsUi63b/nA8IYLCbdKHv4QcsSZVzuPqvSMEmnLseMvq/1s3fa5+
         2e2G2v+vN9AatG9CR38f6KzgEKrrjIjc6hLshpBbYA2sliowecUDyKZaKbckjW1rbhkH
         NtS1bT/IuGpEQpjADDb4u37hlVx4drzz1b7uEt42DrOmX7r7gBUfmLHFwigXjc7AZRZh
         T6XNmNPOBO721XY/906rfiiU7AjipvzHgMfy3cAMGPyZzLnVqraIg2SchzdOdwKS2x/V
         L8f2pmcNyaWulyK0ZRo3sK0SdhorEIWbqJ5kup4rBLTFF1UkI5RqGH4pao7U5LCFJjCQ
         YTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391318; x=1785996118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cs489M3XU7xPRIbALvrKU2CC1mfn9Hj5q9oo8bImFmY=;
        b=RdqXrV3yT6wl7Nqli08ldzYV0aF/PCIRphP3RMHd3Kw/ULBa+UFFXyC1nY+SdBufdJ
         ht13cd5k/YKZo6v0l+65RRvpJwrbfsiRJMtcS1lFCGs0yCOvzP8TTFHxoqNt2F9ME3qf
         VKw1xcA/QVQXHYGPsxJiTYN3YZyYVR6euDDXC+HTJpJrXVM2tU4RCpNZ0K3S5t70J9K0
         fs+B3F2MaesO1E+DGwKsR3bhQ4JqhJDrqHN2VbrzJzQa5tjpHVd2seM/kjpe5gLAF72g
         2x9qxDQh9RY5CSAOaQ95qqUwhBuudqxK3+VsHOySNog5NDrIIfiAUOsTjH6tsoeUEYq/
         O5UA==
X-Forwarded-Encrypted: i=1; AHgh+RpXf7nbzAWkNN+HwxGwMob1TsXyT48mthUlmzz6gEER4ots0dAeIEANB1Wd0ZuFKIQyQ65Tnl4zivzazg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqC9yG11hb5UUgAhMGNdAicutQeke9zfNR8DIRwNWqqrx9LYQ3
	xSHP2sxSAomNJT8bYa4evPURyja7VFfpMCwaFBjT5XNDq/fLi2gr1SjP
X-Gm-Gg: AR+sD11vWBp+U7/iaYzPxgfckM0dnAs51nlrjY0aHwY4c5ZMmqIZqb9+DOeOFJuKCnc
	sTIOsV2Y7UytdZAM16CQ3FeSxJnupR9KGNDPGkyvhqflw84hcFbTtj2l85OMP3ULXuiYP43yx8f
	mg98DmJSb2l81fl+Xt5QGfp9tMh11ixTIs7L+7Wpvjd0yPhzAwm////MugZrDvDvHcgsWDYoZUg
	wCryFpS6qSNE8sXvYkhO7tFsDHzjA3OJxkfB0JlPGiYkbjGdzIjAg/JwO7x/FNOvLvfcKr2naAD
	kmy0DtfsM8fVkStOvfAvWMDDDm7em/+b1EgOeV1Y8OredVA+8uVAaLwbA7ysjGoEvJXCNQ2oFUs
	UikPDMiHvEscSLSFRriMIaTGtYEhtNbf7Zj4jCcSgf15IbkeHy75x6H13MwIOHn7XT+ViA8ychw
	D6qw+20dfPEq74rwsPYe+4aKHu39Fd5pUOzcVOkT4vxlU1fuzPUZmUIBZytBqIRSpyW18GqrLBc
	y1djUSLxnn3w41TubJJlBWvgYPCQTDgsQ==
X-Received: by 2002:a17:90b:534c:b0:38f:7f60:ba35 with SMTP id 98e67ed59e1d1-38f9be28c63mr1157408a91.5.1785391318132;
        Wed, 29 Jul 2026 23:01:58 -0700 (PDT)
Received: from HAOQINHUANG-MC0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b42d6c8sm430737a91.3.2026.07.29.23.01.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 23:01:57 -0700 (PDT)
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
Subject: [PATCH v4 1/4] zram: do not release zstd params in per-CPU error path
Date: Thu, 30 Jul 2026 14:01:30 +0800
Message-ID: <20260730060133.80233-2-haoqinhuang7@gmail.com>
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

zstd_setup_params() creates global cdict and ddict stored in
params->drv_data, shared across all per-CPU contexts. The per-CPU
zstd_create() error path called zstd_release_params(), which freed
those globally-shared objects. While the drv_data=NULL guard in
zstd_release_params() prevents a double-free on the init failure
path, this is still a layering violation: a per-CPU callback should
only clean up its own context, not release resources owned by the
compression lifecycle (zcomp_init / zcomp_destroy).

Remove zstd_release_params() from the per-CPU error path and call
only zstd_destroy(), which properly cleans up the per-CPU context
without touching the global params->drv_data.

Signed-off-by: Haoqin Huang <haoqinhuang@tencent.com>
Signed-off-by: Rongwei Wang <zigiwang@tencent.com>
---
 drivers/block/zram/backend_zstd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index d00b548056dc..2584f47c9b3c 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -161,7 +161,6 @@ static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ctx)
 	return 0;
 
 error:
-	zstd_release_params(params);
 	zstd_destroy(ctx);
 	return -EINVAL;
 }
-- 
2.43.7

