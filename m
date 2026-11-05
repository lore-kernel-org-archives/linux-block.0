Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854092;
	b=pX3QTwKhER7j0joVkiEg9P7y+u83qxN21MFvSlfAUBViWevVVgaxNgh/EDkCR33V4Tr+
	 vfkjHM+Y+TpWbOxK0XTgibDA2GDT+43hrlYb8bPSaqNnxBbsLoZgRkTnkfayrLmWNzZmb
	 jU8SKmN5WhhQS/DyHaSOJE/MCE3R0TeDdaiIDN9ikC8YRQdsoFzHJvVcYyypfpKR6KzOa
	 h2oYVIdqxP5vUFv3fIHYuasPYxdL2AVxmdPDQSHH90iVcNbrEXdDr8tlcRE/nEIp5fT0t
	 ZOiSit10Uu6FmNMzbsg44vgs5G2jpKPocPgRegRP2EfBO8kjuArYwnWEMqkHJrgaWfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854092;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ig3cy4g2u7CXskVAimAX4bU14IYSOF358bPQNQDlMyc=;
	b=tM5FYuwlGFDXBjQ3HuwIY2lQ7JxaQA8iI5T1rIpsuqTsl3iqUMaI9BeTKN/kwObx9Do9
	 Bm7Ib5J4EQB7EwfWNWxULGUU3KIadtCFgwXjoSTDnfxprj/cURt95INhZuvowgyzE0u1d
	 Ef1XFaprBpwCyyzq2d5HMRMrw1OV3pRHIDJw0T8+PKkpbR+nWkjmLlOnT+P3WhZ7Qo01u
	 1BWBpQpfdPfmgXddt7SRi5qdEZCrgoaimmhsa3TZBqgTSqYSOUyQzkttrn0SAcjlJ5Sns
	 Iq/BfjJWWSf/nnlGhT12bVR2GFW7Xhd+/ttbb9wbylDEFZHzxuNA0bi3LScojtZTLTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GNcDKh1W;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E6A606A328
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 04:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E6A606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=GNcDKh1W
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a1947498bso3941350eec.1
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 20:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793854091; x=1794458891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ig3cy4g2u7CXskVAimAX4bU14IYSOF358bPQNQDlMyc=;
        b=GNcDKh1WrwbKVrr7xapvlw9tZAdXzl557bDRLx/tyOSvppS+gQJlpSnM/l2RbSOZ9T
         bANF7hjz+WtbX0aUbRQjdG3QfdxSi5FrxB/nw/ptTNcmjhLB170PVYj3+S0TXQrO3tc4
         m/7nMzac3/k3iU2wiBPMVsdJDN8AOSbRcMrQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793854091; x=1794458891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ig3cy4g2u7CXskVAimAX4bU14IYSOF358bPQNQDlMyc=;
        b=BuPtmExQWjOdjGJnbZnultJDz7phn7zUIqJJfS7i6zA0xGoXsSJ0EVK70w9CvbHXUi
         +Sz2GBnCm2VryLdRkA5trpMITJkynG+yfMzuQChojbn4rd9XfSm+u/Dld+xR0oPjorh9
         8/v0ZovEDRmSzTZ0yNpjwrup5KMq3vMaVaUi+GpxF1NUiJg8I7EXsanj1wmGFs5lk0j2
         IoQUTLF+CYfb6qpK6ecCvD2bYxzCbqqyzQoCgxWnum+SF/QlN9NcbYjg0Bouwl+i5LWJ
         h0oLryHMKFWxA7VRrcWq0LreufYSzvMR7S5VCktR7slLPTWZWbWeDOu/NPp4ZCASKd9v
         G68Q==
X-Forwarded-Encrypted: i=1; AKwUvBwCbPUzP/f+NX9E9Scp30CNeS30xlj71fPeet9ZDS1b1Fd+Jn4BUUxJXx63h4nq+pIO+0pO5DA2JuOntw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/KJ15wjRK3qk5hHlXXKbjoWuLmWoVJTZ9YhnZ0AL6/HGfuz8aH
	KZb/X90G60kQ4gLPl4M7Frh8Vj+664jmd6IsbanvL/n11ZO6oQXc2BWeTkCeWQ0bE736jNrxmRZ
	fV0s=
X-Gm-Gg: AYBFou0Voxc7xkzRJtXOX5rJnfoN38VU9La0GyqhrZT68tBC1aNaBWID7tJ1wYttKO/
	O8DGpA94P2KGxJbgafbM9efPyqwTugGq8AQq5F2cg1Liif+OEsNBrNgADNaKaj3zLQxq7h2715R
	bnP1w4fp7ATvz0kg+zOOi4ywofixon+NIOXOn1MX6ONwQwdAzLBL6y5G8jLXUOOP3oSs47e4vRr
	Y5TV/ibeJm16C4kMQ5BndvffpGfwCAdRpfkfm0c4e5/pGQvZfECLUtBtxDx2B32TS0M/d0g4+Xe
	NgOkrEHzeCj3/fP5MaM3ZkBmqN35rPmEJrWynrles411IwoUIfbaWzmjMjC6E/HewqAgK0kndzM
	KRoVXIYnuuhRnDbnZQqmyqZ62QV2+olapiNOffo2QjgQ6wX/Csllk+fOASgf7fOXXs1stzeoVwd
	AB4SrXn9TvYKaJgCGwLcCM2LgSz8Dm3+bdHefX4ILDyQYIo/vjcg3dF+2WEos3Z5jSgQ1a29Bvb
	24sfStdtJc6BRddgVaonq35SZHubg8+eodWtZ4JfCn6u3Ik9zlxY+VPYLao46pwP6QuujYqVA8k
	YYyrXGjA2Hsjplo4SdhqClokDfDzgawXABrRh9XZ0E87n7xKAUyLuJsHi7+ZqK2MF6Y+9Iu81Di
	Q+AJGdTCtQ/31raqYMpeZQzC4b0kxHjtqxaC1CKs=
X-Received: by 2002:a05:7022:628a:b0:1ac:1343:fa54 with SMTP id a92af1059eb24-1ac5bbb4863mr35522622c88.14.1793854091285;
        Wed, 04 Nov 2026 20:48:11 -0800 (PST)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:37bc:b763:7ec7:65b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c6f0dcsm17142927c88.21.2026.11.04.20.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:48:10 -0800 (PST)
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
Subject: [PATCH 4/7] zram: allocate zsmalloc object under slot lock
Date: Thu,  5 Nov 2026 13:47:34 +0900
Message-ID: <20261105044752.1997895-5-senozhatsky@chromium.org>
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

zram_write_page() and write_incompressible_page() allocate and
write zsmalloc object first and take slot lock only to free the
old slot data and set the new handle.  The next patch makes
zsmalloc store object location directly in zram table entry, so
we need to free the slot before we allocate a new object for it.

Free the slot and allocate the object under slot lock.
recompress_slot() already allocates objects under it, and
GFP_NOIO reclaim cannot re-enter zram write path.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 2c2e11b2b663..e2710ce35b1f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2260,14 +2260,19 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
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
 
 	if (!zram_can_store_page(zram)) {
 		zs_free(zram->mem_pool, handle);
+		slot_unlock(zram, index);
 		return -ENOMEM;
 	}
 
@@ -2275,8 +2280,6 @@ static int write_incompressible_page(struct zram *zram, struct page *page,
 	zs_obj_write(zram->mem_pool, handle, src, PAGE_SIZE);
 	kunmap_local(src);
 
-	slot_lock(zram, index);
-	slot_free(zram, index);
 	set_slot_flag(zram, index, ZRAM_HUGE);
 	zram->table[index].handle = handle;
 	set_slot_size(zram, index, PAGE_SIZE);
@@ -2325,25 +2328,27 @@ static int zram_write_page(struct zram *zram, struct page *page,
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
 
 	if (!zram_can_store_page(zram)) {
 		zcomp_cstrm_put(zstrm);
 		zs_free(zram->mem_pool, handle);
+		slot_unlock(zram, index);
 		return -ENOMEM;
 	}
 
 	zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
 	zcomp_cstrm_put(zstrm);
 
-	slot_lock(zram, index);
-	slot_free(zram, index);
 	zram->table[index].handle = handle;
 	set_slot_size(zram, index, comp_len);
 	mark_slot_accessed(zram, index);
-- 
2.56.0.398.g882cbad275-goog

