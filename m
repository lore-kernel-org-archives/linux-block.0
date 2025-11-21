Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188B92F291B;
	Fri, 21 Nov 2025 05:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702950; cv=none; b=mg9E8+T7nRQXbouNpmTbRog7dExg6Bt6qIShorTre1O6VRNZ0uEoqA3ALzQLn2ocrfYZoWjGz6ebapohfvmGr3tN2TGZQCMq3Uxraua8rAmG99vmogmRMN/hbA25YtQ0h2A0sdMDvlE6EYLxZ7oRYKfVBnSIqoV35PXUp7Ty5rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702950; c=relaxed/simple;
	bh=YtquQJhJYg1l4m8jNm5Lu9vvFqCo/XUdPF7579KI69k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7z/b84snTOEHvwysXZM3j7wMP8SN6K2WVjY0Gmp5AyS8GJTTgWocRHa7m9B69E/3/Jcw7vIBf3UhBOhlxNYwmbO7R926Ek9FLpTdSj+9cDKyZwAEefwpASiHTpg49CtZwF/9k+oSNyVzsKORqVOXkemYrnFcyVdeWRsbuTLjZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D31C4CEFB;
	Fri, 21 Nov 2025 05:29:06 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	nilay@linux.ibm.com,
	bvanassche@acm.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: yukuai@fnnas.com
Subject: [PATCH v6 1/8] block: convert nr_requests to unsigned int
Date: Fri, 21 Nov 2025 13:28:48 +0800
Message-ID: <20251121052901.1341976-2-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121052901.1341976-1-yukuai@fnnas.com>
References: <20251121052901.1341976-1-yukuai@fnnas.com>
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
index cb4ba09959ee..cdc68c41fa96 100644
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

