Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F6F43E9F5
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582360; cv=none; b=ZZzLx5csLQ+oE6ItnMEulKCHr+Jh//ePl32sam0LGWh5Rs4lnB1fFFGUpvG2uXAeFHPG5OOHz8q8XcrSEdB8Ic1r4lMWXIU2tw1SXlGNYxSQTQ6KyFqWj4cWZoTxagr5P75eXqtQk6Xpr7dph93GzIP/GcBXJDe3Ai8eMUxl8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582360; c=relaxed/simple;
	bh=RrFIEm8SrJEjhBjzApoefNfd8aQaR4Oxfr/yDuZhFPU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=r1wPV3AaoPizBQxN9i7HrTnQw2RwKVSrprmM+CVhvmt0IujjPM4W5Ovu+WvYZVFSHerywr3k2GWc6s7s/1sfwDCykNDvdN9nVjBPz+HvtlLD76ZKKqVSzBCj4NeMoMhlYoOrbcyUm2D1D449zbCkUrHlgxPtFafDi9/oY6gjwLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vHmlLxfi; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vHmlLxfi"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-841f1dfc30fso63219137b3.1
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787582358; x=1788187158; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UY30k1UeQzYu1OvDSaJuzIQ8I7z52NjmS+xQ0qJeoY=;
        b=vHmlLxfitfZqNVju4Fys+i9kMW93CHbXhaQ4TweDYrYsnvNOrqfA4WWNkrT0GV/92H
         PYd56DwBcbzMkwVcAQkmr6KBnZVJJFOZsXEUcuPVnKXZwJKmJbGLyjkZerz1wOXyeEbD
         an7AWJQPNPrc/LaH7IVqH7T9ScABFmmDf224G9ZCReXmuCjOBYVw5TBayV+7kijVrrhf
         Jf2qsaDgt8SLMxtG6ZtvLErEWIVT61s7PJbodg/Md5vdN5JMfweDOaTuOU82gVunF2Ff
         9tMKMIW/oJYKvQXAbp7KTKpCVjXuhACi7jzA9Ay0MgByz8RsaI30eSuu6zLynm4l1OHD
         tZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582358; x=1788187158;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UY30k1UeQzYu1OvDSaJuzIQ8I7z52NjmS+xQ0qJeoY=;
        b=pWKfBCS2HCae8pCRbKGy/Bkt6WAHAY3gTekcMgD5Trf4G7EJ0bZ/yIkBE1/CDmVbG4
         lTHEzOjFXOofWaIHbYtyjFHN2HCSteGAPtuLJf/idt8dPxuWW5G82khOrTrnxCTzFhv4
         Qpm+tjkdLh1FrzlsNo/w1jGgFiisBAAVoCx4f9UGMG2IKsx/v4rlJja3kWGwHMyC43lK
         NW5lgdTCGJoixAyoH9xaZHO29rk8CpZAEd0RJMyioMMOo7vSlLP+Vs5RXFI1+lKgv/Ke
         FYfQ+OlJAF1fAl5GVVV9hWzq04vZiiO0Fm6cQL9eIEc28OHldUjpfOq1wiFY44QoyqiM
         bRiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrs3fa1uD+WilxGlnfYUwqlZM7gkO+BOUS94sZ5AhunL1lu6dN8viTIefo8YUXqivWEP4iKxg+AwMk7pw==@vger.kernel.org
X-Gm-Message-State: AFuF++lFZntL7ZacQfFSQisak7SYRhhx1sDyES0vTbiymU2z7C7L5qG4
	cE5i1qYhO+oTJnSKFB4oG/oTAF61M2Q9CMNdrE3FwLq1FxgqtrKPcj9iJEbaSaUzYA==
X-Gm-Gg: AR+sD11yZHFdlRHMcArtYX5FibRyCxrOeJlvJPPAQtrW9YCHGYkp0xWWgM2Y7LPvOwx
	XKNXMRdHOTlf7UUmXBrxest3RHcDXoFE5GVkQmaZCXy2Se477Nme3t6hgTMzzSHGd9lIo4vyH8O
	uezGmEMQGWebbyhOMk/LTmK7M5Xk0dMBtCkhHo2Gq0q+6L6whjGpALNiiSai9zqr6YI0wcaxw3+
	KRMi6ld1CDDqXkXBraRkr+O0GHraHeZqnDhbFwTS5vAamcGQWIVxVJ1yE7Ex/5DLK6dU3q8lcG9
	3KS44x6Glt0F3Hw0vg0pbyc1bARD4q5hh65LKAo+qAK5hIL5quzKb6o3fN3GATRtgSzw/nxbA6V
	YXZSqEz8oAZBIuafpiXr5AO+4WY1pRAhxgzFoFJNDoy3o/+VaSXttk9lclvR+bXcGImGVHyMnBr
	Lkc23+yKyVtagnTKE3zQT8t3KtZKi4a2XzJ9vVMvmbkwOoFj5A/x5NJurtW/rsNSmQZa0Lm7Go0
	UEj+HrtWXCByfdFby371PEo5kCTzvWYs3Pbi9kt9pue6pAy
X-Received: by 2002:a05:690c:c221:b0:81e:a373:47ad with SMTP id 00721157ae682-847073b93fbmr133529677b3.2.1787582357182;
        Mon, 24 Aug 2026 07:39:17 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca5188982sm35471097b3.10.2026.08.24.07.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:39:16 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:39:12 -0700 (PDT)
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
Subject: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

s390_wiggle_split_folio() has no good reason to lru_add_drain_all(),
now that the per-cpu fbatch references are gone.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 arch/s390/kernel/uv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index dc14ebc0105b..120a467026a5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -364,7 +364,6 @@ int s390_wiggle_split_folio(struct mm_struct *mm, struct folio *folio)
 
 	lockdep_assert_not_held(&mm->mmap_lock);
 	folio_wait_writeback(folio);
-	lru_add_drain_all();
 
 	if (!folio_test_large(folio))
 		return 0;
-- 
2.51.0

