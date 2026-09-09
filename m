Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2B41D4EF
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949390; cv=none; b=bAlkVS9dM+K2OiLnth6vVZ1BD3GPNn5b2WgK+JldIJZiYvIgYiTjVLs4+ZdhZePLPq2Qa8pEyd1v4zbbFYws2I2qmUorlfcNMFnBxU2Ixy4B5TWREm9EseQeHLNsUTbEDc3ZqjZazj+08ifDVgOEnZAocAZ+vLrNRENlQgADJ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949390; c=relaxed/simple;
	bh=RrFIEm8SrJEjhBjzApoefNfd8aQaR4Oxfr/yDuZhFPU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qoGtN6NksbHD8YOY+ziq5sjSnBDQ1bPRHMymUVECpeXVIek9J8bKZLtqCAXAL4Vjbuu2luvi01nSK0U80yai7j9PXDnVrwSXXDc3UfdKWwGNjHxL1eJNcNZUQPm7nnTfLmjXW7pan4McaTNcT70RQKIZfWh28ttW5lg2WTEJJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZoRzlaCR; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZoRzlaCR"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8588583a7c3so57687947b3.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788949388; x=1789554188; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2UY30k1UeQzYu1OvDSaJuzIQ8I7z52NjmS+xQ0qJeoY=;
        b=ZoRzlaCRFXhH6gCaS3eEcmQTSTKHzTmJKAFmIlJChPlLxnQWPDvmcYyCo34ZtQ4JwK
         9liXSr9XQyn6eDXCJA0PhPpYangmdjaKltp8Z2mbwnKEma2qNUWjNKz+LESYTRm312fu
         Sc2okpFRLO+NTb1xQex6y7ciauOwGUOmKDcTtFcBSI2lASywJ8vrz8UZEMl0loeyEdqa
         akAq9L9rAqzMHpqT0nf3pI09liWo+VnpxJ6a6l3ebqBnbZE3pYUqEUc1ioBb925HCRSY
         dTbxog+PSoprsbaLQk5FE6QVEYobawHzFMMEdh36UGK8SY6HxDgd20i6s3LNBr9kC9E1
         5F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949388; x=1789554188;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2UY30k1UeQzYu1OvDSaJuzIQ8I7z52NjmS+xQ0qJeoY=;
        b=tIRarSX4yoLJh/ScONSRCKvRA87zzw9TjpzxhaiAv3MgNm9m+tNEMCPV76arl4i+j6
         mYsZJOZBg90FlOIK/hiT94h1lRf0sS+4EywXKV1JCs6wOsvI2/l3aWOrKwnEv4UcEHgD
         mGX84jamZDW1iDt91/weO1xbSX3mEgd61brgMnWMQ668InyQp1HesQfZPgu2vZaYQOCi
         CW4F0uyF4RErj08MJCiP9SPuDhWtuTMZtu1R8orrWecDwLPTDFX9eKufq9eeKTjC9XkX
         4vPQG1F/FO3DKJDifpLOQ2OKZiQcuZ/Es5RGLn6jlTAhpC33g1ALARIdDMnLG3bkTlBG
         BVNQ==
X-Forwarded-Encrypted: i=1; AKwUvBymZXrDnDA2j4IJBKi3GkgQs2/IqA9fT4T+oNwU6i2RrlRL15/fgM8VsdWWTUpmWS/wN4L0oOrpRvL0PA==@vger.kernel.org
X-Gm-Message-State: AFuF++ntNa8DRK70QUvzZHO9WcgNlYXlYj1NHjd8QeQOIDRzMnuXVGGl
	fHCDuJpXZMRjnmyoBR5ungQVwWSdvT28VU/B7z5VHeT24uAX0zKRVdB0YyUTAiPG6w==
X-Gm-Gg: AYBFou0xrBRdrhYfUeLeUZqgBP6Lf/u+lH6+kFK8bjjrJ+/Q/0WgFBxr0nCJI7nXs1w
	N4E74F0/FMP4CqTmAEVajkDLa1PSsLRhMyJ+ug8xeWaGYvsaIJuFQLKcBd1cwlgXENztJrgdeFc
	+O4vd3Sy4gR27JMoAFrSdsOP3hCDqwpXhcuVcUiWKI6sJoD5Fl+pgI1l/GTlOOJkPSU3sGKfTdv
	mDXIwqcEUHwdczjUUWnZKF2weJvOV/Hmdnqn58nZd9g+nCecNK7NWYzcGindToOEyJfkI9Sl8gu
	jIGmpeWfe7kfU1NUfiwfgMFHkhaYKAlK+6dQ882adTHwSrGoh1qrX4U/9aQdL9K9ezOfVaRDIp3
	o//7mNY7e9ilRVfz1xMzH7oHA9jfBuI2SeiDCsFW6uuwdipFcRdQopOEs2kjDWmRJvTlMH1Cc3Q
	tN/QOXOZ2b2FnGVAXbqTzzqMY27CSZJIzFnmA6iBYWJzRIelBvNDTINUMAlCKN03vNpxJLE7UbW
	lbYFGcyr2vZQMj7MXZTEyQh3TVGz+eW31VeWsmDVt3S0gccATWnhbQbdLk=
X-Received: by 2002:a05:690c:4b85:b0:870:c600:686c with SMTP id 00721157ae682-87126aa77d1mr116385687b3.18.1788949387337;
        Wed, 09 Sep 2026 03:23:07 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62503dsm108473437b3.38.2026.09.09.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:23:05 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:23:00 -0700 (PDT)
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
Subject: [PATCH v2 20/26] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <d8a9dcab-4fc6-1f28-d6b2-e9231f3ba150@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
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

