Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98130306756
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 03:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788321294; cv=none; b=FHgoVimsJXRTegfT+34tzw/JhNel2hxm9KhUBuhJxMFh4q3Bw1t1/mMzvtSLensakki5vCO1etyOutiRhVSAeJD12e9QNPCbYwaDB5RbrmQSInNfMb814d6x5k886sfq7LSMpry+JqMYA4JvJLgFG1deHNDKqxnQRAZfnHpMe/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788321294; c=relaxed/simple;
	bh=fRhuNFDdOevX6AnwPPrw0lvkQt/C1Q5JAeS99ARfKsg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pRt14ZsCGDr5hKx9TDkpHduGdRNWAlHzKhG1u5MbwK452Ck1cb/VnLA9tyNln7NpkCaQQrrw4oFz1Vlv15UIyHd7tMBNTARbc2cuR69IJ3vuh9qcE+XCCCwviaEAewr5oCKPX4gd/6HwVRqb1EHe07Q9wibZVsV0/q2Pngj0MNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GfBLQ3HC; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfBLQ3HC"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66cf1f9965dso478423d50.1
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2026 20:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788321291; x=1788926091; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y3C3YFkFN20q0dqMhyWIalQhIX+NjYlCT3NZSRQXbv0=;
        b=GfBLQ3HCJAEBkM3S20uzlPqJx0t9g7goeoft1HoZDyfkUTCw9eRKP0a7Ey9ozYuohA
         bab6Un0U9LfZOl2D7lI0WIDG7i4nX8mjXgGjDC/IBV2XxxN8dzLwQvoIPml7mhwx4GZ3
         t7c29WfgOiR2Ov8PR1qOPr1iM5mATUgZJrv/f2hs+m2Epdl+hiwc91nIt2HeyIhJ2nu2
         0wZfGBNTVYtG4HCVJPCxGQByDgmOCR+AViIAOPsg+ucnZrz01IAigiMIVg+Bq9CfkI8F
         LYYAB33Z66kqO50JpCtkvIM9ZtudZ41X6XbqwbFjKMks1UcSiJOuYenkoJdAzscOHhYI
         ayOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788321291; x=1788926091;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y3C3YFkFN20q0dqMhyWIalQhIX+NjYlCT3NZSRQXbv0=;
        b=EIQT3GoKEUgLW2bXTOnoG8wPTDleDOVYKhvy6owQ1Ziq8vsvW925YN1s7WKPHz53bk
         GNsGz4FPxjGiUOvj5uyh0xYAV0/0HeuUURyZHrI1MX0cNc5LPc6ymuI1YBmhKPRVgIQi
         Eep11CMJjksr7KpAlv3t6OFVh4gmIXAuKuPhElXvro6j2E2PCgxke4XmYrrXFoyBBBXh
         h5UsV5vWGDh6cHbdPUhUhVQd+/NZd7UmnTXKnx891zeEe6mVfcy0QIKV2EPNBnFhP2gm
         qKeXNRaJbjG21vi+PdazPv+b4KmMYULc6DsPxuXWBJRTyIlgAbqJjnZfTN0gPsNkMCbz
         BIVg==
X-Forwarded-Encrypted: i=1; AKwUvBxhagllAnhwZbhfxPgk4vjil2XhX7765PmL4VQazew+Dy3pCsj+v3pikUI4uAwH+JyAQ4rqMg5gskzuWQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mjFa5eEiKcStYsuhzMQ5slnQNXlQUER3yufqXWnr3/UAk4XozS
	AxalZC7WkxUbD+XkHAGQKGgeJG9l/HQXPmompAvRklvH4AUdh/0tuJCXK0xr/edXaQ==
X-Gm-Gg: AYBFou0WdqPbjZSbn4EZvG4stdZsTG4pUYZCwMvU5hmLJCbOkzzmwvfVpO/pFIo85FE
	fxi984Ren9OjVLNb0lWRidfFOyD2ZC4uEh24OS+kCYOYyBB9ciVn17lOyNy76G5fGkzA2ss0KYM
	0RgVkcqTY91NMxzLRn38ki/XMDYtVCQ4dBrDdzI2mKRAcaikwqPyax54kKt1UuMqS87idGnkrTu
	HTMdNqFZotL8g1FM04Q+9lOQN/PzUv1Vl+TahS+dPTNbWfbAEdb18Bc7/3ia7mlIJ33U17DpsKQ
	BeDO3+njAX0sQaqe86mqg5zRHt52KjofCR6qHV4TGyYsb2i0AMMQoei27YdfAQA0phqmqMR7DlL
	rh/XP64U+s3CPam4nKqSl2NofPRgEZNMvsiYHOQd/VbcFYySqwmF5XpVchT0AIU6NLoN2L8Ojx6
	sbyisowcqdcWtcYsQHyt+8FgbTQ92gILL9RVEctrLxyeB5n1DeCdYcLdFAyU3RejyhmJ4ntEKO4
	TTiqdFgC7+ZbQT2vP+2RF0MgO7hSwgm0yzx74/qUo06q0Nb
X-Received: by 2002:a05:690e:264e:b0:66f:92a7:1b28 with SMTP id 956f58d0204a3-66f9bfd8205mr445722d50.49.1788321290911;
        Tue, 01 Sep 2026 20:54:50 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66f985611casm1051256d50.8.2026.09.01.20.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 20:54:49 -0700 (PDT)
Date: Tue, 1 Sep 2026 20:54:33 -0700 (PDT)
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
Subject: [PATCH 26/25] mm/fbatch: drop reference inside the loop when
 draining
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <6d24ca2c-d535-cbdf-dab1-97046a3914ce@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
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
I shall have to rebase the series, but this is an important
afterthought which is best added into the review now.

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

