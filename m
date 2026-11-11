Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379644;
	b=ysUDjUb6XivJzAmUilCbc4MKDm9jYBqSxF3MDE4FHVQYHlNpaJj7/hWCMKlEGWnr5asS
	 TbvLT3/p17Ty7A/JKJ4dga+XuUu7/wMIZU2rV9zlA7J5+Fm+usPbESWD5Kbfv8RZhaqe2
	 tou4FiV76s5ZZ4hV0/+xf2pugjLHTc6spyk8TemXRkEuB5kjsZypJSyciLeBxaXFQajW7
	 lPd9xz5zF0V8mfrQCVX0cVjQfSeKbFfpGjG8x2yVOw54RJFAkYFiJTUCbgPjJgy06rGC4
	 V5DGoed6YBPEVmis8ilxiyannoGh+504cObouEeUqYk1QZtEKSQSO3vbeidBHWXTGhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1hLwQVyMwUi9E19JxtZsIeEAf9lJS52psxbgdcCZj9M=;
	b=K7yApOz0Fj3aIZmE4r9IHkhNaNsCU99e+eEprPy2xPXFgTrhhyUl12yYiDogaJtiK341
	 6pfKGVi122ZGOwhhAI6R7u+0YqSpHJqPeaST2xSvMyiFPGq7WIAwbUzt4Ufxj0ub4xHgR
	 aS978qzpjdQZrvXe3dp0fmYwO5fE18Rc4vOpy2s99ELBSOOlqNrw3ag6CKd3zDfirr/Re
	 MPyvxoJbTt4SPCtmbLewlOEMO+3pX17sD2DkkPT3PQUHt7AB59jTNgRh2WOv8a0SGAyts
	 k00ZIbpEtt0yS/ios2CZ12kFP5W3K/ZOOJJ/RvC1JMsF4u/0T2jWoTwkJunJ5knaP/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="B1D/7hL5";
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0244260A262D
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0244260A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=B1D/7hL5
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso1351947a12.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379643; x=1794984443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1hLwQVyMwUi9E19JxtZsIeEAf9lJS52psxbgdcCZj9M=;
        b=B1D/7hL5EzBInPwIj4oO4iM6NLxFHFrjtpFdJDlTdHxW2F2DHNVRrN9vXwAII1JWZ2
         m5TZFw05fV4SRWRV7HR1YCsOmduoIQDbZ3UPpfn3CLo698Kn7DW7/EAvXSAftuOLQPBN
         iwMMTmZBXgxALrnHSU2U48n9qxKgIRH33UWm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379643; x=1794984443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1hLwQVyMwUi9E19JxtZsIeEAf9lJS52psxbgdcCZj9M=;
        b=QSz/bOGcbydtcJ2QsNUEV9vz8pEvdbctrJL0PeANGi5WUf0zzNZFUs0PhZAzGCW3Mk
         h4fs2Ce0PDmiNQ3gnsbjOa9EHATfc6Zfwx0DFN3PTyVdoyq+cLXqCn4K8XSAaGW3F/0R
         RuV4vvQeh0E6v682/JIrLYg+9ZPm/yMiy6T7a+Xg3T1F4qUmsGgN8CXDjeqLAKW+ha70
         xQHnH7aA7I4w8+r0lD6DXM5bHaebhXgGYc7JzNWUrtG3XljVvH+NcKrGd4QedQliwCqA
         smy028DGhNgwPFOLABPO4V57KFvWmd5o5clTFtZK7sAb8hoPEDniRoGzIzYXseAbpWFQ
         3EgQ==
X-Forwarded-Encrypted: i=1; AL+hErF4RcyWI1OCi5HabnR1BkuLs+OXbwmbYe7BqopndBv/fcFjZbQmn2VTW9hJD8xHONNqV1jT5h7V6NZEvA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/hEQbO+G2weMMBQToxdL9x8bjbzJtWH1YUSzlWQXmc/61/90Hd
	xqIwqT6WIVym80e/Rvql87lbWpX3WA45hvLnJj8YSHa3fx2Y+Dx/7ho0bIELMY6KoQ==
X-Gm-Gg: AYBFou1wOvgGt/BJzO7MhFa1AhIKJZSrTAHCGY42JA03LAanuvnLOvK4xT4ReKZk0/r
	x2fc6BuR5pX4o7OkoJwQy3PnzuWVVM26AmWoZlCkrYsfIrDHBpRopz0Zp5k299n7TFHDlAWe7O0
	lG1tpnAzYlqSrvR8XzI7Uqc5hBcG9Bv+WfrWrsNJjsiEFA17wvdvho6jr/z5qcDrzK/wOcpY9sS
	JL0Shb9dBTqmX9l0n8Zan8uCaUtARVYPF3WbH+ZxuURbOCTOp8NOLLsN9R4TFvtOHjnY2lJcrHw
	YDnO8cNRyFtuzZ+E7AwHWXfL9uzUwTbfYFD1eDpvOvUwIro1lKwUChLBWPkY8oBBijeczDPBw1x
	DLSR0eiyOtymcZHYH1jgMg4UsYVvsuYOHKWnt68bpp5Ggq6kBsSOIfPuQlyXHdrk7gtTCqKiFAv
	55t7vHnapNWXSUGgRGMJHdj4a5hEX3crPGPvDkhZ5gGS3yVszIdd7G0SqKhPBaXFA9lwx1pFCaK
	PNzSVkkh7qlm+RI3Oa2kjVAW00OPmZSDkBu2WKK5RgSQgYV8SIz+s6CdbVgiqqxpgUoQVQnadg7
	/roT9S9j1i5jvx56REcpfT6fVKsQ3n2X8kzEZqIIhvEBSpzm1U9vR016H2INRbYT2O4SVmEXDq3
	SlGmXzziaUbmpunv6KA==
X-Received: by 2002:a17:90b:518e:b0:3ac:9a5e:9cdc with SMTP id 98e67ed59e1d1-3b167ab877cmr4231873a91.19.1794379643365;
        Tue, 10 Nov 2026 22:47:23 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:22 -0800 (PST)
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
Subject: [PATCH v3 03/11] zsmalloc: return handle from obj_allocated()
Date: Wed, 11 Nov 2026 15:46:26 +0900
Message-ID: <20261111064707.2568433-4-senozhatsky@chromium.org>
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

Allocated handles are valid kernel addresses and never 0, so let
obj_allocated() return the handle directly (or 0 if unallocated)
instead of returning a bool.

No functional change.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/zsmalloc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 7ef80e0da626..dab71f582103 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -822,8 +822,7 @@ static unsigned long handle_to_obj(unsigned long handle)
 	return READ_ONCE(*(unsigned long *)handle);
 }
 
-static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
-				 unsigned long *phandle)
+static inline unsigned long obj_allocated(struct zpdesc *zpdesc, void *obj)
 {
 	unsigned long handle;
 	struct zspage *zspage = get_zspage(zpdesc);
@@ -836,11 +835,10 @@ static inline bool obj_allocated(struct zpdesc *zpdesc, void *obj,
 		handle = *(unsigned long *)obj;
 
 	if (!(handle & OBJ_ALLOCATED_TAG))
-		return false;
+		return 0;
 
 	/* Clear all tags before returning the handle */
-	*phandle = handle & ~OBJ_TAG_MASK;
-	return true;
+	return handle & ~OBJ_TAG_MASK;
 }
 
 static void reset_zpdesc(struct zpdesc *zpdesc)
@@ -1571,7 +1569,8 @@ static unsigned long find_alloced_obj(struct size_class *class,
 	offset += class->size * index;
 
 	while (offset < PAGE_SIZE) {
-		if (obj_allocated(zpdesc, addr + offset, &handle))
+		handle = obj_allocated(zpdesc, addr + offset);
+		if (handle)
 			break;
 
 		offset += class->size;
@@ -1824,8 +1823,8 @@ static int zs_page_migrate(struct page *newpage, struct page *page,
 
 	for (addr = s_addr + offset; addr < s_addr + PAGE_SIZE;
 					addr += class->size) {
-		if (obj_allocated(zpdesc, addr, &handle)) {
-
+		handle = obj_allocated(zpdesc, addr);
+		if (handle) {
 			old_obj = handle_to_obj(handle);
 			obj_to_location(old_obj, &dummy, &obj_idx);
 			new_obj = location_to_obj(newzpdesc, obj_idx,
-- 
2.56.0.542.g3ef89b7020-goog

