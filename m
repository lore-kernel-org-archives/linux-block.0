Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2412F5313
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581000; cv=none; b=LA29UeYzUhZ6Xe6e4L9F2RaoqsnNdsoenmDX/UHHJWJHvCaF6usu+pbz32rM+yj1gemhX1NPlhQCo5JhXvUCdt96pMossrp+HSEbSD5niQQzNa8J/NOmlC8n9pN6EbObU/dXaVJXHtVDsQtFcRHe6AMbjL1R94gywwWvV+Z31Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581000; c=relaxed/simple;
	bh=QniatQlrXg10kLiLZvm0JWLrvxMekaoyIeWxGsqqyx4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VUiVHiHNmjMDnuzSbBAOkw9ZPafePuGnyS6BR36JDziGu8VhVLYCHgItyQXSZ7rhdFCLxhnkp0D8W+d8z/OIX0y0Mo4QnHiDwsepYTe4kd9VVRf3lWwJCMECG3/JZusSVZ6TME++zAzEmXC/cBNRidyex0aUtNAEEMOQSYJORNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HZdUIPxT; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HZdUIPxT"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c4474028so40785397b3.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787580997; x=1788185797; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vRQTGUT/r/6sjQRYrNEkhtszeIpWm9eC3zYKRwiMzSE=;
        b=HZdUIPxTkwxFQa4RpZvCl6gyLZYQw97I5pgVbLbpwnIz9HUpD78bFxBcdtU2Ou7v/a
         inh9csPo7IuQeVlDn9VnkQe1hsxTf19J0cz3fYhQinK4rkS6aXHMi4GZo9co5DeM7lDU
         19HSW/qV/duNgmO3lz5+xtDnTR1t8WLBcAEklnG3q/ujAsJnhHuWRbIkgNF8njMbQ+kv
         /3N8u1a1otYGBD8t7LnYA2sYGWhDUJKE9poajleKk0YUgT8isZH5R8wZUR8KzxWglbGO
         dvDtg1S/Z75k/M/PZY922QTXl1FomDedf/vp57R8ltaKEz+Hadzi5SEuZmyP9MZePq//
         AEbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787580997; x=1788185797;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRQTGUT/r/6sjQRYrNEkhtszeIpWm9eC3zYKRwiMzSE=;
        b=Tc7odJQjkMPyN/aheSh3nS1yfrBrHatt7+oBRIRgDd9IXmU0vTKmwPreuc/IH5bpba
         FNIieUdZ4RnFhajCQMypXcXLFyn1yDaY2pCgpcDVa73eDHtIlp8hW+cS7kjHKRX6lYDp
         zTWTTqEiIPSnoZkYRTtMoMrweolzOE0zh9KHudCUZJhuTCTKZSpOQJ1vqQkrUmUeWiQI
         lNrhfM0L8shwnpCn2EIxdWxlBRuDQEuE/aznHACwmgx37Y7GVPijFddf0ePGj7Tk9Ffw
         dRYmpils928aHba1f/oWXCRe0kPhHUDHL6ldLF1sJCqsmvQfFVUdfo5OwVPlips/frup
         4AdQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro+Q6qGNjmFsTQH/BQQsqQaPGmQM0UzdFeZ4eU/1/vaJg7eaH0yLnifqSOw7o+rXZnrFIOb+vHXN5uxpg==@vger.kernel.org
X-Gm-Message-State: AFuF++lnmoRdg1vDxWK1MtROwFjT7iXbh4w1PxMqwXLqUvjJVS2VKise
	9c7wjz4Vp5TO6w85c3TCR6YU5ekzZDahUlE7g5yfe9Cj6+fnhy/um7seWRpXrBi9wg==
X-Gm-Gg: AR+sD13Yn+oyyhVd78IRLrjbolf0R2bOWTBL/QLt9L+yEB0+XeV7ETqJkwF2enwgYk0
	Cz7wWaeLOWnfW3TiJW+aH714GnLC76iBLTR4ZrizugwxvQp9QGUOqZLuP9g26bmFxlIqyPw6jwk
	bXXBJ1YY2TbZhTuAK8jGQIazIOcNpE7EprmqCSdbYK1HBE4vW1vtZS2V5ko2Aeogfx7+naVPUn/
	3rN7m3sBRZsMbVuejJtgMmGz1XzPz2r7Mj2LmVdJbWbHEOIY5lfEGMhFKYv2BS1+X48AzHsMM6z
	dnbTUN0CDnVXTROX6a9/TF0U+FHts1tnt4XVvqYqaNHXsj5ofImYXP5Ld8Rhi9fJkMU9dZoDj03
	PNeA4hcbl7hlJZwxKuj59tVAdNK2Kr6Jo5yMO1yzRmE31lUfD6qCUL9UGpEdLrgysoc5WpnZR+G
	yb62oaF7tTTpuUXzrbVQZ/AHiJKmz+D8XOZ2yPx+NrUBkJjoHDT2cXT8rc2DoJeifxeVVx0rKIN
	Pzjwv+mdVCITUMEAXkBWE5raVloQpfUHiSxx62tmLPV725a
X-Received: by 2002:a05:690c:568a:20b0:844:9f61:92d9 with SMTP id 00721157ae682-849f67acaa8mr75561237b3.17.1787580996861;
        Mon, 24 Aug 2026 07:16:36 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-851e1419e0bsm11879757b3.26.2026.08.24.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:16:35 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:16:30 -0700 (PDT)
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
Subject: [PATCH 10/25] mm/fbatch: remove several uses of
 mlock_drain_local()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <b0a8293a-3a4d-49ea-f902-e6a2a20e5da6@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove several uses of mlock_drain_local(): they were workarounds for
when that sequence of operations tended to leave folios in mlock_fbatch
with debilitating raised refcount (and no good if the task changed CPU).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/huge_memory.c | 2 --
 mm/migrate.c     | 2 --
 mm/rmap.c        | 4 ----
 3 files changed, 8 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7bd99592195..df6bf69a066b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3568,8 +3568,6 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
 	zap_deposited_table(mm, pmdp);
 	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
-	if (vma->vm_flags & VM_LOCKED)
-		mlock_drain_local();
 	folio_put(folio);
 
 	return true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 8aaafcea7bc1..6b71b2415d00 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -448,8 +448,6 @@ static bool remove_migration_pte(struct folio *folio,
 				folio_add_file_rmap_pte(folio, new, vma);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
-		if (READ_ONCE(vma->vm_flags) & VM_LOCKED)
-			mlock_drain_local();
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
 					   compound_order(new));
diff --git a/mm/rmap.c b/mm/rmap.c
index 1f72d279ba68..e76823ec4d5e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2390,8 +2390,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 finish_unmap:
 		folio_remove_rmap_ptes(folio, page, nr_pages, vma);
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
 		folio_put_refs(folio, nr_pages);
 
 		/*
@@ -2765,8 +2763,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		else
 			folio_remove_rmap_pte(folio, subpage, vma);
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
 		folio_put(folio);
 	}
 
-- 
2.51.0

