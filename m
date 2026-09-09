Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D0C3E4C95
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948868; cv=none; b=homsB1kubn0aRrSNUnDw8Z7I3wxW1cG6Fw1ftjYs1Ru2lRSZ8Ur/bhEnJmiU5bQstC4HsRnWg1uNqDtV4fLiO2UtxAkQLri0+hal1coMsV38XBOIS3Lk+H6qjjlk1Aq4zPap9nIFxif1vFxSHodVqIoh6iGYUfM5gZWxQkaPKac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948868; c=relaxed/simple;
	bh=iYBl1TBcq8XbAN5lWXQ5xeG2cPfd6X78ZvXFz11jkXE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K2zBdioKAQJB2SfmIf13mEnHKj9fsb6205cJ7MfhqPN18c5X83cLte4f4/PVdQXxvDPT2P8sOrmZio2w8YThHPB7kId3KkDXerkhCpQdL9yco4wtcrYmd1UkOCpOY+zNl9EG1yRcf2zxieSSabFttABzCV9ilgyOAmybTwIbf/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PRYPqwdZ; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRYPqwdZ"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-66f7f62e915so6288260d50.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788948858; x=1789553658; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cx1TfB9GnW58nOxDn37ATPgkJR6erGAjBm2BqNqkY28=;
        b=PRYPqwdZUo/IB9RDXendGZtCja/iYJ1a6PM7GvuYIFcVs73+Aq2REekIyiRl7fjjAk
         LRp04gPqNFcbyURy/5NcHJapf/ediVuCV9FJ1gJom6LcsEPMy9CDFhkqZ8YDn8ZOT1Ha
         x4O5p+TtNQEe1tpXqurl4XGFaXkVfFZhpr/nW/5B/zHmkgqGY/bx0ycLpnRgdmH7gU0q
         KPRfakb0o+JxLzBDZeilT8v9QkXEYKrAImhMZJKQUmLO1sKS50VNsZuJAQNQ3jAtlJZF
         /hj5X3ycMERjXWMG5IKdk6DNw5Vm752upXAONuac2+tmtxbZxrS+V6RMe0RLe8rdCk66
         7aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788948858; x=1789553658;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cx1TfB9GnW58nOxDn37ATPgkJR6erGAjBm2BqNqkY28=;
        b=n4w20+V8Ikflm9XoN1MsuwPHj566ekvL/edCcXe2E2stxLnyA+CU0ZV2RmFGFUjK+i
         PvQ0xaTfr7Ea1RZ1NodhWrjcKLRZcigv0osnuud+m0AF+LhmAq/xwYSWcEkGOEWiG0RD
         FtpKdeo3IbdgoWo815kiSZFDahFImeaZ4MjpUiPWIRvjxB3Av9dC33jPxibjRr4fTwCy
         58aHW4p6F7aAFq0IhODA+LZa3iuxbdX+MuGfA7SnGbKZPvvhFloBvUNAUXJ5lti5BdQw
         5OPEf9RNnQj3w+jTH/iDojPC+E+U5itWvFE3uMrx2NWzWeW8xTqVK7Ma+Ahyzs6AR11O
         DiIA==
X-Forwarded-Encrypted: i=1; AKwUvBwayLDOep/B3KUqqXOHcMutHGZBQEOYsvpLuoGOMg+2Do7wamFr0nG/XGmMB8YRz+/2xbqlCxm9Kn1upg==@vger.kernel.org
X-Gm-Message-State: AFuF++lgrpEQ3NH7R9cXsM6Cj++zD79Si838H6K1RCvKlm6WZZAZy2KZ
	tPf8oLmGAMVbYAa7TLrogZZPggR4s7dOyxx2diu0lmsw446U6puzuRu3tU+q1WOmug==
X-Gm-Gg: AYBFou2l3fV8GStgGGMLQ+/FdJ8+iEiUxhUTjp/ljsbbvXmVduqHdiNdI/u+Hrjjpsj
	zULwIQbgfNEuAjfC1Mc6fTYwACx/9T5Bm9oOx8ry4Lybv5Pd3lsHsKKFzMMWpUXHaLG9bj+tFzv
	Vc/0ZaLot7g4AsiAp0kE1i1EnZGqMA8BNsdA9Qdv5sbiNKJ8YZMqREpAPfGhtL1EH/cLH5Q2FbX
	lD1pV3fkRaS2xncqQES2xkxnkWHUXc8gsJvC5vKR8aGtXb7zUPp62Es5OZzOEYlKplvVlLlbkyS
	aZLB/ksEWbaMgb5S+U3cRb6NU4QZqAZ5nE7JIYw+1I77uFz8kBsMM1gvpauzyIAh9J9T+10wXhd
	gniEsAoKMPtof71pQDHF+Mu6SMs31TnaSGNcAfjLSo0orA40FwdMC5YK6y6U2Q36HNRTYTZfea0
	+vx+5fypBrxOy6iWL3eYR2k6dUdhN1R/2saeLXq4pSfFLpaTu/zqFMDuSMbght7+Blm/0EUXlZm
	IiIDXm0w+eK2Zumb1ztA3lO6+HJr+0F8anB1vZGK12WGW3anhbRQy+NEko=
X-Received: by 2002:a05:690e:4513:10b0:670:f6e8:1f8c with SMTP id 956f58d0204a3-670f6e87f07mr2998845d50.84.1788948857514;
        Wed, 09 Sep 2026 03:14:17 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb47a8894sm12066216d50.1.2026.09.09.03.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:14:16 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:14:11 -0700 (PDT)
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
Subject: [PATCH v2 16/26] mm/fbatch: remove lru_cache_disable() from NUMA
 folio migration
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <bc903047-0dad-902d-5774-ecf73c6dd343@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Remove lru_cache_disable() from mbind(MOVE), migrate_pages and move_pages
syscall handling. They do not now benefit from lru_add_drain_all() first;
they gain little benefit from invalidating buffer head LRUs first, since
5.0 commit 80409c65e2c6 ("mm: migrate: make buffer_migrate_page_norefs()
actually succeed"); and it's a shame that (even without CAP_SYS_NICE)
they can prevent concurrent tasks from enjoying the use of those caches.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/mempolicy.c | 7 -------
 mm/migrate.c   | 3 ---
 2 files changed, 10 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 79053ece02cd..f4d9b5580632 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1343,8 +1343,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 	long err = 0;
 	nodemask_t tmp;
 
-	lru_cache_disable();
-
 	/*
 	 * Find a 'source' bit set in 'tmp' whose corresponding 'dest'
 	 * bit in 'to' is not also set in 'tmp'.  Clear the found 'source'
@@ -1425,7 +1423,6 @@ int do_migrate_pages(struct mm_struct *mm, const nodemask_t *from,
 			break;
 	}
 
-	lru_cache_enable();
 	if (err < 0)
 		return err;
 	return (nr_failed < INT_MAX) ? nr_failed : INT_MAX;
@@ -1530,8 +1527,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (!new)
 		flags |= MPOL_MF_DISCONTIG_OK;
 
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-		lru_cache_disable();
 	{
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
@@ -1626,8 +1621,6 @@ static long do_mbind(unsigned long start, unsigned long len,
 		putback_movable_pages(&pagelist);
 mpol_out:
 	mpol_put(new);
-	if (flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL))
-		lru_cache_enable();
 	return err;
 }
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 364015cbef33..1d2085529cd0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2359,8 +2359,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	int start, i;
 	int err = 0, err1;
 
-	lru_cache_disable();
-
 	for (i = start = 0; i < nr_pages; i++) {
 		const void __user *p;
 		int node;
@@ -2439,7 +2437,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 	if (err >= 0)
 		err = err1;
 out:
-	lru_cache_enable();
 	return err;
 }
 
-- 
2.51.0

