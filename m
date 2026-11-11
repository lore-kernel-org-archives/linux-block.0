Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379667;
	b=XdikoefGd57ikSZNrQPgcz87ZxChAQqxcW6KmG21BzPOUe28/BGQQIwFasvVyOvzAYcl
	 EpXAoj6RpxYpai5+p2NUKKKWTi8UptxB7F64+nc1wWIa7IeZTpsRqy3h1d1T2rcwKfcEy
	 6X8VO+XjrLLn3z6L5jeS/4vASKVkEaS3/Vz3qAJS2RLFPAXWCukpgk75ChfqUGn3sMbgo
	 A22Zn0PE/oiO77aezC00CanSXB5Mbc8q674ZzL0kxn4Sm2kxsC0GdH2il6E7fX5qlJnv7
	 ppLkW4zuO+vNWSp5HQehRVlvgHpFDEiqTGB8ifke//KY84W4juDffV4gKbEn4s1WeZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379667;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bvnurKRq/kU9ebhETLig/zqsjvD96i3F51B+gs0iQaU=;
	b=JIQ7IQEjeBMbK7ipkuIOV7JZrrjX97c9gLBubLT0yT2XFLDY4cw/yn3xvNnQSQn1VzbR
	 +ur/M8lLd0BOM3mZrjrrFNlElCx2ojQpTgQBhbX1BTcsPso9Ywh58OzYR5gn2isLutuBl
	 m7JOJVbFfeNsysHFr98yIM5dA+o9oAHceHR/OJR20J0nqTSDphULeQYtK8rmnOhxwlJIK
	 izR3ihTMK/QvTYC5IiNFMoaQXYKa4ow/23ah940MiXGOEIDLiiJgdUeAYD5SB5Gnr4SEk
	 sg+kj4qz2nYFnF1HL7Doj33NgrioyLcm/AbIurTsNG2E/XmeBu0DTvLGGW0uis0sz2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=VLJ2HuRu;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D83606B47B
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4D83606B47B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=VLJ2HuRu
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso1960597a91.2
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379666; x=1794984466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvnurKRq/kU9ebhETLig/zqsjvD96i3F51B+gs0iQaU=;
        b=VLJ2HuRuoj5amitbJWoXTKqcESYkJs3OcUkRzhVvHMwJZpQGA2aGy5LI99GenuD+is
         CG7BpF/xXSkoyIKVAhrJjE0CdSsBSaYgt+vPR4GtDS1HPsRCu89Huzu396qSj3hT3jNM
         XPD//SbYtaO7o6inx+QxLcLXs0es5LZxvfIGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379666; x=1794984466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bvnurKRq/kU9ebhETLig/zqsjvD96i3F51B+gs0iQaU=;
        b=wo+xSAG9SAuctq3oXLFtf30ID64pqYUOBrf3Aayiqq15z9fa3tRY903i940/5x7wXd
         S1GUBAro+p+R6g55PyyhoiY3rMlNVWrvpJv2c+ZSweCGCUbhHqOuyREprHssAX8zcIw8
         F5iYDivdC8e6t1J/qmMA0pkxM1qckSpwHq8vh1F3YfVsgUtd64/Vw/DRidTvCce63K94
         R8Mr9imlBBpl6YRcDB2JWUK6iTuEfDJ/J8KRFM9ctyN7wfWt2MjVMlkTUNX6dS3LJhbd
         ZhR5ELi7mbVjt4UQgKaWAjMmeHCeXWWj52Gux0qmDo+gYxsbaWwlY1siZ7jD4Qlu70jX
         moTg==
X-Forwarded-Encrypted: i=1; AL+hErFTe3kWpakOxng/419mEfDHsRGHGF6biB2r5G1wRFYpik9ZG4b4MZZCSrqGGE09JWpH6qnYytqvbKMmzg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8ERX0Zl9cgbB5hKny7Bj2XaTB8cny/TmnxAmaTRQVDWbATRsoE
	//iDCAx2PsJuEBpuQ9pE8ReMjPCo/DoYcRcEuUEblllQa4+UAJ1Ifkn6xFscuwHHVg==
X-Gm-Gg: AYBFou1fGEDrJHlDfLVPOUGDmxUIJRO7dz4YH0WwtE0AZRYV8j03S6gHL33HnWjNA2t
	ePzhJ0rJGhSjnw8x4Tc9vdmvvicVavO/qMLHXdT+o3AHRsWBXEFKMB4zWE/viTo/DdCwyiILXm4
	jccQ9ySKD6lf000lfdDHDuCaVpOeY8PLr9XYNVxamUlBFuTMWUAs5OqsAw9//VNeNxqMvPWn0+X
	k+1R3CuT7hBg24zL3kjQpDNffYTxN9MSoPIJBba0OnhBiz3fzY25bzx40xwagdqNNp4talQqhKU
	KE9WSmh/JuUibdpD/EqsWG7hHNxdq1nQl1yPSPxBeF+C2WJugqwpHUicEQRSQbDp+43tQMjQ3jO
	pGwkzbLF/JbWKNhl/WhqBIwInNQQVR5GoFBcV8G35stiv4N1LLcPQC5ZrUIDZN+aYENZybW6q6n
	KucSP/VjnirFGf9bEowommBPwRKiDy/xrfRjmvTE5/7GH9jEcduT1g7Ls31fKO36gdeOwEXfrdk
	cs3OENMcvEdZ539Y/NvuR/tetTIz+zU+0xQIpuO/ghhHeMmQd3E5sxrKWR6hQOPAlqi/Snuhzqv
	2OVoIsBI9sGARUxEidY1xyt5HXLRuXG9FOLZmfI/6H9YDi3g0LEV9fRxBtucIW2WSXRGzx0WAIX
	8FVOLgom2CJzR4KAXHA==
X-Received: by 2002:a17:90b:3c12:b0:3a8:bd51:205b with SMTP id 98e67ed59e1d1-3b182efb4e0mr1748244a91.37.1794379666174;
        Tue, 10 Nov 2026 22:47:46 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:45 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>
Subject: [PATCH v3 11/11] zsmalloc: populate new zspage outside class->lock in zs_store()
Date: Wed, 11 Nov 2026 15:46:34 +0900
Message-ID: <20261111064707.2568433-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
In-Reply-To: <20261111064707.2568433-1-senozhatsky@chromium.org>
References: <20261111064707.2568433-1-senozhatsky@chromium.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new zspage is not on class fullness lists and is not movable until
zs_store() calls insert_zspage() and SetZsPageMovable(), so neither
other zs_store() callers nor compaction and page migration can see it.
Nobody else has the handle yet either.

So for a new zspage allocate the object and copy the data before we
take class->lock, and don't take zspage read lock.  This makes
class->lock critical section shorter and saves a zspage lock/unlock.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7f1cedd34081..4a6ec43f418b 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1323,8 +1323,12 @@ int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		class_stat_add(class, ZS_OBJS_INUSE, 1);
+		zspage_read_lock(zspage);
+		spin_unlock(&class->lock);
 
-		goto out;
+		obj_write(class, zspage, obj, src, size);
+		zspage_read_unlock(zspage);
+		return 0;
 	}
 
 	spin_unlock(&class->lock);
@@ -1333,8 +1337,15 @@ int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
 	if (!zspage)
 		return -ENOMEM;
 
-	spin_lock(&class->lock);
+	/*
+	 * New zspage is not in class->fullness_list or movable yet, so we
+	 * can allocate the object and copy data before taking class->lock
+	 * and without zspage_read_lock().
+	 */
 	obj = obj_malloc(pool, zspage, handle);
+	obj_write(class, zspage, obj, src, size);
+
+	spin_lock(&class->lock);
 	newfg = get_fullness_group(class, zspage);
 	insert_zspage(class, zspage, newfg);
 	atomic_long_add(class->pages_per_zspage, &pool->pages_allocated);
@@ -1343,13 +1354,8 @@ int zs_store(struct zs_pool *pool, struct zs_handle *handle, const void *src,
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
-out:
-	zspage_read_lock(zspage);
 	spin_unlock(&class->lock);
 
-	obj_write(class, zspage, obj, src, size);
-	zspage_read_unlock(zspage);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(zs_store);
-- 
2.56.0.542.g3ef89b7020-goog

