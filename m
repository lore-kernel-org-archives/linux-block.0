Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5951E503D
	for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 00:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525074; cv=none; b=SNnrCjQF7zudHi8rMC2kzQpCw1TzvqZEA/28sTVeAQorXHyfKmKFMyje1BPrjxt4dWAOLBle9N78WrSnjpre1sNKJ9UjGPl0r8FsF95osfTTRd13+gcCZGb13jRAxlRHcVedSvEj8MEiXpL34Ha87AGaFcXRc7sNp4oa1Bjtk9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525074; c=relaxed/simple;
	bh=5Kzzp1q5+uFLsKc7l40f2r5xZ7fiaS6AaBQAgyehe1U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH3/KLnk59YngAzhtyAy2KugYAw8Pq4U3iwl9EegxOjNaMqVIPbSVSA+ucG9K99Lq7wmt5Jjwsr24g0eFzg2AVL4135eYbQbcXkH3pdpoOQnyLEHlQzg3/uutrr1vF8WEpGbGGUL66sEKcxTnxNgkpiYzM4ZebS/5DjtHwd3JdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gX2lEqZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gX2lEqZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA60CC113D0;
	Mon, 27 Oct 2025 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761525074;
	bh=5Kzzp1q5+uFLsKc7l40f2r5xZ7fiaS6AaBQAgyehe1U=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gX2lEqZcRscnT2Rtq2oRmMYfJUg9M4S3W3QAPRfLNpun/O5uo/eZUhAGrcEx71lFq
	 UXue6806QmI3kwIHm61E6daYQGoBrGqMEXVDAunXvTIRfRlWFRzZGSGz21YV1LwMD6
	 WSXm/ke/LG4I2vTfFi1rGJOP6Yi+SKLyHs0HN8xzCyxZAD/MBm2sraYlkq8AJ6qXfX
	 YkTLbgJg+FjUdqYPtOIZci+gOS7IUV9UnELzaqUQdooclXcqNBRdS7x7ASAiFPfLth
	 ze4iSWvvcCMou6x/p82N69QFEwi/ZSKU/9ZFQpA0bssZGwTGq+BXYNCswkwwLs0FhB
	 FjEHNQ3Yj1Xjg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL
Date: Mon, 27 Oct 2025 09:27:32 +0900
Message-ID: <20251027002733.567121-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027002733.567121-1-dlemoal@kernel.org>
References: <20251027002733.567121-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

REQ_OP_ZONE_RESET_ALL is a zone management request. Fix
op_is_zone_mgmt() to return true for that operation, like it already
does for REQ_OP_ZONE_RESET.

While no problems were reported without this fix, this change allows
strengthening checks in various block device drivers (scsi sd,
virtioblk, DM) where op_is_zone_mgmt() is used to verify that a zone
management command is not being issued to a regular block device.

Fixes: 6c1b1da58f8c ("block: add zone open, close and finish operations")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/linux/blk_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8e8d1cc8b06c..d8ba743a89b7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -478,6 +478,7 @@ static inline bool op_is_zone_mgmt(enum req_op op)
 {
 	switch (op & REQ_OP_MASK) {
 	case REQ_OP_ZONE_RESET:
+	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_FINISH:
-- 
2.51.0

