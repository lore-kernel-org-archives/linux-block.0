Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EBF186E40;
	Wed,  3 Dec 2025 15:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.87.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764775094; cv=none; b=sesUZKLxrbx0R8d/WhmdnwgSO5Vt6pljgpdSWbcb6SgRGWTKQBN1zj9KVfOAJ9uECRxjrxZ5cyD2O1Ll/HbMNYvHH28L8Rb2xM861WkhMaxoZ/b3X47r+O6DCxGzZMkLRQbGEv/cNDHK1SO+ij0dISUy1tF3/4wOt33q6a9ZmK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764775094; c=relaxed/simple;
	bh=3g/nMSlm0U3vgk/EZ768i7XS0tPl9d9uunumgnK0vLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f3QZRdlY7blAd+c/8iB/3r9nodIDaVrNENttlHu7LIHAk72MH2xGAvpNDbGr/5O8A91WSw6yBvfMnHHUV0pT+3rG4bauZTwOYLlH/K9cfrXACy142vJD66Cs3oYrUeNpzEeJoo/MTC60LTeyteEppIZFpub/VBsU1izJjq6jzu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.87.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4dM1Qk6xkpzBBmbj;
	Wed,  3 Dec 2025 23:14:54 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Wed, 3 Dec 2025 23:17:58 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>, shechenglong
	<shechenglong@xfusion.com>
Subject: [PATCH] block: fix comment for op_is_zone_mgmt() to include RESET_ALL
Date: Wed, 3 Dec 2025 23:17:49 +0800
Message-ID: <20251203151749.1152-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03046.xfusion.com (10.32.128.186) To
 wuxpheds03048.xfusion.com (10.32.143.30)

REQ_OP_ZONE_RESET_ALL is a zone management request, and op_is_zone_mgmt()
has returned true for it.

Update the comment to remove the misleading exception note so
the documentation matches the implementation.

Fixes: 12a1c93 ("block: fix op_is_zone_mgmt() to handle REQ_OP_ZONE_RESET_ALL")
Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 include/linux/blk_types.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 44c30183ecc3..4e2e3aed32f5 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -469,10 +469,7 @@ static inline bool op_is_discard(blk_opf_t op)
 }
 
 /*
- * Check if a bio or request operation is a zone management operation, with
- * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special case
- * due to its different handling in the block layer and device response in
- * case of command failure.
+ * Check if a bio or request operation is a zone management operation.
  */
 static inline bool op_is_zone_mgmt(enum req_op op)
 {
-- 
2.33.0

