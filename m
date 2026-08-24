Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EC64307B0
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579572; cv=none; b=JD+Uy0k+jsAP1Jy1YjKq5/rueh91wAgtbA0rb3xbStD78jxrHQ4eWNti3KrC/WM8hPzXC+VjFUM0tdiaRoLRQI3vXgpKBQ7jb8DlaMnSBhc4G/tvOguGonMc/sjfXcsi0wsCi64GVwl8uZw1VPgYWuM/E0pDMWyymrTiv4Srjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579572; c=relaxed/simple;
	bh=INQpY4vkmtPsJDoCs8IyTHaF6Ew7wSWtqA9unZfAs40=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bJgTfjnQBRON9Bb0S1aeZVcH2Di4gMR66R7y4IaLPW9AeyJpu7bil1/yrULhrd262Zb/FjVUcBccPlXF1yjqwcrpPHkivVl2w7Nw0drGDMzfCcTU/7T2CTV9owkg2zEgy6IS1WSWG3lWCW3ypXC/SeEjxLl+IqumnDcRafCBTt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8E5GvDn; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8E5GvDn"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66c744a00edso2118784d50.2
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787579570; x=1788184370; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n94V7wbjjjBLybhmkw6p8j8STOH0bCJCKxuuQhNVBOI=;
        b=I8E5GvDnAjikFhlI7R0RJ/jJBZcFW2jG9OJ4h1HGJb0aPinmiz21qlY0x2kEaGJJjR
         gj6Nb+nQ+TfyOUJdaWEsZoW+yew66t8vea09M2BbGs/Ee6EPPatIVYvL4UtSera+WJ5f
         v37OYzhw/ml2U/C7Big+Mh8SvT7YU3a2LdoSH/zTpNAg7mI9uJVu6issIcln2lTzhwyc
         sCpgqRVu2s5P3dzzH1WXWLBJFxewQEX7gkyb2fa213s8QaR6jtxlh9Z2kUVpSlvxKThM
         GYTs+uejwhbNlcYvj9I2RxnhSdLLjpIGGUgX7uVJUCgleeTb0RfUTlqkb2odQYobzJis
         bdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787579570; x=1788184370;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n94V7wbjjjBLybhmkw6p8j8STOH0bCJCKxuuQhNVBOI=;
        b=Ll2djiNUJyJ/ywBYe5XblAFxDMF+rpkcfkQ6v+SfSR7uQ2W3dk7+U5ivNv44CvHuHB
         dcq3QLEOmmiVwpuGJ36Ky3nYKAre8SsBbLd+nkM5os/KIF5CB8CkBe+Y19ZQJqPSPfoi
         x8zfuShaQ92qv0bpZOF+DTuOqgFVBUE4oKH01ErcUyN3yDjcyhZ4CFhjsELrCrnPMuzS
         83zOar+H7CktX6vPsUK5QuiVjPelZ7G5MCcQSVH16Z1SNcIFghdwnL1fkopwSMuChQ8u
         /54+eYeUF/ZFmxrdbzD5Ng32MG8xft19oMULgo+LWerkhgoBQB51wadFn+R5bOMUL4PP
         hwrQ==
X-Forwarded-Encrypted: i=1; AHgh+RrYqWqbNy2GCkNiNjah9qD6MWhL62wN7/rFhTcSoFdXyCgK6fpMWwp0UdX721mBnDudPiG+dNDcG6U3Fg==@vger.kernel.org
X-Gm-Message-State: AFuF++nZKievLT6nqU+gKhrUSvvyKd+kH1bK4Ab2bTHZSxtOOoeLJttu
	KjzYReqtjWib4xfK2gTt6NUFtAh+nLB4yyXJdh+Q51aQYSyzq1CFmxgwpf0kRti/SA==
X-Gm-Gg: AR+sD13HdPB5d66O/ah+lKUhr9K6Wnl6ONcJSskuhMPE2VaOansFE6tJEwrTGukNXja
	6C/VnC+o7EKaoEGiQHjd/PpWBuaoMckANKnpWEL83HBdFl2ha6SrPgUtyAd4BN32ni5waFlhZmu
	qF7Hbszbs6wvpFh7GatQTrPkV8YAcL7XZQtLo3VzB7HlclqwysbOwFk/9BfGz8EjRxHL0UzQvJ/
	4byl///2J3/RjHGbZ74xcrbPDTaHFXlanU5ZiCIszA27C8xlKRznerMtVFXOT5ld8u29b6hHRa2
	4719RzksxQzSMtbhZNwpSV+oUBRo0W+unjBJQHN5OYvlyBj9TPhKLtzq5sNU5+pyzDD9q1Xhbzq
	PJ1kwVJ2Zy4vowfkZZsmUCWpd6w1Z+A+lHtO7X4pnTE7Uaru7i+B8mhHHh0M1/GG8UBqwa6lGEd
	XxxAwMXNF0ilCBTyRinZUbF9EjvZBZIl3Aqs/8I1ZgF4lKCShtO9iQ2BZMJYKCf4rGW5GZ4w1tJ
	LFWC6fzirew2L1qiwIqJ1JZytagcxzeSfj18a9KlXJRTl+Oo8UiN2QoDj1RYFHg35ImV7A=
X-Received: by 2002:a53:cdcf:0:b0:667:b314:aea4 with SMTP id 956f58d0204a3-66ce4a56db4mr7162361d50.16.1787579567501;
        Mon, 24 Aug 2026 06:52:47 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf4624f47sm3724257d50.4.2026.08.24.06.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:52:46 -0700 (PDT)
Date: Mon, 24 Aug 2026 06:52:41 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
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
Subject: [PATCH 01/25] mm/fbatch: remove !CONFIG_SMP special case of
 folio_activate()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <3f18ab7d-c12a-d2a3-4d3e-f9908f94f27d@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

3.0 commit eb709b0d062e ("mm: batch activate_page() to reduce lock
contention") brought in an ifdef CONFIG_SMP around activate batching:
https://lore.kernel.org/linux-mm/20100805140755.501af8a7.akpm@linux-foundation.org/
shows a sensitivity to bloat that day, not any incompatibility with UP.

No other batching here has a UP alternative, and it's a bit confusing:
simplify mm/folio.c a little by removing it now.

Certainly we can reduce UP bloat (and/or 32-bit bloat) by, say, lowering
FOLIO_BATCH_SIZE from 31: traditionally 16, 14, 15, then raised to 31 by
6.9 commit 9cecde80aae0 ("mm: increase folio batch size"); or by giving
just the static per-cpu folio batches a type of their own with a smaller
array size on UP (1? or a little batching worthwhile even on UP?). But
not right now, it's orthogonal to this series.

And I suspect that the old ifdef led to lru_activate being placed last,
whereas it's usually the second most popular fbatch: move it there, to
match cpu_needs_drain() comment "Check these in order of likelihood that
they're not zero".

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/folio.c | 40 ++++++----------------------------------
 1 file changed, 6 insertions(+), 34 deletions(-)

diff --git a/mm/folio.c b/mm/folio.c
index d2937600cf72..62b96c9ce19e 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -47,12 +47,10 @@ struct cpu_fbatches {
 	 */
 	local_lock_t lock;
 	struct folio_batch lru_add;
+	struct folio_batch lru_activate;
 	struct folio_batch lru_deactivate_file;
 	struct folio_batch lru_deactivate;
 	struct folio_batch lru_lazyfree;
-#ifdef CONFIG_SMP
-	struct folio_batch lru_activate;
-#endif
 	/* Protecting the following batches which require disabling interrupts */
 	local_lock_t lock_irq;
 	struct folio_batch lru_move_tail;
@@ -349,15 +347,6 @@ static void lru_activate(struct lruvec *lruvec, struct folio *folio)
 	count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
 }
 
-#ifdef CONFIG_SMP
-static void folio_activate_drain(int cpu)
-{
-	struct folio_batch *fbatch = &per_cpu(cpu_fbatches.lru_activate, cpu);
-
-	if (folio_batch_count(fbatch))
-		folio_batch_move_lru(fbatch, lru_activate);
-}
-
 void folio_activate(struct folio *folio)
 {
 	if (folio_test_active(folio) || folio_test_unevictable(folio) ||
@@ -367,25 +356,6 @@ void folio_activate(struct folio *folio)
 	folio_batch_add_and_move(folio, lru_activate);
 }
 
-#else
-static inline void folio_activate_drain(int cpu)
-{
-}
-
-void folio_activate(struct folio *folio)
-{
-	struct lruvec *lruvec;
-
-	if (!folio_test_clear_lru(folio))
-		return;
-
-	lruvec = folio_lruvec_lock_irq(folio);
-	lru_activate(lruvec, folio);
-	lruvec_unlock_irq(lruvec);
-	folio_set_lru(folio);
-}
-#endif
-
 static void __lru_cache_activate_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
@@ -694,6 +664,10 @@ void lru_add_drain_cpu(int cpu)
 		trace_mm_lru_add_drain_tp(cpu, nr_folios);
 	}
 
+	fbatch = &fbatches->lru_activate;
+	if (folio_batch_count(fbatch))
+		folio_batch_move_lru(fbatch, lru_activate);
+
 	fbatch = &fbatches->lru_move_tail;
 	/* Disabling interrupts below acts as a compiler barrier. */
 	if (data_race(folio_batch_count(fbatch))) {
@@ -716,8 +690,6 @@ void lru_add_drain_cpu(int cpu)
 	fbatch = &fbatches->lru_lazyfree;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_lazyfree);
-
-	folio_activate_drain(cpu);
 }
 
 /**
@@ -825,11 +797,11 @@ static bool cpu_needs_drain(unsigned int cpu)
 
 	/* Check these in order of likelihood that they're not zero */
 	return data_race(folio_batch_count(&fbatches->lru_add) ||
+			 folio_batch_count(&fbatches->lru_activate) ||
 			 folio_batch_count(&fbatches->lru_move_tail) ||
 			 folio_batch_count(&fbatches->lru_deactivate_file) ||
 			 folio_batch_count(&fbatches->lru_deactivate) ||
 			 folio_batch_count(&fbatches->lru_lazyfree) ||
-			 folio_batch_count(&fbatches->lru_activate) ||
 			 need_mlock_drain(cpu)) ||
 		has_bh_in_lru(cpu, NULL);
 }
-- 
2.51.0

