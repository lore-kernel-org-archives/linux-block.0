Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5592FF675
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581258; cv=none; b=W4Xd0qhDf2WaOrSr+6yRtFviU9HzLJ15vwxQMaFAKSaDLD+I+9mTutQCDVUSKk2mjMKmInRmKMITS22jc4TWYiQpivrQ0Ui5cFN6pVw88CjomuwbLoNOkUjDIbyBqs6ht+ahYVicVNNxglvHGoHYDMg7HifMcUwX1mgrCwCzaRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581258; c=relaxed/simple;
	bh=8h+Tl/oSzEl273fsifSd2ROQHSdSF1jGQXnUSkA/qlo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XAbAb7dLYuezbmT+3vZJjay2xLXKuG98le9EWVMlrHSYpObyNEmZoFZKAVOW8OhUdGaahh9/lbJvJofB7ZIe+kOujQ6MVegGdRpd9SIXH4k/3kFrWHN0KsAu4aaHfWia6LobXNlictaTw+cFx1hBUr4X3AWMd+RLZXmbp5WA1pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MQKTzxBX; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MQKTzxBX"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-836c590b61eso53158757b3.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581254; x=1788186054; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRoTlYAeNn0iQ+Akcq71dtDJ5mRi19RmdUI1yCGlg3o=;
        b=MQKTzxBXRLyXVALWAMfieUw5HptWmyT/+uz5VhS6deH8nU8b1zOs+lAID3sfB/Skr6
         n7Ehyqp/XUEB8x17/4+qABrwy+TaxUsKEryBhMSWXfK9wC/7lUifEcxzyPVh2Hf1S4PW
         BXaasjoFX3mulB7nmbyzAF7O4JdQc0KEggUEsW6CD0QGHg2+jAOOja+a1FhEVuDhAK29
         5kM0EZNz99xCkBi0SC12k81e6vr6UrHjBMXlmCe+FqglI3I5zzIcJUKavJqb/DJpIEtn
         Fvh973ENETGWBjdfEVadgmYcJVw85XXs9QxysAdhG6d/BRg2vwmAwJmWgUUNq6lHm13c
         Ovcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581254; x=1788186054;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRoTlYAeNn0iQ+Akcq71dtDJ5mRi19RmdUI1yCGlg3o=;
        b=l45jvJ4Zqp+pz+f/la8dsz8MWyagXRBf1/V0V0Mak8g2ibYFzhIFj/xuCXjEr4wwyF
         LbJpsZGMChmOgw/2IQueNit69MJu/NOHssTS446BIM27x6BmNNDI1DpPQMDVUhRS5DXA
         A3WbpIjejCN10YyLuLGKbG4oh1ysxpntWLryCuozPc/dfWnOIR9RbtHmX3ROs/42B0M0
         eu8QqLwutQYkU3VRyDHDB09vwtAO0cJ+q0AaJvzG/Uk1K7vVCCc5Wauk56QXr6uZX/Zx
         0dPuP+Qd312LfHySK+3K3iASYIcuCin0BswaKbxBAGtlKbx9s4cC8YovHFqk2QKJv05/
         8m6w==
X-Forwarded-Encrypted: i=1; AHgh+Rq8T1nwwc5Fpziq8AgtsyNZBEC2XsmGz/2NWxGrGRvmVhAPplKbLL7e1IpHqbrp2rL6/r4Mlul6SIwaOg==@vger.kernel.org
X-Gm-Message-State: AFuF++kIxWe14/J4whKp/gUZvCgMxsDdjcZJiF1Fwrwe7mD98m/Hx12m
	l17oOKIeBEOlou2BTHlmCj0UoUoitzja9vin5qhnCiW+ActTji+ETnV5BQ8NInjPbA==
X-Gm-Gg: AR+sD11w4dFNPzpE9TGUGYkm6tn7rV+l/PG60JpZMt7/T4uFwI9JhSSg08k40LX8PGw
	fVn4qoawTaFwvwqmAyvFAZmS5p89mW4bYUtRE2kT8D1W/fS8LeJuLFX5hSEkwUFF9y/CcWEj3NE
	+LQZc9JuU+CJz9TBEYBF7kzYT4A3Iit7vJnzOmWU7njRQnMomjKWpBkhDOpd6xos2WyEyrbiUk2
	VNvTyIMZz//0I4l78vqLM6gqV9S3q6sBQMiQ2trlLx+Z8B27AgJLvdxgdsYmC/tj7aYXESLj9u4
	OX891hdoa+zoH2MCY5vb3JJ8PTXQUNQ7J1jua585tRfCYK+nr5oFqKsUfnx243buZICx4yEhiDf
	BoOYnwTdysb8XhRaNdsyn1mUQ58wysylP2HzP5hKeJf6LJ9BBx8JXiwWFsc8s4KqFzg19XfeewB
	zkAVnVWn4J9HbAdX+MsHw+lrnBtIo+bma2uaB11sh+yREAoD5cnwWyYy8NSnPu60vKD04PxZNVi
	mTkvRRCIVQjrub4FliOVuPjZCTdWErlc4OQA4zvTKBwHeRX
X-Received: by 2002:a05:690c:e217:10b0:81e:a471:e8b2 with SMTP id 00721157ae682-84c95f4df1amr53178007b3.2.1787581253476;
        Mon, 24 Aug 2026 07:20:53 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac3f525fsm33909927b3.44.2026.08.24.07.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:20:49 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:20:44 -0700 (PDT)
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
Subject: [PATCH 12/25] mm/fbatch: remove percpu_pvec_drained and
 folios_put()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <3599e5ac-b74f-87ad-ab65-78d24c148fd1@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
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
index 87feaa5a2b78..a426f7351787 100644
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
index fa4cf9d7d51b..782b8245d213 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -159,7 +159,7 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 
 	if (lruvec)
 		lruvec_unlock_irqrestore(lruvec, flags);
-	folios_put(fbatch);
+	folios_put_refs(fbatch, NULL);
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
@@ -1062,22 +1062,11 @@ void release_pages(release_pages_arg arg, int nr)
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

