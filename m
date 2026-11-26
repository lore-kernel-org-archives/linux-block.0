Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795728236;
	b=rosE+JKwH68LC7r5PAbv+xfTrixm7o2Ww4vOocSRYyiYE7CjZ/G6i65ek2BHu72yxSfX
	 3gaKkJtjgtpuaKCtwsH0ogYosTL2yVE4EGezUKWjyMznuWAgC2FHoEbeY4k3Ra8CTAphR
	 Psjkik7CFCpO6Wgf0CcrdplE67CZxKahwibUnLav9f/7Vz6flrZYhHIxvFeGqfwOn/md2
	 NtcbsruPTwfMd4Rd0GCGUC3+g/GqCHvcidP2i3hpbEd/0NNC2Vu/IC4CekgFnDzshn6qp
	 OLpMWboDwJZYt1mH4WIPs9KxyHp4GRr4ARkWTbxKEsXNJLn2u5UTTgGx4v1I021vJSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795728236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Lctra6v16d6sYg0AClxI9qA2MaKBXhH+6tSQiMMOxxs=;
	b=NNLSBWHJZxXwoW3dZiKZdzP8w8grIHUQEa8f8QpiVB/NP013s2Rsbx02WW6zuAoRAVIM
	 ushNw4Cx7NWBskK1LRKDMrqdVoxlNrdRmphlklgf8IyVzqv792lka8/oIg7c5gAbQye/Q
	 wlD7CQIl1Eh5K3wkPHmurGlPtbbH4gc5G2eaKieg7qSAW4ukXZu9rz4kMjDJEpib1dtP+
	 dcu4M9mGjRF7J+MDKipFXQbio1re10iu+yZ6PpY5VwY9As7F17DhJs6vyXP7RuoPaTEOt
	 R1ok9R428UQm8Po41hETquV2f98tOxOQXPeT9g+CGyUnIqNYfo/0hqo6C/yGGv+5JDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="GC8UhZ/9";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0DF606A31C
	for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 21:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B0DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nilayvaish.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GC8UhZ/9
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-3854627c1c8so9955818eec.1
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795728235; x=1796333035; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lctra6v16d6sYg0AClxI9qA2MaKBXhH+6tSQiMMOxxs=;
        b=GC8UhZ/9KJ6ydP90T4Sc8xtEYWO1hmVvyUqkAHZ5e5oZDs/YkN26xJ8shb4O36Rtal
         NcunxK/pirDjvo/7ItutTUOTiLD32Yq8oXCRmtvegmU/lL3ehEkF25Lr9JGqit3ncwQj
         0JnqeuRu4sjQ3Om32Q3y/QGqlSSP62qzxK64kDd2/9IlvMJb04GARiFSpXdrigVrNyag
         gyg2wZ3zl+1+3uJDfmzCmQ4beZJExmu9UEVleEOAZKkiIQFVIuw7rSt3h3lpB7oQztdm
         8x5f1IVxnTaQuu6vLynGFHq6uhDBsLj5s3tKPIlx0W87x6KlsF4rFvPmmRtd9O+EhI7u
         Drwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795728235; x=1796333035;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lctra6v16d6sYg0AClxI9qA2MaKBXhH+6tSQiMMOxxs=;
        b=LwomZ+n+0KdOaWL5Gs43Wj0ctv+X3c5TH44wiYrioT+ksH6un8OLWOieobm5GBW6yZ
         CsB/g7fnEl2lQWYQTmuiFCIUUgUWNPJV53GwrNojtkvCxDptLWkHURhfV5xKA3p88cyv
         Azzrj5vHfF+qhsP4YAseMj/1yR+4a3+3rwMVPlTQJENWS+P9rYYlcXFuv6kMGAZ5MOgK
         dypglVUVirlqYv0B3H8RXRtdQug7bwc/+DmbTbKxoV6rZNX7EDzeJqykztqhnRQDeywy
         2NBlqBhe444kOmuIbgsVCLKIbuBV4a5FimJLVxzqnOWDUHaC5MctxjA5EoYxn+HVJsFe
         eR6Q==
X-Forwarded-Encrypted: i=1; AL+hErHlxKE3vDcKUPiDrc37Y82X2wySthzF2ZUtSiyZLwWTipZ34vzMA+AwShculF7xptZQfaKCxzfaAZUmxQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/D1gYn8Ipv8GWoCuVRLi6J2T0TEKeygMSD025lT9CJ/ZYQpLft
	lbQ26zM/WNHWLMPGzc7clPPGqVzhvi+apcy7pbAMzTQK0d8QczCHIEIP1UmAmPuSpvxO/ucr+r/
	8dbbfTfT2CXEF2RuW/QQQYQ==
X-Received: from dycnr12-n2.prod.google.com ([2002:a05:7300:e9cc:20b0:386:89a9:69e9])
 (user=nilayvaish job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:259a:b0:36e:800a:71fe with SMTP id 5a478bee46e88-3856c4b844cmr21896859eec.1.1795728235174;
 Thu, 26 Nov 2026 13:23:55 -0800 (PST)
Date: Thu, 26 Nov 2026 13:23:41 -0800
In-Reply-To: <20261126212341.916839-1-nilayvaish@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261126212341.916839-1-nilayvaish@google.com>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126212341.916839-3-nilayvaish@google.com>
Subject: [PATCH v2 2/2] null_blk: stop storing the page index in page->private
From: Nilay Vaish <nilayvaish@google.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
	Nilay Vaish <nilayvaish@google.com>
Content-Type: text/plain; charset="UTF-8"

Each backing page records its own index in page->private. The index was
only needed because radix_tree_gang_lookup() returns entries without
their indices. The XArray iteration provides the index, and every other
user already has it at hand.

Take the index from the iteration when flushing the cache, pass it to
null_flush_cache_page(), and drop the copy kept in the page together
with the sanity checks that compared it with the lookup index.

null_blk no longer uses page->private.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Nilay Vaish <nilayvaish@google.com>
---

Notes:
    These patches were written with the help of an AI coding assistant (Gemini).

 drivers/block/null_blk/main.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index e073eca48655..299cf57b1c12 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -961,8 +961,6 @@ static struct nullb_page *__null_lookup_page(struct nullb *nullb,
 
 	xa = is_cache ? &nullb->dev->cache : &nullb->dev->data;
 	t_page = xa_load(xa, idx);
-	WARN_ON(t_page && t_page->page->private != idx);
-
 	if (t_page && (for_write || test_bit(sector_bit, t_page->bitmap)))
 		return t_page;
 
@@ -1000,7 +998,6 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 	t_page = null_alloc_page();
 	if (!t_page)
 		goto out_lock;
-	t_page->page->private = idx;
 
 	/*
 	 * The store has to happen under nullb->lock, where it cannot sleep.
@@ -1026,7 +1023,6 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 	if (cur) {
 		/* Somebody else inserted a page while the lock was dropped. */
 		null_free_page(t_page);
-		WARN_ON(cur->page->private != idx);
 		return cur;
 	}
 	if (!ignore_cache)
@@ -1040,17 +1036,15 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 	return null_lookup_page(nullb, sector, true, ignore_cache);
 }
 
-static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
+static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page,
+				 unsigned long idx)
 {
 	int i;
 	unsigned int offset;
-	u64 idx;
 	struct nullb_page *t_page;
 	void *dst, *src;
 
-	idx = c_page->page->private;
-
-	t_page = null_insert_page(nullb, idx << PAGE_SECTORS_SHIFT, true);
+	t_page = null_insert_page(nullb, (sector_t)idx << PAGE_SECTORS_SHIFT, true);
 
 	__clear_bit(NULLB_PAGE_LOCK, c_page->bitmap);
 	if (test_bit(NULLB_PAGE_FREE, c_page->bitmap)) {
@@ -1092,7 +1086,8 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 {
 	int i, err, nr_pages;
 	struct nullb_page *c_pages[FREE_BATCH], *c_page;
-	unsigned long flushed = 0, one_round, idx;
+	unsigned long c_idx[FREE_BATCH], idx;
+	unsigned long flushed = 0, one_round;
 
 again:
 	if ((nullb->dev->cache_size * 1024 * 1024) >
@@ -1102,8 +1097,9 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 	nr_pages = 0;
 	xa_for_each_start(&nullb->dev->cache, idx, c_page,
 			  nullb->cache_flush_pos) {
-		c_pages[nr_pages++] = c_page;
-		if (nr_pages == FREE_BATCH)
+		c_pages[nr_pages] = c_page;
+		c_idx[nr_pages] = idx;
+		if (++nr_pages == FREE_BATCH)
 			break;
 	}
 	/*
@@ -1111,7 +1107,7 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 	 * avoid race, we don't allow page free
 	 */
 	for (i = 0; i < nr_pages; i++) {
-		nullb->cache_flush_pos = c_pages[i]->page->private;
+		nullb->cache_flush_pos = c_idx[i];
 		/*
 		 * We found the page which is being flushed to disk by other
 		 * threads
@@ -1126,7 +1122,7 @@ static int null_make_cache_space(struct nullb *nullb, unsigned long n)
 	for (i = 0; i < nr_pages; i++) {
 		if (c_pages[i] == NULL)
 			continue;
-		err = null_flush_cache_page(nullb, c_pages[i]);
+		err = null_flush_cache_page(nullb, c_pages[i], c_idx[i]);
 		if (err)
 			return err;
 		one_round++;
-- 
2.56.1.839.g22a8290db9-goog

