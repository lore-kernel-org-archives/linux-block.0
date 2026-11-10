Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289729;
	b=g/+IUa1mh78uRA9r3B08une9Z9BXve2dHXHkBB/HJFEjDjiWuyqVMF1Pwf/E2sCMVacY
	 374GUbYZK8gLasEDC+Vm4E6gzJKT4vcS6SHfnhbD58FFBYz5UlKGxVjcswdyzEgUhTROG
	 Lnc/TflOTnskQ3kkWzVAVQI+MEihBUrzpSE2w8e+RvFjp8AEFAm2FpZaZ7Lnbc9dUP2AX
	 x/msu2tAsdeWmPpunfEY5gSWG1kMvKMi0Z65YQgfplVmvSq8E1rXG9ZU6RYeXjh3moD8B
	 Kut0UpNIYslqWmvJ17i/95uspozu7ynMgvywlYC4pvdM2AMQMP9q0h4BFgeBsdZ/yYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qlHsy27E5D3YFabLkscnO6Hr0slQj6Qu+mskenxvEzg=;
	b=TFkODzVvCfe0/UezLil2UUatiKd+KW88ZI4ErfklAt7Hl39W/GxhPTMfnbQTX+vT1525
	 qbqNG8oBw1ggxGRwzWpGVpmoXS2QAk+y3MXFaGlfe917WctyhK08bGKgBRbCHaRZebvQQ
	 Tbr7aNH/uFnoGtoEpF1Gy1xKMvk9Tgo8zy/ZWiRSn5Ep20V//ncaF2oJXG1fjvBuqQWuI
	 RlR5iSx4My+dRroGCNEng91MZ/6IU08IYQvwRwOiQ51L2y1TeO0/yjNkZi0OE1UMomgZV
	 6TZRxFEpcNSlVCOuzqD3MscbGn7QBbmki+b/fLhKycqrpXxxLaUH31KVmJb1USlSapg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3C606A31C
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 05:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB3C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ccca948203aso761512a12.3
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 21:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794289726; x=1794894526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qlHsy27E5D3YFabLkscnO6Hr0slQj6Qu+mskenxvEzg=;
        b=UrMkwU5dJFPj0lHRqxwYyPE4Xv29hrwlH1N/nziQ1cXBKEANU05Y/4SEcDQ8iBGk3G
         1ESJ5TbAE9JHFMbEYl72ogNknH1tIJMY32+UtTKYKpxZkWActMFFWBovE2d5LUTowAwg
         iU2qwPXogAKNSN1LwOGsmqgHIoUXxcbRvJy78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794289726; x=1794894526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlHsy27E5D3YFabLkscnO6Hr0slQj6Qu+mskenxvEzg=;
        b=cfmv3jUenJfZ4aUQn6zjYK4kGjslh0S22IOC0D4w2PksiyI+NolrSTyliIxaK0h57i
         J1fy9s/SXtV2qn0Jv7C66C/Xa81HJoE/L0Zjfe6lL7GiBmdro90XiYsUfCaXZwLvu03H
         gPaSTH+hkngf67/5YzxLmznFF06rAFM4oaUazedJGVqRKsATbn6cI5BME/m+UngnhVPM
         eW4tiyyvm5F/FutNCnGfsIbcz8qXD1PJUaZuwK19PWxaZS7YuyswJ6DlGjs4nG8jcWTQ
         AGlpUYnZdNG+4R2oxD70/o6LXdOP/kEK0dVIUzJNtlvEZv89y/bfOMsvzqzX1xT5wn6k
         VSwg==
X-Forwarded-Encrypted: i=1; AL+hErFxeSTEw+ERV8ec4LLBqYY2rYptaO9HPLhKBCwyvva1RTYB/4diPwVoFarfIAGEuonz0tQbIBpm3fj2Kw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OIazuPnv+y2CKytAw/8Yy4hVUFUq1/kYXYY9rJdoIJrBiDl8c
	VZEFuCDg+QkHYTfx8+vPN2LDm0XJlY6O5vPo5EC0Con/9ZONpiL+ES/muMjVxU5ddA==
X-Gm-Gg: AYBFou3Ybp8cQWQYzfnB58j7rqS776wyUoB31ZTLg1FNdw9YGbTH0B33syKtGCCTWkG
	ADUnUUxA7Aa6AVoMRbskad05jwh3i0XhCbxYosR5eBKFD7q6Wqu6z7w912JOCkQlZfQXThAP9S2
	YPtctnozxvOEFhAXYKExYLjRgPVLL2B3F+Ki0tC5Dj80EocMdm55aT8KzCaRDjRsovPjJucA/k9
	taS1Pc+1cGVeTJRjqy0MlAh7EfpBMOvQtP8064r8kSqFc16yPFdkNXAJuRi8OhcubzQ7Mqbt088
	1qwibEeL2Nj94pRAJ6XkjnX8jdAI52LHLvkE1VunMzvUhq+O3S96oxXwrxVv/waoHj0x8j+DIkx
	3a16ZrOMHJ/ZMsocEH+/EwCMXaweU57/K0DtuAY8lJ5el2S1LKQN7BY7dpmXqhHx6l9czgc45+h
	Lf3Wc64o1ZMTugbFxQoutOYd+63DPWP+GSYalqAYLu0Vni+vR+a7ekQ53HMOXlAZZ+KhrU5u2yh
	Q1kvbjCRJQPtJScs9N8gylgoGowmlSsJsHf17ydMgLYP0s6x5NwtgOoxpPeS+Kswj/v3fz9TC3K
	LjzPc63GfFpY3oDyQ7O85DjI7oI/MO+ZfS7bcx+Vp6jnrRCTu60AwzXCBzFsmGvYhTT+dsme+gv
	4VaFaDU2eITbYFJvMBg==
X-Received: by 2002:a05:6a20:244d:b0:3eb:39fd:badf with SMTP id adf61e73a8af0-3f188c51a46mr1510768637.0.1794289726009;
        Mon, 09 Nov 2026 21:48:46 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:e137:9384:7cd8:6e40])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e53asm444634a12.5.2026.11.09.21.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 21:48:44 -0800 (PST)
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
Subject: [PATCH v2 00/11] zsmalloc: redesign object alloc API
Date: Tue, 10 Nov 2026 14:48:05 +0900
Message-ID: <20261110054836.1515030-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
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

Both zram and zswap already have per-entry structures that store zsmalloc
handles, so allocating a separate handle_cachep object per stored page is
redundant.  This series embeds struct zs_handle directly into zram and
zswap entries and drops handle_cachep, saving 8 bytes and a slab
alloc/free per stored object (2MB per 1GB of swapped out 4K pages).

It also folds zs_malloc() and zs_obj_write() into zs_store() so we don't
take pool->lock and look up object location again right after allocation.

A simple zram test on a 24-vCPU VM
==================================
165 fewer kernel instructions and 0.7-1.8% fewer kernel cycles per write;
lz4 single writer +2.3% IOPS / -2.6% average latency;
24 writers +0.9-+1.0% IOPS; no regressions.
Memory: 8 bytes less per stored page.

v1 -> v2:
-- addressed Yosry's v1 feedback (too lengthy to mention here, Yosry
   posted over a million comments, or something very close to that):
   split-ed some patches, squashed the other ones, added handle
   alignment run-time check, added 0 PFN defense, etc.

Sergey Senozhatsky (11):
  zram: drop stale comment in write_incompressible_page()
  zram: drop get_slot_handle() and set_slot_handle()
  zsmalloc: return handle from obj_allocated()
  zsmalloc: switch handle type to struct zs_handle
  zram: check mem_limit before allocating zsmalloc object
  zram: allocate zsmalloc object under slot lock
  zswap: do not free the entry if its pool is NULL
  zsmalloc: encode 1-based obj_idx so valid obj is never 0
  zsmalloc: embed struct zs_handle into zram and zswap entries
  zsmalloc: fold zs_obj_write() into zs_store()
  zsmalloc: populate new zspage outside class->lock in zs_store()

 Documentation/admin-guide/blockdev/zram.rst  |   4 +-
 Documentation/admin-guide/mm/slab.rst        |   2 +-
 Documentation/core-api/memory-allocation.rst |   2 +-
 Documentation/mm/zsmalloc.rst                |  22 +-
 drivers/block/zram/zram_drv.c                | 146 ++++------
 drivers/block/zram/zram_drv.h                |  10 +-
 include/linux/zsmalloc.h                     |  36 ++-
 mm/zsmalloc.c                                | 285 +++++++++++--------
 mm/zswap.c                                   |  28 +-
 9 files changed, 293 insertions(+), 242 deletions(-)

-- 
2.56.0.506.g506a7eabc5-goog

