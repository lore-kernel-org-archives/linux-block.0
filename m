Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4481847D475
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863549; cv=none; b=n6LofkzusxBsFw5DYrxF7xVwza30RkrGWexikdtEg5ZVrrIhzzLdluF4Sl1iwnSy+UWLmyrGvrbV0akybRC6Vih+kXUb30h4vig3LA6vD1eU00bHi+L/HxGj+Ba+cg8Mp6gJg/9BmLG123J2qoAYUHBNn6PAI2NOMyG8jbYMCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863549; c=relaxed/simple;
	bh=Nhf4Fe/qy3PS3VDDQcGaRcZTOiLvleV8wg4reUL0kvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DaS461n6tZmvE8whJac1/+Jw1uwDWoQe7CcAl/oBiCyztxWLObSEHch6rCM07E0McQW43oDWot3CmIpuV13aSOCgjK/MxojVvCUlTLIJzSYp0Lc0hblQzzDtroPyp2l5OFGPVRfFp6YG7bB0Bfj2dEU8QAyNglPOudZSxb5Los0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gy8oAN5k; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gy8oAN5k"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-881269371acso2143769b3a.0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863548; x=1792468348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RFX4FeTrLTacTalFto0lbFyZ1pMwSeqR4eMyIxwMMBg=;
        b=gy8oAN5kXIXBea/v8BgGyVB4WPB8OXUVowjOkK9F/sGNT9ElSp+D9PUyJZtAm0Z7cn
         pHwfsARu6MTtz/dcJY5sDOCJJw5g+yOAFhGkB8/GHQjlNBRvFYbYqscdJrHuab/k2Q/Z
         Ml0KtfCMi2RVR9LkqZ3ayB4B3GsAfo3siwGs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863548; x=1792468348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RFX4FeTrLTacTalFto0lbFyZ1pMwSeqR4eMyIxwMMBg=;
        b=00y5rnpz4Y/N8BU6efjE8kRzcbqJVziTM1s3Vuw+NaGAUARr+rRwtDsBV9plBN93m5
         CIdTauyjeyvkEHADcrhTpY3Xm0dBnRpFi1A1bhLgv83db6/YSUVcYGMaYkRGuvvNhX2/
         QchJImaG8K6XzTtEoTDgTdaKz6lqVXutzX0rqWObq0iyX7KuLc4I94Fgg1ZMFjC/y8UM
         iq1fHQo9T/UwNMYWGVPvwyKEqqthgX+mhE9wRmWrPrE2M1LMa1h1UbeCDTLC723VjTRh
         Jjv3n1XpyzDZxqficAa5HqlD/1S+T86BFVA49DYpKZYXz1Edb/1AAzGyU5DP8AhZVoiA
         x5ZA==
X-Forwarded-Encrypted: i=1; AKwUvBxUxwo/OKyj3fBOyxS4VSS0cMlyW3ey94oud2SCt1Kftp3w+7haUWMtXi34njPdKDWj1gX0VwmoZAUGig==@vger.kernel.org
X-Gm-Message-State: AFq9FYLV503JiF3U3TnneqnCGei4qjaVr075Jx84s6r+tIynM7cmhv8i
	hsK32aQbHpertDOlD5ZZFc7DUiMQyTG9u/o2m2LA4ZchEtwpxm2RubuAJ1md6FAu8Q==
X-Gm-Gg: AYBFou1BUXqwq0uw/sm98+HOg3dQVLqexqWqfHyhMA5DW4GgA/KiW7AZHpLPseZUY7w
	H1SgLotqrW19toEI7nzGsTQSnzeZ8aGZTPMdvy0OSfO0qoO71iNF16i8RtKbuGnkvZ18vY2rcZx
	7yzD6JoTLPAzBnvMkdfF/yp7BFmSu/Ksc6Jo2jarJ3vU4cX5PL1HgoxVc4fwWl1cpk/U142bLBT
	B52VFq19W01l4up31UJa0RUyAPTS7n1ma4C7/BF9oyZPZQ/fUdT2EKC0wIXbYyxAs6+hIB9FDOA
	NTHNQsrBuboULtd14swlRK/sZ7HqkPncM+A8d3OEt9kcj4CD0AOPISRtXOS+OZRr+b1S5oXeFcn
	VQfVocIPON7rim4kCN/mlgdFR1wyOSXNNMppzEtz7r/qq1Xwn8OU/SJgkT54gIUstZC2Y49QLCb
	Zdbbzkh6xw6TBm8wuDWXxdH9HORQm7JTdVj7kDH4IpZo/ZUarXa6R6K1qKLCoQ00HiyFZw4NMOx
	uOy6Xc84SZOou/i7KQVXp/czbFO53Ee+raWutCT7mSdpKrUloW3lmy7tf8XZw==
X-Received: by 2002:a05:6a00:3d49:b0:891:e380:3d03 with SMTP id d2e1a72fcca58-896a29105e5mr7734654b3a.28.1791863547666;
        Mon, 12 Oct 2026 20:52:27 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:27 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 07/11] zram: zstd: do not use kvzalloc() for zstd allocations
Date: Tue, 13 Oct 2026 12:50:54 +0900
Message-ID: <20261013035201.2809924-8-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013035201.2809924-1-senozhatsky@chromium.org>
References: <20261013035201.2809924-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
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
2.56.0.385.gd3acb90ef8-goog

