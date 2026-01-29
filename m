Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB1D37AA87
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671934; cv=none; b=lXRqc/LKbVY7dX71Yky02vTV9TxH8ISaDMJcfjQ0Gzh9gv+oiILxD3h/RdKP9t6Xy/M0k8hBOTXSuKkTCo7q7JTXPhwLFQGD8QKJj0QgRfk6mVxdZLvJIr2/+9YylJgt4K4u6nNkeKYCjryhtq8dbyy9UvbgKu9DyDFqmOmuaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671934; c=relaxed/simple;
	bh=e3GURwlAexY9hl/enLz72RYyoa3WwFpXW4YXaY58vpg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttIBzIchBoEk37l1ny/eRma2FvHsQ+bMlzRTLJNAFpgQQd/hVt4tpqV9WHH7AhlGbcbuwvPA5VymHhIdX/JXiLizIJCYIlUR3a+XN8m1Vkf8cMbq14bxVdcH1aLVTCQAumgNfHSdO5niBlZErg8kT6pLv7XX9QbtP2Bs282fXAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSnJy6Fb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSnJy6Fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D678C19421;
	Thu, 29 Jan 2026 07:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769671934;
	bh=e3GURwlAexY9hl/enLz72RYyoa3WwFpXW4YXaY58vpg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=kSnJy6Fb7Bv5KqXZ4W6H69aeEYGVXtm3pNBRldeAOGTqI6dOeNBJjOR/pxYH/okgK
	 4Y7ymkOHM/HtCnY0TgxwFRQjhoSbYvjdSnHEbWE1th6zlht7Yw8c1nDUQYsRI7G7Qb
	 tIGJFiIQPmsXZlIEeK7+aYpCdL+Uke34Gs01jCmPwv3ES8koLw6SWkAOw0g4HCjZ9L
	 udKWKwC+rH69D/nhQ0/KfbYv5totw/6WrlxSP6pU/3BeTEmPXf37CGI8la3LCdziAJ
	 QCEdWjFW+CEA8fa766AE3iygx2z1DJxClhyQlQggkjzJ/u8jN38a+4vzb0GsGpogu7
	 kBeVXKpo0c7Rg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: cleanup queue limit features definition
Date: Thu, 29 Jan 2026 16:27:14 +0900
Message-ID: <20260129072715.1107336-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129072715.1107336-1-dlemoal@kernel.org>
References: <20260129072715.1107336-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unwrap the definition of BLK_FEAT_ATOMIC_WRITES and
renumber this feature to be sequential with BLK_FEAT_SKIP_TAGSET_QUIESCE.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/blkdev.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 251e0f538c4c..4536211ff33c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -340,14 +340,13 @@ typedef unsigned int __bitwise blk_features_t;
 /* skip this queue in blk_mq_(un)quiesce_tagset */
 #define BLK_FEAT_SKIP_TAGSET_QUIESCE	((__force blk_features_t)(1u << 13))
 
+/* atomic writes enabled */
+#define BLK_FEAT_ATOMIC_WRITES		((__force blk_features_t)(1u << 14))
+
 /* undocumented magic for bcache */
 #define BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE \
 	((__force blk_features_t)(1u << 15))
 
-/* atomic writes enabled */
-#define BLK_FEAT_ATOMIC_WRITES \
-	((__force blk_features_t)(1u << 16))
-
 /*
  * Flags automatically inherited when stacking limits.
  */
-- 
2.52.0

