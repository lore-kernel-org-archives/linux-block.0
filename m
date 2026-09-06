Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDBC156661
	for <linux-block@vger.kernel.org>; Sun,  6 Sep 2026 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714001; cv=none; b=J4+unHVsJe7BGwgCkwNm/fuhZU6Ax6VoJ9YRXUJDRVp6TlSbSAq3RcwzTQLZHPOq+emBzsKrfFezsVWL8sD4mTZ+iYAtxEV8QdZdLKm/orz9kLc9tqldzKAvyvaX85jrfFhUjDQ5V0w4mxgN+mgUulhFbgmGa7J4/rPu/NUiD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714001; c=relaxed/simple;
	bh=koHGgaYQhy5l7Xd8x0kzeUbot1zmBz43hCw43Ud9Ni4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qqncfQ6ThYgsWQOFffs+XC8l62rmNa16WA7bFUSoCgmiuj3YLAm3P7ioj9olMJKahTy0xjaH24W0NkG9U5tAyKJJu0u9hVUXUkRvaR1Fe9b7f56kBYEKK9OtvLGTnhfx7waVmfR+6KV8PHl3B+kvvYC/8CEUxyGs6l0bfiS3aKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlbHRvsN; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlbHRvsN"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49b965570d7so32170095e9.0
        for <linux-block@vger.kernel.org>; Sun, 06 Sep 2026 09:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788713998; x=1789318798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZY+zOvdhv1bEP14Lz6R+vV714VKIw9Zvoo3pVmRXn6I=;
        b=FlbHRvsNr8+1Nc6WUxmoOcX1QeTZ+NHmizGk5G1dCvEtUNR0db8AolR2v2YA62Lv8u
         948Lq5nrhNiEN+Wn+Sz3QoDdUuAyHZwglYB+RDMRZ9mr9tvG0Ll5qvDAJ0MBr1J1PhQi
         E2Eyld30WYN50L+avUhVf8a8eoxnzdJM0lhur/1ln8Q/+i8LfI4eq1pRllM0/Jtxtfex
         LvssMjs0rEc2hGZikltu3BoOcVP3cf19bE83E7PeGBHzCDtB9o64UVwNjpMSJWPrQCEm
         5PKTfwKnb8bBHxYqTI2cdHhZTWxLEmKy3hu9UKRjC9c7+fqHcpmnXzhEzHfjDEG5e4ry
         LFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788713998; x=1789318798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZY+zOvdhv1bEP14Lz6R+vV714VKIw9Zvoo3pVmRXn6I=;
        b=dEJkZU8Ru0x3CgxSwpUeb0WpTBT8D/g23mSi9mxcF3kVa9Ye/KYi/sD57Q33t70cTL
         BOaUjgp2ic3jh5/SUGPAM51VMgxWtojTJqR55J3tlaEg0O8ZQOV34eXxTlcgj9b021nZ
         q3dz1RiR1sLJLjn7wRPQGBo6YGmm2nm2CNtG9eOrO8L4Z09AGSD2hRL6zW3WDDmjDh8d
         MWKJfguQp8H8+IWD4Tcmq6QiiiMQtuuKHe+cTnFfZB7V0cC6pRoIKgew+bxHYmGlOlNW
         no6XeRs0O4RoL57h+k18kCkAttENwFlaW62SzVOpVAlAfYrwJrHtLdh9V71o16pnBW5v
         M0AA==
X-Forwarded-Encrypted: i=1; AKwUvBy6u8DDDLsjfYmaNToRRr4yqEa1/7zC0TKlnq5xvij9ZDEuznNdJAM3yE596VAWzmZGdw/03P/IV/vI+A==@vger.kernel.org
X-Gm-Message-State: AFuF++mIZARUJny4DNraB12RYA1x9mKt9o+K0frj+j0X8dIIo0KzW374
	45BjE+ArlMLf7PFihBAeopD20yWi6r97ctjABJ7FL0NyUcW4XP5OQm3e
X-Gm-Gg: AYBFou1SyLN6fSjevUboIvPswKnsjx6bNJDfbR4bzr8AEkvwMx6VVKyD9pn7Sx5lRAB
	5KZCeYZAj/uuEwsv09Kb0j4KPlABmePgSACVtvSMSbcnfuG9mfFxcFCIeq6RFiWwYNGiBhVXF0R
	bWZ1sul4G0AtefkN0EvTEr7kv8BXL8M2+kMmm9/D2Dea+pMaR7Tpg9nveeOzV94Mdvzoom7zV87
	MHIJLW+C0AaYdAnwmEW24JhyL3L9HTSGqh1Ri5yg8HbaQ/3KoH56gVLvgdILWk5vWZnV8DhPW67
	uchssu+zc4qTfQP2pkvskLYeZbumGokgJF5nbPu9d//mnj1DPlkeK4OoLAjAQnUhedXaj9jwzl1
	u97hGKsINExAlgqnGdws424EexkRRwMLlWv+Kn8OYzplHbdwJj76GoxzugqYLshW6oSXu6+tkQn
	XV7JKzJ+fGxSQJTQmCilc8ZprxuBeibmaLz4buaWnp10fzHmztb839wWXHoD9YR3qcqGlgHHU4o
	PPQ/xngQszBfmLTwNhRxmV790GrVqgvApRVJNVtSpnQ6ewKbXVtWiinSZuWQPdM3U8CfNxTw3LS
	kfjqApFgbL5wRZHxVPQD8VnDOFWHyskMYrk9cliy6YBIvf5qMQk+Xayf0o103hIBvFev42fS
X-Received: by 2002:a05:600c:138a:b0:49c:fc6e:8cba with SMTP id 5b1f17b1804b1-49cfc6e8e34mr155605045e9.30.1788713997908;
        Sun, 06 Sep 2026 09:59:57 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9d84-5101-9c80-d25b-14b6-410c.310.pool.telefonica.de. [2a02:3100:9d84:5101:9c80:d25b:14b6:410c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm245902265e9.4.2026.09.06.09.59.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Sep 2026 09:59:57 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-block@vger.kernel.org,
	Satya Tangirala <satyat@google.com>
Subject: [PATCH] blk-crypto: Fix the num_prealloc_fallback_crypt_ctxs parameter description
Date: Sun,  6 Sep 2026 18:59:52 +0200
Message-Id: <20260906165952.2344-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module parameter is num_prealloc_fallback_crypt_ctxs, but its
MODULE_PARM_DESC() names num_prealloc_crypt_fallback_ctxs, so modinfo
describes a parameter that does not exist and shows no description for
the real one.

Use the parameter name in the description.

Fixes: 488f6682c832 ("block: blk-crypto-fallback for Inline Encryption")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 block/blk-crypto-fallback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index 2a8f40a65158..877934db18ef 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -34,7 +34,7 @@ MODULE_PARM_DESC(num_keyslots,
 
 static unsigned int num_prealloc_fallback_crypt_ctxs = 128;
 module_param(num_prealloc_fallback_crypt_ctxs, uint, 0);
-MODULE_PARM_DESC(num_prealloc_crypt_fallback_ctxs,
+MODULE_PARM_DESC(num_prealloc_fallback_crypt_ctxs,
 		 "Number of preallocated bio fallback crypto contexts for blk-crypto to use during crypto API fallback");
 
 struct bio_fallback_crypt_ctx {

base-commit: 986c24e0fe44f844b44d365b71ce831947f50298
-- 
2.53.0

