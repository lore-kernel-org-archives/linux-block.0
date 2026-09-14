Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BA54749DA
	for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415724; cv=none; b=AAP4/hcQ5MZTIRBLam+g/sKV7QXlcDa8edQdRJhb/PKjMftWpnfOo70jbrXVkssnqfrAFpgvgKUJNvoXFPyHhz9OSagKmIarVzqmU2biqrfxjCKXtiyu9IVRyBz4CJNmty/3+jBIXV2KzX6UA8UXDKISlIANtyJCQNc9x/345aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415724; c=relaxed/simple;
	bh=Laxp0Q4fdbSsx/bSE8DTPChd1Qoi2LY7exp/DnLxEmU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tuj7LRg14RXJEGrpbJ3g2DxGtDOCFg59XpVHnYF2IfOXHUOt3Fw+UJluJ/qhIUGmTdKvv+uqgp/b0kXsoAxf6jTJ/W1FzP3+3gHVWkQFRQ+SKxFLYRAnztL/O1FvImweflxi/9LLjrXU9MFUT0S+IxWrlDwykGxzz19zAzMPtl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZWWB0ai2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZWWB0ai2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49e6deb520eso32174055e9.0
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2026 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789415721; x=1790020521; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Laxp0Q4fdbSsx/bSE8DTPChd1Qoi2LY7exp/DnLxEmU=;
        b=ZWWB0ai2E8LEiUs9dj7YmK8iWFC9gI6JB3A5pYaQrwS7PuRQnm4TfTsi3tSWkIZ/xw
         LQhje18rNeUA3tz7+5HBt7vDbnnmFl6skKUYmWYAHRVzPUMtFO29XFum/e/ae7AuUJ6d
         BNWJkh8AtPb024c1+bPWZf70JOWyCRLoWwVcjjO7h4o606IQKmTh7xV0pNghACpehWg2
         uwEGTI/s/A9Yr+zyjYR8d3Oux/sZ1T/nVhnXwNFCmI6+bOaFh8PW+kCUAs72g5LEPM6+
         DfO6I8IGYheougyRGiiLg8xvnecFuATVWZ+Fh11GW87PsG1ORd3kLW4Qbq3wZYG7XZk7
         BmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789415721; x=1790020521;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Laxp0Q4fdbSsx/bSE8DTPChd1Qoi2LY7exp/DnLxEmU=;
        b=IMInbgMKXH8gjDHemUm/MVfRiKVXTmauuAfD5mA2NsRbzLaKVNfBfo7pzXMhD1Frrh
         ECCZRDUSAXcEbaWUPfC4DXPyQa9VvfP8Ziv1VjrXcvg+kfHVsyemrKuU0RB1fePwefJO
         giFYN2iUCqJqgG8yVXsVFfN3ELbAkhioZxgqYB4Q/hpj+ipghaNWzsTxkTHVH3bUt9OJ
         Qqff0sn+UjCLnSlnAC+oS/b+ymhpkQ3e3CCE215gOKpKdvj1Gd2/aKIgWkWLeLadY5z0
         rQE7CU0u71fcTDFcCbNLJXQrf/bYXiXETCT88UUStAX4NmFUZdl8mfvwj1y6qtlkx/kr
         ruvw==
X-Forwarded-Encrypted: i=1; AKwUvBxwLbymAjz1OOipp5RUGWMJRwcU35HJGsngbDu9LtZ7+gZruNf/pwx0cVPHw6BxjsLDt9dH/4yK51GzUA==@vger.kernel.org
X-Gm-Message-State: AFuF++mSJm5Bfw4fp8KpCwHpXsF5IwBgVPkH2m2rDc1RCdlgt92FaH22
	S6r1Xye05y8Rw7lTJQ/edvvZ3cGWztKYFUYmoB89uZyIX1vqMDExzXBbxdI1rVsj6Q==
X-Gm-Gg: AYBFou1MfQfW+0KzxzS86IbX2alIgRZMJhz28EWOBpKoWvHVlLZyYX89ADUOgUWS0vC
	KpsBp8I3ybp6W1vWC15icwU3h9+aKmTi9GnJeWtLEk4YefeMjZjDn4Al1oXzpOVTo2pkWN4MoEd
	GBlxZAp+vPurO1Nm8toCy5bNDK6HycqlmfeDATDOE2ELScjKI3+ZYgoIiuIHZrl6OSkdbIseyAx
	Rg8x+pDJY+vRLDkNYa78SHZH8OfPr/DRJ2n8Wuz2cj8zFXuwa2uCeqxcRiJ4/DxFXSjbE3pJMx3
	luSm5p3TLBXw4qEsekJXpZ6kIJsXWMEBjqRdIBkgFEvqiCpz9W45tnt/KgFT92KWHxzWcuJoJTg
	claFf41AkKR2m09/ElEnhLeYTZvRI6eZZZ4WhQoLQJwQPTYmQyJAyY+LNJ8IoFroF2DD7qLqWuw
	5FsnVLDXcE4MEWSU1CGWBOn9HB5QrqYHVnsKVD3UKfxO9unKLAkSIB+1soO1/wg+hJMIDvkExv0
	n7+NwcBEuUwf/hhgc48OA==
X-Received: by 2002:a05:600c:3b1d:b0:49e:74b6:740f with SMTP id 5b1f17b1804b1-49e7a685a5cmr49653885e9.17.1789415720432;
        Mon, 14 Sep 2026 12:55:20 -0700 (PDT)
Received: from darker.lan (104.157.125.91.dyn.plus.net. [91.125.157.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e6f1sm28315322f8f.6.2026.09.14.12.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:55:19 -0700 (PDT)
Date: Mon, 14 Sep 2026 12:55:08 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
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
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 07/26] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
In-Reply-To: <bbf33dc0-6812-f204-188f-f2176a4faf4c@google.com>
Message-ID: <60bac57a-e486-c0af-1a8e-583fd6e939cc@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <c44a34f8-ea3c-48cd-27d5-02df129be685@google.com> <ddab52d0-48c7-4d2c-b403-45f11e041654@kernel.org> <bbf33dc0-6812-f204-188f-f2176a4faf4c@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 12 Sep 2026, Hugh Dickins wrote:
...
> I have kept the address for debugging, and do put it to some use in
> the paranoid vmstats patch 27/26. On 32-bit, with 4-byte pointers,
> this LRU_NEXT_ACTIVATE bit does then leave one pointer covering two
> adjacent entries, when it's deciding whether the folio points back
> to this lru_add entry. Is it possible for two adjacent entries to
> hold the same folio (and so perhaps miscount the stat)? Yes, it is
> possible (if that folio is freed and reused and readded immediately);
> but so unlikely that it's of no importance when gathering stats.

It doesn't matter at all, it doesn't affect the choices made here,
but I do want to correct my estimation of the likelihood of identical
adjacent entries. Perhaps the most common occurrence would be, not
when freed+reused+readded, but when isolate_migratepages_block() does
that little lru_add_del_folio() + folio_add_lru() dance. It could be
that the entry it "deletes" (by breaking the linkage from folio to
fbatch) is the one most recently added to that fbatch, then
folio_add_lru() will fill the next slot with that same folio.

Hugh
