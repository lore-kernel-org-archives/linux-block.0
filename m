Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEC32F656B
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108051; cv=none; b=jSj9zQOaAw74v6mE/YcGcJl1kmbNM7BS2EDr0M/bZ0fLY0rA+exdZUC5V+RE+dpFKXOyGqtCZ3hZaTUIHlyjEzyMfg7jGjRLsg+j38WDa9TrtPcECoicxB2pMF4UjH695pPIp3vqE95t8Wx7t4oblvTZhiCmEqqXicaqle8lvag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108051; c=relaxed/simple;
	bh=DC7x9YWROCenDmlSc1FcZsUca68HCfG/mUx/W7rmzrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRNlpiPNLidQWOfKdManRU4fLtE3ZydRiKTa4tzsDdeN5FUqzwccDX5kJgIUYbe/fJm3YP5rtqW0JNpmXnsS806qVasF2SQ32BmPvQsqjHup/4Wbl0O+l570z0aO3lFphHx03Y/4sBOItho5IHCY9Wo5QLqXY9hPnoHDHvD5ddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VTnmIb1T; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VTnmIb1T"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4e6ec0d1683so314511cf.0
        for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760108048; x=1760712848; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DpdiimUJLGEL9YZv8OhwGPgsBnQcaD8Xj4apakBfn0=;
        b=VTnmIb1TlHElKTohVvdtRHx7HEmeqrB8hSvmF22DJB+mQqqZZk+wvsDuz4uln9V7FU
         dpsQgLT/r6jgDPFmApUUPclup6rNvOlQo0ZBmnDUNevAy0Zisy9ZysmhlASpSd4Rc+w1
         UlL5OoGSVmhMYUtrcg8PpuJ5/J5BCFolzz31lFG/HMjjS7/pk80KXDRttm9jhNG34XxI
         y42d9fImcgtux4nhQ7EP8Q2jXzWGqDHaxpe/P/Sck42KrtcdBO5PGk1kL/VeEL5tIWyF
         /sauTiZHoQFdaXa8Z681DWvHC8T3LFGFuTu+3Zdya2+6jVwPi1yIjMqIFriwTRqAu6Ku
         DWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108048; x=1760712848;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DpdiimUJLGEL9YZv8OhwGPgsBnQcaD8Xj4apakBfn0=;
        b=lHFM5iK49enAvgNKk2IXsl2lLyUNwzpmxZL5LUOMLrMdDsa43NKNwaXNtyb0iiGE0v
         CPkqy0oSVp4EFpQQe4CRlpy9B4VRpif1nC6jI2wabbAtrRMzMRCRLbshX5iT1TMn2YPt
         TPYsN9kGCR5yax86LsjYPpGw5w9AhQQ6AWS7Vt+GLcpGBt8qvjjT5zEr0sSNCjNiX3x9
         aAr/bMEGDo9pVdndun1A41T4jZBziF4yx2cXeRaeZb2OTcIwYdIm4EKDKCcCsosNC8Tm
         gGJr1ox//VLYRnVJKZpDXqH9C41/6K6w9S2JLeRsLmh4NbIxrfRnBqNtCMScwibiTb+c
         9LpA==
X-Forwarded-Encrypted: i=1; AJvYcCWWPWdTUKvA2l2Z6HgpSEgSk+djCCcxDj9r7wN+S1AA6d2WO8f5Ab0yQVVQqHJA9vS/hotH3sRE6qwj5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1CvGPcaugn7Z8j2ZTckdPPAto6lzrRn438BOpF7gsWcwvqJEd
	2OHb+7ljmPJTFThwfzpPT12W7NZGSL4fndvh79JNQsYNOpDJkbbSts5q8mQ5KwxoqvNJf7sl7tu
	cyJCwjvtww72fobkhHk4VMMlztr/Q3z9gfHdF7rGT
X-Gm-Gg: ASbGnctUmWK8r7I98zoEHgsyMYSwtUsJ6q7msR/D/hZfV7CRGYtP2ValkDEwybG3jaq
	t3Pm5+Ozr1s5xuY5HhEDEQg+nu5a48ldQULzeEO0/qTFFrTfCDmYwNaNnDMlly8nCD9KF63aZsB
	7f+ZTBDu+VCIb1eSX6wUVLCy+xaizjhFCBoieXOMDxgz00IGCudqNwIzDaw+oiIOe+Qwk5PQbZD
	CBlSTT3zjyQhYhPT+q+Xby14O6g7JBepKERtxP/gJ5dwihaAuqF
X-Google-Smtp-Source: AGHT+IELG1HO5re9l71qV16AXiLCV5TxV3n/x4fv7b1UlE7oKp+shLXPJ4Ui15bl56g81Rjif4tTmM3A2oXDy0V1pv8=
X-Received: by 2002:a05:622a:50:b0:4d0:dff9:9518 with SMTP id
 d75a77b69052e-4e6eabcf616mr24839371cf.12.1760108047605; Fri, 10 Oct 2025
 07:54:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010011951.2136980-1-surenb@google.com> <20251010011951.2136980-2-surenb@google.com>
 <aOhx9Zj1a6feN8wC@casper.infradead.org>
In-Reply-To: <aOhx9Zj1a6feN8wC@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 10 Oct 2025 07:53:56 -0700
X-Gm-Features: AS18NWBSQfAZ95bfn8zHE7YuLwgx02HxJfLsEBTBLUde_yaDHMul1ATmajxkrCY
Message-ID: <CAJuCfpH85Ns8_+JNG4HS6TnFMUN0si+mcLXxUxedhQh1c0CSEw@mail.gmail.com>
Subject: Re: [PATCH 1/8] mm: implement cleancache
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, alexandru.elisei@arm.com, 
	peterx@redhat.com, sj@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	corbet@lwn.net, axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	hch@infradead.org, jack@suse.cz, m.szyprowski@samsung.com, 
	robin.murphy@arm.com, hannes@cmpxchg.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	iommu@lists.linux.dev, Minchan Kim <minchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 7:39=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Thu, Oct 09, 2025 at 06:19:44PM -0700, Suren Baghdasaryan wrote:
> > +     /*
> > +      * 99% of the time, we don't need to flush the cleancache on the =
bdev.
> > +      * But, for the strange corners, lets be cautious
> > +      */
> > +     cleancache_invalidate_inode(mapping, mapping->host);
>
> Why do we need to pass in both address_space and inode?

Ah, you mean why I don't use inode->i_mapping to get to its address
space? I think I can. I'll try, and unless something blows up, I'll
apply the change in the next version.

>
> > +/*
> > + * Backend API
> > + *
> > + * Cleancache does not touch page reference. Page refcount should be 1=
 when
> > + * page is placed or returned into cleancache and pages obtained from
> > + * cleancache will also have their refcount at 1.
>
> I don't like these references to page refcount.  Surely you mean folio
> refcount?

Yes, mea culpa :) Will fix.

>
> > +     help
> > +       Cleancache can be thought of as a page-granularity victim cache
> > +       for clean pages that the kernel's pageframe replacement algorit=
hm
> > +       (PFRA) would like to keep around, but can't since there isn't e=
nough
>
> PFRA seems to be an acronym you've just made up.  Why?

Inherited from the original cleancache documentation. Will remove.

>
> > +struct cleancache_inode {
> > +     struct inode *inode;
> > +     struct hlist_node hash;
> > +     refcount_t ref_count;
> > +     struct xarray folios; /* protected by folios.xa_lock */
>
> This is a pointless comment.  All xarrays are protected by their own
> xa_lock.

Ack.

>
> > +static DEFINE_IDR(fs_idr);
>
> No.  The IDR is deprecated.  Use an allocating XArray.

Ah, good to know. I'll change to xarray.

>
> > +/*
> > + * Folio attributes:
> > + *   folio->_mapcount - pool_id
> > + *   folio->mapping - ccinode reference or NULL if folio is unused
> > + *   folio->index - file offset
>
> No.  Don't reuse fields for something entirely different.  Put a
> properly named field in the union.

Ack.

>
> > +static void folio_attachment(struct folio *folio, struct cleancache_in=
ode **ccinode,
>
> Unnecessarily long line

Ack.

Thanks for the feedback, Matthew!

>
