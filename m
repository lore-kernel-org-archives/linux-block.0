Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EB1CD15;
	Sun, 16 Nov 2025 03:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763265154; cv=none; b=N5LFcgdr3FqEmljRYcWzQBMF5d44ZUiD5Xm+XdtBqMm3VI03SXzyH+65a5xWEK4bvaoUIsOpbHGRGBXMbGCv/XrEtOms3xqvtcJMkmqPmFVgc2F0cGCtENV/EWwY/S8radMtmVRR9DfhqGf4fJtlXoR92h3oM5o3g0YK4Yogvjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763265154; c=relaxed/simple;
	bh=hh1bIV/4NJvdi+LJD71lmjTfw9FGPr7RlXla8j+ZY4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhRJ+t33zmu4YDNGEFKqfgA2G2QoFvgbDqZVHtc13sSerkd8wtOfjdOZBOmSuwoKfI1o98hICJPCaMvFPncY/rO/gHRuEjsRw5V4V+p+N8h3Sv5K7CCDxZQmQLlAq0i12ct+cGyUprjULifcsxlnH9cSs02iqfmPS/3eynRyJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399A9C19422;
	Sun, 16 Nov 2025 03:52:32 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com,
	nilay@linux.ibm.com,
	bvanassche@acm.org
Subject: [PATCH RESEND v5 1/7] block: convert nr_requests to unsigned int
Date: Sun, 16 Nov 2025 11:52:21 +0800
Message-ID: <20251116035228.119987-2-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116035228.119987-1-yukuai@fnnas.com>
References: <20251116035228.119987-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This value represents the number of requests for elevator tags, or drivers
tags if elevator is none. The max value for elevator tags is 2048, and
in drivers at most 16 bits is used for tag.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2fff8a80dbd2..bedcaa59feec 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -551,7 +551,7 @@ struct request_queue {
 	/*
 	 * queue settings
 	 */
-	unsigned long		nr_requests;	/* Max # of requests */
+	unsigned int		nr_requests;	/* Max # of requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.51.0

