Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1608C280335
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770106799; cv=none; b=djA/5frRdt1XYX30af1YM2oCX91Z8gFWEg8tx0kOFvWguSbram29NSBGnPkMV59gbtIwQkQmDnKsU2os8oEy39X450Rkleu2WMPNZ2yI+Z1StVFuKukoSRAaKHsEOmqHc0/l1Y/HG+an6/b2ad6ReLvNCn3Rf/KGof2vVgBR+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770106799; c=relaxed/simple;
	bh=jYR1/4zbr9Md7Na1mWo3ITCIVzegFWwCjfZgBeTjIjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DWqE7n/YGvfrRo+KlX4v8WVw6t3M9/HRD1awUXQHWxbW3SOPWwkGuW0i9klIzjHjN0hYIuxIrhyZbXCXyh63W2TXAQxMEtgPryeIcy4yVmfOWlN9UYxcgchI0LM6oL9W8XW+7BO4CuKAA7mdrE4zRgnLBKLFMcht4t6ssJDYMZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF865C116D0;
	Tue,  3 Feb 2026 08:19:56 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	bvanassche@acm.org,
	hare@suse.de
Subject: [PATCH v7 1/8] block: convert nr_requests to unsigned int
Date: Tue,  3 Feb 2026 16:19:42 +0800
Message-ID: <20260203081952.732210-2-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260203081952.732210-1-yukuai@fnnas.com>
References: <20260203081952.732210-1-yukuai@fnnas.com>
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2ae4c45e4959..67d8d9e03abc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -550,7 +550,7 @@ struct request_queue {
 	/*
 	 * queue settings
 	 */
-	unsigned long		nr_requests;	/* Max # of requests */
+	unsigned int		nr_requests;	/* Max # of requests */
 
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
-- 
2.51.0

