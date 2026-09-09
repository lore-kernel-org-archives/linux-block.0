Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AF52B1C4
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950284; cv=none; b=hJpt+C4/naiGuLvQ6/oxuk59ABiMQQuL5b2XEDQT4KILVQWsyFeNylp+R0xPyhYMjznuh83vFJGZAb7wkamuYgQI8S0q7gfCxogDboXVx+w2SynctIsjgBT6VJzG+aMPNJ2RtTvskmnWTgKqJJyfO/crK+IIgtrXB8bHabduskg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950284; c=relaxed/simple;
	bh=G/+0ifcYc6SQaMip/fcKwW0z1nfyT6dvA3rvG1KtE7g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=M+NQQLf/B9N2JZEX+08GQBbHNmlzBFvXBH0YVO/PaXF9i7o0c9GJCKL4VeSaj/95L2sURrOLA7TVleYsX5Vzu3e1Sz+4aojukSym0BkdjxqH7JJA6VulFqVNqAGX15cz9nUgHSoiQJ47uX2EhYICWTI8kwcGCarfU67o5zn7X88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dlladz9v; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dlladz9v"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66825847b2cso6162295d50.3
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788950282; x=1789555082; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ubgJuILilCUv+JDm5jbfScMjR0I7p8athUKDiI1DXU4=;
        b=dlladz9v903VmREmuBo/W8xz9HvP2F4cjlFXBE7pBWEhJnjx0VhA45vaIX64TS0YUA
         8R63dwujaHs0glLZ6fMrR908UpfZxOgzlu64ik9WDs6OEPZiuTNHYTaPxvA4HoCPPFFc
         ui/keBGH/qlewdQIP08QxKbElMaN2urO0KbcRcaKnxcuNl6kFqSuqNhr1T+2qys7syKs
         19aLGiDvTzd7nIklqcmAsgqICRMtmVcmJHH50PvRxkESYxtm+SGw+4o9u7r5hiM3alRw
         1O5uAV/vA90QN5RGlzxDIkzec2aAzwjVWjihT0T5hMdABoZNgn6NcN+isZaKKM36IuYS
         Ebgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788950282; x=1789555082;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ubgJuILilCUv+JDm5jbfScMjR0I7p8athUKDiI1DXU4=;
        b=JThm/KAe8oTBuzrt7fSBvEItac2Np00DxMtzRrVvkisGBQuM6mpQOo2mE1WrHVj6US
         JiCjiwtJA7tL9teinx6/5ApGQ07m/clGQO98WxEo2M3n9c8w3zB3SYXnqIqxNCDypDOx
         eDF3CW5F6k6Uyi7GHiUSf6T11R9PKLshpwzi/vuxTP6Nuklp0oO3mLK5zdx8z8H94Bam
         K/a4L354ClH00Fn0rBb07x6NryqlW4vhriB6X5SjVE2YBXobaLLM08WCbe+EUAFYb+1C
         t3Qn4xvVKtcTxmGONTGFN7xbW/4Xi7XEIuZx1vg3PmZ8HDsVrtxQr1U2O4kGN22N39kA
         ohcg==
X-Forwarded-Encrypted: i=1; AKwUvBzaSEo8YOyIvIvI6wnPNdVYyaBj4GKF9unMdF94ihNZq0mYIwxmKCYUGe9cR0R+qIGINH5Cjkmv6aD7XA==@vger.kernel.org
X-Gm-Message-State: AFuF++mnsydAtSYGUohItVQQiuYCzMnCjfSuwPFAMuy/f3+LbWiHtaOl
	0fejp9dYngUWqhwJt3/Zdfgb8C7UtXckMzZgIs/+6OJYht4B+zuTVJbWTkPjp0SErw==
X-Gm-Gg: AYBFou0sxBU9kUVj5GTCwxyHMqhN8CbFtlPfN3w2Gn2BYLdzMc/rFzfWm14PG1gu5nK
	bFjt4HVdN0/RG+Z/ywODlbMc0nDEUXTlUAT2iGVtUOBGa6LxtWKET7CSuzEyyxRq9FyDjXfVyj0
	zGnMFwO0ZoRnXouQJdlpB20epuhlrbNqCyWiwHqA+WZp6rHAXlX5Bvc1mDYG40V2NsFGAq7jcYJ
	EnIk4CdFmxzybFNhlsyg+C7HJA20/qHUvZkauTMK4zAdHpNpJSrPCpLZ793mgLmDelGsp10rF5O
	prkJGs9OwJGJ8NuH2Ek0xdkFvt7Oota+ZnWSbW3C9RLlFWXvdU9RvHl0z0/XrNxtQmnf7qbLaeA
	9GkbEnhWGETg5hzEPQqXEYr3w4wM6BfYBZoNqhVbAPxG/KjptRH/9Kpb4/KRky2P4H/RzfNUu9u
	L5QUDst80kyvQ77f762waYeN9chZDEs2jyOoF0I4k33XTEdRopTMol6c3Zpw43MFfmayLqOA2Wk
	mUx031PDJfM8JCYrDPBUZODjpzGr0/5gp6Y9txvApY89sk4DHObow==
X-Received: by 2002:a53:a6c1:0:b0:66f:79dd:19b4 with SMTP id 956f58d0204a3-66fb5a81fd0mr8721653d50.33.1788950280907;
        Wed, 09 Sep 2026 03:38:00 -0700 (PDT)
Received: from [192.168.1.242] (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb49763bfsm12116197d50.19.2026.09.09.03.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:37:59 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:37:55 -0700 (PDT)
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
Subject: [PATCH v2 26/26] mm/fbatch: drop reference inside the loop when
 draining
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <5af5eb5a-2a18-268f-d86b-5dd079a748be@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

folio_batch_move_lru() and mlock_folio_batch() used folios_put_refs()
after their loop: but that's counter-productive, to batch up dropping
all the references acquired within the loop. Now folio_put_testzero()
inside the loop, where we also already hold (bar races) the right lock
to remove the folio from its lruvec.

This should be much friendlier to compaction, in the common case when
the folio is still in use, to bring it back to expected refs sooner; but
I suspect that when the folio is freed, compaction won't accept it until
it gets to be PageBuddy later on?

Respect the comment in mm/vmscan.c move_folios_to_lru(): could be done
differently, but it's not worth optimizing the case when we cleared lru,
since it also has to handle the case when we failed to clear it.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/folio.c | 23 +++++++++++++++++------
 mm/mlock.c | 27 +++++++++++++++++++++------
 2 files changed, 38 insertions(+), 12 deletions(-)

diff --git a/mm/folio.c b/mm/folio.c
index 55ca799a9dcd..7c545e4c090d 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -128,20 +128,18 @@ static void lru_add(struct lruvec *lruvec, struct folio *folio)
 
 static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 {
-	int i;
+	int i, j = 0;
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
 
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
 
-		if (!folio_try_get(folio)) {
-			fbatch->folios[i] = NULL;
+		if (!folio_try_get(folio))
 			continue;
-		}
 
 		if (!folio_test_clear_lru(folio))
-			continue;
+			goto restored_lru;
 
 		/* Do not add to LRU if it has already been added */
 		if (move_fn == lru_add && !lru_add_del_folio(folio))
@@ -155,11 +153,24 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 			lruvec_add_folio(lruvec, folio);
 restore_lru:
 		folio_set_lru(folio);
+		/* See mm/vmscan.c move_folios_to_lru() comment on ordering */
+restored_lru:
+		if (unlikely(folio_put_testzero(folio))) {
+			folio_unqueue_deferred_split(folio);
+			__page_cache_release(folio, &lruvec, &flags);
+			fbatch->folios[j++] = folio;
+		}
 	}
 
 	if (lruvec)
 		lruvec_unlock_irqrestore(lruvec, flags);
-	folios_put_refs(fbatch, NULL);
+	if (unlikely(j)) {
+		fbatch->nr = j;
+		mem_cgroup_uncharge_folios(fbatch);
+		free_unref_folios(fbatch);
+	} else {
+		folio_batch_reinit(fbatch);
+	}
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
diff --git a/mm/mlock.c b/mm/mlock.c
index a3cfdb274fc7..c528cf7135bf 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -27,6 +27,7 @@
 #include <linux/secretmem.h>
 
 #include "internal.h"
+#include "page_alloc.h"
 
 struct mlock_fbatch {
 	local_lock_t lock;
@@ -170,28 +171,42 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 	struct lruvec *lruvec = NULL;
 	unsigned long mlock;
 	struct folio *folio;
-	int i;
+	int i, j = 0;
 
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		folio = fbatch->folios[i];
 		mlock = (unsigned long)folio & MLOCK_FLAG;
 		folio = (struct folio *)((unsigned long)folio - mlock);
-		fbatch->folios[i] = folio;
 
-		if (!folio_try_get(folio)) {
-			fbatch->folios[i] = NULL;
+		if (!folio_try_get(folio))
 			continue;
-		}
 
 		if (mlock)
 			lruvec = __mlock_folio(folio, lruvec);
 		else
 			lruvec = __munlock_folio(folio, lruvec);
+
+		if (unlikely(folio_put_testzero(folio))) {
+			folio_unqueue_deferred_split(folio);
+			/* __page_cache_release() without irqflags */
+			if (folio_test_lru(folio)) {
+				lruvec = folio_lruvec_relock_irq(folio, lruvec);
+				lruvec_del_folio(lruvec, folio);
+				__folio_clear_lru_flags(folio);
+			}
+			fbatch->folios[j++] = folio;
+		}
 	}
 
 	if (lruvec)
 		lruvec_unlock_irq(lruvec);
-	folios_put_refs(fbatch, NULL);
+	if (unlikely(j)) {
+		fbatch->nr = j;
+		mem_cgroup_uncharge_folios(fbatch);
+		free_unref_folios(fbatch);
+	} else {
+		folio_batch_reinit(fbatch);
+	}
 }
 
 void mlock_drain_local(void)
-- 
2.51.0

