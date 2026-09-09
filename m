Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D5B48E0CD
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949514; cv=none; b=Vc7HOXKpnMAopfgnBneB+eeUplaOBU25fxjwF0nfk8/1Ko2U4hfqnenq2j8xb8wjxLh2+t5+ShRaIN7dtPJ/pfapgRKbH2wIWSjrdBBMmBAQ9WOpScnZb3i9OrdSUQ6Umd8t5lHt0uSCAlXDqUWzkNqYjmUBVUJdOVIHSL3ErxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949514; c=relaxed/simple;
	bh=PA7/Pbx5AEThbU1dExwqFT9w9coLuAoGrR7Ue2+wOTE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZcC/ejYr9sRHE+bFeDPFdvLVxtvgrbSanzbiFlv2WUn5OHAfLvujXrOGzTNi1RFB4qCCWQKk/jIooarbhQ9PWAQyyOQXX+zYIX9uVvxAcGc0LNAjk/dosLssoG283qpnYoRDFZ6QF2ezn5uJtIRJR+C5qVJ6PaCf7lhGH71SwoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HW+EaZji; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HW+EaZji"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-87ab6e5f91eso26412637b3.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788949512; x=1789554312; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbn1aAX73v4jfLOAScY/xk2YxlfOe4UtWahA1Ug2y2k=;
        b=HW+EaZjiYCl68C/eh9GtTeuUwf78zPfGbkzhXivweQVojv1dxlQv6iKtumQ25xbgD0
         ytVgs7VsVheV0XktCqLX/GcVUmrWu9tquIiesM9bgC/EeimVdpv0yrd1DMlMlr7VH622
         EVqOuxKrljgR/puRT5ILgOmsugaRxrjhp9EUxp96wB0u9Mh4NrG6oKBALnMdztkiL1y1
         raKA/B0z8YcICgjAayDUFOe46xzC7ejMAhEcvp5G9PGZ1tivkFZ0z8ghLYhXH0JKCD+H
         X/zsca4oz1yCyhRfzVEfS4Ha3sR4wu52YEP/pzWGpOA2TlnPCPCagE0Aoy0lV5GO77hI
         sjJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949512; x=1789554312;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbn1aAX73v4jfLOAScY/xk2YxlfOe4UtWahA1Ug2y2k=;
        b=ZARgdsnpxQl4XXgTrsbiT1DWFTN0SSvq3jQiF4jBt+wIMyIT+LL0H3gPPHeE9W31bG
         k06EyzIgFQ2rB8RqCUMyAqjzvOml43kFPfUfcnQqgjdySkOZT/rQzWOiCV1EOlooty5s
         9Oc8yF0OOSv1myHMEn7oObMEvi8Beo6ACCqkMRzcbFReEUxPhFE5sJRFhAMryMD++40Y
         GvC5DApZJ+lWYWTY+QjW009DigN+ahrO88j5lGRhLOl/KD0QEfUt3j5+AXeBgdGBhAtm
         C3fkbXWrx0ycrUb3gZqMEYYd7V0BDamjkaCbi24TDNf4XKXRWkUJG53h1H9M8wNTvfvj
         4o7A==
X-Forwarded-Encrypted: i=1; AKwUvBz+4fk3x3Bxmk7ZosvBJdFnD0E1VYq98/FaQA1qM5QwCyf5SHdWUf5SkSzqsqk9OP7RJuj1/o2KgsDlfA==@vger.kernel.org
X-Gm-Message-State: AFuF++mWFqP9EDum5JRIL6PifBMc3qIpt/MJo+4m1wH0BBF5QSsGxWb/
	tFQ4iK8zj6HiU4HOkcIuhMd9QC+dNHxKkapRqS10g8CMXUgnuZwWxMyaC2fIaZGUgg==
X-Gm-Gg: AYBFou2yI5iR9aKJSE6qkJZziPncpPeJsl93WA7bQ5/GSRZXrJ+XtTG0IibOPK4eupd
	266SZ/jQxnWj3uLpF5dp7UTcvdw75PeA9aoIqlv+DISCnIfnN8KTeSuh/GQWT5zkE2Qh1MK3iLY
	70fvFmfE7/8b8vflJpTRbukzbi9uLbk+prpEuk/3DMXTVWdwu/OhLkbRL+Ms5GKnjo9uwyLrl5v
	NlkWPY1Qup1IjXtUlz3k7hG6KCZkLUxgJxpQvJx0B1RgbY9SScyXurMB3tarwdL41xm3AmFfNHW
	P1hcfGw2TpydUwGEDKIW5ckveh9uyT9fDY4RFIzqpPBvNkvXJApSBfGh3SjKekXE4rUbeuVYNC+
	c5ss658PaLKWV5+tFpAISfG/B5E8lO1mXdEAhOTqSviv8bwdaLMB7IJkMZb5QdBok2WeFyoSrhg
	fN6Us+DByG3X5A30wf9nW/8MGTmncYCS/u/J/7VHd6XvfWWwb2TA5q6hsY7hbPbai7ibTPiJrR4
	pKudkXwvu3TI7Hsfx6EsvyyW7sBgODPAVn4KPRnro5WbCA4ljR4w+126o0B6XmPf3r5nA==
X-Received: by 2002:a05:690c:62c4:b0:870:96e4:6716 with SMTP id 00721157ae682-87127b36981mr130530337b3.28.1788949510969;
        Wed, 09 Sep 2026 03:25:10 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149315162sm107287417b3.12.2026.09.09.03.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:25:09 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:25:05 -0700 (PDT)
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
Subject: [PATCH v2 21/26] block/fbatch: no lru_add_drain_all() in
 invalidate_bdev()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <0debd9f6-0ff8-31b0-4830-3a81ba56754a@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

invalidate_bdev() has no good reason to lru_add_drain_all(), now that the
per-cpu fbatch references are gone; but keep doing invalidate_bh_lrus().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 block/bdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..853545b29b7f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -97,7 +97,6 @@ void invalidate_bdev(struct block_device *bdev)
 
 	if (mapping->nrpages) {
 		invalidate_bh_lrus();
-		lru_add_drain_all();	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
 	}
 }
-- 
2.51.0

