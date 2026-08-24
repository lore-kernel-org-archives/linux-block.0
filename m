Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED38437861
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580242; cv=none; b=AvdjnDI7iiDMQSmNLrbBmdhRO+bMmhwvKCI/2HezaDlLRm/3EoIiPBxWXDRJsdiOWupzyCkpKN61Zr50RJlXb9UHrsyC/67mll2fAMFJ5/IPMFnTF51ARcky0dKOv72HSQUuEMID4He2PGLwjuIFwSGcVUQr7X04z5wjkuFp/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580242; c=relaxed/simple;
	bh=LN4S+uhNeXEkUev4MtTwRUrSM4Q5tR/xe+5lbgofppg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fLAg7Ulhz0oL4OLr0MM2PwTjAEKIJubFBiO1omBQEqGDj3qzayO3n9eSdNquqOAQjxaHgoPZaJ4uWSAYED/cjdPlKttkqTLv5H55Msyw8p5CD+R8F49fsS3s8Xt62Vne8hkYipw06TT1gOtFGLYJ/2LLa/ARXJmpo+eMZPjS+xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rtl52Ag6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rtl52Ag6"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-81ea0b7d137so30131517b3.2
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787580240; x=1788185040; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gLqnUltfGMwKBemLbA/06+FuqdHtLjtQ/H9OD8DkJLA=;
        b=rtl52Ag6X87b4zggXTJD7rgDtSYz03nSHK2+Pnjivk9XsTrG/xr0dPmc00ofbZztON
         G6/piNskoQTvXOwyCzz2tTj1fcti2eCb3O/cKFy5ejNiy/nZspB4YvWAf7ad7c1GbCx3
         8Vxd3w/SWRN9LlPKXU70AdbcYilK3QfI9rtujvxBb96jDNmSNgrbbecDXiIdROQTVOW1
         GzDdjcg48xiPXr/AKK1YS2VMOJ01t5Z8qMiMb496nMlIpIJYFFB+Pt8l/iiMXhommpWQ
         fa6ZCXVE1OwyXsL5fcId8kProLFoFo9xNuM9Qtd5EE2JLDfMHQn9cEeAXo1bN6wAY1nR
         b/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580240; x=1788185040;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gLqnUltfGMwKBemLbA/06+FuqdHtLjtQ/H9OD8DkJLA=;
        b=Qkpwnk7g10EFHG5Q6d+KenYb+BNkgEAkq73aNFoaql7uyVeFBZ1i6lyIOyYHjleV+F
         1WQC6PdamwdhSshoATxOC15bEhTam+t8NESuyQr/sQ7CZ52Wjf8jpt/QlymZiWiUQgNI
         zve/RrXoign9GmhY57kPV/6sgH0F10kY7KG60vS4kfV4SKIOgDAhcvPYxO/SDoNczTgB
         K4mEl8JNQPRdciqGcPU5yXoQKZuhxzeDkdDjG1RBfK30olbR4fe16NfkyyognKc9dJIy
         Tyc7tGNyofaar94tvKaXNdHB9O2B5mj3iqkfJdd+wkJJI12Dn0W5b/a1J9IMqg2ZRFgZ
         VMFg==
X-Forwarded-Encrypted: i=1; AHgh+Rq3wyTpuetRBMQKKC7A4i5KKWSnud62cmvIWl1KCrvPj8zRA0ctLDiH6Ghy4EiiVEKaefCSxthqIdHwxA==@vger.kernel.org
X-Gm-Message-State: AFuF++m5YMMn2FCb2ymBrt6So7UNsOljI4GPpgZTF1gYl8DiEg25UQU5
	ascJT4I1bdVMYFTFd5cdeyewH4zUvAHQKIMzj3jM4fs2/FthSch3DF7MYKYjJar9+Q==
X-Gm-Gg: AR+sD128iVSRovZtWYXZQNTFJsRoRPgbqjOkT0o2/bHx0JWErbAGRiQLMe7wvHfCXFo
	U8fjrWFgYf58dd7keNTyAxTXFigQv+iMI1O5fyMAaceYG/WPYjdcynKIPupiZInv6p4cJPur698
	NVsjBEaN+NCKLyXJYxzDEO9Rh19PFVEBvLzyyfIwi7pqWYOdyOvxSJvH3VUMcC4dMt+eWHf5fZ8
	/IC983HxVWtEcki+olLq/ACCp/TDx9VVuzxSE1wtH7FL5plxsU5t7MrpKfy3AvWe3BkpZ/EOA/j
	xFCbeAuAckHL7yfsjIxKwhBXf+lh7VDDclKv/lKowDmiSGLR2W3eurgY6h0qUgXm5jGr9ZpDjm2
	az8HYu7hi1awOcgX20nmOWQFNhevYWKj79VyS6zw8L0iUgh1H+13lq26FZsnbAO+FFcRleQ16d/
	jAGkwgiZzTGFGGyF7DCepdoGUY+AnhERewbbIjZQXtMxnHYLQOKRFZabeKTfcL2/59xpWZrLzzg
	h6Q9fnlElyrDn2wUjU1BGi5TXDVGodAisO7qUdIJIV+vRrj
X-Received: by 2002:a05:690c:6004:b0:822:854d:4563 with SMTP id 00721157ae682-84c9682009cmr74201097b3.8.1787580237568;
        Mon, 24 Aug 2026 07:03:57 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cab851290sm33478997b3.35.2026.08.24.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:03:56 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:03:52 -0700 (PDT)
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
Subject: [PATCH 05/25] mm/fbatch: lru_add_del_folio()+folio_add_lru() after
 clear_lru()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <9c538ff2-7150-1021-df1e-fbc10f0bb92a@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Most callers of folio_test_clear_lru() then proceed to remove the folio
from its lru, and add it back at the end when they're done (if still in
use). But isolate_migratepages_block() and check_move_unevictable_pages()
sometimes decide against, and release immediately with a folio_set_lru().

Which usually works fine: but there's now a small chance that while they
held the folio with lru bit cleared, an lru_add fbatch drain came along,
and had to skip that folio because its lru bit was transiently cleared
(previously, the lru_add fbatch drain relied on finding lru bit never yet
set). This risks leaving that folio off lru, unreclaimable until freed.

Fix such cases by trying lru_add_del_folio() (which only takes action and
returns true if the folio was on an lru_add fbatch), then folio_add_lru()
if it succeeded: invalidating the old fbatch slot, appending in a new one.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/compaction.c | 13 +++++++++++--
 mm/vmscan.c     | 16 +++++++++-------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index a049415512c6..9e045a90ba21 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1204,7 +1204,13 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 				     !cc->alloc_contig)) {
 				low_pfn += folio_nr_pages(folio) - 1;
 				nr_scanned += folio_nr_pages(folio) - 1;
-				folio_set_lru(folio);
+				if (lru_add_del_folio(folio)) {
+					lruvec_unlock_irqrestore(locked, flags);
+					folio_add_lru(folio);
+					locked = NULL;
+				} else {
+					folio_set_lru(folio);
+				}
 				goto isolate_fail_put;
 			}
 		}
@@ -1293,7 +1299,10 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	if (locked)
 		lruvec_unlock_irqrestore(locked, flags);
 	if (folio) {
-		folio_set_lru(folio);
+		if (lru_add_del_folio(folio))
+			folio_add_lru(folio);
+		else
+			folio_set_lru(folio);
 		folio_put(folio);
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4ca9775ceee8..7da12ffbd3bd 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -8021,17 +8021,19 @@ void check_move_unevictable_folios(struct folio_batch *fbatch)
 			folio_clear_unevictable(folio);
 			lruvec_add_folio(lruvec, folio);
 			pgrescued += nr_pages;
+		} else if (lru_add_del_folio(folio)) {
+			lruvec_unlock_irq(lruvec);
+			folio_add_lru(folio);
+			lruvec = NULL;
 		}
-		folio_set_lru(folio);
+		if (lruvec)
+			folio_set_lru(folio);
 	}
 
-	if (lruvec) {
-		__count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
-		__count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
+	if (lruvec)
 		lruvec_unlock_irq(lruvec);
-	} else if (pgscanned) {
-		count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
-	}
+	count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
+	count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
 }
 EXPORT_SYMBOL_GPL(check_move_unevictable_folios);
 
-- 
2.51.0

