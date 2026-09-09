Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3947DF99
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947214; cv=none; b=R3Bk7IT2y5x8SMERHlivQi0Z4+qFhUdDFu4NVZU2wgLghwUw0G0KOTsYuV0s4BN4mHNHbk9R+W/mBVPcyMQb88nKxgTGaJYyBLBdEej6i/7NIi9jLO21Cy/+8y1uwqMQvM9waAFi1EIbqddbbY+0ZdtDWe0W2rXxVFSMiER+fo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947214; c=relaxed/simple;
	bh=yz9phphkpKB30xOl4FfJtCYJLrw/kdVME667JYPkLrw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZqVSX3m0qrEF1lM8RyW8RhvSXPhFfKNNf6XONWEN7dkCNkKLlHZukP48tn0M3cUdeZqlUSeE3BkgEOHUm4P8E8KUUR2+MqsDinNN+800w6iT5p7PClHN0goWRAek3Rdjx02aJKEGHeC/DAKRZhcB0prhSfnZzBPzcaoW2Q4JrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJxIfVzB; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJxIfVzB"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdccso8525157b3.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788947211; x=1789552011; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5+7MnKyiB0fAnf+ZBPoUiSQUKpsvD64pam2O0QOh8zY=;
        b=YJxIfVzBzbyp1rCrC/UYAyN61dhGtbLDcYpDojgpKogDd5Hlbpr4ivQU+2cW8np1xZ
         nqUT3K59Ak+GAkYkO955repklb+APUlLa5tWbWOWrMJ1gVs+JTM6FQ7GnsdFQtEJQIf/
         1zOSBORaG59rTroCAbCCwJzErPzg84xeaI3gaL6GuGgUdx+YmaNJptqcxJ14TfXuQP3T
         QDp26JBdBE2LWOLqRs0TuIJ4rsaEJEy3irRO6aepdcsDgdY/FNymdCHPUc+kz5yRW0tm
         ixoyD4ohVIKA1geXHlxoXzkkNl2t2jtvoZ/wiKWTk13gog/Ru4VHwTLmJBWV/syA4XrT
         4k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788947211; x=1789552011;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5+7MnKyiB0fAnf+ZBPoUiSQUKpsvD64pam2O0QOh8zY=;
        b=ReLHiKk+sb34L9OLoA9Bgztiz6uEm0+CKnr1mq6lyJwLTI+dyIrtgkQ4OYxtwK+a30
         cHzg7TU+7Dlx5nV829q2gi2VLBGpgUCjA8vtvNuMi5y4ENwtNpT8KNbIE64rzl4VA999
         D5+mpDHrILTlsQlV8mxNNirWPGsWzxZrXomQzYVCGAiLBUDKzAD0duJSpwzPXsaGTZbJ
         44M6knDdC9BA8enHa1Lp+m226ywh3I0VQra8+aqiCDtfaTMJeCV+nX7pEk1+NyD1sCjy
         iXLmysAxC1jdDnLTQfgHTKm69G9EW3lICyIM3De08iGQc8DP+Hi/hYaGGO/FbXA2Thwm
         rAiQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+mg/4O9V8suZi2f8dFVCEtl8e8xP1YO1DifgH8fIRZGPWeZSsI0/SKvpxITYdEoHSuBx0529zuYA3fQ==@vger.kernel.org
X-Gm-Message-State: AFuF++km5Ec4qH96J6UA8Q8kWXXG9krF0PzhL0FoEVVRR2KAGT7mt+8c
	JzSxwWreo9Qslhd8p/RxWDhr9CVKo1PBt7rrb6DljbXt1KJbC+AqJ+oYWCQEXBj0Bg==
X-Gm-Gg: AYBFou1bSCL/wqIZ7tye5dV7xmb1LsP2/8oJuqKJiJf63DWdV29iumTYnl/aoR+O1sb
	nhbKh7n440NbFftES2rRPIYq9FDR0MeDgc4IHM+HYsQttjGYJ16zigsrKskspKRFakWsR2wXc+i
	Ugc2/iefL/TAg7UStpP32OBzE9rnbVpI8OjR93Io23ujmFjSyITn32+/X1cvFoYBhcVwLG5sqUz
	tNP/vPq2wONlI+N/R+Wg6JTIU7IJ4R8c+wcWwmgESyLZuW+QUP6M5Jcj+o8Oiu/h6/urJ2bLj2m
	oNnC+BWGKaLvBFuVHjTb/DvTijjJPIFlus5PdQ+k9rWfx1bd8C5BS4hXy9DUnNMUq4lTTESJQw5
	78eTR7pSFy9s28XzJs2neW6UIAzMFGG2YDpwpIF5H+2RZlZdYZ5o0JWEF716uovkcSoOoXZL0Wo
	ZyB+tHruKLMXE4IsNq5YHQqRvGA/6BUnok87Xhv+U3vjriPu/AelC743Q44OXae8hD41I15KWHs
	UdMWeTHReQ3K7ouvWaOHMZ6JgcMbszdRmVCKQPgf2SlNJWTMlLwBdlbB1w=
X-Received: by 2002:a05:690c:650c:b0:85b:35f6:bc5d with SMTP id 00721157ae682-87f23fe7a98mr24694497b3.13.1788947210602;
        Wed, 09 Sep 2026 02:46:50 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316356sm106597417b3.9.2026.09.09.02.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:46:49 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:46:45 -0700 (PDT)
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
Subject: [PATCH v2 03/26] mm/fbatch: temporarily disable lazyfree and
 mlock+munlock batching
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <5953f6aa-ca44-c9a2-97e1-a5b3b92e9e50@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

It will not matter if we occasionally get activation or deactivation
wrong; but a mistaken lazyfree (MADV_FREE) would likely cause dataloss.
So disable its batching while reworking the per-cpu fbatch handling,
then re-enable it with more thought afterwards.

Similarly disable mlock+munlock batching temporarily: they will need
some redesign before re-enabling. Just insert one disabling line for
now, leaving the rest of the code as it was, for consideration later.

Signed-off-by: Hugh Dickins <hughd@google.com>
Reviewed-By: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/folio.c | 2 ++
 mm/mlock.c | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/mm/folio.c b/mm/folio.c
index ad6c64a4c22c..b9dc4f5e10a6 100644
--- a/mm/folio.c
+++ b/mm/folio.c
@@ -219,6 +219,8 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		local_lock(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
+			/* XXX Temporarily disable lazyfree batching */
+			fbatch == &cpu_fbatches.lru_lazyfree ||
 			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
diff --git a/mm/mlock.c b/mm/mlock.c
index 39215a3eab1f..929abeac85d0 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -255,6 +255,7 @@ void mlock_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
+	    true || /* XXX Temporarily disable mlock batching */
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
@@ -278,6 +279,7 @@ void mlock_new_folio(struct folio *folio)
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
+	    true || /* XXX Temporarily disable mlock_new batching */
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
@@ -299,6 +301,7 @@ void munlock_folio(struct folio *folio)
 	 */
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
+	    true || /* XXX Temporarily disable munlock batching */
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
 	local_unlock(&mlock_fbatch.lock);
-- 
2.51.0

