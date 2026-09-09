Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67A849891E
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948096; cv=none; b=YKslgGUfNMKcHErNSqWnh6aYKflBNNU/HfqEVKjh1E2K+bTF0V7aVvpThdvy/KpzjLcjo3gVZ1cHvnHTK2OF6N3S6166P42tZ2LCSKHleW0KK2t7oOJ3s/mnhlVyk666WEMAFkpr4LmeXB0HB7QnfKzV+AvWhwBj8GjavOg7gLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948096; c=relaxed/simple;
	bh=XRPintYB66K90WWvosFbfNFMrCSstXNSaa8RFhDin48=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Mds4pFZYqrqURru2vgFZajtwF4OlkFr8re4fKPJLN6Q5CPq8SjPIkY5fT4mDAUTB6OpNtyAhctAdD9yAYwsaE6ypLVe1QUSBe+GGOMQGvXy8Jhrt3MuMTMlz3panaTIEqMGvCORMTsIO7zH2kPW+4DP1YakXvwWvUofIPuT5slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=miXBoVtX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miXBoVtX"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8200b55dc47so66616607b3.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948094; x=1789552894; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uNBljcBd5pVR40/qSQbRzR+DUQkxJ6419XWxuVBt6mg=;
        b=miXBoVtXzB81K9/BBn4QUKvPEx38fEiF5IeyhcQRQExOJduKdwjtIQtB9j3uLPNiBt
         7v4vgDOjRjQb+HpVMnN8hiN8s39k1BnbDCj1TKoKL4j9537O5cwYrRs3d2Db/1QTnTlD
         hP2ES713C96NJQARCB8pKpx58vfhEGCYFmv3/+EvZ/LQCFKqmBbgjZIWrfqXF8tVfmPh
         ALdvIj0c6FmMyzFkonnJhgNubX91O2aOTD6k27lRMygmAko1UKmPgfmkAEVCQbDedq24
         er+Cx2GYbKDMXrJimC/la1c4vLXli/Wj1NmM7n9b6lTvfZaPE1N7As8GRb/g/tOEdvyN
         OXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948094; x=1789552894;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uNBljcBd5pVR40/qSQbRzR+DUQkxJ6419XWxuVBt6mg=;
        b=npMFOr4A3s9WaP+Fxpe1YlXfZ/H3JDKbEBW6cbaamKwOJwEGKeojSz5Mrbx2L4hp+0
         ELwkulcLrGxKkYLxG5qF18mNSYqVGgh3Vih4t6kdjYFlblYA4EDEuhUdqnXn1IRm4b0D
         s4uAJvPl22eI+MmEiI9Ic0M+S+bBCI23cF1+RDaSvjDk3N6NdnEAXxqebJ4P5LBZqEDV
         wa3hG3ThDMCGwFZGzsW1KtWgg/SNQpN6tzgtbNBQnQNPcxNEvyxyMiNT1Z0G59UZiw9/
         Ejr1m1VmdSkxKno85EI+Vg6WhrzwIwMJxu4/x2jq+Uetcnr6nt2emqv6ALXF0jfXqrtg
         iXVw==
X-Forwarded-Encrypted: i=1; AKwUvBwvASv+KEVkTieLcxMU154nchwbIeFFy+HgSkLtSv20scj+5xTzN10p0sVoKw+aQBgFROF47BAFnfLNxA==@vger.kernel.org
X-Gm-Message-State: AFuF++mVAeEFpjBCSYbyC2HGC+0S0MEsbFG80HqPL/MKmFLKNRl2v3g1
	DaeCF8JacbCb+rZFPxgtQrURTw6wLtIO+1SeEksyVaIxPQAsvBthKsxTCTTPNFHUTA==
X-Gm-Gg: AYBFou1nKOos4v8z9taa1zMNbBeukOK+HaQHRDOnKFTE0z7MUN4AsIlpQE5nEkpGd1R
	Sgxdaq3C967Kz83ttnwnDQDddVkhg3rAjHEEf1mt00Mv9J3uu8NysJEKsohOfa0K64nb+9GRQDt
	c+tmlZrB08AHW2q9tJZuR4wq/+atQiGXd62PXOegoVrFE6Rxva4jlnq9uhckTtkbR1X2UOYMzVb
	/AWp3WUYJX1PBBnH0QFCWVaQqfbPXDNIZCI5mdNR0IwYq3iGP/MuW9HBdWtpr8slDvEnX7w/MMS
	G9Ktek7VedNB+kWMU0ipIJLmYAfvgEGBQwdXJabgNahjR+h+tPKmjgC1CuqTnz3CrRn/faZv+c4
	cMiBD3yuaSKwDvvSFMkEi/Wq/lQWC8aEgOA71eAyGdbprt046PlvBFwz4eiz/SjbuMJw9v7E0tN
	CNYjNaWQi/IjK5HUbkYg87EmqTN3YTz9LEjrUKxREmI0d4LQTivH2XksSfetGvojnJIKv/ZYzJT
	kyBi1fSYRP+LMAslWK2VPwgxlTIg9COjWhUGpv46ddTUx43bww0xLXIK2Q=
X-Received: by 2002:a05:690c:88:b0:864:6f4d:ef7f with SMTP id 00721157ae682-87121acbbc5mr139590577b3.7.1788948088169;
        Wed, 09 Sep 2026 03:01:28 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a0b654dsm107264887b3.25.2026.09.09.03.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:01:26 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:01:22 -0700 (PDT)
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
Subject: [PATCH v2 10/26] mm/fbatch: remove several uses of
 mlock_drain_local()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <9633684f-e5c4-d92b-8295-5cccaa18fc36@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
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
index d53e5443b802..3628b5bd1359 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3570,8 +3570,6 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
 	zap_deposited_table(mm, pmdp);
 	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
-	if (vma->vm_flags & VM_LOCKED)
-		mlock_drain_local();
 	folio_put(folio);
 
 	return true;
diff --git a/mm/migrate.c b/mm/migrate.c
index 15b45832bcfa..1939d6ed19c9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -447,8 +447,6 @@ static bool remove_migration_pte(struct folio *folio,
 				folio_add_file_rmap_pte(folio, new, vma);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
-		if (READ_ONCE(vma->vm_flags) & VM_LOCKED)
-			mlock_drain_local();
 
 		trace_remove_migration_pte(pvmw.address, pte_val(pte),
 					   compound_order(new));
diff --git a/mm/rmap.c b/mm/rmap.c
index d1819fd69938..1ee42d60d77d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2396,8 +2396,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 finish_unmap:
 		folio_remove_rmap_ptes(folio, page, nr_pages, vma);
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
 		folio_put_refs(folio, nr_pages);
 
 		/*
@@ -2771,8 +2769,6 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 			hugetlb_remove_rmap(folio);
 		else
 			folio_remove_rmap_pte(folio, subpage, vma);
-		if (vma->vm_flags & VM_LOCKED)
-			mlock_drain_local();
 		folio_put(folio);
 	}
 
-- 
2.51.0

