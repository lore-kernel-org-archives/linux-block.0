Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289750;
	b=XVRgIrCxafV8hQc/URSthj+lb9Iy+LfRy6nBOY7KUGtGm9TNgWCVsX4vhVY4+a+DHdGS
	 uABFecwEDx8e7Rb8Ywhm/0QqFp+KjEcbQnlcqfjJrHn7uiba/JwfrkgwF2DN8HzbVyQdO
	 z9Zk3Qx23vV85ercx3r4zBx8K3Bxa2syqrU1J3S1ZOZQxWvgK3mZY7HmyUvEhnF5z82Y8
	 72mZ60NIU9rPesWbGb9VkLp1o5jvO/X6gVbmZHmNjjc43SG6TsP1+eNSoEdNcEk7kx3E7
	 rD2LtyXW/MeDgrInfA61soYFaKi8ag0ogoTGUR+POqgDJlT2dh26KO1Bq6vxm/WKa3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289750;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Sa1P5bQLdexkX29DaU8SK96x8pyq0qViW8lSam/JRYQ=;
	b=oijjiUW1N7/EcbVrOoY8mOLYK+C29DmfAGw95o3PYfJ6MkDVU+qIXpjnN2vQqs/KElpm
	 gjmc5bJRadzh/R2nfL/Mno9k0nEInFAvjIiWGk+wsNQ7/H2ZttpNYWLmF9XAQuGRAG/BN
	 mZ5Xfco7pYVA3epCrHmiaGSSh70WqvxcRXzzzhA5vmMagrheL25b+kB1rvE6lrTeVDVbM
	 dfer0qUtemJjdcQzPlZ9zP5w9jqkXiZ1tYyzZiz+LYsAapUPB0c91M6NWU/duPl0l9gKj
	 6NEV6OmgRXuSBqY9EKMXs/ZkTL/TyvM69xnchL/2oM9EsD++rTMWTLOjlph9OPB9dtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Qf+EAb8g;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D6C60A3810
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99D6C60A3810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Qf+EAb8g
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a39e5161c1so1168952b3a.3
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289749; x=1794894549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sa1P5bQLdexkX29DaU8SK96x8pyq0qViW8lSam/JRYQ=;
        b=Qf+EAb8gSvRuPUTufeU5p9157hYxGSEOT0Ciu2UEIYHyFMstIh6g1TEAEz3WYM+PSM
         voXc2s8RItZtod4txTnfx/MNbah4DX/sli3j9NkqUZRnpJ+AXR7mq8sVlg59Oebk0rnd
         4bScfJlGQySDBHXg5TZM6T5vYD+kQmJDsKZXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289749; x=1794894549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sa1P5bQLdexkX29DaU8SK96x8pyq0qViW8lSam/JRYQ=;
        b=PyfQrJnfdv725wY1jQxdvjRriAhADtDZ1BqAjFdSZKjeGVngHCNItvHnpC+Hn7QF3m
         0TBZtnq3jbmjDYGCmYxcIPzI1LDUk1XZ2lmUUEdoJ8sUFQxlR1QWX7jPHVnPjxBMVJB2
         /DCPMwltYZ9NcYXfP2h32uY3SE4Ug77izrdsubJqg16eg+4WVaCir8J1H6VjhniguF0Z
         xLLtcDSg6qQ+CAiOwLh5dx99SKyFE1gawlrHirX6J40zhICF2XCNVsBptQx3fIRweaT1
         dCN7vy5XgsmkdzTKo1Mf8MgU/BPoAQ85sijTjpzT1nrWrwdWRd5yXciuNkVXkDp6Ar9A
         Tp4w==
X-Forwarded-Encrypted: i=1; AL+hErEWh/k9b34S9mbCIZzTK8rY0Brdl21zECfzNiJa7UywG8K57RWWN7PqF0zsv/yBcaMxWAQQHanFv2fmOg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9vY4zVnavrdzhVrhymoN6FRYFeYbidX622NcxhQSa+7WOWOAUw
	KYuZ/9BPhq7VGjtRqGpbkWsk/w67sa3ivJzLDSRqQ1ekEiAjMy338VQ4s+Ja9Z59xQ==
X-Gm-Gg: AYBFou2YbQPa/UJONTcqb3IEA5Zxit7OIw/7nrG43y17Og6hoY16mYYc3wpGAAE4711
	cJKmqGTShm3k98yncO9+OWmKikWGDMG/20Zj15lyGVA8xgyCljjnFYz/aPs2fI6M7fCCGmc+f8K
	EZK11BLtH49x+I+AukbpeyYDKYT2mrjTlY32w4Sx0gWQbbtIDmaGbMhneBk2A34q0onl0/ob+OU
	MPuFlnTtFnwjG3yLYixHSTdhIiD8ALU0o7dA2C7z8w+996qda//Jf9NjlTVq/rv3XrlNemlA2s9
	E5Wzuxs8bzmb/NYxsZO8ohzFFrVq7r1ptJWoHFYXHGimQUYIGIrOnr+6Nm0c1Zo8vAqN0wBneUK
	fo+9LiSIR/loETwIpQvypLvBWS4rV1o6+Jdu6tVPukMh77Ir/RCaKr+beWPQ5F/CEvRLi7vR7H7
	sQoZ2F1hSe/Mwyh0ovRN+DmqNpyLBK7wY+79/vAl0Vg1zlC9kYbwshZEZCMdWufcphh5ZzCOEQx
	4xMo8JvTcuANU4OFwHkhx1WyslzQoOhvQ/4qTTytyVz52jDC6L6q4L6up+K00kUr/hBTHkePQtn
	q19fQLcCbRsTqsGlj4gCN9vWzdFxeC9BDDd+esztffomHnYg5ww7gOXBV3InHtQ3V5ObtKgEWew
	/LdptZOaD5LQgO99rAA==
X-Received: by 2002:a05:6a20:3c8f:b0:3e2:2d44:fc65 with SMTP id adf61e73a8af0-3f18f2aef8amr1472830637.37.1794289749035;
        Mon, 09 Nov 2026 21:49:09 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:49:08 -0800 (PST)
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
Subject: [PATCH v2 08/11] zsmalloc: encode 1-based obj_idx so valid obj is never 0
Date: Tue, 10 Nov 2026 14:48:13 +0900
Message-ID: <20261110054836.1515030-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261110054836.1515030-1-senozhatsky@chromium.org>
References: <20261110054836.1515030-1-senozhatsky@chromium.org>
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
the same before handles moved to handle_cachep, see
commit 67296874eb1c ("staging: zsmalloc: Ensure handle is never 0 on
success").

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 3a6a7253fd01..aa436df0cc4d 100644
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
+	    MAX(32UL, ALIGN(_ZS_MIN_ALLOC_RAW, ZS_SIZE_CLASS_DELTA)))
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
2.56.0.506.g506a7eabc5-goog

