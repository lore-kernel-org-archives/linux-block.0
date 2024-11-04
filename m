Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F041AF0B3;
	Mon,  4 Nov 2024 11:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720274; cv=none; b=dgSfhNvUAnCEDO/9DxF6NgLRDbTT1/cccmAeamtKgq+1itfx5Y3Q/uvvoBX10YXDnlNBIhzfWAQB+EmYiJBuQMcqzIsH3TqWCnkhlNwCFpqosgIrJf2oDCXTfeOVDOJZ9xw4YhicX11Xr+S2nVXHl4ZxIuUrTKN6/7W5q5zrwmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720274; c=relaxed/simple;
	bh=lx77u/gDFh72VpnCCaSNEYGR1kfowZD+gXLyxcawzxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rh3Am0rOQxOUP4pwFmCbcmDicx2j6RR2NoBMcxsrVU94m3SBgJU0WCElszqxtm0d5U+zNCrqhTq9YGkijrAmwbRDKA/9tYce54vyG3eYQCQcQ3XWbeKpld43op2XIQBgZNYAoPYu+EY8DBPsdTk8RnC2hvyKSUhPH4PMXbzaenA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuhQkevM; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuhQkevM"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-288d70788d6so1865148fac.1;
        Mon, 04 Nov 2024 03:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730720271; x=1731325071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5SX/xXj43PUOgFpyn0Un3MyTb/tedyX32wA9jp1y7WM=;
        b=OuhQkevMKcb91AOxnpB4PkRwFAQ1vswYVqL87gxYJPt4AkWiPev5gjrLmLB03jN/XY
         e8gOTxobbJXTWxvJ1/raEkY4us2jIcdc3eXpR4MmhqRYc3JoYH67Sh6mIFdNFQlzx9G1
         xw14D7un5KSuxKxQX+UcZdJflDYelFy76MWcbjnzQwiaG98e9UgZBmfXQnPYac/ZKkVl
         reX25FWHp6mYGlFblKnFbC5YEuA4gDbekaG5Kc+bCTNSziiMVH4hHYIhW5vOhAHlmaUP
         7YzC+pBhXUD+uN35E9U2VZX3g6Pfhn7fJQ9kdQ/DdgxReiYJBQEnVS5Sxypy9I8q6KaQ
         3Rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720271; x=1731325071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SX/xXj43PUOgFpyn0Un3MyTb/tedyX32wA9jp1y7WM=;
        b=ZOpaWTGbO93pGSIjZuWqFUBJHHeyR6jkuK/h1QQM3OV/QZKyu9ppNcmLnBCfbZkwGC
         t9KpOJuM56El6dvUG2kKFbAwznYy7N4Q/jXqcpnMXsAMkoLwBpDZBUc6N4Kd7cxdsmD5
         WKaTLZUfxQpgZnUax8o0Z+ZtJb2tdpP7a5IctAMA1Ddi+8sUqfoh20D9tsIrkIP4O+DH
         XiSK4rwcbTXdxJuGep0eYXuQYxqjaSY5wP2tnsU5ZSbrwk9Sd2cSJjIuV0G3U74xuAfg
         y/nGKfSvGUPH5Z3wWjEGyGkgQG+ctOpLg2HvPjGsjGMB/bv+JzYsKD0Cg3bImwOgIDCf
         KHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCULGjHbznQDa4nip+2Uq8/mttk5KJ/eWlivrHHJ0jO6SecnXvNvazs7QAyNNjH11r3oZYQWNvJPak/padg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEkAIBkECkWfyUKP3I261Mtj5alJbHlpo7gKApL4QygdDszASF
	OcGe1RxyA9Haqp/tt6dGNytZSrR8/RuJgaMnjm5R8bxt74DKtTXD
X-Google-Smtp-Source: AGHT+IExgD+swM8YyDjIhA/y95jVAxvHIhtfjWOHz37OrhpHT02SP1aNF9kaDkS0iAvKJJecbW6mOA==
X-Received: by 2002:a05:6871:3a0b:b0:270:1884:9db1 with SMTP id 586e51a60fabf-29051af2919mr24065200fac.7.1730720271529;
        Mon, 04 Nov 2024 03:37:51 -0800 (PST)
Received: from localhost.localdomain ([202.119.23.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b87e0sm7216526b3a.36.2024.11.04.03.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:37:51 -0800 (PST)
From: Zilin Guan <zilinguan811@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilinguan811@gmail.com>
Subject: [PATCH] block: Use WRITE_ONCE for cache->nr_irq update
Date: Mon,  4 Nov 2024 11:37:45 +0000
Message-Id: <20241104113745.3099644-1-zilinguan811@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function bio_put_percpu_cache(), cache->nr_irq is read indirectly
in line 776 using READ_ONCE(). This ensures safe access in a
multi-threaded environment.

776     if (READ_ONCE(cache->nr_irq) + cache->nr > ALLOC_CACHE_MAX)
777             goto out_free;

However, the increment operation is performed directly in line 792 without
using WRITE_ONCE(), which can lead to potential inconsistencies in a
multi-threaded context.

792     cache->nr_irq++;

To ensure consistent protection against data races, this update
should utilize WRITE_ONCE.

Signed-off-by: Zilin Guan <zilinguan811@gmail.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index ac4d77c88932..e2648ba71bac 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -789,7 +789,7 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 		bio_uninit(bio);
 		bio->bi_next = cache->free_list_irq;
 		cache->free_list_irq = bio;
-		cache->nr_irq++;
+		WRITE_ONCE(cache->nr_irq, cache->nr_irq + 1);
 	} else {
 		goto out_free;
 	}
-- 
2.34.1

