Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792894749;
	b=Y5cvsfwCCrlc86oEUi5StvHLngHj06xtAE4R8gqfWq/fCmf5LCboB8hxPrT8PVr9+OwS
	 7/7z7d3VaRnnug3HLXJvbR0E/qA17mYZDqY3yGy7rvX0x60DNSJs90qrHYQtX6Si8SISu
	 gtf//PT9sOx4uAoa8Ott/EFXeTv94SoDxqejAgIeFkR66+AHcxLJmhrKiJw4vtxtv+js0
	 /I7iuwoHjHmqrKzmgUk3uCdt44m3JC9CCI9tBXjANnIp0ERUChFIVbYeYGkgu24lh/s7I
	 GG1yQqPyWtnvXGJIE5H/+4EUIRnY4zraIU8McCo3fNeyD/T55WblZYKUx6vEQINFE0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792894749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=q3okMCYlIonzi2nM46q+sdWA0XzhR4Jh1qbkbieycoA=;
	b=jR//JJgDNTd14WnFIbNuI/y0X47pRC6MPVnRMKFxTpGGvMLljkjV5mdliEC2VLEOH9cu
	 nzM9WFT6FhfG3E+0edApIuYujlOdLsMePl2S30hRwqlyXJ9eI66QgqiNNFXhQVRoPEM5M
	 +K15Atg4MXo53EYx9cYimy1QS0MGkCttz7A9iOPCj0q8yMi9aYTgNKqFsrZPvJGsSaKAG
	 uzuk9U4IAXijn8CwxB6vcChOEbt0ZXgcm6QAcrIIjw7GWANwf7w9Ne//Zd66VvlOsVxGd
	 2CSPXqxqVuUXpynALLnBIkMIZ3MS5V3Cg8cm4R6SCoEVU5FCJ5Z31ILZ9Z7OYVyEEWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DybsHMGC;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDC606A32A
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 02:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17EDC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=DybsHMGC
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1931ff67a29so4064142c88.1
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 19:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792894748; x=1793499548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q3okMCYlIonzi2nM46q+sdWA0XzhR4Jh1qbkbieycoA=;
        b=DybsHMGCS9Zp3rKuRWqoLA1fNNYC/obFuXI87s0VVl3Su3fHC7LcCj6ligX1EIQnbR
         aOy96erDhjM3xe3h3PK/sH9VF+/Faqv4RdCfA5tMoeFAyTZv9FafBmf4pnFq13elz/Gv
         OU/V7bkRsCjmdDBTRLAcg6pWhKJgGQIFYDzeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792894748; x=1793499548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q3okMCYlIonzi2nM46q+sdWA0XzhR4Jh1qbkbieycoA=;
        b=Fp+cN6FVglVvUj9lYyr5A/L+WM4+VyIhjSihttQPsqgDD8hQdGJiuHAZ0iqjM/lYbz
         39yLQhUmfiMXjw1lrl0VTKipvLoJbm6GJ0fgE6ASeqGB9lT6jTugstmuZ6DPLGJ+5s0G
         MaOm1KQUCn7jWi8Ja6Q13PjA9ylCN1U0N5YMKyyiEvLYQTUW6uZ9R7gNw6Mssij34eRq
         NxBIZ8wdU7CLrd5vdpOj6OWCwkRSZg/5vILSrgDH/VJ4ftctNskL9rD+8NzIZVLC6CFv
         +pFaMOq1bW8pZvzS+R6TTVu6+Vlcjvn6X/fcktfynhdubRTIOyaQkBqpHqXvFeZgFjKC
         Kocw==
X-Forwarded-Encrypted: i=1; AKwUvBy/Qy0hPDwxoq43/MsjsuraPRKkMQ7PYnHLvd7x9an2qTvk/oNwq3e5qLeOh/ExY+l0cEMPWskID5g4lg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdFhC7zE9PROSLAlNBpARoBpKu/J7Ah7eAkpa7QDDipbiHC/iv
	iw4FJhsTFiMbunRkhLkILp/EIif84BQe61lbS27iwARBOLytkS8AVBr8Vqfa7Tx1bg==
X-Gm-Gg: AYBFou3PR8z0e3Yq+ZUF6mRR4MM8he4dBppKEDOZKj0uh9uDgwz8acjAmAFXY08f19b
	V3WbNgwZXb1FOJsgbaZLGAlXeY+mhX+MV7r5mXILNv48hkaDhjar1OLPn06IHPj8cMjMIxQilSA
	McN5xd+y9smOuyeOFGGS4ZLyCvkJTQkLTou92i9qHgrjfgMqi8zbuwDTWCReSNEnAK/rQ1QqxTS
	ZT713g5yFaiaEWPK9a1WHJO/KZnfjKvcukhBpiaObd92+LmNF7OU4ben50R1oPkBetaJstUD7qM
	iF0SnSML0ZUXQLWBlKBt9dVSrVavpMxXgBI7CQSX/xrBLbzTYFiqHLTr2o1gAdW1f8RJZtMZup+
	+tTZYECFWLvSybBKnpzWUabe7BMpLeXRwgHIS0EvUWBefgyHqfvVTQqyvY0nGEAoV7JpR+esqym
	LFqk3/h/MVnc6YykrhC/8D8HTamr5Xe1ETWArZrjgUfbFyI7l4/uu7B6mF4BGHAQxjOdJSU78uP
	LJT+HiC+J0BbPxeB9Wiza7ZpZG7cDFqGRYLRbIk2zeM8Fezh6cdgRka//jU8dwJ6gMJvSZ7x2mb
	EbCuKY2ToPzNyvox29JtZQHGup0S27HZgiZDHQhJfr1D0Lk6MH0aUhbRtmM2IFxOxsBGhTCVQo+
	piucdqZyyDjUOh39BKQ==
X-Received: by 2002:a05:701b:4544:20b0:190:f24b:9491 with SMTP id a92af1059eb24-19b5804d78amr2509222c88.12.1792894748124;
        Sat, 24 Oct 2026 19:19:08 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:9f87:66fc:8c85:11bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1989ff2ee5asm10387242c88.8.2026.10.24.19.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:19:07 -0700 (PDT)
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
Subject: [PATCH v7 10/15] zram: zstd: do not use kvzalloc() for zstd allocations
Date: Sun, 25 Oct 2026 11:18:26 +0900
Message-ID: <20261025021839.1542805-11-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.257.gf7497c7d27-goog
In-Reply-To: <20261025021839.1542805-1-senozhatsky@chromium.org>
References: <20261025021839.1542805-1-senozhatsky@chromium.org>
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
2.56.0.257.gf7497c7d27-goog

