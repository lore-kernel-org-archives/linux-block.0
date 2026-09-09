Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E31485CD1
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947083; cv=none; b=ZWctc+RiEved4Yjtw8pxU2x4rF8b6pe2rR1j0e3Ug6Adg8rSNONZU494M4QGFljeSuwTdQdTxBZesHFxxNC8siIyRKsqnkttg+vdvxNJAkk296C534fXzSgz3kxreJhy9JidNRUdEx2xFRcqOtV0CfN7Y4FSOpKP82faTmik38w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947083; c=relaxed/simple;
	bh=bTUnCSRZY4G+HM39v0Xkm1aeH5odwpKTGFZaGF+zFkU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gHLHILadtFoPs4aqQ7SYd6JhkCVuZ3+0t7fIcrRcLZPX/1vWp0SdEQnzyWVdAs0zYzTXjJWsnf7jwr6uB8+umbqqMyBnQQdS5LNDaS9jwiCYXTPOXMe7W2gmW+r4UKrtXIBJaMqvQtGqMvUpPz4NTURoWZzuGxaYOkPmV6B3XRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tdkF8xNK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tdkF8xNK"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-87c938111a7so13698427b3.0
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788947081; x=1789551881; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/77qcoGASc/bcotpYpu7s8Toxgxo4GzXR5d/4rRuxI=;
        b=tdkF8xNKlSCsIfsWgL91//5JVWgbkFK8LI9ElBpjlcX2oh0npUSYMyYmAKaCdOFusp
         lzLiD0XQai4k68ZG54JivS5/UV9clbwroSxZjzDWKC/XRqHNG+PpAPOvrp9xtVCCpVLi
         w5PywqOGLYlOtNtQ7Mgj4iDroomAxlO8O9QpcHgCKmwr74pp6TDdr/r1CoWVwt9FuiVK
         O23DIzXJzukdhqm3IXUwBBV984B1jGtcg6hWtagQoz3HgCPFL8v2/vSCaWqekEVJbo8L
         jh2bXikkE0jWIqw4pouWidbBZb8Kik95aoNPF1D5Ai6yygBz4gICB8vPsBmPSaBfoc8H
         ve2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947081; x=1789551881;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l/77qcoGASc/bcotpYpu7s8Toxgxo4GzXR5d/4rRuxI=;
        b=bNyD2iS/fZ/YZAsCYEpqUIII43fJuM9rEPaBvyRTnc4erutd9IiwdfioIqpLlXu8ax
         vS7j+FsDq0bn0dSZyGHca5EDwKGbLBROAY8rnT8dDXrfgHI5G5sOW0S0QngCwGQkxcW7
         Zdtx8SVaCV/cg8hht/wODdWPRNubQZVPtQQhXDQrFEyUuRicYU+NNiVAcL+W/gvY9Zeg
         LWuCNJ3840ZjmifgVqWjS4Dtpu+UQ2ukynutyEO61DG/K31ssEw06m1+KGsE9pQdXFPP
         v/78DLOj8dPgk3bKjfhzV6aD2FlQ+Ma7yVbQQcY6ekvtkwUJvjkmzHSZ7IHcFxjzXtwj
         3u1g==
X-Forwarded-Encrypted: i=1; AKwUvBw/m4gQkTClyqSVhKHIlac9mlCFiWwpvIlPmguivgbJ1Rsp05G5ZoMGt1dfhfqZdVIW708wivAKqB2tWg==@vger.kernel.org
X-Gm-Message-State: AFuF++mGPbJUAtCDTf27B8khi8bSyRMiMKR8mgVX8BbvSyDe3SbQ2CsV
	/ZcCSNHyTW9mkhTIavFteVem5PpjzAZ71XyT5MjsBGeAV1cpp2fmDgUiPONrs1IhdA==
X-Gm-Gg: AYBFou0wFJ3xHEDuQpi1SXmivpurufCd93KddVPlDHY/2pJgOuEgRQ/THZjyVYEAi5f
	0hgwdS9sYsHmHrQUmqYMxj0nfLDbUfh9zHo9BBdq/kmV818LV0Rf6zmf29mRiuJze0/Rp909RJC
	ccvHo905+0nzxVm6pzC8zOMKzkx9UjVN1gaA9djR2gB4tK4lHhNiv6yU1Fmxw0BwhNwDfvPb8xw
	Pr+7CsAZCg+GBLAW861gEgErbBy4HjISqYz/hJ9XROn7jGviiIR2h2lpmCcPQqUX+qF/KcJXPFu
	vBeKRowZQ64eOnyi82+5Pc+osW6RNvhWOvyoQ6gYVBv/0ca0z88vVhvxHUmHANLqhxYGtA6JH2D
	Rkp2LbHHFwpTqUKkFgP7pvKT8GGgFkhJ1/eyGjO8zAo4JCf1UfN0opqPsbtNlTfvX5QYHV+DMlM
	mMfprtZSIdFGsHrgNgVPL9HT0vxDj0NKRyO3Bi4lWsPaQHcB72j9a9k5jKi87+lRQ/k99+BzYuV
	sqM9r/2os/+rNJ+zT47qV0iq7O1KN/S/IeJxdKAs4C8Pkz2bnXPybxz+oNf
X-Received: by 2002:a05:690c:a84:b0:7f0:38f7:6ca6 with SMTP id 00721157ae682-86e6d7905ccmr129247067b3.5.1788947079991;
        Wed, 09 Sep 2026 02:44:39 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-873194f76e3sm92930227b3.5.2026.09.09.02.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:44:39 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:44:34 -0700 (PDT)
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
Subject: [PATCH v2 02/26] mm/fbatch: allow folios_put_refs() to skip
 xa_is_value() entries
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <c441176c-33b7-c8f8-fb7f-51774e1fd853@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Let folios_put_refs() (hence folio_batch_release()) skip xa_is_value()
entries, and therefore remove unneeded folio_batch_remove_exceptionals().

It made some sense when introduced in 3.1 for shmem swap entries only,
but workingset shadows popularized exceptional entries in 3.15, and it's
silly for so many sites to be squashing exceptionals out of the fbatch,
merely to suit an inadequacy in folios_put_refs().

But remove exceptionals on leaving truncate_folio_batch_exceptionals(),
one of whose callers then passes the fbatch on to others less tolerant.

No longer essential to this series, since 7.2 commit 9669b87065a6
("mm/lruvec: preemptively free dead folios during lru_add drain")
allowed folios_put_refs() to skip NULLs; but still an improvement.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-By: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 include/linux/folio_batch.h |  5 +----
 mm/folio.c                  | 25 ++++---------------------
 mm/shmem.c                  |  2 --
 mm/truncate.c               | 16 ++++++++++------
 4 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/include/linux/folio_batch.h b/include/linux/folio_batch.h
index b45946adc50b..e1cc8ae023f1 100644
--- a/include/linux/folio_batch.h
+++ b/include/linux/folio_batch.h
@@ -22,8 +22,7 @@ struct folio;
  * The folio_batch is used to amortise the cost of retrieving and
  * operating on a set of folios.  The order of folios in the batch may be
  * significant (eg delete_from_page_cache_batch()).  Some users of the
- * folio_batch store "exceptional" entries in it which can be removed
- * by calling folio_batch_remove_exceptionals().
+ * folio_batch store "exceptional" (xa_is_value) entries in it too.
  */
 struct folio_batch {
 	unsigned char nr;
@@ -100,6 +99,4 @@ static inline void folio_batch_release(struct folio_batch *fbatch)
 	if (folio_batch_count(fbatch))
 		__folio_batch_release(fbatch);
 }
-
-void folio_batch_remove_exceptionals(struct folio_batch *fbatch);
 #endif /* _LINUX_FOLIO_BATCH_H */
diff --git a/mm/folio.c b/mm/folio.c
index c093ca900a3e..ad6c64a4c22c 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -964,6 +964,10 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
 		if (!folio)
 			continue;
 
+		/* Skip any "exceptional" (workingset or shmem swap) entry. */
+		if (xa_is_value(folio))
+			continue;
+
 		if (is_huge_zero_folio(folio))
 			continue;
 
@@ -1069,27 +1073,6 @@ void __folio_batch_release(struct folio_batch *fbatch)
 }
 EXPORT_SYMBOL(__folio_batch_release);
 
-/**
- * folio_batch_remove_exceptionals() - Prune non-folios from a batch.
- * @fbatch: The batch to prune
- *
- * find_get_entries() fills a batch with both folios and shadow/swap/DAX
- * entries.  This function prunes all the non-folio entries from @fbatch
- * without leaving holes, so that it can be passed on to folio-only batch
- * operations.
- */
-void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
-{
-	unsigned int i, j;
-
-	for (i = 0, j = 0; i < folio_batch_count(fbatch); i++) {
-		struct folio *folio = fbatch->folios[i];
-		if (!xa_is_value(folio))
-			fbatch->folios[j++] = folio;
-	}
-	fbatch->nr = j;
-}
-
 #ifdef CONFIG_MEMCG
 static void lruvec_reparent_lru(struct lruvec *child_lruvec,
 				struct lruvec *parent_lruvec,
diff --git a/mm/shmem.c b/mm/shmem.c
index 897fa2b61346..1f2809adec54 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1157,7 +1157,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				truncate_inode_folio(mapping, folio);
 			folio_unlock(folio);
 		}
-		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
@@ -1277,7 +1276,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 			}
 			folio_unlock(folio);
 		}
-		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 	}
 
diff --git a/mm/truncate.c b/mm/truncate.c
index b58ba940be47..4151f7a167e3 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -53,7 +53,7 @@ static void clear_shadow_entries(struct address_space *mapping,
 /*
  * Unconditionally remove exceptional entries. Usually called from truncate
  * path. Note that the folio_batch may be altered by this function by removing
- * exceptional entries similar to what folio_batch_remove_exceptionals() does.
+ * exceptional entries.
  * Please note that indices[] has entries in ascending order as guaranteed by
  * either find_get_entries() or find_lock_entries().
  */
@@ -95,7 +95,7 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 				dax_delete_mapping_entry(mapping, indices[i]);
 			}
 		}
-		goto out;
+		goto squash;
 	}
 
 	xas_set(&xas, indices[j]);
@@ -113,8 +113,14 @@ static void truncate_folio_batch_exceptionals(struct address_space *mapping,
 	if (mapping_shrinkable(mapping))
 		inode_lru_list_add(mapping->host);
 	spin_unlock(&mapping->host->i_lock);
-out:
-	folio_batch_remove_exceptionals(fbatch);
+
+squash:
+	for (i = j + 1; i < nr; i++) {
+		folio = fbatch->folios[i];
+		if (!xa_is_value(folio))
+			fbatch->folios[j++] = folio;
+	}
+	fbatch->nr = j;
 }
 
 /**
@@ -575,7 +581,6 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 		if (xa_has_values)
 			clear_shadow_entries(mapping, indices[0], indices[nr-1]);
 
-		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
@@ -732,7 +737,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 		if (xa_has_values)
 			clear_shadow_entries(mapping, indices[0], indices[nr-1]);
 
-		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
 	}
-- 
2.51.0

