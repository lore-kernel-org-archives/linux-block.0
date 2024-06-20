Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1188D1BB6A6;
	Thu, 20 Jun 2024 17:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906239; cv=none; b=PdDPgUPiBzd11FJAFYvSNfbTJ11KraEv64Igh7suDgo/zDa8AotQ4PA+GZWjKCjp5o1paaCCLRqzEcCgWINW5c4MkfkcXuIIwx1CrsyQbNaYUNL6xQBdFLNqg4kIT68NO5Y392BBd3Dh2JRbBFBC02NlLd5Awt6t523mIjQVw6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906239; c=relaxed/simple;
	bh=IVOqRERikmBLXj/S4EhqDnNUn0svGtRW3/tF+qqU7rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWTidXXwn+dqHG1OEyJMO2Xx0VqY6x50e0QubUp/3r8H69MN9dvDj+mD95RdTUbISb6iYfmrP8FOQ1hRrQZy+ff4+B0r4kd2nHzxWShnLm4Po3DSq4vJeVt//kmp87w2LLaY9Nl6QHkMiN6cUcIQCX8AGSswgbCa6RMysM1saco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbyNgHUn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbyNgHUn"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-706354409e1so1087930b3a.2;
        Thu, 20 Jun 2024 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718906237; x=1719511037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HhrUk1+mUN1F/EY1c0kk41tZKguvC2y3hVnxrlEDx7A=;
        b=CbyNgHUnnmxAeGqFpUvDlO/Xv4DSwaGYjDqTPsPpoVNg+ePvN0DNkLZlEj+WSsFn0E
         kX2EXvwwmd5Xj0WF8ZTL49c4md3LlLAyqu6nv9GQr4cnyG9KIK9/xpC4tPQ+dkOJURmf
         1xTYtxAiaPibRv4nO5IUyBebHKwjtLckoyvA/OwXVDjgfDOCdcinFhezZlUit//llQN7
         ntZMzRzKWHyQWTg/+JeNSmeTECeuc7W5wollqg3ZiHNjmm9v7MgQy0BL9r4NEZ4DxKV2
         XA/YEyQFECEE4LzeGIDKOc28iKzJbkPCyfHjcIXuNaDaUQ14EevbE1/5PHZu0qq/5H7u
         /Lmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906237; x=1719511037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HhrUk1+mUN1F/EY1c0kk41tZKguvC2y3hVnxrlEDx7A=;
        b=FRvA+w9sSEDdoXvWu5A10gqGEBZle3ImqalrjlwONoqMBAKHH2xmRnW7CiyCjJKbWJ
         4ua1z2nR9YGRGfl0nxcsTHkUn8VnO0AEKDjkEbH/uzGcBhsa/rWL2l7rudS0bQz/+4lo
         8kVcRH5yYpB9M7Enf4wW1MJnKL6KxomUQQYO1FWfy2nPm/6mYKYwDpi9HPLGgnI9Avd9
         5+LXHeeREeECfdgOPF1oQXT3Q25D/YZT2znniv7YnpwJ/7vXPyWFr+ipGABPQkJ0u0vG
         Il2MMlilqviGpqsQqLKlwVCDsP79VgRgdae204Y2HTRLADxlyDZDvuynb/S3i7HqL8he
         +JVw==
X-Forwarded-Encrypted: i=1; AJvYcCX4omB2ONhorDQQKIudg5r+rMK2KqiPOUvpyUovsPqvPDdwA3V1yOqR0MKT0dp6qH7A6iBO6fZisVnR8Eh1naNXDUBL8fJqz2RAngc=
X-Gm-Message-State: AOJu0YyqbtGzI+v3xqPjQNOXIaYtrXY9QEad4+o0RcQOmmOFImup/e4J
	OZxC0oL7D32pWuc+9ldTstuEBH/XtfLXGqW3m/Ebc6RMIYGgNW+xPIFv+39p
X-Google-Smtp-Source: AGHT+IHpmxkoFebUUOkKdZ9h5TVM/Y2ZZ8tmFfJa0z1asysx1Lt0lrjXjd81Wa3PpwLPa2TUwX38TQ==
X-Received: by 2002:a05:6a20:2056:b0:1b4:772d:2892 with SMTP id adf61e73a8af0-1bcbb594fdbmr5780731637.32.1718906237195;
        Thu, 20 Jun 2024 10:57:17 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91dcf8sm12602486b3a.27.2024.06.20.10.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:57:16 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v4 03/40] lib/sbitmap; optimize __sbitmap_get_word() by using find_and_set_bit()
Date: Thu, 20 Jun 2024 10:56:26 -0700
Message-ID: <20240620175703.605111-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
References: <20240620175703.605111-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__sbitmap_get_word() opencodes either find_and_set_bit_wrap(), or
find_and_set_next_bit(), depending on wrap parameter. Simplify it
by using atomic find_bit() API.

While here, simplify sbitmap_find_bit_in_word(), which calls it.

CC: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 lib/sbitmap.c | 47 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 37 deletions(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1e453f825c05..3881996217c9 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2013-2014 Jens Axboe
  */
 
+#include <linux/find_atomic.h>
 #include <linux/sched.h>
 #include <linux/random.h>
 #include <linux/sbitmap.h>
@@ -133,38 +134,13 @@ void sbitmap_resize(struct sbitmap *sb, unsigned int depth)
 }
 EXPORT_SYMBOL_GPL(sbitmap_resize);
 
-static int __sbitmap_get_word(unsigned long *word, unsigned long depth,
+static inline int __sbitmap_get_word(unsigned long *word, unsigned long depth,
 			      unsigned int hint, bool wrap)
 {
-	int nr;
-
-	/* don't wrap if starting from 0 */
-	wrap = wrap && hint;
-
-	while (1) {
-		nr = find_next_zero_bit(word, depth, hint);
-		if (unlikely(nr >= depth)) {
-			/*
-			 * We started with an offset, and we didn't reset the
-			 * offset to 0 in a failure case, so start from 0 to
-			 * exhaust the map.
-			 */
-			if (hint && wrap) {
-				hint = 0;
-				continue;
-			}
-			return -1;
-		}
+	if (wrap)
+		return find_and_set_bit_wrap_lock(word, depth, hint);
 
-		if (!test_and_set_bit_lock(nr, word))
-			break;
-
-		hint = nr + 1;
-		if (hint >= depth - 1)
-			hint = 0;
-	}
-
-	return nr;
+	return find_and_set_next_bit_lock(word, depth, hint);
 }
 
 static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
@@ -175,15 +151,12 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
 	int nr;
 
 	do {
-		nr = __sbitmap_get_word(&map->word, depth,
-					alloc_hint, wrap);
-		if (nr != -1)
-			break;
-		if (!sbitmap_deferred_clear(map))
-			break;
-	} while (1);
+		nr = __sbitmap_get_word(&map->word, depth, alloc_hint, wrap);
+		if (nr < depth)
+			return nr;
+	} while (sbitmap_deferred_clear(map));
 
-	return nr;
+	return -1;
 }
 
 static int sbitmap_find_bit(struct sbitmap *sb,
-- 
2.43.0

