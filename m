Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795491395;
	b=QMcxFUbupgnQli9+u0uKbx8aGL6fQ+xggKLFcrWLHEjwXcMwJYPcLguXYcT8dJHyKp1u
	 ZsmeDO3GXoprcV6rVZcarKnT98l8pPAup9sSuUJFIklpN425mjT545PyufevFjTMWXriP
	 SXEFKTW7cUoXP+71S8Bbm7ywGG3S/Aa/6egam/V5OkSzXvY0BC8c6/8syVQNwhXOxpgHr
	 GgXit+q+Yzis+l+BUsJT2D2IU6XPpIFWB/Nk9cYNNMU9vKAySNjHv5imkrHluqKXzYcmq
	 PQ5LE+GgkoZZQ09e6/KySpjUfw7Qd/Zew3r2QXtRMfcX5EAqM7i/DLEWHOReK6/KC9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795491395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=d6ppZGVJDw+K4nlkQRD1jXExlHhdqYSWNagaXOYD1M8=;
	b=jo8ZW4xlScMNookmSDxCT42nn+zU3vNlFztsMbNtzFlyK6hThpC8A9rVXo0lDoZzDCL6
	 umBqDb2eDbGsvwlvQusZ1+bx9OJ9DARwVzacp3Yb2dmloHsrQy07Sy5gmu9ezwrK6fJaw
	 zkHUtPSd1unNzZlEz1BkmH3puUiHwNr6s1urBoy19tmEI68nIgc1Sp9htoxvzWp5KUQ8B
	 N2+VNKZVwn02w53aJdqsfaXaRM3APNvjVuLLQnHodyuuyKB1OAZaHomSxx6wStyc1CSZw
	 k1nmTtdvrN4klTBwLAw94si8hyt6H5D2DMnp5oHc7WsdjAl3MxKsrbgbVf+OyCBGZvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ubekiw7L;
	arc=none smtp.remote-ip=74.125.82.70
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2068606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 03:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2068606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ubekiw7L
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1b29df78132so3612757c88.1
        for <linux-block@vger.kernel.org>; Mon, 23 Nov 2026 19:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795491394; x=1796096194; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d6ppZGVJDw+K4nlkQRD1jXExlHhdqYSWNagaXOYD1M8=;
        b=Ubekiw7Lwjw6PCD4YgCrYrSmftwFEiuLRSBf0Q/IEFboKvnH2qpx9S2AzS8FAaGqLd
         eO2YnUUYraqwkVgMQCMUkSjvaySS6gSeXE/pOLKcHlI1LSVX7rQZXF1ei0zgqTNMVVRg
         NnxJJ17esIDs+Y5lfg7qWLdfglBoQKkxhEz60ig4a+yvSxPbC3NXhN0tKRYD9PaFjsa9
         QOm7POChVG3rB2tPy7UGukVcIUwrw2EpKF6exC2Rm6/4ownxRlYZSYuALzUKC6fCf/85
         M1fxmv16sQa1pKXXjtoThzaVZA6LOb7HWyfttn5hmnGnR58oVjLJ41AnH+ep2f6Mv7o4
         O+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795491394; x=1796096194;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6ppZGVJDw+K4nlkQRD1jXExlHhdqYSWNagaXOYD1M8=;
        b=QZlvOhbrJZ6TKIsEYOpoEdxfC82MnH8MCxRH5k3C8CTyB/C8fXMSuGP5R0O8PJasIW
         rjxvo8DAJN/rK7vJhDV18+9EPEgI7gYPFBr5IOzjthBmFPMSlrM4SejKVaZMBBUoKCbj
         Hj1e538ArrPs1CXHZGwso1rqMM0GRXCQayIQuLscxCaTgfV6vT1+M+F+oHbHzzph5Zai
         I0veBx8NVnJMvMnHLuDKvRJbTkReHKp6hwzbFkZgk9KoVLx3KeGxzD2xQEKJQ2+o78CQ
         t4oI0mG0GuimXlVsF0q6ZnK3LlscCXlsLwIKooXiAw4G8YjPkZzJYtmaTrDDLmSBi/yZ
         3fQQ==
X-Gm-Message-State: APuU4Z9FlbDtdKJLp4mhPz94B+foD6utTnZVwjuB0rF3xB9IoZATUnIc
	5M75zV8WF2HdmZUoVFavQpMoVpi6w0SYDTue4VFiybs3efsUpN1HEYeN6U3whKZ55PoN5td4EgD
	tVGjDIIiVpEt5stWRD/qFlg==
X-Received: from dlbpu1.prod.google.com ([2002:a05:7022:e881:b0:1ad:2ffe:151b])
 (user=nilayvaish job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:701b:2607:b0:1b3:b67e:9fcf with SMTP id a92af1059eb24-1b5568c4833mr12838021c88.17.1795491393766;
 Mon, 23 Nov 2026 19:36:33 -0800 (PST)
Date: Mon, 23 Nov 2026 19:36:30 -0800
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261124033630.832566-1-nilayvaish@google.com>
Subject: [PATCH] null_blk: use page_private() accessors
From: Nilay Vaish <nilayvaish@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"

null_blk keeps the index of each backing page in page->private, reading
and writing the field directly.

struct page is being shrunk as part of the memdesc work, and its private
field is one of those that will move. Direct users have to go through
the accessors before that can happen.

Use page_private() and set_page_private() instead, like the rest of the
kernel, so that the driver no longer depends on where struct page keeps
the field.

No functional change.

Signed-off-by: Nilay Vaish <nilayvaish@google.com>
---

Notes:
    This patch was written with the help of an AI coding assistant (Gemini).
    
    Based on next-20261123.

 drivers/block/null_blk/main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index ec0d7ba4d938..901952e911b3 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -941,7 +941,7 @@ static struct nullb_page *null_radix_tree_insert(struct nullb *nullb, u64 idx,
 	if (radix_tree_insert(root, idx, t_page)) {
 		null_free_page(t_page);
 		t_page = radix_tree_lookup(root, idx);
-		WARN_ON(!t_page || t_page->page->private != idx);
+		WARN_ON(!t_page || page_private(t_page->page) != idx);
 	} else if (is_cache)
 		nullb->dev->curr_cache += PAGE_SIZE;
 
@@ -964,7 +964,7 @@ static void null_free_device_storage(struct nullb_device *dev, bool is_cache)
 				(void **)t_pages, pos, FREE_BATCH);
 
 		for (i = 0; i < nr_pages; i++) {
-			pos = t_pages[i]->page->private;
+			pos = page_private(t_pages[i]->page);
 			ret = radix_tree_delete_item(root, pos, t_pages[i]);
 			WARN_ON(ret != t_pages[i]);
 			null_free_page(ret);
@@ -990,7 +990,7 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 
 	root = is_cache ? &nullb->dev->cache : &nullb->dev->data;
 	t_page = radix_tree_lookup(root, idx);
-	WARN_ON(t_page && t_page->page->private != idx);
+	WARN_ON(t_page && page_private(t_page->page) != idx);
 
 	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
 		return t_page;
@@ -1033,7 +1033,7 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 
 	spin_lock_irq(&nullb->lock);
 	idx = sector >> PAGE_SECTORS_SHIFT;
-	t_page->page->private = idx;
+	set_page_private(t_page->page, idx);
 	t_page = null_radix_tree_insert(nullb, idx, t_page, !ignore_cache);
 	radix_tree_preload_end();
 
@@ -1053,7 +1053,7 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	struct nullb_page *t_page, *ret;
 	void *dst, *src;
 
-	idx = c_page->page->private;
+	idx = page_private(c_page->page);
 
 	t_page = null_insert_page(nullb, idx << PAGE_SECTORS_SHIFT, true);
 
@@ -1112,7 +1112,7 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 	 * avoid race, we don't allow page free
 	 */
 	for (i = 0; i < nr_pages; i++) {
-		nullb->cache_flush_pos = c_pages[i]->page->private;
+		nullb->cache_flush_pos = page_private(c_pages[i]->page);
 		/*
 		 * We found the page which is being flushed to disk by other
 		 * threads

base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
prerequisite-patch-id: d52d42a2ec9ddc2b12b3412ec0d07254b417e60f
-- 
2.56.1.839.g22a8290db9-goog

