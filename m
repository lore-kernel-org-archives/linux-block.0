Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1012216E29;
	Mon,  9 Dec 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763471; cv=none; b=GFpwcby8ZMM6wYIIiL2ujU78SZuZXHC5Is77EW9sdfnUmHD7Wqj0nFTCrOws404Qy76HvCalhgEdEsdwVuYzFVVU567/ew0V+lJA0U1pozQyFVF23QhzGZCnLlxC4LC7Q8QkaIHPV94Ne6MbyiEJ1A6qC+yhUoeGzJ8EEX29ZLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763471; c=relaxed/simple;
	bh=UL1umb3+OKKP4NIwwX2YKxMLyMq+sGP8UkjwENxBpNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkumpaCdf2Qh6JL7s7A0b029zftk8xQ9u2SlNR7bRW4Pniv5JGSb4yeJSS4G6TLuMtJh6PfCpLiapNxWM5Mcz3cemCgS8DjTForWC73q9CE8fOSAWF60LtbYzzv5MROZSPFB8kfgzQ25GsP2K5zt25faWcw+zLl8Z/9pk8C8GOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si5W1kj1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si5W1kj1"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-725ee27e905so1286034b3a.2;
        Mon, 09 Dec 2024 08:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763469; x=1734368269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TWIw0hhAH4VJQ0Z+LUoADX7ca43ciXjofF1Ce/M4dOk=;
        b=Si5W1kj1kx6JtFcVJodNDB0BX3JJq8N+xV7UBfjg42LQTNglJTMhe7v2g8AnrlwLUU
         uEmXSyuFll5qwCSvkoyMdxwivH0v/dwxrLyQtpxHEDG7rUwAtCcSpTz3oSONoEhx25vY
         RPuaGW7rPupDp2rUjRDlaudBPb90iehiprXzN6wfip7tCRWx1fW9Fcbht9iBBPNJMzW0
         2zqEPN90XTtmxN3gCIJ7nAFEiM2fScTunQSJPIncsNl5MOSFBFNS1teVh06pNQ3PvXlc
         kjmpbHiR/gBfkatW7qqViYz7Ivud1mCXRGqn6o30tlXoBz3GsUmPmj3OPTHX1ot4KUPw
         Mu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763469; x=1734368269;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TWIw0hhAH4VJQ0Z+LUoADX7ca43ciXjofF1Ce/M4dOk=;
        b=m5kHAXtwdDvdyz5vqr3bvlV7TFbUJfH3uUosrL5FgU4aEbwuKZCbLxGorLgHzJgvx2
         I4sJ/y1JwC8prn5fR71Uj2ZAuIJDreWkG2lPjDKxdOI4uu4O6DlvycziohgP+mc9W+Ho
         GwjwTZpnM2zwpoKS5taRO/DCBa584ZRuhk6qfMYekXWQj9LSGLwhGOn1Fx9xPDdmLkjR
         WLlq6HrFPCgTXcWTU33Lc2MgqXdbdjzvHhhWn1zF713afK6nxP2s1TElLzspuYMektbS
         Qy36FGRW70xbL6Ivw1lWPvmYTer07pGUFCm9032rl2cHiO863Am3cPXOtuhn2OXOLIcZ
         LqVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWA5+vD6po7hJAgIjMCqTTWHhNTEWHlHCkvrqtCfy0EErRck3pEPFHDs20Ks5+jd2tR2sc2b9LS@vger.kernel.org, AJvYcCWYgQRfIvXzYzGjZTfj5TkD4XsiQqtfPzKeeuHBGqO2tCCQjLKQUWo7isVOWRsB66YdKKADPjnmzeIivQ==@vger.kernel.org, AJvYcCWs/o2xaxmryXty5LMAsX7KtPz7FbgsZZVpAwV7r2knj+miriteInGZLxs9SemG2rEzMv0lrQxEO1uNcOVr@vger.kernel.org
X-Gm-Message-State: AOJu0YwyfAeZOBrWyxWA7xU44mv/vRunwGbVK4ajIClJ0xqregk1hciN
	ZwVRczVQ5l3hdHiRJxA5C39su++BgReP2mmJe0e3EyU+JYngh0Tt
X-Gm-Gg: ASbGncvwIY2+4EtuBiX68lUpkBGOQBaeUgBOdGEX7mSx08nD3ggl0081qcgAkapC/Sd
	SDV8CY6/Uj/laKnOlETyzJ1soLFwVI62X8MY41pdcrgyK+5LwCu3qoBZ94anL7oG9cY41BpK1MG
	obzEuJj54gaPWgsq91WmetaY0Xr8EaM/Qkhwe3ZgMXqS7OoGjAzT3Rdv1ldm10Nq6JSJonsmhsg
	LmrhqXVLmH1QXS+zHOTgLN+RA7jvAyrbWIdHhJaeRTaKMgZvUgXEOkqPQWK7Rxnkf0J8pY=
X-Google-Smtp-Source: AGHT+IGPb5h1KzA7h2yK1etF1SPW3948xDox8qr2YCpFm0ctolrhSkaAbYueqzrsyOSh5QsXCLFdsg==
X-Received: by 2002:a05:6a00:2e0f:b0:726:f7c9:7b28 with SMTP id d2e1a72fcca58-726f7c97e8emr3032663b3a.8.1733763468992;
        Mon, 09 Dec 2024 08:57:48 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273c7f3f1fsm514201b3a.13.2024.12.09.08.57.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 08:57:48 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>,
	Desheng Wu <deshengwu@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] zram: fix uninitialized ZRAM not releasing backing device
Date: Tue, 10 Dec 2024 00:57:16 +0800
Message-ID: <20241209165717.94215-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209165717.94215-1-ryncsn@gmail.com>
References: <20241209165717.94215-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Setting backing device is done before ZRAM initialization.
If we set the backing device, then remove the ZRAM module without
initializing the device, the backing device reference will be leaked
and the device will be hold forever.

Fix this by always reset the ZRAM fully on rmmod or reset store.

Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
Reported-by: Desheng Wu <deshengwu@tencent.com>
Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
Cc: stable@vger.kernel.org
---
 drivers/block/zram/zram_drv.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e86cc3d2f4d2..45df5eeabc5e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1444,12 +1444,16 @@ static void zram_meta_free(struct zram *zram, u64 disksize)
 	size_t num_pages = disksize >> PAGE_SHIFT;
 	size_t index;
 
+	if (!zram->table)
+		return;
+
 	/* Free all pages that are still in this zram device */
 	for (index = 0; index < num_pages; index++)
 		zram_free_page(zram, index);
 
 	zs_destroy_pool(zram->mem_pool);
 	vfree(zram->table);
+	zram->table = NULL;
 }
 
 static bool zram_meta_alloc(struct zram *zram, u64 disksize)
@@ -2326,11 +2330,6 @@ static void zram_reset_device(struct zram *zram)
 
 	zram->limit_pages = 0;
 
-	if (!init_done(zram)) {
-		up_write(&zram->init_lock);
-		return;
-	}
-
 	set_capacity_and_notify(zram->disk, 0);
 	part_stat_set_all(zram->disk->part0, 0);
 
-- 
2.47.1

