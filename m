Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379658;
	b=emX/H4+61PljeSoKRGWvMRKCgR7dDQJJGmCR07j3M8LMMvUAySmjG3bxKFV2tdx4op29
	 Qc+DMwQALJ9k6AaRtdUzV7K7wLSNcobXXWsUJx+6gltOV9GI4bozb9VJbSO0WljfStZcs
	 TFO3A4HC+LkuvUzZtiJksbNUZfgTN6vIt3jniuVgj9afPYzkS0dSA49yDegF4Kbr4VyjC
	 ux+UFZVrtvH2c3mQVElGFua4iyBxS8PoUtsDlnFTUHznwiafxbx5tBqlUhMIoWcWha4B4
	 hI2aq0X9Cbqp+A3PkXyT0ILLkBZ0t/yeqmlEcn5Ovedn/q/OqPuTsu9pT0FeLWTxAcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=danRQcnk3B280h/USGxRmGkCh5xva64LrrnpATvfP6o=;
	b=So1EgMOQi528oTpDnbpepR0W8evm3wDjRxVXkcZg4eCfWmfKlTVWKyThUgMahkH7u4Yk
	 NFxs0ui2IeIgLungLILMlCc3Cz6Ksm/aKp5iP80Y6cDz+80IKUJAxIfd9m9wu9YGHSf97
	 Qh45qa6+ca3ppntEaYuHpcnADDW4Qob+/O9hQ8VvThUzYg1fX8fMGSmz+LtSl3FElHKKr
	 2ejfJxwAfyE2CFoZ+Sxadd7KnLDiDpN9TKU6U2HtEVX/FCOjPG7L4I4MJkvafu1pGLU7j
	 PEvzTLyrw854O//OF+BrQxElQyg0AlpAczNO+Vi/MUbrtMILPErQE2sxNZgLq52eTAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jyxXPrHw;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D8606A9B1
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 357D8606A9B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=jyxXPrHw
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1358222a12.3
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379657; x=1794984457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=danRQcnk3B280h/USGxRmGkCh5xva64LrrnpATvfP6o=;
        b=jyxXPrHwWjP2gROkYCPjx/nYrnggPL6tEofE356ysgsXm9Xt5gUw8I1zKd/kH9FtGW
         mLx32KUZ6g5LskLuZrtCMDI9BYoIehKWIgEKtLqam4brQAtlTPAeOvEgK4Nvg6Hc0dwS
         WjC7PJht8Q1DVUjLsiM5zCn/gK+6A/LknNc7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379657; x=1794984457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=danRQcnk3B280h/USGxRmGkCh5xva64LrrnpATvfP6o=;
        b=UuNQVTKxoxoW1VCRWFMjRMKC2BDhxXYfb4ehmEWiu/m0zYuPAGYqo2K2knooRQ6rNQ
         lAbEvGE4jk82JFqlNzb+t4rC8yR6c9hO+Mg03HbsQLLw4+fF0Gn5rgQfgyvWhoqFPhvT
         rVt9OUzKOcz1LVNfBQEyRY2/mGYkKUHG3b5vy7yhfjjIYtP9vvH4NZ7twJWnIj7278YO
         sDxOjDE4q5r2frLYu03sJgKVegmUK5AN1E523Z0UQGsZCbx/N9Hw7TIOPBb33DnMnIrU
         gh6Yu0uUbIvoXHDgvAkrfNvdJLot4EPV2/sy3AE0DqZcG0AQrvjbM3Z5s52SnMqxkF5l
         K8yA==
X-Forwarded-Encrypted: i=1; AL+hErH1mjMSuWZoviDOgaDTyTaX7w6skNDj30pKZ6i3Hlll6TAsfP/04SX4k1+LorX90NfUfNAfv/CzSTZMqg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/aHcvlhe02VDNxshQgvu5gWltemtGfIpCo1iTIhd7iSWkg8nCI
	7TMFRK0zoFmBVmEjA42x4BKCcAQu7L5FOVDKnfYTSl8SaxbPrS00izxwhmvpq9YOlQ==
X-Gm-Gg: AYBFou1/0qlqmrQalLR60jTkGsTfZs/0b1uE7GSLw+KkGQ74Op/d7VF1gO/GO9XW0F7
	7FcJzqpkrFb8pLqN8+CKONZYDV+BpWtYHRUbJAhVqND1JIoJTKkphyJNRirulH8nTZPsnXwWcM4
	RY9v6Mg/23uMctplDNxgVh0rvtF620jIxswL4P+HbXdvDgvVJi10eHV89+ZLLxRS8oo5vsS9yZn
	3NIhJURyvTAYHafCfZW6Hqa09f7whcRV1uzOADNQsmtpC0RqsMWZ9AUjLKvqAXzdB0HMOvC156i
	AMel/Z90DTZ6+78a1B/yB7e91d+FWf3QIg+cG0Pp5a/JX3k0wQSUWZxIdBlJWBdAZ5TUGwRdQlQ
	MPkmBc2nwA88A981axPF30c1B7InA3nTADur9g6M0GTbMyDrrzVMIiE+ty1tEeyiILej+qAIpAu
	u0PlTBlz+sxhJ5Oh76EKsIy31DEEdoX7WC6ZPPiqIhKhhaADGdN+gYwyjaIquZ0r1ZTvOuzMT0w
	ZWg0a7pYCv0b6cbu1+XTZyCSQSWeVywacUczvYRfcwtbQr0DkLo05ZwaH6jWor/3Xg1E0SDjjxA
	oXXIJ/WgKDgG4DOyErLe8VRsuCsgcKIPQHjBF+c2XZzt5PFnpHn73KO12p0t4Gxostag+K8dMTk
	XEM+xMZql9qQ3BR/O4eDwGZs6/zCSRxkRSx+GneMe
X-Received: by 2002:a17:90b:4c02:b0:3ac:450a:fa22 with SMTP id 98e67ed59e1d1-3b182e02b4cmr1701761a91.2.1794379657428;
        Tue, 10 Nov 2026 22:47:37 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:36 -0800 (PST)
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
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 08/11] zsmalloc: encode 1-based obj_idx so valid obj is never 0
Date: Wed, 11 Nov 2026 15:46:31 +0900
Message-ID: <20261111064707.2568433-9-senozhatsky@chromium.org>
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

The next patch embeds struct zs_handle into zram and zswap entries,
and a handle is considered allocated when its obj is not 0.  But obj
can be 0: object 0 of a zspage whose first page is PFN 0 encodes to
0, and some platforms do give PFN 0 to the page allocator.

Store obj_idx + 1 in obj, so that a valid obj is never 0, and adjust
ZS_MIN_ALLOC_SIZE so that the largest index still fits.  Unlike a
separate tag bit, this doesn't take any bits from obj.  zsmalloc did
the same before handles moved to handle_cachep, see commit 67296874eb1c
("staging: zsmalloc: Ensure handle is never 0 on success").

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 2385c1951ca7..9be538d0be22 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -61,7 +61,8 @@
  * Object location (<PFN>, <obj_idx>) is encoded as
  * a single (unsigned long) handle value.
  *
- * Note that object index <obj_idx> starts from 0.
+ * Note that object index <obj_idx> starts from 0, and is encoded as
+ * <obj_idx> + 1 so that a valid encoded obj value is never 0.
  *
  * This is made more complicated by various memory models and PAE.
  */
@@ -169,9 +170,6 @@
 static_assert(ZS_OBJ_IDX_BITS >= ZS_PAGES_PER_ZSPAGE_BITS,
 	      "zsmalloc: ZS_MIN_ALLOC_SIZE would exceed ZS_MAX_ALLOC_SIZE");
 
-/* ZS_MIN_ALLOC_SIZE must be multiple of ZS_ALIGN */
-#define ZS_MIN_ALLOC_SIZE \
-	MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> ZS_OBJ_IDX_BITS))
 /* each chunk includes extra space to keep handle */
 #define ZS_MAX_ALLOC_SIZE	PAGE_SIZE
 
@@ -189,6 +187,11 @@ static_assert(ZS_OBJ_IDX_BITS >= ZS_PAGES_PER_ZSPAGE_BITS,
  *  (reason above)
  */
 #define ZS_SIZE_CLASS_DELTA	(PAGE_SIZE >> CLASS_BITS)
+#define _ZS_MIN_ALLOC_RAW \
+	DIV_ROUND_UP(ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT, ZS_OBJ_IDX_MASK)
+#define ZS_MIN_ALLOC_SIZE \
+	MIN(ZS_MAX_ALLOC_SIZE, \
+	    MAX(32UL, ALIGN(_ZS_MIN_ALLOC_RAW, ZS_ALIGN)))
 #define ZS_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - ZS_MIN_ALLOC_SIZE, \
 				      ZS_SIZE_CLASS_DELTA) + 1)
 
@@ -794,8 +797,10 @@ static struct zpdesc *get_next_zpdesc(struct zpdesc *zpdesc)
 static void obj_to_location(unsigned long obj, struct zpdesc **zpdesc,
 				unsigned int *obj_idx)
 {
+	VM_WARN_ON_ONCE(!(obj & ZS_OBJ_IDX_MASK));
+
 	*zpdesc = pfn_zpdesc(obj >> ZS_OBJ_PFN_SHIFT);
-	*obj_idx = (obj & ZS_OBJ_IDX_MASK);
+	*obj_idx = (obj & ZS_OBJ_IDX_MASK) - 1;
 }
 
 static void obj_to_zpdesc(unsigned long obj, struct zpdesc **zpdesc)
@@ -814,9 +819,11 @@ static unsigned long location_to_obj(struct zpdesc *zpdesc, unsigned int obj_idx
 {
 	unsigned long obj;
 
+	VM_WARN_ON_ONCE(obj_idx + 1 > ZS_OBJ_IDX_MASK);
+
 	obj  = zpdesc_pfn(zpdesc) << ZS_OBJ_PFN_SHIFT;
 	obj |= (unsigned long)(class_idx & ZS_OBJ_CLASS_MASK) << ZS_OBJ_IDX_BITS;
-	obj |= obj_idx & ZS_OBJ_IDX_MASK;
+	obj |= (obj_idx + 1) & ZS_OBJ_IDX_MASK;
 
 	return obj;
 }
-- 
2.56.0.542.g3ef89b7020-goog

