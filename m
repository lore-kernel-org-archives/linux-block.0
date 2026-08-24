Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEA1439008
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581412; cv=none; b=rxU+m8DX83/zhMRosYMPX8o4isXSu0MKJ8kZlu7u0KDK5YVbN5tajo7JT57YDQ3+k6uQiI6c2EioGgNlE2HzNgpXa/avHbrP9hJ1AgUk0rncMkeTZ0gUq+Mdbw4CXjfYQiNlM3xWnPyXrfw12nCUHlHFf8lpnHycn+haDX+FOPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581412; c=relaxed/simple;
	bh=6kB5h1HEECPTicOG3LYyogzNQExsOtWLu7kTMzR5cg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JoKT1PdiQ7FRO0z90jCXgGrsLGfTXwXbw3KzthwaV+ce/UEBxVsUpBe7+lAWwpkmJ7AqLn85K+KC1J+CqwbNglOESGvS336P44d0xlLgTuc0FihTMiIy4AgYzQk/Dp4IFsl9CEA1rKiz0OSUH3aa4v93fN1r8/NNFBi1l8QW8T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qTL5iIIU; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qTL5iIIU"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836cb2fa1bcso53083727b3.1
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581409; x=1788186209; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAA3AJBckMfL7iDkU5H4UAChzqupIeoXexgfVyLiXUk=;
        b=qTL5iIIUHVBB9JoHNIpqnDPZ8Tgfan4sEu+QR0jdnehPcdRuSmmSwrTk5iczR8q5DD
         600sh1DTir0FNM08emH2W9KFR+c5JnQvIJhyb3T26Cw4B38BIWghn22vvykMM45M388U
         bJnjrkF6MAh4c/yHo3+o/t/uMp88ct+95h8a6fHmgzcnDUYnTD7ZsU5oDvccIbAxwtl2
         WXjIvy7nmjcYv7IeJhvfOCQdnexTlqMx+eN9GT5NvTXc1Pu3tbLAzS6FYPxnkxx6+ZSN
         Op/Oam74dLn3ZBLZnFPzkvHBG35ayFwnOvUGHFjjlvN6wqCLJ/YOlwnFTazDqJ9O/4LZ
         BUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581409; x=1788186209;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DAA3AJBckMfL7iDkU5H4UAChzqupIeoXexgfVyLiXUk=;
        b=SpXzw6VSJp/i2L8yjelEjd07LCno1+LbLm/+uqtX2Z4nDnHXw8mlq4DMTFV6IBEv9A
         NzD3nhP7/37wjOjDdJtsDqVWgc8CwZPRRUAQMqfko4Y/Sa0heNo4f1VrKhp9o/EC2a7g
         MbOLzGrKov1L/SAxVhtCcK0aaDFOdVEGn6JNkE3DVKnM9HpJj4Jt2zDmdKCHhfLp9sFE
         LREV8A3cDwrY9Iac6qsnoGtRy6BnxLcVX/2ZakyLp3k9Jbb2wtil+fUZ95sQluXwg/6v
         r/1ksapgY1wXg7Ox5VzX/DOXGUhYwD5rAhNzY/JkDCiypX6+mOvRNoMGNqO4Rornil+R
         d6MQ==
X-Forwarded-Encrypted: i=1; AHgh+RqmS4zKWtqoltSMh1QG+V+/T0zOm/W7/m1Nfh9WgW7QQruPQMtisF+2EJ6dRF6yufl6UCHwo/j74eCOJw==@vger.kernel.org
X-Gm-Message-State: AFuF++laPMFSJO/qI3GcFjWqO1EC85vpnvtAkxDYHBxWB9DmQi+uSK7t
	jnjcmSJi6QQiBuqQA4LWZQGWxX+1q7Si0t80gx+vh+DH0kIy32uhADfjqkA90UKWjA==
X-Gm-Gg: AR+sD13qCSl27ivWQ0IMdWBgoc1gAANdKKTlMBHLaWjYEhTbfMJMy88dWdHv2tpe8mJ
	uAKIcxrerzT/sRESbELzErvH0FB2gNEeXexMwa12D0bnq8x8Ht5oCe60EfD2HhAWnD28Tn+nbac
	NeT1V9wKTH/OCGE7RszPiHUjzw477PRy/N7gV2pc8yIV4Niw3jwlsijWr7y1u+fGt6DItX0Suiu
	vqlbWwq3pKNw9g5j1DbzM1N5PlsUSanEgV487SfWgXx53nxM18Jaj+7vEeYjcMCVpbFqpQ9xgZ2
	6W97jFnjNHtRsdsB6f+y9juyIdoTbnEIjSrPd+veuU/aqaveEDU/jBV1Mb9Irn7ef0kMypil0R0
	kioHwXKU2vJHCIwfCeQ+EHGbl/aDd1ivatucHnBJEy5IhTG5hLSrht7dPw4BACWiRY6kDzQwH+S
	eXjfdbvwC/hD/mWeK001OdPtFxyubp5zQpzqu9AtNdBNAFm4PrPNY9EGY4oRO+rkvFyxt/8sYxQ
	5c8squV1uf7+aSgJHsuu6bfERyR6UcymrAimcJwX6e0uxJL
X-Received: by 2002:a05:690c:a4db:b0:80d:a249:4854 with SMTP id 00721157ae682-84c99f902c3mr43542587b3.17.1787581408945;
        Mon, 24 Aug 2026 07:23:28 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cab854483sm33838647b3.33.2026.08.24.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:23:27 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:23:23 -0700 (PDT)
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
Subject: [PATCH 13/25] mm/fbatch: no lru_add_drain() to
 collect_longterm_unpinnable_folios()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <fbf3fa74-c646-8855-17e4-e8b35dfd9c14@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

collect_longterm_unpinnable_folios() has no use for lru_add_drain() nor
lru_add_drain_all(), now that the per-cpu fbatch references are gone.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/gup.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 99902c15703b..9616379ab069 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2268,7 +2268,6 @@ static unsigned long collect_longterm_unpinnable_folios(
 {
 	unsigned long collected = 0;
 	struct folio *folio;
-	int drained = 0;
 	long i = 0;
 
 	for (folio = pofs_get_folio(pofs, i); folio;
@@ -2287,19 +2286,6 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drained == 0 && folio_may_be_lru_cached(folio) &&
-				folio_ref_count(folio) !=
-				folio_expected_ref_count(folio) + 1) {
-			lru_add_drain();
-			drained = 1;
-		}
-		if (drained == 1 && folio_may_be_lru_cached(folio) &&
-				folio_ref_count(folio) !=
-				folio_expected_ref_count(folio) + 1) {
-			lru_add_drain_all();
-			drained = 2;
-		}
-
 		if (!folio_isolate_lru(folio))
 			continue;
 
-- 
2.51.0

