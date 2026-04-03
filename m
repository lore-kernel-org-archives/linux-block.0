Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39173603F6
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242281; cv=none; b=VydBL4CAu4iHZ9jl0g3tTRdN8d6jWHlRJ7F6yJzjTIXrpsi46+aIL+2dONrkPi/1MOdFVExtf6Byd6CqkhaOTGGd+0j2vYmiz957i0he/UZyNosHO/fkCTababS1Y7mgASNAmXeMORkZqk126tlhjMB8i2cn3e/QDw+qLizvPqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242281; c=relaxed/simple;
	bh=CHli6OjyyhVH17GdfDhyFur2TDwkqD++6jM26jVUMvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sYHrJG2DKOxs9pmeiN630sH9ImHG6leXAWeEzb6k0de0L4KQdjQftX0fQtgP0zNkLHYZGzrG8qto/zsG+Fz/+04jr4dwUOeVAAqFIEXkR5Ht/RgZV0F51si29gSymPT5Ts1RccRVosdXgVYgh8iL0EaDzUKaKJ3SDdH1N03wB2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DFZG+5/0; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DFZG+5/0"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-604fe79aa84so124210137.1
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 11:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775242279; x=1775847079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7NsxmQyQRU2oQ25rx8KXDJ5ez3Qqo6sfbE7pEowz1h8=;
        b=DFZG+5/0pFhOlwHGQECflvX1NuQLM54+oS5yXzIYy5VN8THHSttubuR0WCf8egWYB6
         qWR3iyW9MY+GVWJc7KyOAFsnsX6HQ/LVH0mVTJnWEIjWz8DGdvVm6Pnyf1C3enX8AOrt
         XElzyULnjvudK9jthf0MvC3+jOsS+vBVi27lGaCEzBY8Vrz+K/yi3JPmZ5Cytmbu0IVh
         /ZeC4ki+FnHr3lrCX+ybhfbaoHoFNyCiVGHi1F2zm/ztgUIGC2HSL/3bvPWdiyQxN0cz
         ElCJM+zpmcQk7uYLZofvPVJdGfaJEjpInT31KW8kRJSm1TijVqqjx5HaCWuMMZABHH3r
         pxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775242279; x=1775847079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NsxmQyQRU2oQ25rx8KXDJ5ez3Qqo6sfbE7pEowz1h8=;
        b=cMAAokxQImnjre5AMKW9ZsjaQkRh7EIyyx87TWpqPtvLMGwLiMPM7BBIvuvKxNloTd
         FD0zRHm4vV20KDt4TEEcz9fSn/9eqLkRoIs0y/BxMXy5QWDm18qcWRYKJ6YNV24wiGqp
         TNRj24Y7u7ME8fa13RvQ/KNeIkoPJ9d4Fr/PJPLkiGDbnXiV+HyLSy9rLqnpK6pkL2n3
         X8XZ0H9AyMOODF6NwsdTMnRKxa25AeU+o7k86iMT7FdLBsu7aLVc5WY7rXXSeZquz5Aa
         SJXFyB31U8P1Ggo4qwF4XbHcJDwOlIWgvpwpDffORpzDtt/EeZIQPEc85XVJ7oLoj24J
         aeaQ==
X-Gm-Message-State: AOJu0YzxrEeWDiS9XEO5vR+Igv+KsjroSWZxg7BT8NokJPin1Om5GIUA
	m56NG716BUm6/l0rx2CDclTzV36yYvHO/L6Q/5BqpeFXEPf/Ca+pTKR2wjR2h3dxqCZ/w812TpX
	uNlEUPWvB+BkV247tSIg+NwSTGEoDW7wjw3yagvDFJP7FyEdKFoh/
X-Gm-Gg: AeBDieu35f+naMHGUGWslKdXORbhPQ7Yx1qWmplI+yMGim3gsSgo/265jJxsgea1I8f
	INmMS+IAl2bnt+Fuv22cc3nAc1HM9QvQcc2HtF7rf4oO0y/p3T09QphHE/RXWjhlCQ71g8CI4zS
	vmCX1gDZGRfFWcP6WIM95MTrWUBym4+vE9hF4gHwvhQVTZ315/2c0tZ7r5FWJcfdfChd7v5vTtQ
	Ih66WVJrIYfZDyxMvoDOXchD6sOvzOB4dGxBjAZwbOZJ88W0yH1fTzLVhYaEg2QZpF6fzSyePSz
	qC2hSBPvh0+cPe/QhVyGPH9/IvuJXIJRKs7vnD1SmJLZxuME7zsztSyDhy/2poWdzECUL1eWf+5
	ZDZzSlMTmS5RIv3eITNWureOUVbSfCbonu5uJuKw=
X-Received: by 2002:a05:6102:358d:b0:605:53cd:302b with SMTP id ada2fe7eead31-605a5136da2mr750854137.8.1775242278740;
        Fri, 03 Apr 2026 11:51:18 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-60582fe7990sm504170137.14.2026.04.03.11.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:51:18 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2AA9E34071E;
	Fri,  3 Apr 2026 12:51:18 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0F14FE41BC6; Fri,  3 Apr 2026 12:51:18 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] t10-pi: reduce ref tag code duplication
Date: Fri,  3 Apr 2026 12:51:00 -0600
Message-ID: <20260403185101.2172135-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

t10_pi_ref_tag() and ext_pi_ref_tag() are identical except for the final
truncation of the ref tag to 32 or 48 bits. Factor out a helper
full_pi_ref_tag() to return the untruncated ref tag and use it in
t10_pi_ref_tag() and ext_pi_ref_tag().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/t10-pi.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/t10-pi.h b/include/linux/t10-pi.h
index 2c59fe3efcd4..c6fe5db47c7a 100644
--- a/include/linux/t10-pi.h
+++ b/include/linux/t10-pi.h
@@ -35,18 +35,23 @@ struct t10_pi_tuple {
 };
 
 #define T10_PI_APP_ESCAPE cpu_to_be16(0xffff)
 #define T10_PI_REF_ESCAPE cpu_to_be32(0xffffffff)
 
-static inline u32 t10_pi_ref_tag(struct request *rq)
+static inline u64 full_pi_ref_tag(struct request *rq)
 {
 	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    rq->q->limits.integrity.interval_exp)
 		shift = rq->q->limits.integrity.interval_exp;
-	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT) & 0xffffffff;
+	return blk_rq_pos(rq) >> (shift - SECTOR_SHIFT);
+}
+
+static inline u32 t10_pi_ref_tag(struct request *rq)
+{
+	return full_pi_ref_tag(rq) & 0xffffffff;
 }
 
 struct crc64_pi_tuple {
 	__be64 guard_tag;
 	__be16 app_tag;
@@ -62,14 +67,9 @@ static inline u64 lower_48_bits(u64 n)
 	return n & ((1ull << 48) - 1);
 }
 
 static inline u64 ext_pi_ref_tag(struct request *rq)
 {
-	unsigned int shift = ilog2(queue_logical_block_size(rq->q));
-
-	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
-	    rq->q->limits.integrity.interval_exp)
-		shift = rq->q->limits.integrity.interval_exp;
-	return lower_48_bits(blk_rq_pos(rq) >> (shift - SECTOR_SHIFT));
+	return lower_48_bits(full_pi_ref_tag(rq));
 }
 
 #endif
-- 
2.45.2

