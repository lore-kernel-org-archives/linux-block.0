Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0433B7B8B
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812091; cv=none; b=XuWGC56j4+iyfWOI7hK+NOqADprVletIf54IyYKR3eszgjMD6pX3F63PzbAGRn/mOouIm/INUaJtfch/ptQJKt708WdgOKoSx7X/5zPucQkxHdltf2cMtS8zAODYXhC7N0VORt9scuoguSybDv+7KDwwSor/02JQRcCzwV7WpD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812091; c=relaxed/simple;
	bh=QiQtrjw9eIMb2cuYIUCH/KxXjh1LseTI/2iLzYitHWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPrJeeWz7pQwG8VRg8MhWB+eqMyQvcaDZo4jx5QSTqLC3AlIzwtFHQDLBaoTfLMnbZCJ1ICAKaIKKCDSPYqqX0mBIp1TBC4CO/+nEfFCLSKtCv93osOAbxLTPQRGaB16sgmFN9UCXFKqvluG6SOaM3P1WRXfJz5C2Ev0bA5RNJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2+/fxbK; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2+/fxbK"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-45f194e9a98so3441222b6e.3
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2026 07:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772812089; x=1773416889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ltlmh5+xfasabBt3G7wfvJiHvUvttPKwWWOjoNqhRlQ=;
        b=X2+/fxbKHtxUbrCFdv/jPdLDloIXufoeipQcQY2hOv3LiDXMJVg6TeBqKuKiI5HJ6m
         aId4KbWpM5rnJ6gDv1tAdfAKK1zG/0gfRrEZWmXcX8VGY5LI/v+sGwgaTp33TbG+EEzY
         231dzWFMe80B8SriVeKweH6KdpcSOixSLUlkfIymEq92IN9mOp/hPmZAx2ICU1P+QVqj
         4bKfMQyUEw6ajJUrD5fNnaqtm2SZ40mYFuMtlq3kpgOe1JzPyOVqs27iZT8Dk/PyR//o
         8AGePpM2h7ThXXo9q/PebPd++w5EkcnbOvdAzPfjuj7LSFU2hVdLh/MK26ObyY5Yig4A
         jkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812089; x=1773416889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ltlmh5+xfasabBt3G7wfvJiHvUvttPKwWWOjoNqhRlQ=;
        b=VxBNY5y3YtnbFiOnFnewU1cffzAL0DaKAOrBYn5XfFdVxz/f6ExwI9HnBSl5keLeH+
         mgsQS3fMVo3MMxJE/w8TXIUJEafdWtorAWegZ9HMgXETICDeUSmLnXn+HumIy+MkAqbz
         BiBFtwPjTMTMrELJHn0A8EUtd2n+gsNk+CQThYiftHi8i6LHpkSviY4QgKTb7/7MvCRq
         epDIyQD0UIfkyyR/7vwTXdh4AarXJzy1tJ2Y+T/xtocR0QGX2MZt0pyk6rA7VBiJUgAT
         roX+KWsz7XC2XG0qkllYo9SBEQDDtkDXEgw+v9w7vhkw1dzilhCoEv+RccK8FCz5yhd+
         m/gA==
X-Forwarded-Encrypted: i=1; AJvYcCXoww36f1khtLbonMnNePMSnj7aC0/Q75HPXnKHoa28f1z5xBvhhLt+vLHOJa5MQCbS25zK6U9E/uSsbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9CPCCm9uzJQzQmkEhlN5/k6nj2uBwJ6A47Rou4uBmnSpt+0Y
	vV277yuiz7awh/IEeuORohrBEnYh3qtQRdxMQmXW+UFOguM28T538mOl
X-Gm-Gg: ATEYQzzVtpSpH53hVZDX2X9cnx3qolNcJDShe5OE35DsnmLPuP76UaglhppvmJVNusR
	gJ/OG7/TAAMo9W6XxDK5JcLTxiDq2RLGPjUPF5CNlqmBF3xhKqtMEwZ5KYlPOkkztgXrZb5IGI6
	ihV7/sNdXIJ89NaD7gq67VBOAUH2riCNSA2UoBtt+kjaSb5QUgyqWSXlYD4BGZUivyGNeDnmldI
	nmpHQ86ujCPM0n2srMmSbRXzJt4Z2uVUrABJ5H40NjLFY16MLbKqBFsb4Nxa/2VfpBlxSKvDkpI
	WO5HTlnKccL+res/549oEg6h+nX1qH0kTihrwAKrQA34ZiKQaCxjhQVgioR8azagZh2mc+N4JAq
	kicSooqDy2GBH9pLPJ920UgstuVrYz9j/1wZE6orVJuFvpXRXuiqtxBsHnLAGBetYgeh0MMzNXI
	rXQfhAn1Hd55ib0SJqfWdMqg==
X-Received: by 2002:a05:6808:4f08:b0:43f:5c61:448c with SMTP id 5614622812f47-466dcb0c3bemr1240922b6e.39.1772812088834;
        Fri, 06 Mar 2026 07:48:08 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:52::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-416e68369bcsm1683173fac.15.2026.03.06.07.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 07:48:08 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jens Axboe <axboe@kernel.dk>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 3/8] mm/zsmalloc: Introduce objcgs pointer in struct zpdesc
Date: Fri,  6 Mar 2026 07:48:06 -0800
Message-ID: <20260306154806.187506-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <aapO2Pd9d5B6MEtu@hyeyoo>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 6 Mar 2026 12:49:44 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:

> On Thu, Feb 26, 2026 at 11:29:26AM -0800, Joshua Hahn wrote:
> > Introduce an array of struct obj_cgroup pointers to zpdesc to keep track
> > of compressed objects' memcg ownership.
> > 
> > The 8 bytes required to add the array in struct zpdesc brings its size
> > up from 56 bytes to 64 bytes. However, in the current implementation,
> > struct zpdesc lays on top of struct page[1]. This allows the increased
> > size to remain invisible to the outside, since 64 bytes are used for
> > struct zpdesc anyways.
> > 
> > The newly added obj_cgroup array pointer overlays page->memcg_data,
> > which causes problems for functions that try to perform page charging by
> > checking the zeroness of page->memcg_data. To make sure that the
> > backing zpdesc's obj_cgroup ** is not interpreted as a mem_cgroup *,
> > follow SLUB's lead and use the MEMCG_DATA_OBJEXTS bit to tag the pointer.
> > 
> > Consumers of zsmalloc that do not perform memcg accounting (i.e. zram)
> > are completely unaffected by this patch, as the array to track the
> > obj_cgroup pointers are only allocated in the zswap path.
> > 
> > This patch temporarily increases the memory used by zswap by 8 bytes
> > per zswap_entry, since the obj_cgroup pointer is duplicated in the
> > zpdesc and in zswap_entry. In the following patches, we will redirect
> > memory charging operations to use the zpdesc's obj_cgroup instead, and
> > remove the pointer from zswap_entry. This will leave no net memory usage
> > increase for both zram and zswap.
> > 
> > In this patch, allocate / free the objcg pointer array for the zswap
> > path, and handle partial object migration and full zpdesc migration.
> > 
> > [1] In the (near) future, struct zpdesc may no longer overlay struct
> > page as we shift towards using memdescs. When this happens, the size
> > increase of struct zpdesc will no longer free. With that said, the
> > difference can be kept minimal.
> > 
> > All the changes that are being implemented are currently guarded under
> > CONFIG_MEMCG. We can optionally minimize the impact on zram users by
> > guarding these changes in CONFIG_MEMCG && CONFIG_ZSWAP as well.
> > 
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> > ---
> >  drivers/block/zram/zram_drv.c | 10 ++---
> >  include/linux/zsmalloc.h      |  2 +-
> >  mm/zpdesc.h                   | 25 +++++++++++-
> >  mm/zsmalloc.c                 | 74 +++++++++++++++++++++++++++++------
> >  mm/zswap.c                    |  2 +-
> >  5 files changed, 93 insertions(+), 20 deletions(-)
> > 
> > @@ -893,6 +898,43 @@ static void init_zspage(struct size_class *class, struct zspage *zspage)
> >  	set_freeobj(zspage, 0);
> >  }
> >  
> > +#ifdef CONFIG_MEMCG
> > +static bool alloc_zspage_objcgs(struct size_class *class, gfp_t gfp,
> > +				struct zpdesc *zpdescs[])
> > +{
> > +	/*
> > +	 * Add 2 to objcgs_per_zpdesc to account for partial objs that may be
> > +	 * stored at the beginning or end of the zpdesc.
> > +	 */
> > +	int objcgs_per_zpdesc = (PAGE_SIZE / class->size) + 2;
> > +	int i;
> > +	struct obj_cgroup **objcgs;
> 
> Just wondering, perhaps it makes more sense to have an array of
> objcg pointers for each zspage (of size objs_per_zspage)?

Hi Harry! I hope you are doing well, thanks for taking a look : -)

Hmm, I think you might be right. For context, one of the first
ideas I had for this patch was to have a per-zspage array, but store
it in the first zpdesc. As you can imagine this was not a good idea...
(head zpdesc page and tail zpdesc page? ;) )
But! storing it in the zspage struct makes a lot more sense to me.
And I think we can actually simplify the migration pathways as well.

My immediate response to this was that "subzpdesc swap ins/outs would
be difficult" since right now we can just move the pointer, but
if we have a per-zspage array, we actually don't have to do any
objcgs pointer migration at all.

And I think the cross-boundary cases are handled a lot beter by having
a per-zpdesc array too. We also don't have to convert the per-zspage
obj_idx into a per-zpdesc obj_idx as well, I think if we do this...

Let me mull on this for a bit : -) I'll give a shot at implementing
it this way, I think it makes sense!

Thanks again for taking a look, Harry. Have a great day!
Joshua
