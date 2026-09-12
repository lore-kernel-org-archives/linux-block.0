Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E09397E9A
	for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 22:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789250846; cv=none; b=toNYCkVgA8KbXfFJpNiQCe5PXBnE7Q1Yy0PQX15imCJpanM2rTxYYlhyxSKlL7Iw/iHJ0VcuEnP4NXJJknM6g/lhK6PvDGv5R4buYOpGhKa+0OGRRnC6Y8j45Y79rTTUzLUv+ou4x9oJp0rwh0smDgPp5UJ52lQfI0SNVkiNXUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789250846; c=relaxed/simple;
	bh=aO0EnKRtbp4eQRdiajrWBnJhUoH5QBxQwM0G7h6ERwI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jzIAvmZRHGCUhxDdGpU7d3UonI50z21ztqCxIqbygogspUyl21X4aEL4taOOKOecIuST4lMaAtuNEglD2CeBzfabz6MVTvv6ZiZ0/EfvRyijATM1APlwN8XGIaYNrpr58mu9JP1fN4YHEn54Kk5U7lKzanEQRcnHTxVAcSGIrzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BRtj19Jm; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BRtj19Jm"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b965f447cso5304165e9.3
        for <linux-block@vger.kernel.org>; Sat, 12 Sep 2026 15:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789250843; x=1789855643; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rv9y+bdGfrIVxvXFR+/Wb3gMq5lM5A+QpTE+pSCVxcc=;
        b=BRtj19Jm3XCuIKfHnRQELeUcgfjAhTyscn/BtZ8qnMuQa6d+j51+unk7VwNUWZf+W+
         z98zEU9F7KpbgDTYRN9CQG76ae8O5OaHYSxjk2fyPnfLbVVCgQe1GpnB+3BUoQbksT8T
         Ct0IURHezJufjPd0Q95+dOpvacKfd4kHwQjz7dq9GAhQ0uBfy2adJ9KDnoGBzzNfdyrj
         jq0Zjy/dG+dlM+L+FKdSBRrDRzQDL8Phc/G6LYFhl2VreS/DYy8FSgxe9JYYpLf1r0iY
         XAmnSKFNOgWspEwTi5Ob8sPA6HyrYtkrnbUnuucJCLBcHh1ayw8MPm3n1jVkCDl7WW+y
         rHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789250843; x=1789855643;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rv9y+bdGfrIVxvXFR+/Wb3gMq5lM5A+QpTE+pSCVxcc=;
        b=I2mAbLhHcIakQBes9NC54yDUiE6fw6yEarqxqHKCmQAau8QVekO63BKOkB0cRFMG0W
         cNxZ/B7gxD4xcbvC18+dUhwPHsiswlz5KqLnEMtvLY1UGqcEShSijWUC7TYZnrWkzeuz
         zIaK3mMQrI8IqPJTmU/2LexK59VTGhBS27kun0Yhc71gEVbelXL7j1zbc/9Xp/ruJ57/
         0ucEc3+i8pPQShZz+1Y9TFpxel6kTHxItfj4PdephUtlcXjU4T39SO96zEz8+LN0YqCS
         qaMznOiCN+3mHjswleJOr9wtjhv+mkw/lGdpBAYJC0Ffzv9YnRwZecWAT2b6P4KNthB+
         Y43Q==
X-Forwarded-Encrypted: i=1; AKwUvByZk+r07DPeRp5yC4nvfuIWnshLtaPxDX5T1xbgRQM3jZhd0gLEwhc0gqrYf6V2VcWpqO9MMKnwCuVsmA==@vger.kernel.org
X-Gm-Message-State: AFuF++lkkysC07zpE8YKasKEvC0Q+vMpdEzodNAEvIOpaAYt4gvz2n1p
	XDeS59PXD8J7xDum1OH4oSyUc1NUG3kD6ouPW9SQl7VtIBQZnWqcSDAkovMyd0pvXQ==
X-Gm-Gg: AYBFou2bK8c3dLh/BANibgKsqnxF1/NbCsGOXRXmy5NeEz6dKR+vczEhjC/eQdcuHwk
	V5SnzhAGxX+Dfip/Kp9GhS+m8MWo9vWBfjk7WFvpkfPXQJpwSeh72ulVejf1iGsMA5VbiVSggmY
	0k/MqAmpIYf3nPG9vUec2Ip0QpBtZxEUqH7wEn7TQ8Nv8Afq0277wJ7OcikD9NoSeHnvL//REE5
	qa8ReuzAR0pAwWYlvsV6PcILUc9WkU4Uw75ZclDNeA9v4QGbNPi9MYf7WiP/d47Q9E8vwd45cXb
	34fa5WbTpH4V/boNETHSL7F8I+Zkwr5KrtfJeuDIT0A0P5nu4PAjwxXMqBfc3Sj0oE9GwMqXYsn
	I91t4eWV4L0y9djvSCyl94J4QpHQYOMqQTHYoW+UX5KZXt5yY5ieLgSyd0WuujM2oM9R2S11o6Z
	iBwc/KQioa2+bwy+/1MNWqCuirx0fUdALNBzETti2S7zV6Zx7GeQxEdpF8luNe5X1HIaMIjKivV
	55FsPt+P3M1n0XSAwRE
X-Received: by 2002:a05:6000:2f8a:b0:486:e920:6726 with SMTP id ffacd0b85a97d-486f6d5956dmr4081301f8f.51.1789250842159;
        Sat, 12 Sep 2026 15:07:22 -0700 (PDT)
Received: from darker.lan (104.157.125.91.dyn.plus.net. [91.125.157.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb33ee5csm15513089f8f.20.2026.09.12.15.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 15:07:20 -0700 (PDT)
Date: Sat, 12 Sep 2026 15:07:18 -0700 (PDT)
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
Subject: Re: [PATCH v2 06/26] mm/fbatch: fbatch_drain_lazyfree(onstack fbatch)
 before ptl unlock
In-Reply-To: <ac4fedf1-168f-4166-8059-353f2cbf04ae@kernel.org>
Message-ID: <9ca87753-6851-7b54-4305-75d5319b069d@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com> <17e1a6c3-525b-1cc3-0731-349f0850e3ea@google.com> <ac4fedf1-168f-4166-8059-353f2cbf04ae@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 9 Sep 2026, Vlastimil Babka (SUSE) wrote:
> On 9/9/26 11:53, Hugh Dickins wrote:
> > Re-enable lazyfree batching for MADV_FREE. But it's not safe now to leave
> > potentially stale (then reused) folios in a per-cpu fbatch for lazyfree.
> > Instead, madvise_free_pte_range() keep an fbatch on its stack, and drain
> > it each time before dropping pagetable lock, while the folios are secure.
> > 
> > Ignore folio_may_be_lru_cached() and lru_cache_disabled(): limitations
> > irrelevant to this fbatch drained under spinlock (even if RT); though
> > in practice madvise_free_huge_pmd() does have to drain every time.
> > 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> 
> It seems correct to me, so:
> 
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks.

> 
> Might be that something regresses performance though. Guess we'll see.
> 
> Also seems to me that if this patch was preparatory, the batching wouldn't
> have to be temporarily disabled. Doesn't matter ultimately though.

That's true, the order of patches does rather reflect the order in
which I got to think about things - but I thought it might be easiest
to review in this way too. I was anxious to get to the core patch (04/26)
as quickly as possible, to find out whether the idea would fly at all;
I could see lazyfree was a problem, but wanted to put off its solution.

Hugh
