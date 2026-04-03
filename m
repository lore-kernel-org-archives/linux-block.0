Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4263CB2FE
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 18:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775242148; cv=none; b=o21WmL1MsEGFB8tw4DyPYj43ydisD4xAF80eAtTN3x41nJlse/U7qxSQ67Pwhxj6U6nTDOFzUYBN14ocfQ9uM0efMGhwvV306jpWrPBnZQ4m6mTiYsrWi1XtlTU8yxqjHx9332j1o8f8C5GACQYUuBG/Yw+rlDkwdYvcveMv8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775242148; c=relaxed/simple;
	bh=gQCOO2I5iux5Uz3jR14s2fQwwIRhVdscHw1edQFArhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMX+7QPc/8cDe8ENK/xKPdkUoJtj+8NxkoUgUu1+utK+9M6nAusno/g+zJJknyKNIccWDxQmy+WJR2YCnetgqLIXS1fill3HoANkcOvqfj65EHbjHen59Y2hVHPzDNCSuL+6YKVOvBjA5M7JGUPeoKxDOBxYLOjTQg2LLbRUx0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ie4CLQSu; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ie4CLQSu"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3597822d6d8so211603a91.3
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 11:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775242143; x=1775846943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FPs+1/3zZN7CqhYoblNKC630QIsQYxPkweGwnGO0pvw=;
        b=Ie4CLQSusaphlBsFY+V31DKHTNwVxmNZP7J/1vT7QuJ8GZDTKwLenc6gq/Mm2c/3Ew
         TlDWRGMtTXzeSlqYeyrHiCguPPOT1OEXIMQ+EOVfy0jJwmjR0jsFagNyN27JDdg2XrY4
         MzQfatjJUePq7TVvaUZ+zLI5LKKel9wOh12gYrnXC8GhDHaF6vkpl08t2qmxmZ8DztVv
         x+H8pjNM0F/mpR8l+aS2p59d9MONRxGxO0b98JqqNNr9Di+2DNq5cBf+YxxgYtgxLWT1
         8/K/3wZOZLoNwayr0rCsebFF2VTcMsvB8UbnvG0X9OClq3Y7X1IGeXr30lwW5Lp/hxrF
         u7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775242143; x=1775846943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPs+1/3zZN7CqhYoblNKC630QIsQYxPkweGwnGO0pvw=;
        b=eG56ViHolpzG0hk8ADmh1mcCqWEjcle0xWGZfArWDdHpHTpPxbH2FKzFbhkThFJuSS
         u+RWUv/b9FqYfqyyQdKl7gHK758T0i4Rlt1tUBe/ObAIFsIYbr0TCk1ZKMa3dbElEwXG
         AEYOyoTerGpPlPv+g0BJGNZAE8Re8wLxN0sdbnV67oB1IQXwLMyMLifeh4ZgSn3Tvk7+
         +KCosjvmKpUMiw+iKhc4BgSO3H1h51BGoeXMVB3hspDis6GFKyi1H+4BVlzslU1s0Uu7
         FKMSILAXgvufdZQuIpKWjVs9Cs20SuDjDSGec0v3ysEingjtFn524SRzKdEXLIsdb/a8
         3TYQ==
X-Gm-Message-State: AOJu0Yzfrw08T7Wt6lKMwozYz0oW+9fEb5VNKovRSavFjTZfpVZlTrEp
	RR+vCXdMl7yy9EnYY3UpD2i/m+mfklA7dTr3nwwuvYVSNmU67N3QdKAYo38yeVCxdNAFTBEnUZq
	L3+52K7xHPq9KvhP9mVcBhrIjc5UHvOJaZp9z
X-Gm-Gg: AeBDieuB4hmTMf92/ZI9MMW9eUqjQ4j95fd4co4wE1La89a2FpY+P4v/xkVuN76r0SX
	1a28YmL2DnGApnhS+Dcza3erl2V7CwAzKG7VpChItTMt2LRi0JbmHiK4HbwSUnISgQIIJtuQGNX
	L7X0dHfDJ8smZswxDamCPnOSIxGfh5elZycGJZYyH8+m/PUL+HtLduPtmHoGUksVfYRSVdqMO9Q
	7ZdDXn8/muimbtnVfTSF2xmP8+IWYbhu9MRc0sAwSaTke0kPtj9DvEuotfaDP2xi94OHROGYC0v
	KtymMFr7bvUqAcsQB9QoRTaVuvBo/4IUhLzrHcJWVWinAZkR09RYPDtJM0VEgewrGsd98Gvu+02
	9VYYZq/LlicGWrJuStwq2eOy7w8cHvPY0hn3qlvfVhyIiXKC+Zeks9Q==
X-Received: by 2002:a17:90b:35c3:b0:35b:94db:fdaf with SMTP id 98e67ed59e1d1-35de6a69bf4mr2127741a91.4.1775242143282;
        Fri, 03 Apr 2026 11:49:03 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-35dd369164dsm485693a91.3.2026.04.03.11.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:49:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 672CC34071E;
	Fri,  3 Apr 2026 12:49:02 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 4CA5FE41BC6; Fri,  3 Apr 2026 12:49:02 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bdev: remove unused BVEC_ITER_ALL_INIT
Date: Fri,  3 Apr 2026 12:48:51 -0600
Message-ID: <20260403184852.2140919-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro no longer has any users, so remove it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/bvec.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 06fb60471aaf..d36dd476feda 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -201,19 +201,10 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
 		((bvl = mp_bvec_iter_bvec((bio_vec), (iter))), 1);	\
 	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
 
-/* for iterating one bio from start to end */
-#define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
-{									\
-	.bi_sector	= 0,						\
-	.bi_size	= UINT_MAX,					\
-	.bi_idx		= 0,						\
-	.bi_bvec_done	= 0,						\
-}
-
 static inline struct bio_vec *bvec_init_iter_all(struct bvec_iter_all *iter_all)
 {
 	iter_all->done = 0;
 	iter_all->idx = 0;
 
-- 
2.45.2

