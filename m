Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794379652;
	b=hHCAM9+XXMGXHchhPZa5T/8xmhnI3QFZ2g6xCS3sG2v45AGJPxiOxz3VRID84ZwTTwXp
	 PZcBpLuQGcX6j68lSwOccTMzvP8mGh/uo+G5HYIYr7LBZVv3evax98ZDC17rti6/75ZWu
	 1TJtnmJDSeTeAisFHl7oRbRquPxAv8H1rsuf6ClLjnVAlRgUGl7djdVW99lAx7bvrlwUI
	 IVXkr3WgmoixKIIZR2MSUJ4LgC1TywK0y/5QnWC+h0Z5IrBZ5A+Hc0Wo93b8qFtZIA5RB
	 XE7VrGcfy1kI6oXZ5kElBVi/cy58bdpklryHOPd9Rt9H80W1XKYEaBnbZUYEDaDmEyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FxBgELUdpwYR0KSdpANT2wdlj1GRYG+jNYkJLmCk2gg=;
	b=uUUOMlxRlfR2vlz60UPGElQEh3IRALdViFoiROLB2X5qNaKdW4NuszPAfpMhvqqJRJJa
	 TP1FhnPNMJncd9NtsC1943QfPxRBAjqLi4MMY/7KSV9JZ8ahNtuOjbEw1sqHeTyQOd8k7
	 /SLvIZvIcaPRjlcj/0mQkCStrMIAEe8N78j/KJ8Kct/RVgqGM5fAvcbwCxiQ57xiTVA42
	 dHKvcv/C3BPiEr5a8XHSf2X9w3q3xqxfb1+TFfeEmdTNcpW3AqTjkOtwUm3EGOQ0AB+mh
	 H9KeH8xsNCfAEFS0MzUmPNtrJGwy5Dt19YCVVvh4N4jwO9RAwNtgBpjbvcFU+C+TRnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F34gCQ+f;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAA60A2614
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 06:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FAAA60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=F34gCQ+f
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd62c570b5dso1739028a12.2
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 22:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794379652; x=1794984452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FxBgELUdpwYR0KSdpANT2wdlj1GRYG+jNYkJLmCk2gg=;
        b=F34gCQ+fCCsdN0e7vOwttwPv5bUW9XytE3ZxJWJajeLfJGE9alIme/Ue9OnhcVR4GT
         DKLoLxq4LH0dBeDwQ2Xj+0fzuxzfWHl2+eITf0e0jD/ZfkY0G1HIbdB2ri6A2Vni4NjK
         BTfQekxJP7n3OGR4fn4JrNoEaNYpbuLnjemaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794379652; x=1794984452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FxBgELUdpwYR0KSdpANT2wdlj1GRYG+jNYkJLmCk2gg=;
        b=GiB2O5bx7FPiEhNU46We2Q25d0jUkwRkVFTf2OgB2rCgqnjQFlMjXrGvmrn5dIRwSc
         a1K6jiKHorvpc+X55FE0PZctHT/xCRS/9KZQt34FZHX6CtLDEmanim+fqGlGT3yMffnP
         sBu3LBsTduoe9Mo7SIzzUMZAlQP9BICQ0TwsXMIpu2xoqQBdsNvTLjqqlfBWcByk1d4o
         zhOBpU45fqDi4jrSuHATUlh8iGgJleNkHxTgLlzb4Uup7aaknrrQLnUpIcKNbtDrYmkc
         rQkgihroDJEIx14ypZpflmvDuZG0jWkamj0FNeUn53KeGMlM+Ds3K6dRIe7Zq/8K/9O7
         CUlg==
X-Forwarded-Encrypted: i=1; AL+hErFJeVvPvjnTCU5/09kkNkrBC8YBXnyabZ6iTXaai4vx8Ssx3olY1R48OFCdjGn+psRWqeK/DlJbK/Lxwg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/hDoTvVa/rjieMu4/fvsath05JrhUA/0EI1U3mF/3DM4kHHcXf
	b4J7egwe24KoS567j6kRY0D7uin3wmHSMYkqNWFw77IuYflKSuIO7gEJ8I1wp1e4hw==
X-Gm-Gg: AYBFou1Oe3bz13JhI0piVwDAB9DsUT00OFAuAui8RNeAtO6B6H2igEvjIj/64ICLwhD
	WpXw7rKoeZs2ynjlr6/V+R4BkUlZ4L62I9RgSyDhuJA3n9hbBD7l6hYtaaqSOWu+nKjNZT9KW78
	fJb7raIz3TEaQpXmOx5Iib7W9M/vwu9dKbTnQCpdeBM3B3kmY/f6UGmtHtZWWyb+W/h1xplk32j
	l8WbI/Ch+aqxpyyQW3iINixMlJjAy5G77/mPGwtLu6c73RHQjMVZwvB3LScw4J0lGwBgsqnqC/A
	En30NNLW8FmQODBzPeqqzccs6Ud+HE4qKLKfYNq7E2ICjfF3r7OlrRuCjum/jPkTO4H9BTr3V4H
	N0SZsFypmDPk2R8D+mwerOzt3W4Bz4RMU4gcVMxmle2+9Pmixxg1N3dypJPUyK4crp7UpwfO8dy
	ohbo6jpEjH/w4CGWmMkBBsmuHPYRbkUiYyEXFza+v/3O1PfXQSOprVPbYMMzwYTsHKlo9wswyFO
	LyeIvWigbHy+1fciECoY0V6D4OYLCB3JWqYug2+hNqfluMhgmDo1Zvmu4sr60ZOcnfFZHRTBSRN
	wtnx5YDP91p/hX7Gf1+rDQyMVe7zGomZuKh0c2xa1ZZvxDF7qML7tcv6nd1x+wfZs5ywfBeFohS
	vBJ+HYNxgd0xAJBtNySneH8+Dgjo8rbuDui8NIeQ5
X-Received: by 2002:a17:90b:1d4e:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3b182f1903cmr1771365a91.54.1794379651615;
        Tue, 10 Nov 2026 22:47:31 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:ad6a:b446:df00:78dc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db85a9bsm3268666a91.14.2026.11.10.22.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:47:31 -0800 (PST)
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
Subject: [PATCH v3 06/11] zram: allocate zsmalloc object under slot lock
Date: Wed, 11 Nov 2026 15:46:29 +0900
Message-ID: <20261111064707.2568433-7-senozhatsky@chromium.org>
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

zram_write_page() and write_incompressible_page() allocate and
write zsmalloc object first and take slot lock only to free the
old slot data and set the new handle.  A subsequent patch makes
zsmalloc store object location directly in zram table entry, so
we need to free the slot before we allocate a new object for it.

Free the slot and allocate the object under slot lock.
recompress_slot() already allocates objects under it, and
GFP_NOIO reclaim cannot re-enter zram write path.

mem_limit is checked before slot_free() (previous patch), so hitting
the limit keeps the old slot data.  zs_malloc() can still fail after
slot_free(), e.g. when we write from reclaim (PF_MEMALLOC), which is
swap-out, so the old slot data (if any) is stale anyway, or when the
writer is an OOM victim that has no reserves left.  The slot is left
empty then, matching standard block write-failure semantics.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 74e02cf4f53d..dbcbc267344e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2261,11 +2261,15 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	struct zs_handle *handle;
 	void *src;
 
+	slot_lock(zram, index);
+	slot_free(zram, index);
 	handle = zs_malloc(zram->mem_pool, PAGE_SIZE,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
-	if (IS_ERR(handle))
+	if (IS_ERR(handle)) {
+		slot_unlock(zram, index);
 		return PTR_ERR(handle);
+	}
 
 	update_used_max(zram);
 
@@ -2273,8 +2277,6 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
 	kunmap_local(src);
 
-	slot_lock(zram, index);
-	slot_free(zram, index);
 	set_slot_flag(zram, index, ZRAM_HUGE);
 	zram->table[index].handle = handle;
 	set_slot_size(zram, index, PAGE_SIZE);
@@ -2326,11 +2328,14 @@ static int zram_write_page(struct zram *zram, struct page *page,
 		return write_incompressible_page(zram, page, index);
 	}
 
+	slot_lock(zram, index);
+	slot_free(zram, index);
 	handle = zs_malloc(zram->mem_pool, comp_len,
 			   GFP_NOIO | __GFP_NOWARN |
 			   __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(page));
 	if (IS_ERR(handle)) {
 		zcomp_cstrm_put(zstrm);
+		slot_unlock(zram, index);
 		return PTR_ERR(handle);
 	}
 
@@ -2339,8 +2344,6 @@ static int zram_write_page(struct zram *zram, struct page *page,
 	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
 	zcomp_cstrm_put(zstrm);
 
-	slot_lock(zram, index);
-	slot_free(zram, index);
 	zram->table[index].handle = handle;
 	set_slot_size(zram, index, comp_len);
 	mark_slot_accessed(zram, index);
-- 
2.56.0.542.g3ef89b7020-goog

