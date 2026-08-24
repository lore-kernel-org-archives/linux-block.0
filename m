Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED6239E60
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583082; cv=none; b=ovxAwEkRdy3tguZ8nyYIcCbLjr8Yw5hR7jUbMYhBp2OyyyvE4gLZOVR8S7QqfhWgeVhoSQ9c/Ia0t3hWgp0BV9xUum187mVRibhOhWsorqDBVrVapccun/yxr8YJwoge61imoNi/EolUakvSi+/Iml+y+tGGYBfwJObo2LuJMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583082; c=relaxed/simple;
	bh=7NJT4klpwyNAMnizim7gBiFUSAGUskks23qiOn/LHJk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BNH6ZhDGL0GJ9hsCATqyj5+FEIWPf99MWqhTJKff7CLxUPCaUxeTgldsdGU9uFuNOoWGtrX5GuqGINOef+DrNPcBr2WBYgG1ABHWKAEHJHIqOaRowIkvC2t04CVDs1bbhww//kXCN9zk3I/YSFgYnnW4ok9Ys7ir0BTPfOsN6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S6ki/Kff; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S6ki/Kff"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c67a73eb7so6826416d50.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787583080; x=1788187880; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oBC/SAP50I4KxaPevcH0bVL/Jm4cuaV8N0/RCICjbNo=;
        b=S6ki/KffP0CvW4GdH1OievddahR9ZfFf8YPANe+JjHk1n5WhyjAXSp2eLSrrF81MS0
         vewun7rPdck7G1hU9NpG7nNY167RPfM1oK02Yvkx/obU985dXLQ4KuMUrZylgGAtAsRE
         BdgUc1mSGWpwfTcTETXOExnNb2IQXWIA9t16VebWo3C1cjx1tpxC9KJ/QaGsyXVQyU86
         63RPry+8FEZ+a7ZkTh4+JnbYefZf4LH92gCAcbfMDzflxBOzD9DD+EE6XWDDUN6TwYbo
         plugGwqaZYZJ+gm9flXqaCswhY89IaRl09bCJ1PGT4/tskvt4wx1XxeJwFWCT/DQw9Ed
         QUEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787583080; x=1788187880;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oBC/SAP50I4KxaPevcH0bVL/Jm4cuaV8N0/RCICjbNo=;
        b=ERqrRLhIJ/sCkQN/fn700BPdQkoj8iG2oIrEoNSI+3gZzvMdU67zUt+C/ix5wkC0o9
         K2/Ere+YLdN3ULiP8CNjmy5qCJix+NQW7WnOEPHnPL5Acj4kfH57W27QeuRWwqmU6ozO
         oeAudNa/0aD0/6bQB+ZkSyOMBCenH/naMxWU62DSEa3yrli9jNYOVspEYyGqvc5dbjf4
         bbU9VvdyYU1MOWLopDfB0P2rda9QBIGlMUniaMBIx+FMrF8N9/3nWUIq6m17JSTcnALk
         7nh22XI+EDINYvwHGR6KYj/K0LeGVUOERihABp3Es+7bo2L3r5Zpe/0zvyz/sQ+UEP9e
         DjLg==
X-Forwarded-Encrypted: i=1; AHgh+Rq4xwTiy3Gv50A+be1VGTr2PMIL6d7tI5xdOXRRgzlFDgg1vSaTiN2P+MawtKGP+UQEl4okelXnYhJrDA==@vger.kernel.org
X-Gm-Message-State: AFuF++mxKofhSQv3mkUu+vGeD2WsPzblAzr8x+6bQSf6BEDtU5yfNpTm
	otDdCGH+Cr02fYYCCGhj0koDztzsdp3gdZOf2UuQTZyBWvvWZSZ+44YlfBO+wVZxIg==
X-Gm-Gg: AR+sD10k1mRhVO9QneMS/FTk/cCnFiPLH1K8mLTzI1vauSuYIf4LFCfGfQPuDEvyhAL
	VipmGAUOm4Nz65xboHGxCsEWkKKzFI+zQuZAwhtJClVF7yH+HnHSd270Ao3cK/Tb4k5wJygY8Ac
	0uXqys14iVAVdFDdyPQkFcZ9iT27tQLEMv28AkqE5tcLaMAKnk182/EC6SrQDYS3/Sq3FTlBxFK
	o64Z+i57T7iRyuxfGxLRkNKVU0Q3QDuXlxRFCzySlXk53NlkOFNRhMxo2PlO6t+i97QKRWbACmp
	2c/7JdtrOXWjkEzf/sqEoibIrmg42DsbGQ9XkFG3KNhYKpIiFr9g35rC0cEjz8eoiZZRdIZ+7jf
	JnlwYJqL/+8R2V7ydHKM8mhA5vLdVM3d/s2aQ24Zod9/hPeCGivJ6ldM0TeCy5rYBve8RKGgttP
	Ik5yuJBhcr4N2zfAopU5ISgryVBcoz4vniGv4EIESYq+BIRm1woPIAwY4VvEJsDn/nG0V15CH0Y
	bBY5jG94r+BpRwkaoEPJ9J3IuYZcFPxmut7+Ip4pJcGi4H5Y7HVO85ScWg=
X-Received: by 2002:a05:690e:4843:b0:66c:e378:bd2 with SMTP id 956f58d0204a3-66ce3780eecmr7793232d50.22.1787583079315;
        Mon, 24 Aug 2026 07:51:19 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac01868dsm34817937b3.42.2026.08.24.07.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:51:18 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:51:12 -0700 (PDT)
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
Subject: [PATCH 25/25] mm/fbatch: move lru_add_drain_all() declaration to
 mm/internal.h
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <552d4644-995b-e605-175d-3268b67adb66@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Only mm now uses lru_add_drain_all(), in forced reclaim and in memory
hotremoval: help to keep it that way by moving its declaration alongside
that of lru_add_drain() in mm/internal.h.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/swap.h | 1 -
 mm/internal.h        | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index ddfd9b7bb861..94b694328ee7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -300,7 +300,6 @@ static inline void folio_add_lru(struct folio *folio)
 	__folio_add_lru(folio, false);
 }
 void folio_mark_accessed(struct folio *folio);
-void lru_add_drain_all(void);
 
 /* linux/mm/folio-compat.c */
 void mark_page_accessed(struct page *page);
diff --git a/mm/internal.h b/mm/internal.h
index 7a301c401d39..73d618254a3b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -57,6 +57,7 @@ static inline bool folio_may_be_lru_cached(struct folio *folio)
 }
 
 void lru_add_drain(void);
+void lru_add_drain_all(void);
 void lru_add_drain_cpu(int cpu);
 void lru_add_drain_cpu_zone(struct zone *zone);
 void folio_deactivate(struct folio *folio);
-- 
2.51.0

