Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFD03E638E
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 08:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906473; cv=none; b=quhAKLiGlCa2f7r8jn+d8urdATPeXH1FgiKPgS8NWNen9lovwlt8vHqcdKnqQVQ9b4eKWDIxPs8nxP+zgesl960p175R87BUvE7makpyUuzwiqbSTqsRWDpvRtyBidx3ddZpAS28ab5a+8HSBg3P0M0l5cA0qaps67NlDhyAzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906473; c=relaxed/simple;
	bh=hrY4llJi2AlzZ5c1W4tRySENqKRU+7rNGfd4hHgfsfA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HXIAHpsxf7az75JL4a2bJnwaHvUkuhErSBrp0rkvPcWczBO+eXo+3kYE+tX2NrMbwSWxXnOalyxeuuo2mVFh06nESjY1tyzA7gK3LKKImEiStfEhdoLrlutqA4blfEwGW+iHu/tKJxkCcGr2mf0F/+M3TcbiGEIUfvbQcDBY3io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wcudiWAl; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wcudiWAl"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-85b293528a9so23366287b3.1
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 01:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787906470; x=1788511270; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hF7W6IgkqW3BA6qKiN2sGuxt00zyQz6GHtb2s+mggXw=;
        b=wcudiWAl66Jp1oIAZOxdKfsUPYY8QvwHfXuetwh3NWJlpXF3ftS3WhWQQuzeA5gpYA
         Nyvm3x4l+KWwBEJCv+qNJX25JAKtrhXqGNQYvJqGkvYfP76Ip3xPETXLwfDTx8eEuej2
         ntKI+g9EB9TO5SL9SxFjcIaq2YXVO+HTzs4IH8/GeaVsvEr04xdSJ6MqMvlYmvYLTbDy
         /d2j7evP0q6Bf0C0BC3PbCi2aa1fDAuTvj9MCZpI5TuJ+IUn9wEe47qbhCspI7+6u4Q/
         sHDnwJ1mmtOQKPFH/mi6iW0ei0u0r61fqo8cOhEvz8G7di0tnOXhOnrNyIxU02k5ayiI
         gfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906470; x=1788511270;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hF7W6IgkqW3BA6qKiN2sGuxt00zyQz6GHtb2s+mggXw=;
        b=RW9HYEbfaOkpbJWoQ8izrRgK3otPPifj2uRLusm7MJACF32lbvzGQ4mSVxH9y5ut/L
         czd5r3T3pzTq/mbmnF9ps7xBH9WheJ33Ly/NvUygvOakS+YM2zQGNhty+X1FuuFnG5Lz
         XrDMbenxpmo8/la26nUgue+LDeAYmf1RDPiQysnrwaNZ1eiZo9/Nlb3dwoKocju6A7Vi
         w9mJak3yjYm/Byy9uuPjyiQHsocXJ4jHnmNZLJyaLUsBL0rb2T5zDYfM7Bwywf9RNc4V
         1nPReb6D8y6YbL4QICvIRs+8QEQQoOkv1xUTPSCwAu6IL1k73AEruEL9ENjClP7tWyzm
         l+8A==
X-Forwarded-Encrypted: i=1; AHgh+RrYl0vqsMbCsBG6Nx8eKDasvKZX1acRRCPLetYWNksOx7+FhUdiH3XdfZvaYHn4f+B4b0SFYX1pByCcZw==@vger.kernel.org
X-Gm-Message-State: AFuF++n3oGZAnXYd4xTuulOTZZMjGy77wroHNtLaGD3jls/J75rMZbBR
	K96x95A+6OEVPXtD9AbleSVnpgtkZUpFgGdUkJXSHTe0rTYSQAkxISYUy+Nz9ADEGQ==
X-Gm-Gg: AR+sD10eey5lop+fFq0IbCLnPvEV8qpYyYQrzOUyUmhN7i7E7aTgi70SoCk3vyRKo/t
	pmkPDYVz1KI72SLdWNc+SHxxczOwvJ1ew0b3MMOpTUnl+AnuejPXekhoJItMcYW8GqQdrc5qEll
	oUMqe9EXTetOm/DhsE+3D7eCrwsr7BFp3XJOuNhQ1UW4+HRd4qjTDjOxOSZ7RT093dt4s5MkLXW
	SIJKA6XvzbXIgHV1h8ZQ2ST3DOMs/etOe+DXdsDrKY6x/aSD5Rz05w1VHqzD9MJBJfJMTwq+ELz
	kYqy6G8i1lDBkKyaMrdkgbiJhN0RNnnDrb5kKLiK0nzL6vE5kMDRlrMb9qSDAVYttHiaDTokaUQ
	vn+JQ0pCGvTjn7fYOdEyF2UgumNEzi2o/mRUw2qpdW0/KuoC954a9K8bbUqS1JFJ2LDyWLCa4i2
	y1CPc92Ks9+bGrcoVMCLF89AuxIDnD9hxCGxRiIF+sjj+eQsEsBkkpUwQwr95lyM45KMvwXid5p
	eVUM2iEh6KAWVnxVDs3kQaE6pyAb1PhkATfSr0YgYr85qXD
X-Received: by 2002:a05:690e:4181:b0:667:8644:fb5c with SMTP id 956f58d0204a3-66e1185c3a5mr4866839d50.16.1787906469125;
        Fri, 28 Aug 2026 01:41:09 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66e4ed15430sm508418d50.15.2026.08.28.01.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:41:08 -0700 (PDT)
Date: Fri, 28 Aug 2026 01:40:51 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kas@kernel.org>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
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
Subject: Re: [PATCH 07/25] mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize
 folio_activate()
In-Reply-To: <apAllneItXmyjRPo@thinkstation>
Message-ID: <7b30ca86-dca6-83b7-a632-180e35ed2a0c@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <16b39f43-d91e-7b23-900e-90cec13837ff@google.com> <apAllneItXmyjRPo@thinkstation>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 27 Aug 2026, Kiryl Shutsemau wrote:
> On Mon, Aug 24, 2026 at 07:09:34AM -0700, Hugh Dickins wrote:
> > @@ -355,6 +356,8 @@ bool lru_add_del_folio(struct folio *folio)
> >  	/* BUG_ON(folio_test_lru(folio)); */
> >  	if (!(folio->lru_next & BIT(LRU_NEXT_BATCHED)))
> >  		return false;
> > +	if (folio->lru_next & BIT(LRU_NEXT_ACTIVATE))
> > +		folio_set_active(folio);
> >  	folio->lru.next = LIST_POISON1;
> >  	/* BUG_ON(folio->lru_next & BIT(LRU_NEXT_BATCHED)); */
> >  	return true;
> 
> folio_activate()'s try_cmpxchg() can land in between two lru_next reads.
> Logically, it is safe but I suspect KCSAN would not be happy about it.
> 
> Maybe READ_ONCE() here?

I expect you're right, and I or someone should add that in due course.

But I'm not in a hurry to do so: I did run KCSAN while testing before
posting, and amongst 770 KCSAN reports did see a few which looked
likely to come from these changes - yes, something in lru_activate(),
which would be the WRITE_ONCE() end of the READ_ONCE() you suggest.

I decided it was more urgent to get on with posting the series,
than take another pass working out where perhaps to add those:
needs a different mindset.

I'll grouchily get around to agreeing to add them: but I think
they hurt readability, and I'm surprised that KCSAN doe not object
to almost every line I've ever written - that's what we do throughout
the kernel, make racy unlocked choices to minimize overhead.

Do you have a head for smp_mb__ barriers? I'm more anxious that
I might be missing one or two of those.

> 
> Other note, page_pool (pp_magic) seems to be using bit 2, but I don't
> think there's a real conflict.

Yes, again not a problem, as with bit 1.

Hugh
