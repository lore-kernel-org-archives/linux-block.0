Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A628456DE9
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582694; cv=none; b=n692Wbr+kdU9AiMYG1yr+SDf27bwd8gOltUz4gVNWPXK1+d8sA4YhpJabnvvyYNkGByx7Z9pi+HAf1+nlzLkFsSvwoH+hoiu9Z3EStLfAc5vVrvzdyBIN7A1f8WtIVy/JxkJSmIESX3l+dAdBodGUcHgPdW9/zmRU4fPHefr7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582694; c=relaxed/simple;
	bh=apGggQcJp2WV1URiHg8Asmh4iwaxGu1pF3vH60oXvTw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fody2V7Qf+PqAwOxcqxOIhza2UUc2lgI76UxyyC2+1y9UzLE2y3klvTtJ3P30MujmLHb+3YSR8lUQv4JjhBXVSnY9apmqgfLfIlcynhTzdFIKksBQrzWDLTo5NGk0gtbeHC7iL9P/9Lm8UPK6XlAVc1Z0/AnyPi3LVvqT5AbIJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjfA+dv3; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjfA+dv3"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8200b55dc47so55161047b3.3
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787582691; x=1788187491; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0mZ5Gk4/1Pu5bK3S+WjW2BlP4j/qxWTHvLM7mSgUCfk=;
        b=vjfA+dv39bRlVtK0b0GiuzgSC5Dw1NWDJhcPFIX+5i1SXqDN4Poyu8PuB8wxuWaklV
         vSn+QfqIxrvfnXLqYLZGfBzwXcEU7Ohsog4WOxIHMfRylgketZWsD6uvG8IpdRqaCq36
         av+sgXujeDW4AkrUEsvxcrhKTH3v0xkbKO7nJW0gNz3CTAwC5eRpASfwRQGgR4bD9NgD
         oEhHl4iFJ4T1KC8HnbPrLYQ+L/lEPhnZQhc6Guec/9L+By7XpAyI9eqgFlZZEbxQEml7
         eEDt/MZvpYnD2UkNDh7s0MKICzHOW8oxHS7v3v/G1I96pVF2rwpJ5n1u6d7Wjc+48yc0
         04hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582691; x=1788187491;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mZ5Gk4/1Pu5bK3S+WjW2BlP4j/qxWTHvLM7mSgUCfk=;
        b=VgJGxf7CFyiAj493qRfOd8fzII0UHci3v+bWwcNldH9IAsshVpL38BiyabvgdaoyVV
         oPOGv5XujeRJ2vJkEPbhGgFNkVEcuhbm1o09qDKUZvVLkUHL50ws1+XBQX+ZqNxIitO+
         BZaTlcMx6XH8MNzkNOLUzclnEXiMG00qicPJMS4HNdGeVpkvjeO50Oc9/kM01mqazMVE
         ShveoNbyjhirZp0vsOhL6/azc53+K9n09w3ikUeqT8uUZk7e7iN+pk1pf9fTgCyZdUG+
         M9pPUZ9m3i1BFey+Rq4ayNfZz5ShEUjurcYvOO/Isu92r+4K5k1ebOauS6po1CZz0wyn
         lYXw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7mAt23vEhDV5NMECLgno9NHW//BQBIRXRg4eH1trfB6vymI0ZVuy89Geqz6Xl6oTX27QLjaLBPOlcRQ==@vger.kernel.org
X-Gm-Message-State: AFuF++koobual89YpYIjy4zOX89+rSyd/QV4xXjnYbvMgxm6gW73My3k
	mjM9AaFDld9VHkKDVX1JLoPrvuRRFsPExS+bRreSOzBeq6JmQbX9Yabnlsbz8pIEbA==
X-Gm-Gg: AR+sD10vtAIwbLIldPn8NdRXXxsmuKa4bIDNxqo8ydvlWBnibv+xRVIvy1dO1Ckqxjj
	5NpRAd+vRDhHAxeQ+0HpXsMwQ0vQPv2ns2nAblLMuoZ7O+Osvtv8w0aHDbHHlbeVmur9KPEeHGT
	OKKAOloMTNIPUduKKcbg21akONwDfz+I3NIteasEAj6eRQXe0nQWQdHAIvi7fml5uXHWunef554
	qnLaGivKbvn+HBYm07lfcHYw0UAwBGEweFZnK0JF9kStbKiyHIYAvwfkvYROM3JMQR8f6Ntv2hZ
	PTCyZhld291sLFCL2oqvCnP384ygm/A2na80mwULb+VS6ABWSbhcTSZ4RCTzrD9qF+bXVSiVsFZ
	vZHZ6wQUqulA33ZT155D3BkK1C0EKbFFdom5MV+1Wlz2k//qFuvHOlwDOvPCM4WZ16h4FxZ77UC
	1wbZpKN5SDrkylKzm9LuIJPHQv2vVQyIvOgCqRukVfWEIB52LnBvvYn01XW6ATrbvi9Lzyx4qu3
	8oSuab/GNWiAVyULGfxR9Lk60FiH5iaXtdH7p3uYg1LWD7g
X-Received: by 2002:a05:690c:5:b0:853:f007:7557 with SMTP id 00721157ae682-853f016ba69mr7002677b3.19.1787582690568;
        Mon, 24 Aug 2026 07:44:50 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cacac521asm34834717b3.48.2026.08.24.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:44:50 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:44:46 -0700 (PDT)
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
Subject: [PATCH 22/25] fs/fbatch: drop_caches invalidate_bh_lrus() not
 lru_add_drain_all()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <97a16bae-dfe8-b58b-f0c9-6eafb3881195@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

drop_caches has no good reason to lru_add_drain_all(), now that the
per-cpu fbatch references are gone; but it may have good reason to
do the invalidate_bh_lrus() part of it.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/drop_caches.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..054af78e6a2e 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -10,7 +10,7 @@
 #include <linux/writeback.h>
 #include <linux/sysctl.h>
 #include <linux/gfp.h>
-#include <linux/swap.h>
+#include <linux/buffer_head.h>
 #include "internal.h"
 
 /* A global variable is a bit ugly, but it keeps the code simple */
@@ -60,7 +60,7 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 		static int stfu;
 
 		if (sysctl_drop_caches & 1) {
-			lru_add_drain_all();
+			invalidate_bh_lrus();
 			iterate_supers(drop_pagecache_sb, NULL);
 			count_vm_event(DROP_PAGECACHE);
 		}
-- 
2.51.0

