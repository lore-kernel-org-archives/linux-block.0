Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289736;
	b=KSqwrHVMmAlfXDwhgt21e4m0vq6UPNH7rrzVxCGSyBX73h0keoBvi16Beqvabp1yZMU4
	 BZJk1vHlBO+DXovQa8r6FhnFFKcaNaUuUKUEOemL4ahUBavHw/ljG1R9cFTTaoIOgXXf7
	 pEc/vBfiYFL64JUtmLGrtKmTokZeRNo0+6cOqgj6JonC+0+dnKkjp732cPScjTlSHAM1t
	 mR6XN1W+FZ8KIMrEibEnviNArrhgTKd+cdpgGXEVIA/b5pWBfGDXo4rfdPgKSXdeJdoOl
	 a2y3h+7W9Us4LobgIo/EMuS+e17IJctObHgzU6m7qQj0TsZ/G8dQ5LapmJdScu2FTxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ztVA0sUV+JwbT6qi0K19Xf4qSH79z5sTbBuAxuXF9DM=;
	b=lKwE4/glY587fggbHqXHkX3AGPzYekq1K8/CAW7m0GpezSug5igI45dzLLH/hxPbFPor
	 fUvuPCujd7XtqkJUdlIpCwqBybCZTyQklTfMV2kGY7TeZp4+71HsukU84ZW0uHE1Wvaz2
	 nDStdmndBxriGBH1FjVUplIfsutCvt/lQfL6cV9ws1jO3VE+c+e6ZQU2kCyNCTxBR09wT
	 aH0h4upKnNKv3u11G4xR74tm27dnDDzmIt1cWywYGWb6M4c0KXBDuNqGPoeD0C2e32hhn
	 SEOWx3XNF3TmW06C8cwKcMKx0H0UAL4ZIlSGycKRjFHw/uBKr/viIuigvQ9K4tM1QBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="RW+Y0l/K";
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7DB60A2623
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C7DB60A2623
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RW+Y0l/K
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so767599a12.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289734; x=1794894534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ztVA0sUV+JwbT6qi0K19Xf4qSH79z5sTbBuAxuXF9DM=;
        b=RW+Y0l/KXEf8qcCbDWoRBZPVwg9A6bbecci8qAWMx3o7xPj94T1FfaSNcQdPrqf+TO
         fUAa7CWn+B0dar7Oq+K0oazS/HHNIN8QRsSs/oVcPojsQUK0OJARHcnvO3tsole0+djj
         DR5ztTp5VUMn8ZyNafuNy8DTpzJ9ojUbPa904=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289734; x=1794894534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ztVA0sUV+JwbT6qi0K19Xf4qSH79z5sTbBuAxuXF9DM=;
        b=A0e7mpP3IA9IQF2ScIc2QqaOduIb3pjeSpPNW7MivnUaMQ2qSAlhu/irxH+/48clb+
         YZcJUSKRYH+9efLEepvmHYNlLn0HeoET4HjSKzBWY2OeE6TO1ABpP0C1OTY8wHwJ7O48
         fnwrCxzRVyQvS1yYPp3EinodvWiAn3+XcB+5viJUoJMh+6s9SxOfJDTkKtajlziTBfsD
         VAIeV6bhuk5i6WS3DzQ21q6LVCjs1a+0rtiHqekexaJEevZgdnZbfRITC025O+swx+QZ
         2Kw4qO72e0FY+Xcvhsy2lN8ryirCrj71v19DYagCCgjTIyE8OzofLwgZWDSqzhwFRgQ+
         0Fsw==
X-Forwarded-Encrypted: i=1; AL+hErEvamkJykUvZgZ8JgrcudHA079FWW2+u5jvv65tzcRSeJDjmwyZgmzAI7pEQ6Nt+UanbKjdondZ0K9auw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8lMuFjm7Ks84kriPYb13gb+7RTtuSJVQlTZX6ENKEcx8irPu5K
	Wx+WdEhq0ZyK17qqC8DgvmM/z2NT/3Vhw2QLkWeOkeVOJX9+UZDtSE5/4j+r59Z7R/khmsfW4iR
	ypi4=
X-Gm-Gg: AYBFou0oMVq10MFnrbRLaDjWMvcsH8xkaNwpglmIOy+OP5b/TG57cfM7EKJHOjvKUsr
	NtDyYwu8AEkDes4exbP8IYELH9lpgBRVNiQW0FHbIX75R91UIuI/zGgvVW+ZGrzeeRssFKKEDk/
	/5QkEsqxyOpe5Y1G8SKQ/eU9B2cpFvxyz3xXhiw9G4V+TvBIbyEYok9Q+F2KQAz/bz0RbA+zADh
	OcrpXBu1sDvH/4Z6QHKG+8B0Ac79ePRvXg14BWKJRlohDIycDbfx9/LG+rtvz6Gv7lIJS+r0SQm
	HJTCEZ9oiWtdR3ippqQALEF28LCmtmePhwKw8d/3/m8HXG+TXHA+8mLnRMqnesDrltkd54r+tpZ
	mCpb6xJWJ4D7gG51L1b4yWNkJEm1w4Pe8eaRbjRh1iIAerErUW5YlWk7flqC1XinT/xmvB5SLKa
	TGEncu0MostQCUrEG1PMPJMpXDvAO47t43jT6W8pgFrsN1K9Hg5MEesOC38Uo/9BdJdO1ImzRhC
	+yA8or60DxieJ7px4ZyBCQvM8BPKa1RGzXvtcZQ1rhVyn5UBZSNg0lCldWG0pwnHVLAKOFqQ7IG
	laZVw99P+XHRI7xfW3D1JeOxbUrk4M5cTnMP2d3urJYhEYZmvGLUDrseyFQ5REoAEORkQVP2jIK
	8yF30oHnxhpgEYyJMJQ==
X-Received: by 2002:a17:90b:4a47:b0:3ac:17c:6e89 with SMTP id 98e67ed59e1d1-3b166cd4924mr1684341a91.19.1794289734505;
        Mon, 09 Nov 2026 21:48:54 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:48:54 -0800 (PST)
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
Subject: [PATCH v2 03/11] zsmalloc: return handle from obj_allocated()
Date: Tue, 10 Nov 2026 14:48:08 +0900
Message-ID: <20261110054836.1515030-4-senozhatsky@chromium.org>
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

Allocated handles are valid kernel addresses and never 0, so let
obj_allocated() return the handle directly (or 0 if unallocated)
instead of returning a bool.

No functional change.

Suggested-by: Yosry Ahmed <yosry@kernel.org>
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
2.56.0.506.g506a7eabc5-goog

