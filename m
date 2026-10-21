Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550587;
	b=DwhJ1Ui9GuPJbCfWxqgt9CnoFyXd49lVMKa/rIPh9OAo0Jeqjx0fvax2EwC33BjPiWQg
	 4wzgMTfhII1INS+7Ad7/ruNZiiwBGEZZuFRFrIMjy9Z2889UxfoxFH2tF2Yv1CuH/C0W9
	 gpuITPPK2qTR9nUwFd0yhtRHrkCObtLpvUSXXYr/+MNOY9TO8otei0EFIQkAzQCxvJ8OE
	 0UFavOKH/gtlQL2jhIpw40ivFkXjnL51q4uN+erqPjt3OjubLT99vJKgN/dGLwEuB1oXv
	 VqS3EMHCe3dPA3Cj+oTIJRmivEkEil0xxUwwUF9MkCOf3728Q0ECzhYXuvu8dpjvzFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a7YBuhT5Z1iUOeQz6f7j9faCl7gkobBSFAHTtt1TvOg=;
	b=IHFwa7+XxU7Il3rJw8HWl7+nk6I0iy6CPmBcOSC/XUJIBrOLtRYNrxRRW1RjqCAb4ySM
	 XPzdNgG7i6fYrfPW/sqRnrb5kr+R4iYeXevM9IHChs2nMB9G46G8FPCFpk4XixaN8nMo0
	 QFPoVJwuYnYxAv/eiVu9qaSd4G3izKliB9MgiQzKiMGUxzhpIXs/1H/trACLltvCg1goA
	 WwEwBDVPMJPFEFWuhoZQBVi/A6/87b3oAW/5YhsskVzzkdPsYp7LvbwAiDqQ+IH2vsPqx
	 7KK87I02TnClUBWJkxbbpLUILm+0u/kvKxOGSjX4hIo9fYhz2j4FrkFmeMOd47uW5OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="KvrqfJX/";
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2126A60A261D
	for <linux-block@vger.kernel.org>; Wed, 21 Oct 2026 02:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2126A60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=KvrqfJX/
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-17bc533fda3so322060c88.1
        for <linux-block@vger.kernel.org>; Tue, 20 Oct 2026 19:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792550586; x=1793155386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a7YBuhT5Z1iUOeQz6f7j9faCl7gkobBSFAHTtt1TvOg=;
        b=KvrqfJX/sF2Cbkpx9LIk+m7Vp5uQeIYPSDEoWSaBuFvPuzog2ZYazwNEI4OOFPzztw
         Y0v5chwMIpdkod+U7K4Y118sz55q0uDUefShxrTirtwCXV2wPFYxMtwmK+Y/DrVPhC+H
         WW1szNHbXBfNGZe+BdJQzWYa82rKM6g02KWX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550586; x=1793155386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a7YBuhT5Z1iUOeQz6f7j9faCl7gkobBSFAHTtt1TvOg=;
        b=WNL0nT9ff7Pt7jDTsPzn2JYwfV8BPXPENdwYyxcNXsQliSHg1LUs1B5XaGfjSLfKA1
         YTKsJPNIkb1AzPdcNAFUuC7uAVnIyZBtTO/sXeyKKk4Shfr/eAEKrxJs8t4rA4Cyr+c9
         7OvM3YNsgCtd547ma5yg2NS79xj4LYGFwJwoA/i+HNdyarWgMvUWpvGuL/10bBI3JvPx
         JgV1jNQGqokwK9/LqTw3Af1MWh8RIHChTmaW6AfLIUG9izclOBk5k17R+ZFMlXpTY1oz
         n0VJ4wU4iPJLxDoht5a3ZjRrUmC7bjHWGKqOW8D3WOWDFWN7VeRLG5vagfENRSBFlVlt
         fdiw==
X-Forwarded-Encrypted: i=1; AKwUvBwzBnUWeh+gQ5C+SecQM1iLSro9RhganRHyuPcIc+6ykGSD6J+RvrqROuzqyiqnUjwNekF8MQ50ICy7XA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdJ7Dys7PKNvz7Zl7vo6ozwfX2R17HcSlHtXkf1ovrW5Aflxz/
	1HM357YrVWcoHFAbudiJifyJ9gsnljwdv+/GfHxlKYmQ3bFRY+GkGZPnxusWDtczRG3U0/duios
	n1hg=
X-Gm-Gg: AYBFou0cvo9QsWRdFL4rb4weaWanA+16bXQoJwg45eemuB3xBQdgPtVkr/YRbLnBSaK
	m9VuH4pGe7YqjcKHOtoh9ZovKAfj97OOU7BIuv7qjs6XpfyRo5MGRuq2XIg13uwUsvbgMAJTgux
	6URB4Vj/aVu+/4uaJLPupuYSDQxAMejj8HYE2Cobk0C6F/p5J7x/Qi76RGuujsVSauKH+J2zVTB
	czesbnqAXpfR392hH1sNGwBaIbeU9kNO0nSwQYu1WCIOat+TahBMZ+XOKqZTEnLWeyp2wFn3hgl
	6oBZtLENzS/JE7VApUAY4XvqwA3RLPREqbzrvqFg5vx1n2tdipMaGFDJB0dLAzo70OpF8E3ym2X
	nAoIsRUPI3fuAYHhpxf2XoMPvorN1tqWLZYCKXka15/oJy8T1rSKTzTeDT4BpeETPNgQrxadIVk
	OecjX4dgHLt3PLYKLspC1QhLx01ouvjY6SDXLF41mt3IPfgLDl5kWr/H6uuPnChozdpqBi7N3Bm
	5FWJo03TZm87Seolma3b86qQMB+3F5eb8TU9h4RXCbOzWkjz7gVft/PYLcu6SpXQqsQoXNqF/6d
	tY9XiWDd89NPWElIpW6L0ldbEOaJxO3RoSQ9qdw7fmxF
X-Received: by 2002:a05:701b:2915:b0:166:29a2:f83f with SMTP id a92af1059eb24-1909f5c7e8fmr908136c88.5.1792550586245;
        Tue, 20 Oct 2026 19:43:06 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:97d1:a8be:236d:bf79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19035c0c9a6sm2392047c88.3.2026.10.20.19.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:43:05 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo0325@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 08/13] zram: zstd: do not use kvzalloc() for zstd allocations
Date: Wed, 21 Oct 2026 11:42:18 +0900
Message-ID: <20261021024236.1787884-9-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
In-Reply-To: <20261021024236.1787884-1-senozhatsky@chromium.org>
References: <20261021024236.1787884-1-senozhatsky@chromium.org>
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

When a dictionary is configured, zstd allocates all of its memory (C/D
dictionaries, compression and decompression contexts and compression
workspaces) via zstd_custom_alloc().  zstd_custom_alloc() uses
kvzalloc(), which falls back to vmalloc() only when kmalloc() fails,
and kmalloc() rounds such sizes up to a power-of-two number of pages.

For example, on x86_64 with a 110K dictionary, switching from
kvzalloc() to __vmalloc() reduces allocations from:
- CDict (level 3):            512 KB -> 400 KB
- CDict (levels 12+):        2048 KB -> 1552 KB
- DCtx (per-CPU):             128 KB -> 96 KB
- CCtx workspace (level 3):   128 KB -> 84 KB (per-CPU)
- CCtx workspace (level 14+): 1024 KB -> 764 KB (per-CPU)

Use __vmalloc() for allocations larger than PAGE_SIZE (and kzalloc()
for smaller ones), which is also how zram allocates zstd workspaces
when no dictionary is configured.  zstd_custom_free() already uses
kvfree(), which handles both.

Acked-by: Brian Geffon <bgeffon@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/backend_zstd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backend_zstd.c
index b367049f131d..7a8b5ff186f2 100644
--- a/drivers/block/zram/backend_zstd.c
+++ b/drivers/block/zram/backend_zstd.c
@@ -26,10 +26,17 @@ struct zstd_params {
 /*
  * For C/D dictionaries we need to provide zstd with zstd_custom_mem,
  * which zstd uses internally to allocate/free memory when needed.
+ *
+ * zstd allocations (C/D dictionaries and contexts) are large and
+ * long-lived.  Don't use kvzalloc() for them: when enough physically
+ * contiguous memory is available it serves them from kmalloc(), which
+ * rounds them up to a power-of-two number of pages.
  */
 static void *zstd_custom_alloc(void *opaque, size_t size)
 {
-	return kvzalloc(size, GFP_NOIO | __GFP_NOWARN);
+	if (size <= PAGE_SIZE)
+		return kzalloc(size, GFP_NOIO | __GFP_NOWARN);
+	return __vmalloc(size, GFP_NOIO | __GFP_NOWARN | __GFP_ZERO);
 }
 
 static void zstd_custom_free(void *opaque, void *address)
-- 
2.56.0.212.g129ede20d9-goog

