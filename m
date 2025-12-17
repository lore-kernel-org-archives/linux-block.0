Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E8350A0B
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 17:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991954; cv=none; b=F8xaAAeLZEGUONJH5EfgT9G+HmYzQCGTPh9mZTUiUPmHBET51siwFz/+VDyqmhfHOiBIM8hc8Fe22FlqnIVxgbv89SPp3TFrcB+GWKY5RxUyxC0rzsTGtIAInXdYlEcYO8SDBI272FWGH8EW1DltBH5ax6fBs3H8w9nAqULs+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991954; c=relaxed/simple;
	bh=PhWmqG0vu+gCeyUMnCwiS6JRUSoAjuRw55yZTHXx/ZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDQswIdTYRbt2XsutnluDQsLjvuA5CNKRhfKOzm4+mHyXYh0jOSnAZUX1Pe7vLRrgJyXAjUfeKC+CRci2ZfFunEJXG4ZTXBmYEtWi6Gty27+r4jR01rlCnqlXX8l6jffbbv3ljN91abZx1ixq53Tg2ONNPxY3fXNxon/srdZmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=d+c8MTey; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="d+c8MTey"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so6865209b3a.1
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765991951; x=1766596751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3LrPFakvwygW1mGO7QQNc0jtsk3gCAQdHtYav1hcwg=;
        b=d+c8MTey3DevbeCLoDsBdo9judcaRHXuWB3qZVzvhW2wiB0tmzl1g79vC3pu8iWVgD
         6+/TbKoyb6H5Kke6wZYBQYnSS5ga1gBvPARHrXbHNrYvN6+VL9MFkllyMRYT9W9XJK5M
         VwBCIFx43hniWMd3wkLGvjonkA2+vq6XIpvk7C/dVE9U0JVS49qfsRljT7ievONX+ZKM
         mm0qbieSueAYm7A/KrX4f5nUz+HYLoQ/YX+aYYNzFkQ5+RWVTNUwv74GRgx5em4CB7SO
         d0UqH926tUH5RpxnFokBwvK/R8Le6ZvO7jqVkE369PGzdest5Si9oEsfaDK+OrFXyYU0
         QPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765991951; x=1766596751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3LrPFakvwygW1mGO7QQNc0jtsk3gCAQdHtYav1hcwg=;
        b=syrJuUS92nIPHyJ54Y40VQKVTWVYmR7A+FV2ZHAcJL9wQeCNRBJpWHs+JkjHKkl6Y+
         qIe+TNtVPwOBdg+J8wC/WqAjTzh/tx9AaaKH6623qd03CNIHTVK9/IpsKfzmAZEQjn2d
         cBMXBKr9T2hU3aGHcLZNDyQ1KPqTnN4TMYAkrTqb0J0J7kt2NyK/zcjaXI4G3Rus0Sa3
         uGefBPCrMcbszDSrmIOn205RWTjJ/jnnLR+AmjBfUdb8xJH2l8S5wO7/XNEF9G/d1UAD
         MV4jFSgonttuTZ5tPvj/YTuh4+wXDUwDuC2mtjr4kxNS8uoqcDsUDxg3kaJhr+X744tc
         igNg==
X-Gm-Message-State: AOJu0Yz/yO/pIdS8IkDmqfnHSQutgb5JOl5EXk3XWZ2AowTyMP3D0Ecm
	NKspeDDo59S5D1n0W2Soc7hWFKy7el8NewBu2GMfd5LdypPiwH9qtNCwXYboJHpQA2U=
X-Gm-Gg: AY/fxX7ag5vIWqEiVCQdkuHMyEubqa8xoWeee8Ltu097vEAorgest1iqIKpdKFmDBLl
	LsMLg5lCI/0f57mBp/Ua6Ixo3jzuH8RznkXTVQx6VzreYKfl/cM0Al9JhR66K7bp7agjmI0XWZs
	hixE5qoNmn8TFAsSbUOEVKrkPmb+kfK3uHv59v6VVufo013CvvXuIyxMGrNb/xrB8XVqDlS8Kgf
	Iy3J9kbIaJ6xrqWy88+TRAvCZjOo2OdnKAH27MrbrTVeTKTy85N8hVmsGxiCUiB0Ji45UzzFIqA
	pdm4QkGH+8yHBdGdeeXwj5AoAoEMbvOcGLFshor6v5c6X5auhH+Mp36USNcu4jjjX6bwu5unQ82
	U3+ymvzniNHl/w/aTnVKmzykPnt00eaNIa/++YbZjLtJwa3zmpDzDFZQUkhWq9ldhViYG8f14Ub
	9L0qBS8NgOEBljGIb1UEVwFEiXL12wsV/Ey/gHqA==
X-Google-Smtp-Source: AGHT+IGLeUXapTBEv/2bQX/CS1eAaM72hI63SCMBxHHzY/vLcw1Jr5zpynwINplOjGbg8sQGjhvXNw==
X-Received: by 2002:a05:7022:3a0a:b0:119:e56b:9580 with SMTP id a92af1059eb24-11f34bd915amr17286041c88.5.1765991950520;
        Wed, 17 Dec 2025 09:19:10 -0800 (PST)
Received: from dev-mliang.dev.purestorage.com ([208.88.159.129])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12061a94f2bsm121461c88.16.2025.12.17.09.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:19:10 -0800 (PST)
From: Michael Liang <mliang@purestorage.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mliang@purestorage.com
Subject: [PATCH] blk-mq: always clear rq->bio in blk_complete_request()
Date: Wed, 17 Dec 2025 10:18:53 -0700
Message-Id: <20251217171853.2648851-1-mliang@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ab3e1d3bbab9 ("block: allow end_io based requests in the
completion batch handling") changed blk_complete_request() so that
rq->bio and rq->__data_len are only cleared when ->end_io is NULL.

This conditional clearing is incorrect. The block layer guarantees that
all bios attached to the request are fully completed and released before
blk_complete_request() is called. Leaving rq->bio pointing to already
completed bios results in stale pointers that may be reused immediately
by a bioset allocator.

Stale rq->bio values have been observed to cause double-initialization
of cloned bios in request-based device-mapper targets, leading to
use-after-free and double-free scenarios. One such case occurs when
using dm-multipath on top of a PCIe NVMe namespace, where cloned request
bios are freed during blk_complete_request(), but rq->bio is left
intact. Subsequent clone teardown then attempts to free the same bios
again via blk_rq_unprep_clone(). Below is the codepath of such double-free:
nvme_pci_complete_batch()
    nvme_complete_batch()
        blk_mq_end_request_batch()
            blk_complete_request() // called on a DM-target clone req
                bio_endio() // 1st free of all bios of the clone req
                ...
            rq->end_io() // calls end_clone_request() since @rq is a clone req
                dm_compelte_request(tio->orig)
                    dm_softirq_done() // Note this actually defers to softirq context
                        dm_done()
                            dm_end_request() // end the clone request
                                blk_rq_unprep_clone() // 2nd free of BIOs on the clone req

There is no valid case where rq->bio may still reference live bios at
this point. Clear rq->bio and rq->__data_len unconditionally to avoid
leaking stale pointer state across completions.

Fixes: ab3e1d3bbab9 ("block: allow end_io based requests in the
completion batch handling")

Signed-off-by: Michael Liang <mliang@purestorage.com>
---
 block/blk-mq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d626d32f6e57..b8b9ca2200e4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -905,10 +905,8 @@ static void blk_complete_request(struct request *req)
 	 * can find how many bytes remain in the request
 	 * later.
 	 */
-	if (!req->end_io) {
-		req->bio = NULL;
-		req->__data_len = 0;
-	}
+	req->bio = NULL;
+	req->__data_len = 0;
 }
 
 /**
-- 
2.34.1

