Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866043EC2E6
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 08:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907457; cv=none; b=rUHpqld+YbrrptXKUNFlgYpNIvzsLvjnwCacXuDJs0mEjhzE3WWuGG6pIKFpK/hbQXezjPiShU7qgsvrfJWSPVC54H+nHWbXxnZYvtsPVMcvUP8wu8f/Z8omyxuy+L4b55bHu+ee+j8xTrpg2rV7KJWD3i2TfJT4QTw7mm1C64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907457; c=relaxed/simple;
	bh=7+eJz+npcWbhXvT8pye6HlMH63Esl3yFHBxUe6wWGw4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ICuNO3qr2bjGXHU8Z0S2NOT/SF/2DXs5LM2AevXhYKGA3foJVPlrXCHmBV9X+HqAHHXg+dQMhdCUBkgJMtlk8x+lNTkmCnNVghXQxxPrhSMSgn5EhO0awQsUkhdQcGwt44xjZ21BEhxacd9p5fD7VJb9dpdRbOIIYRNHq/piBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lBVWFWsT; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBVWFWsT"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-836cbcd0a48so9310217b3.1
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787907452; x=1788512252; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hRHnAqVdyLXqgRdMi4x9m/HrY0C+uMDxYAPAdjQk/dM=;
        b=lBVWFWsTnavzQYv12fsSjuDL+NQnXz0AOq7OijkR+IkgQ+L0WenTjGZQPLtJ2SyrjJ
         o3I4JaQzCOsZ6/0C6j9YRbGKr7ZYkuWyqUrROAKjBD0cr7dA4To2kUZUyAMLXqUoWkMN
         12Sud2qisxJqCoWzT8uJck8wB3YjektKF28j+0dLIDwExKkLjuxdYQfcCI5vzuuFZGUC
         Fwhd4zX3OG43tPe0iaYWjRllOWw5XoiKdMOtV3hJXY7becFdr6kYKktgYP9K0vVOiTOU
         C4jv7byOOLiQ1kqrX/DrTS8V6ZSLPRcorsDNol3e+GtDfaW1ekVVZWL2GukjZ/34sDvU
         A8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907452; x=1788512252;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hRHnAqVdyLXqgRdMi4x9m/HrY0C+uMDxYAPAdjQk/dM=;
        b=PcU0b/3V4gwz+1f9dRUsCr3SqayU8gr3NPpMeBELdqOWq4AGQYkdi3Ik4naw495PWi
         PHY7nFqI7wqfy3uTI4UrwYI/bTTE9aHsynfkq3ssZxPqIHG880lgg/4bloey8SUOBtUd
         XgIVNyR+T1i4ZPGtf51y1tOEAIsrptgjs09C2Rrk0+PSiF3tw15T57nOplKjyFVy0d/c
         l4QrGbR0XsRGSG0d074ChqWygHJHLd8MHKow7zwZOc+f4Q1vLBx8ywG9JrYRS4jP8pQA
         V6Zf6jKrYRNuGMguftTm87SdceA9mHR0kLODZkMBOvC6JYN0+M+4KwL8lePaBMGiI5b5
         +Txg==
X-Forwarded-Encrypted: i=1; AHgh+Rod6DsO8KmzzTI/GrbVeDQTTzMiR9lw2M2502AqVNDtRmIAGskh2D5q7LbSur081v0oLlv/ygwK+f/Flw==@vger.kernel.org
X-Gm-Message-State: AFuF++my1K02VM7gX0HnUe8U07b1QnE6BGzBI0Ccu0C3SJwOLzQ+od3B
	YabNK6jhqXtZTk9l52F5a43ksu9OLn2jjL7FCCWE5RCMtyVIUI4up3mY7XcwzujRRg==
X-Gm-Gg: AR+sD11DQS96OnFxunA6p8+dZjBIYzHTLLQLk2T2zvP+2PL13TVO/PXe7Gz4Ks5Kbxb
	GeQbvrku4M86VVMcX+En5awHSweG4mbrsx1eSw4zIGkat4uuqAO409hGZrazTqDPcJOIq8axR6y
	/OocRLqbZjGZbvsuPU1Wrmc+sGpiPVmuH9Ew9lfMLMmHlS3Shjj9BqreVJJ1tZuFeNGbY+OEy+k
	z+k6IZo/ZbCguFz62RDMuF4B1fdPaDssKttdnVgjqUCr8AMgXnETpzDSx+cKg1Su6CmZ8xqxefj
	v56UXiYnwwFF5z1k28p6jJEijkJV4p8/T1rd52ih/hK3g7n77HZ8Y3Ifi/4wMOHbPtER9PW/Y/2
	VcN8xuc3Fyfz7c0UEDimsYlylh8KzJeVUZwdQ1J8BVWPU4zi8nYlvi3Jr9i9q7DszEeIBoj+eCn
	WtPk8roM5+5NiYrOXy5ltMMbm9BGZiUETy+6Z1yAJL86rXPiNO2ZZPEn7+wEiajZtbahImzAwYN
	dFTnxNPS/VRfS6h73km3b40y2TOo/97mhYisIvAwRoJSFmG
X-Received: by 2002:a53:cb90:0:b0:66c:c8f1:7623 with SMTP id 956f58d0204a3-66e4c6ce6bbmr1380164d50.27.1787907451455;
        Fri, 28 Aug 2026 01:57:31 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e5ed1cd5bsm3672297b3.17.2026.08.28.01.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:57:30 -0700 (PDT)
Date: Fri, 28 Aug 2026 01:57:25 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, David Hildenbrand <david@kernel.org>, 
    JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>, 
    Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
    Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
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
Subject: Re: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <20260827145502.2fb4505b@p-imbrenda>
Message-ID: <cdbaa4ff-d2b3-34bf-dd41-01fdc65edebe@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com> <20260826155722.0198d3ce@p-imbrenda> <2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com> <20260827145502.2fb4505b@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 27 Aug 2026, Claudio Imbrenda wrote:
> On Thu, 27 Aug 2026 01:49:12 -0700 (PDT)
> Hugh Dickins <hughd@google.com> wrote:
...
> > 
> > I most certanly don't know s390 or that code well enough to guarantee
> > you that no stray references to mapped folios can remain there. What I
> > can guarantee is that no references, of the kind which lru_add_drain_all()
> > used to be needed to remove, can exist there: so there will no longer
> > be any point in s390 (or others) calling it for that reason, to help
> > split_folio() to succeed.
> 
> we are not using it to help split_folio() succeed (although that's a
> pleasant side effect). We need it even for small pages, to guarantee
> that no extra reference from LRU is present on the page.

Ah, thanks for explaining, that all makes more sense to me now.
I remember from when working on memfd write sealing years ago, it too
had to be able to account for every page reference before proceeding,
and resorted to lru_add_drain() and lru_add_drain_all() to help -
those now removed in 14/25 of this series.

...
> > If Barry's relaxation goes in before my drainage changes, then
> > there is value in that s390 lru_add_drain_all() in the interim.
> 
> hmmm so, should it stay for now, then?

The s390 lru_add_drain_all() should go whenever the rest of this
series goes in. It's not essential for the callers to be removed
immediately, no correctness requirement; but nicer if we can get
rid of most of them. I'm hoping this patch can just go in along
with the rest via the mm tree - and I'm sure you can trust David
Hildenbrand to understand and protect s390's interests.

> 
> also: I'm working on completely reworking how the transition from
> non-secure to secure is handled, with the explicit goal of getting rid
> of that kludge we are currently using. That will also get rid of the
> lru drain. But it will take some time (I hope to have something by the
> end of the year)

Good luck!
Hugh
