Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FB4145B3F
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758626504; cv=none; b=dX2Ei3zXn9kJrmhtAI6dzKoT/SXH2EMtMfYGpgXdsHutCYzso/KwWec/QNdRUdiNIa7DfgHUnw57AyvUkxiiL2wAEs2aj6qKNxnaQ3Abb9cMVMCoWZyR9P6/NtcXzdb+3c36jGCnW4PA4wYhw6n1KP1NJi/FFXlIjYhOeHmEX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758626504; c=relaxed/simple;
	bh=oRZRbtn25wG8Mfnxe8Xvi6eumdN9gT1dtlxB0ybo29I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQ7vuBbhAgLcq/gWRBmGSNXJAqGmkb/kRZNpKJ9xERNex5A5F4RShZ68qs9MYE9zzXuE992UI3Cxo9OwtSxUdsXisOnV/T4xC8JJnWm/G26xt8kTKNXpGukoQtDCDncYIkJ5Aq2XuD6qvjVxUGS4IXjRmDjzVpM6pjPz7TNh8T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=bmvMIh6Q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="bmvMIh6Q"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77c1814ca1dso4175348b3a.2
        for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1758626503; x=1759231303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c8aCLNCj+LP+gXeguDj859ZfQMvDmgLrlXk1t4GOA0U=;
        b=bmvMIh6QimjUOM0z7jHqezFFQE+2ZNbyvK/7+QU/HXrsZYJrmbPsC79Y3Bn/O+paw8
         h2FSeWA25McEt8PZpjS197b7Lxlo6yT3vEYp0tyjM3EEuKYyenLpZnbuLbEBylWio2Cj
         ++UhvMPehz7zSksF9oQaRyirWvyFKtsXAPiMGfnDsQqvEDEH4fO8pRZ6rdSLlFrzITPG
         cRUNBJyfbQcGNJ02D58PV0imaxVY+icxWbbQN7WOe4jKqCtp4Sdi493A1gsG2lGsUoYa
         cwSVWAlKtYXGHDLMOYFH/eVe0VI9rMcwUrxrefeDOrF0CqIDUDADJ8/WGFN391qdtV+x
         LMQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758626503; x=1759231303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8aCLNCj+LP+gXeguDj859ZfQMvDmgLrlXk1t4GOA0U=;
        b=qiEQZVtjyDQkyhyWR8Ag/5FszUUayaQE5L7zZJ8KAmC6bI6AHfTOD2zeUEIaOxSWXn
         uPihctCE/s84IHtf5LnTJVBgC/bNaIk0mg3+kFOH7eYbiTI+UIaXWLxfuKnCqc6TMO5M
         1KDX5ZAMn9lfrjU4hXkOav3bsGURimfjT+hZdG7WUA8u7FNrezIMc3L3V+MQDzDqziFJ
         CYAfrw7jV91yjEd9NxlYXYvwMNYvYse82abAA5/BEBHzCFk/YThO82QICpUCei4KGfII
         YnBz0MkN+JM25JpJJ5z7LL9XGCL5Wq10vPIoLcceaYVTOr3SlzKAd/1r6ot6r6iZO+RL
         Q7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyZWY0AvoKhLmilR5F89G+5NMkZL5F+krqA2tYVXC5IOFDIUSwgF92DrX0XYNa+Oh3dQwN1ZL4XT7mKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj49c5ofz245v90qqVUEtPwpVDmSaQhJL7Fdpcd6LxXGnkwLFb
	SKi4XLvubJvM8rQPUvd0+oLSUNz21r4ATPEoWdmZ6zciYUSRfm9/jaaWTzld1ddwaUM=
X-Gm-Gg: ASbGncu6XAgIboXeDnAnSmWf672GM2FQeSa9SLEL23WTCKLB/s1RKdJVntPlUANjLko
	0wKPwJug2mLC/kHGhR7EFtqWwyT6S3IjKkA8I+QjRuPIU2pkwrvO7C4Q6LAwOm++16a++14hM7v
	3kFJX4dKAQKFxess9k/FEJ23yyAwq0WQh5rAyqFURC79hADpw/yXrYC/cV37E9zkQhctTNuP4Pc
	zWNjwUf0OVSp+6uiGmH9pOYnGdJh34cBq396CASsIVrUXjjZwQEdAvSlRU8Ce4KnkkwRysH6dvK
	2RIyLqCOWCQRb+Taa+nqhKokMWCmjDOvipSafbAX0b2ZPCli18VQW8wHkd7bOyvFWPLhGkiS09f
	kY49T2ER73E7tUrrzo9mthhxRgg==
X-Google-Smtp-Source: AGHT+IGeMmgGYBGDbCAEjEyfK/FBtgLjaMcau85i22KMrpu5feCZtDLVsrAl8PmDzawt3QD2OEIvLg==
X-Received: by 2002:a05:6a00:1783:b0:772:31e2:b80b with SMTP id d2e1a72fcca58-77f53884356mr2169770b3a.11.1758626502659;
        Tue, 23 Sep 2025 04:21:42 -0700 (PDT)
Received: from localhost.localdomain ([147.136.157.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e87fb4698sm12048962b3a.96.2025.09.23.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:21:41 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	hch@lst.de,
	axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH] block: Update a comment of disk statistics
Date: Tue, 23 Sep 2025 19:21:36 +0800
Message-ID: <20250923112136.114359-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

From commit 074a7aca7afa ("block: move stats from disk to part0"),
we know that:

* {disk|all}_stat_*() are gone.

* disk_stat_lock/unlock() are renamed to part_stat_lock/unlock().

Therefore, outdated comments should be updated accordingly.

Fixes: 074a7aca7afa ("block: move stats from disk to part0")
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 include/linux/part_stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/part_stat.h b/include/linux/part_stat.h
index eeeff2a04529..729415e91215 100644
--- a/include/linux/part_stat.h
+++ b/include/linux/part_stat.h
@@ -17,8 +17,8 @@ struct disk_stats {
 /*
  * Macros to operate on percpu disk statistics:
  *
- * {disk|part|all}_stat_{add|sub|inc|dec}() modify the stat counters and should
- * be called between disk_stat_lock() and disk_stat_unlock().
+ * part_stat_{add|sub|inc|dec}() modify the stat counters and should
+ * be called between part_stat_lock() and part_stat_unlock().
  *
  * part_stat_read() can be called at any time.
  */
-- 
2.43.0

