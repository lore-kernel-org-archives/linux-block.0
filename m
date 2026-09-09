Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BF43DC4C6
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949860; cv=none; b=R+gXrp0lKVA0j2fuBSs+oWzBsm8uR3A3k8VsiOmpd5nXBc9kJTLyjDrMJMr4x2B/PBBzNr6H5hTD8aqh4cnafBHYQBQ4dK+apFZ3rKWKx8fxOL7/+WNje5aNcI5VXTCWt0QVJOSbv5VHJpae1Yw/N78xE6kVmd8pTvTr6NtB4bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949860; c=relaxed/simple;
	bh=e6+P0w42WSank7bJyBRxJ0I/o2AdvAByGwMedNmCY/Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cKrKMWKGjFA4um/h7foZUaxWsgv14NHLJzsy5UWFQZXu7d2I9PH9qefhOUsoAMoZax8/KToFVd9D5Zktv4LOQX5ZTJ45iMxIAB/p2RlCdlad6RdfRGI56IyCbVWg3fXRoxsjRoomc3WtZDFIK3toA/1lhkK5Mpq+6xm3CZ+QbKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dnL/0r+o; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dnL/0r+o"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-86d43cdee51so70273547b3.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788949858; x=1789554658; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xikkFdSddcZk7EZo4mTtVn7i5ie1aP6lqhxPtSw7MtA=;
        b=dnL/0r+om2LqYB9UWE6tkpdxIFAuAA70GZwyzBcqbjutXXb8HacxXnzq40Z7FLVc7D
         CsOGNNuLraa8Ye+UWFNxQLLysNo6ShwSpEpNaYyBF5h4KPkuwctUWSGDijbRS/GV6JQm
         QZFjVrOUF64ePn+xzLq1r98qqSC7BMmeYCW5UKBwB8Bus4PLL7vjqJzCOfHLkddxhtei
         o0gVwgxkyL0LbI12y+ZF0AwReh/ktCAWly79eYoR19C0eg33Qem0lJl9VSw41d+LlHjb
         /mGNIwm1h2TtZTnmayVZYgjeEaXPRTFhpgMtXetL38UDHNBAuregBL9hsCaIaL0XA+NM
         vbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949858; x=1789554658;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xikkFdSddcZk7EZo4mTtVn7i5ie1aP6lqhxPtSw7MtA=;
        b=nWfxqiSopb8T/FI/pN5RgNx3BPC2aRkXxINwV+yIZyDuRcaBW9qmwKNn37mCg5pDti
         rgzrmdY36IfgnwXeoA73avHpRpbtC9ucvRCDgT3Dna1gVcRyzWfrb5WFSSed9P8hy3U3
         563YwwlYTf7G6qHKgJPWVqUa4ZexlDGBwM1OQsLNdGUWsm9XXyWmD2/94gGcm0FPel9F
         Xhbqn8kYEQ9Htj+986fzILpt29KuZphHlFn6KDRq4Cp41N7twzmo3hkdFoFgwzyMZGh2
         ORQxh57vmHVVL9MXQbJtNfjIVLESEU49mOqZnoTgUvEn9nB+CLPZ7rV2xIWun4eRK/7X
         /CgA==
X-Forwarded-Encrypted: i=1; AKwUvByI75INOd4BGprhQ9HEfSzrKcUzhy4vNORR5sKLR/nEpOKCK0yeEulQOyjzJ/8SJ1g1Owm+JaJSUNodTQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mJGw9XsVpoktqj7R0piaHRQ25oJXeEy0y47t17zUoh4ahh6rjb
	wgAuVQBteJX8HxQQnBdnLYJgtwvHX7vHeQUcShTFJ4jRaM6sNuMN2GWU48AVo5UQ0A==
X-Gm-Gg: AYBFou1+NILzfBIaISuE9y9wta7J6vjjzT06Cn3/vxNKPGKmvKc7yZpel5naliA33V+
	wSeZf4cu3OSsKn6JPHCnIF3EgwaO5Pl4L74gl938Z48iDgu0Bm8gSqnT3EwkOPPnc4Qyd26Kxqb
	5X1fCEFdTh7KRvRq86gzW6Xc78/6MFYwcZxl4UgkTfc7pQcgmbYnQ9B/yRJMAni8SYCZJTHqRNo
	LrUbaevDy1Obt19OYDyJb1ZdjQUcF5tjTvtvPaMiszrqlipEAiShnEUkCZbbDlhrqca/eW2sduI
	Eq9/YMb8p0KJBJU4tw4xzVkR6uyiNBM1zhI4rIeZSU2sRXQK00gl5ntqiRMitVi5IRoWfi2dyej
	N2/bTbw9PwdJDonAfI7ON6anLD6/ZL8jaHx0VVDID+aCJ/lyJhv9QRj8LQEX1yzhukj3W3Pg6Pi
	P3/iMxvf1eCNtIwXusNg+PeYMg4d+v0yjYzzzvrtwUFAnQMOBg6yy6jY/MtejX5hxkvPsW9ZMMY
	iBnGOCmwJ3/RxPMa+sD0Ht6AwWIEXV/aDBqg+iTaKyEVfW1BEQPVg==
X-Received: by 2002:a05:690c:c047:b0:845:1064:5c03 with SMTP id 00721157ae682-8712b59ce6dmr98838127b3.23.1788949857100;
        Wed, 09 Sep 2026 03:30:57 -0700 (PDT)
Received: from [192.168.1.242] (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b52f641sm106441207b3.37.2026.09.09.03.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:30:56 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:30:51 -0700 (PDT)
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
Subject: [PATCH v2 23/26] fs,mm/fbatch: use invalidate_bh_lrus() not
 invalidate_bh_lrus_cpu()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <56a1dba3-1dd4-e4dd-a38b-3fdee74a690e@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Whilst there can be a case for including an invalidate_bh_lrus_cpu() in
lru_add_drain_all()'s workqueued visits to remote CPUs, wouldn't it now
be a preferable cleanup to remove that alternative, and stick with the
smp_call_function_many_cond()-based invalidate_bh_lrus() throughout?

And fix the UP lru_add_drain_all() to include an invalidate_bh_lrus(),
which went missing when 5.15 commit 243418e3925d ("mm: fs: invalidate
bh_lrus for only cold path") took that out of lru_add_drain().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/buffer.c                 | 16 +---------------
 include/linux/buffer_head.h |  4 ----
 mm/folio.c                  | 25 ++++++-------------------
 3 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index ed966fa73b1b..7d114e5b9c62 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1427,7 +1427,7 @@ static void invalidate_bh_lru(void *arg)
 	put_cpu_var(bh_lrus);
 }
 
-bool has_bh_in_lru(int cpu, void *dummy)
+static bool has_bh_in_lru(int cpu, void *dummy)
 {
 	struct bh_lru *b = per_cpu_ptr(&bh_lrus, cpu);
 	int i;
@@ -1446,20 +1446,6 @@ void invalidate_bh_lrus(void)
 }
 EXPORT_SYMBOL_GPL(invalidate_bh_lrus);
 
-/*
- * It's called from workqueue context so we need a bh_lru_lock to close
- * the race with preemption/irq.
- */
-void invalidate_bh_lrus_cpu(void)
-{
-	struct bh_lru *b;
-
-	bh_lru_lock();
-	b = this_cpu_ptr(&bh_lrus);
-	__invalidate_bh_lrus(b);
-	bh_lru_unlock();
-}
-
 void folio_set_bh(struct buffer_head *bh, struct folio *folio,
 		  unsigned long offset)
 {
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index fd2c7115c054..f19f9e80be8f 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -518,8 +518,6 @@ bool mmb_has_buffers(struct mapping_metadata_bhs *mmb);
 void mmb_invalidate(struct mapping_metadata_bhs *mmb);
 int mmb_sync(struct mapping_metadata_bhs *mmb);
 void invalidate_bh_lrus(void);
-void invalidate_bh_lrus_cpu(void);
-bool has_bh_in_lru(int cpu, void *dummy);
 extern int buffer_heads_over_limit;
 
 #else /* CONFIG_BUFFER_HEAD */
@@ -528,8 +526,6 @@ static inline void buffer_init(void) {}
 static inline bool try_to_free_buffers(struct folio *folio) { return true; }
 static inline int mmb_sync(struct mapping_metadata_bhs *mmb) { return 0; }
 static inline void invalidate_bh_lrus(void) {}
-static inline void invalidate_bh_lrus_cpu(void) {}
-static inline bool has_bh_in_lru(int cpu, void *dummy) { return false; }
 #define buffer_heads_over_limit 0
 
 #endif /* CONFIG_BUFFER_HEAD */
diff --git a/mm/folio.c b/mm/folio.c
index d66aa2469e86..dbad66e805e2 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -681,21 +681,6 @@ void lru_add_drain(void)
 	mlock_drain_local();
 }
 
-/*
- * It's called from per-cpu workqueue context in SMP case so
- * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
- * the same cpu. It shouldn't be a problem in !SMP case since
- * the core is only one and the locks will disable preemption.
- */
-static void lru_add_and_bh_lrus_drain(void)
-{
-	local_lock(&cpu_fbatches.lock);
-	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&cpu_fbatches.lock);
-	invalidate_bh_lrus_cpu();
-	mlock_drain_local();
-}
-
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
 	local_lock(&cpu_fbatches.lock);
@@ -711,7 +696,7 @@ static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
 
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
-	lru_add_and_bh_lrus_drain();
+	lru_add_drain();
 }
 
 static bool cpu_needs_drain(unsigned int cpu)
@@ -724,8 +709,7 @@ static bool cpu_needs_drain(unsigned int cpu)
 			 folio_batch_count(&fbatches->lru_move_tail) ||
 			 folio_batch_count(&fbatches->lru_deactivate_file) ||
 			 folio_batch_count(&fbatches->lru_deactivate) ||
-			 need_mlock_drain(cpu)) ||
-		has_bh_in_lru(cpu, NULL);
+			 need_mlock_drain(cpu));
 }
 
 /*
@@ -824,6 +808,8 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 		}
 	}
 
+	invalidate_bh_lrus();
+
 	for_each_cpu(cpu, &has_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
 
@@ -839,6 +825,7 @@ void lru_add_drain_all(void)
 void lru_add_drain_all(void)
 {
 	lru_add_drain();
+	invalidate_bh_lrus();
 }
 #endif /* CONFIG_SMP */
 
@@ -872,7 +859,7 @@ void lru_cache_disable(void)
 #ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else
-	lru_add_and_bh_lrus_drain();
+	lru_add_drain_all();
 #endif
 }
 
-- 
2.51.0

