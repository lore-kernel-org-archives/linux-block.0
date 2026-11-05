Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854084;
	b=4MQ9z4gMygp0Zr926MZtU+1SYddP6Kbqypy7WOOCp8Yv3g02BcJm6YTgYxLxdqdBTJVc
	 d71Vpb6ayENf6xv2zaXAr1DVn1fqGnTGm6U7vztexQokcZsS4cq0sBsBF668qI4iOatQs
	 N9nQ/yqHvQs8B7nknMePoxLck12uu2wM10hZvjRTxknp0Cvhv2XJSxzZZfZn10zSyC7jx
	 mFZ7oVYXbF3uStC3dls5Qj7jMDnHpVk9NK1OLe5O5h7D55feDCDtJiKSMXhaHtXLQ0VbB
	 NnQmNe+Fpr+Qa99ZeLVoGww/AQkOa0JQ3aLsaijq238NWi191J3gGoIq5MuJUibNmLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854084;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7RktNgHUwlwtWmAgMABeK3FK5t5bFNo0JMMWVYG0t8s=;
	b=EVYFUtHzi5Om5cNnyQmSwX0D6TsBkoM4uNt8ySydeXFrjoHPjQLYMscY65gjHz1CbPQD
	 WWm0f4NTnw55/t6j9OFjSPbwQ3qPuTF0aI/GNI8GV4UXAXc7BYHhGR+DsNKdqnxAVU1ie
	 SA6pp8m8wd0TpuTOhCXbFH8Nd7zD1NUz2fgTAqUIcZtcj7AwPj1xZAfIu/jsMn4fYA7bl
	 6mSGqiOhvOfii/1L3qnbmdCd7UQo+0gNMq/jB+gghy0eEYMFv06Ai4v0uUXXgohKxxdoh
	 uGeDEF8rutK1P+vjCDAJfCTZh2zIZogy04Nwahn2BeG04exmlvAQI2yLwqVRlIRTYow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FcFJNonH;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43AD606A32E
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 04:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B43AD606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=FcFJNonH
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2af4c8d00so3267669c88.0
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 20:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793854083; x=1794458883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RktNgHUwlwtWmAgMABeK3FK5t5bFNo0JMMWVYG0t8s=;
        b=FcFJNonHwrsUGGzPEUXa5IWB1RxPWF9N21EdetTVk9Qfb4o8e49MG0KPclz9Mrr4WJ
         YrD35TxhjwPNaCrCaHT6nMMekSMZ21cXIR7AAhllVk96wT22E9YwAINq9mgRJXuDX+i8
         2RkaahY0Z55IMVK4xKO34U6UAUFJA9yAakU3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854083; x=1794458883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RktNgHUwlwtWmAgMABeK3FK5t5bFNo0JMMWVYG0t8s=;
        b=BAwfKBwl8o0gKROduWvRANisV5nmHTtn59qyE+e/MTH5vhFxFHYSxLOr3CmF5jI2zK
         uP30raz7QjfV9s7kD4+em/w1KnFjycQWnuh4qE8U5siCrFBpO7nXbcTlIfaN6WeSZGZw
         iGXE41dy91jUoDTeSYHQLaYWGUkD5DCTOStZbkD6Pufd8rAZ4w3bLCpgcME4qpA9Ti9h
         n5z75iu8gh0smTn6iJJyOcY5GVLTNvgXKwXAaqWNwD4is9zy0g4oO0KlnkGwwuEXvgvn
         rqrPkTjhF0JeUfbk6ZU1tghJ6r/vwOiKpcq5l/bznCpB+LzhKMadvqF9kBV8nyQ7whdF
         mgqA==
X-Forwarded-Encrypted: i=1; AKwUvBzmD0tMd2moo1RTAfCVKACsIKzI18BjtcEQTq6GF06PUZqHOhyY5k8zKInnYXkOaTDviXNMMZTrShzaYg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8PSwp1jG4ddCPfM69WxnTGMk6C5ve8KAVO04MNUH+IPqwAox76
	XKcFkTy5TtQK24iLDe/Er3rb4ROMtHXQ3vEztyDQOkHScPAFVG+VZwAretnZ90apNw==
X-Gm-Gg: AYBFou1XwJkTuEn/0kHfUpu4Sv25goPdbyZFuRlgFfi1jU2k1CRw7yUlTltaw1wH0ky
	9orG19JlmEKZBSBKqOZwAM++fRhS3hehgQM5XlYGOF2U6OiKdK0gt+3QbKyb1p+KUi+NCY+ENIu
	DB8sg7dWwz0SWMmX6rIWxd6bHiqtvNVEhRKM7NWFtJftg+0JWGTxq004w48wIpN0zVnBX4lR2gN
	jtOGTI3x6qxHKGcfEi9zI72QzGsK0H9rpnyFoTk0T28kQYeCyfk7KpMK7/fvK0MicGjYBAt1UwH
	zifk6kGlYHeImfrQLFsxlo4zVYyHQPXAUIkzzjL2NItaDUnt0lrQS0GHfYiM/oNNtQKKMX5gD3+
	a+kx8G9+MLuUxvh7Fe9iQn0kcGGWkfH0o0Lzk4AG8ACt8LHfxwI7PWD6g8NF6fXTQmNwSwXZ5Ef
	fI4M1EHzhgA88ZYT0cSKTANlXAL4pmvR4w3rakAGRrIFLFNTd2JiYSdp6YmYg1gEWkp5KlQnf/G
	qWZ9CcFJCK9oM3+E54ZEW0zMNuz7+v7UhP65FHYzuKeSsVP+JUMEVuu5C+vvJUP8ZXanYVImr9e
	ZikUvyoARyk+8YgE+rb7/9fj6QFgvxVt0tdsvfYDc21xkfLOnYmIHio57ZVcnEvJ79gzhnGresy
	57KlBx/06PlXLCyAnw/I=
X-Received: by 2002:a05:7022:170c:b0:1b0:166c:6a94 with SMTP id a92af1059eb24-1b0166c6be4mr17748555c88.28.1793854082667;
        Wed, 04 Nov 2026 20:48:02 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:37bc:b763:7ec7:65b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm17142927c88.21.2026.11.04.20.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:48:02 -0800 (PST)
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
Subject: [PATCH 1/7] zram: drop stale comment in write_incompressible_page()
Date: Thu,  5 Nov 2026 13:47:31 +0900
Message-ID: <20261105044752.1997895-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105044752.1997895-1-senozhatsky@chromium.org>
References: <20261105044752.1997895-1-senozhatsky@chromium.org>
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
2.56.0.398.g882cbad275-goog

