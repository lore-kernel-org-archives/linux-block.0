Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EFC2BE05A
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948325; cv=none; b=r5ix6BT2WQA84u0RgrPMHywRUB5yZxaHWp/PnLYBcKMD0pNhAsLO1FJ+3s1O/Q7stBpHio0SCFbVGAWqm6yteUXcdhrPeNO/vNHt/eM79tKRqKyMRdTcbkOfq6XtRZMgC9mVAoGrX2GqQjK3ukvL1LoTvatE2SmWNVbi8X7JnCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948325; c=relaxed/simple;
	bh=qMr1bVSK6brdsAbJBgTYmdPhEJSJ4vqK0Yk38H2rNMM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QKUUW/X0O64nXjpGO145lflyL2Y+O8jaxZb9Ebs73/72k3wU42RUhe6moMPFWf49L2Z9SylDYovDVR771cgcaA/Xh0nuZ1YcSChIFqWJzgXyeCDh2EhgtC46+QJJYKoEJLIuL4R2ZoR0cu9kGF4YYvEiuUQpdF13i+sZubgrtPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qJIdpKn1; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qJIdpKn1"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8200b55dc47so66674247b3.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948323; x=1789553123; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yFQHd4CD2vPDTEJCwRK4KnJHHa5RS0l8x4Ius5m53Xw=;
        b=qJIdpKn1TDNl8g9xLqgYhGyLTBFmZwLT3uxh4xLIzoB6uOXZ/kkb6TCBUi6sGuyltQ
         v+Z3Zv2H16MDHZkRD67zgpNvUxTMXYVsrHpgDheD6iGS6mJYgn6KYYTqakiEnpnBvgtd
         rFGNLbZJq3Z549hPDiaZ2IVFgxtbuSvWkrT7/EmPXP/oUODZbGq8dLOk+2HXp18a2Q/S
         cfxGp7GsdIQTy8bur5gKlM2+NtSyAdXuqQj2J1AUsqyml8eQWrmyQ7n18yLytFBGh0uP
         KCqqbNOELV+f/RDtWz2WBhaYkKkxWjWidVHWY6gN7tgXQoR8KJHAmTqQ1Be9uJqc88/j
         koww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948323; x=1789553123;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yFQHd4CD2vPDTEJCwRK4KnJHHa5RS0l8x4Ius5m53Xw=;
        b=VY5yuaXj+be34CTpLpTRBo0701WRF+mPrt5/SYUXNPylSlPjLBOdLGiVyVBc5MSMMl
         FxcIXl1XzN7ed6VQwLrBWROvzhPK3+O0VyMIMf7SMrkH6fkSM5CLIYxC17j5kpE7pPPD
         Y8lmBArVLrC/tsuW6BQKT4+GxswpRhrcEs3Wxdl1GxlEuqhRskBRAQouyOOapwnJjL53
         hwAKMRbAEthCum7PUb9JPjU81Abpb0xx3eK9bJ6GGPM58OLvVGigbbbaq2z9m025O0tg
         ELdWpuognOhDxMys2bwUE/OnGXKeY88tQa01fOBAAdMHstVkvRFG2lRrvcGKskJ07GD+
         6U0g==
X-Forwarded-Encrypted: i=1; AKwUvBy85MapLzovLiyZCq1nFz21wkjtQ9PLx3y1vDilKzu6RqXMWhX5SV5Gg6YHjWX/NqfoLHVCXKwYj/B6Tw==@vger.kernel.org
X-Gm-Message-State: AFuF++mz2/CX1qahkVp7sQeHwN/zGKZ/5hBL28xHQrr8cYCNUdhzLDbH
	li5IaTgca1jUBsJgaEYfWIJvXR/JBXgQqGOFcqKoIkIL9SbSJ60kCbirlvVxIIfXxw==
X-Gm-Gg: AYBFou1FmtnhhKzR7jiUigIADi+wGFaoduKhaSYNHgnwgYquroU61oBEYFDEZPPrOus
	FMEQkaND/BOW9PsCi+5AMM9ACNYg9PTrNT/5j9P05vFUqBDvwfRHEhzCLZux9aBeRx1iBISfux+
	4LA0Qi7Ugz0VcNFbVKxUxUro0Mk2ePFIRNSD8dg3+bRoH/G+SQu9tzB3xiohlYztLnPYFph75Yc
	xpF6iqfEONCRlDNYAISgieqOjo/991CdosKdbo9qslxXXaIR1MK5mPlCa3GXsftFhwETRN5vsUt
	XToRke96z2Aly1bBSxFfXTcwfCCjSZSqvfQ92EScK3wfitgfMrtpvt1msMXngyLTycEuF4H1p9W
	akKSFKV/8COhtuouP0uShb3DB40RhFGY9ZM5Uk7nMtD8aSAuUm0HGt5QDTQ0iu6oh7iJwMyPVr1
	z+A9gtIoPTFXlbOL6RAoHJTfM3IS+m4//tHoTBo5b3SvifHt1jub54rsuQzFMScl0rYz/ejKEbO
	O7Wafnf5YE01Lx5qr78xPDu/mKbQb6jkKRJA7ZcZsv1ZSFCNMZdlNmARFg=
X-Received: by 2002:a05:690c:88:b0:864:6f4d:ef7f with SMTP id 00721157ae682-87121acbbc5mr139779397b3.7.1788948322156;
        Wed, 09 Sep 2026 03:05:22 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714befac64sm107718397b3.47.2026.09.09.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:05:21 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:05:16 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 12/26] mm/fbatch: remove percpu_pvec_drained and
 folios_put()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <e5f75b23-a65d-85f0-850d-a3c375ef420a@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove the percpu_pvec_drained field from folio_batch, and its only use
in __folio_batch_release(): remove that now pointless lru_add_drain().

Which leaves __folio_batch_release() as an exported name for folios_put()
which is itself just a wrapper for folios_put_refs(): mm/mlock.c and
mm/folio.c don't need such a wrapper, just say folios_put_refs(,NULL).

Or should folios_put() be the export? But __folio_batch_release() is what
drivers/gpu and net/sunrpc are using: don't change them in this series.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/folio_batch.h |  2 --
 include/linux/mm.h          | 18 ------------------
 mm/folio.c                  | 17 +++--------------
 mm/mlock.c                  |  2 +-
 4 files changed, 4 insertions(+), 35 deletions(-)

diff --git a/include/linux/folio_batch.h b/include/linux/folio_batch.h
index e1cc8ae023f1..a3337f70e109 100644
--- a/include/linux/folio_batch.h
+++ b/include/linux/folio_batch.h
@@ -27,7 +27,6 @@ struct folio;
 struct folio_batch {
 	unsigned char nr;
 	unsigned char i;
-	bool percpu_pvec_drained;
 	struct folio *folios[FOLIO_BATCH_SIZE];
 };
 
@@ -41,7 +40,6 @@ static inline void folio_batch_init(struct folio_batch *fbatch)
 {
 	fbatch->nr = 0;
 	fbatch->i = 0;
-	fbatch->percpu_pvec_drained = false;
 }
 
 static inline void folio_batch_reinit(struct folio_batch *fbatch)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..942a9d9ed5c8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2201,24 +2201,6 @@ typedef union {
 
 void release_pages(release_pages_arg, int nr);
 
-/**
- * folios_put - Decrement the reference count on an array of folios.
- * @folios: The folios.
- *
- * Like folio_put(), but for a batch of folios.  This is more efficient
- * than writing the loop yourself as it will optimise the locks which need
- * to be taken if the folios are freed.  The folios batch is returned
- * empty and ready to be reused for another batch; there is no need to
- * reinitialise it.
- *
- * Context: May be called in process or interrupt context, but not in NMI
- * context.  May be called while holding a spinlock.
- */
-static inline void folios_put(struct folio_batch *folios)
-{
-	folios_put_refs(folios, NULL);
-}
-
 static inline void put_page(struct page *page)
 {
 	struct folio *folio = page_folio(page);
diff --git a/mm/folio.c b/mm/folio.c
index 18e97923e527..5021639c5494 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -160,7 +160,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 
 	if (lruvec)
 		lruvec_unlock_irqrestore(lruvec, flags);
-	folios_put(fbatch);
+	folios_put_refs(fbatch, NULL);
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
@@ -1043,22 +1043,11 @@ void release_pages(release_pages_arg arg, int nr)
 EXPORT_SYMBOL(release_pages);
 
 /*
- * The folios which we're about to release may be in the deferred lru-addition
- * queues.  That would prevent them from really being freed right now.  That's
- * OK from a correctness point of view but is inefficient - those folios may be
- * cache-warm and we want to give them back to the page allocator ASAP.
- *
- * So __folio_batch_release() will drain those queues here.
- * folio_batch_move_lru() calls folios_put() directly to avoid
- * mutual recursion.
+ * This used to optimize with a drain before putting: no longer helpful.
  */
 void __folio_batch_release(struct folio_batch *fbatch)
 {
-	if (!fbatch->percpu_pvec_drained) {
-		lru_add_drain();
-		fbatch->percpu_pvec_drained = true;
-	}
-	folios_put(fbatch);
+	folios_put_refs(fbatch, NULL);
 }
 EXPORT_SYMBOL(__folio_batch_release);
 
diff --git a/mm/mlock.c b/mm/mlock.c
index 1050010bbe0b..97134eff6b56 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -191,7 +191,7 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 
 	if (lruvec)
 		lruvec_unlock_irq(lruvec);
-	folios_put(fbatch);
+	folios_put_refs(fbatch, NULL);
 }
 
 void mlock_drain_local(void)
-- 
2.51.0

