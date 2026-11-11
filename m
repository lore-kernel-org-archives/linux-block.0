Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379638;
	b=gEMAbeExY3fYSVy++Gx8jaJK2J+J+p7FLYz1rh0FUYDJkRPDzjGwHv4YuuBgV5gKy7JD
	 kAfOJV5X/SnxQSEiA7jnDG7N4w10WwRKsBMpisG8vF4odPh4RrN0y+IF9/9ZwxBe0Xxh5
	 rOgkocnnRGaVvow8MGzlS57cTn2CA0f0DasulbJfAj5K90kjwjbtoTljEstOouYP6/fWH
	 PsQVSlVvxC6ZKUaAOAVYzv1QtvKkb89l+5qRaJJHE2/kLyQ+syh6aGLm1H3JqERQ5Ip5e
	 xKzKMrJYB+jGMdKn2uOgdSDas6yDcRBNb1AGCCDrNuoKOem93fMTaxj9ia9Q1SlSL3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LoLBKM4Sjqa25bXrwKOIU9y0T4xg6/+5J3Td4BlyGMY=;
	b=1t7SbXeTGzDbOF/9/JNsEfL1RzJw5/euQK72CtehZmcdEW+DrS3c2tEtNxXqfmQCD88y
	 pSr16y7CzlSCzAc9cLDvDL0PqukBjxq+GndgUtg78URzI7deQ7l/mdldsQMo2WwHhexgl
	 42cS/3dXJKhpjX33AmdSwc3NKm+7t8fQCRhUhQ7U8TgQGCk+G0B+ysC5PRrztSYJwNDRn
	 VJ0eIySIEEZquu9vcgBOcvBy7TqARXGtuqtw0vRm8Hainz9hWJQ7FOe+tEO9w3FeKA9UY
	 4PjmbxxPJD6PdNtE5VhrgcrnaP8genPEpNLH0qP3l1lZSrRnPJWK4KXC4eJyOBcGYbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RMs0yD1B;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7A606A332
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61C7A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=RMs0yD1B
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so1610119a91.1
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379638; x=1794984438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LoLBKM4Sjqa25bXrwKOIU9y0T4xg6/+5J3Td4BlyGMY=;
        b=RMs0yD1BAbRNlQCyHoYg25Frt8KVLLLZ/hDDP7KKI5L/b343Dqv4AhSj+L4oxUViu8
         xlH9SuM53RG019S6bVnt3EARx7kILuexpZh0hQSK3NAh4YieTCsdROG3uvFp28tNfF4k
         Bl5pX10oDkS50DdclVyevwlsfRxSB+zZr1reQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379638; x=1794984438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LoLBKM4Sjqa25bXrwKOIU9y0T4xg6/+5J3Td4BlyGMY=;
        b=1K5vGTIPuQ/yUlnlJUFDWdmxpFHJd6y6zO+7QHnDN5HjEnMsoMkX2n0hr1TZldOJBL
         v5/94lNGRGCL53p2mJgatQIGTZ/3nVj+CR87OpJBnK7ahHK01hEV9bmfZeQ3BPL0rgFd
         XJ4u3kfmM+ScAgkeSEtkof8y/ZvZ7M+MZ5wOBmLfyScUyDSsjY0G6zLzPO8XAZEo2SRK
         DM4Kpat/oWUyY5aTsWvo4d+uNiN/c9HdIzV8XP/jp5ynCdOiMNniTnVB5xMLORMnit1K
         T8CVkN/p2Aa9mVtiq1uUM4HipNkxikt237rUpDKHMgsaIHhf+bSTRHLDfjOp5suCGz97
         WVOw==
X-Forwarded-Encrypted: i=1; AL+hErEH4+/KhWGFhXCWQFbqT76fMjp8PataAXFIFSRCToKgQ90OOk5suvgGmMDS8QmGqkpU1TFXUbsH+6ltxw==@vger.kernel.org
X-Gm-Message-State: APuU4Z//Yint+UkLym+QMErUzySGw6qAYt2sYKmOP/q4V7QmHo8fLkpN
	NVvZGKvYeAx9wkY7PtOqbsx5OYSVltL1HNtnaR/qsTuEPuFdIPLQ5u/Q50BqCPlJLQ==
X-Gm-Gg: AYBFou2BRTODkqvkZNQKgfNhH68ootgWBIMxr5x20hEMBJzj3AEzmVsrkHQP37iX6Az
	wjcV930wempZCmScyfo1FucHmrUUshXop1cBpeY1ZKatQohGMC9OaNRnqQB/eYWQ9mA0GK5KxQ+
	yks0QF6m1eiFQsWDuMwkKBVGToII1W/6xu+SQ1fQxY3K26JF/dhuXXFgQtmkReuSX7YzI4fS4do
	cjnNLD8AGyg4UAvGjm7TDkLfnfRnYcLkrGfrZovSd/5p51ItSKHEbQJQ4RB2fxr/5lJiUrtGbIM
	7rUcp6lUZrS7O7YxjGZr0G+c8u85ljmz7XmpOMJmcguu5mRjDw7Qu5ov46rfBG/NX4bojhMsNDk
	ayB3rfN4fV6JuUmqBHyAtByvWK4XHkjEx6NrqVAMMHQ0Gs15z9rn+AX7W3jpuPrfoik4ODSIBYB
	sdV7m7FBCZxoeS3y4rWhmh2ITuSZ/LaKg59uKrQFzWQ4KaWC+fOfY/2dkFB9kYBvmVidt2BJOPJ
	sOeIrUhDSmWQlCnwf/MgHiIBFIS0qi969pKA4nanwa+rZxV/2HKCiuGT0uU5YjYNttRek9h8LrA
	n6fOhXyf/YHAmCBIdLQqV59ZhLEE1hH3jR9siLYP/Ji0xxZR9XGLoQP5/qTC/c6z52Z5uhf6uU1
	K0C8BENO98k3rlQ378l0ulWoNwVukG5BdSY/s3a0=
X-Received: by 2002:a17:90b:3c06:b0:3b0:a413:dd8e with SMTP id 98e67ed59e1d1-3b182fd6335mr947201a91.43.1794379637677;
        Tue, 10 Nov 2026 22:47:17 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:17 -0800 (PST)
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
Subject: [PATCH v3 01/11] zram: drop stale comment in write_incompressible_page()
Date: Wed, 11 Nov 2026 15:46:24 +0900
Message-ID: <20261111064707.2568433-2-senozhatsky@chromium.org>
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

zram doesn't do fast/slow-path handle allocation anymore, so
the comment in write_incompressible_page() is stale.  Drop it.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 632045b65bdb..380615b73446 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2271,11 +2271,6 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	unsigned long handle;
 	void *src;
 
-	/*
-	 * This function is called from preemptible context so we don't need
-	 * to do optimistic and fallback to pessimistic handle allocation,
-	 * like we do for compressible pages.
-	 */
 	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
-- 
2.56.0.542.g3ef89b7020-goog

