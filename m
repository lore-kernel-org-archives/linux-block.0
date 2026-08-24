Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBBA38839D
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 19:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599998; cv=pass; b=q8kEqjIrdw/egVgbSmnS3Um16Salk7j53rYT2q37io7guDvzcVKG2LnpLtwDLfj3P/N6grFllX5BtyRE+sQSOa+PnUhQiCbUkT2XHRmATk13/1uD2PPprQY0Mj0VQK6dE9zw++hnVGGA4LYbijt9dYcLbRQ5UUKjF+An1bURYRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599998; c=relaxed/simple;
	bh=6nzgFXxKsg+JnpSIQP0/wxVzDkLsa2CzNa+jLf/mGAU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgkWmaYUnLs2EOjdDogpXXgXYXehYBI1w7wX2BOX9J7qe1MmQbawJKb2ZVxusD1O+7oyVC6p4Ls0/pdbLHYzqmfY/WbYQWRJFmFrk3c7+u5TyTl5HvW3P+ScNuTrbwp65Y/NnIjx4s0oMQWI0V60m1ZE0z/YI9LKUq1yC62z+8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rWbvmCWm; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rWbvmCWm"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52cd38ddcdfso22513751cf.3
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 12:33:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787599996; cv=none;
        d=google.com; s=arc-20260327;
        b=dd6TS/Pmr0i8Qha0PkqsLkhhIomeTwr3sFgpl/d822aN2x/ACpgGHyVD5YHidwBP/4
         7J/WDkf9h5Ldn2VDIrfEqFNlaUBE7LlI4ILGWcnYOYZSc+QJG32Q9Pc5QVpYDXOynAUQ
         6l5Qqz0csa4EIyfAW1w07QsaYGLMYi4UqxaFOb7fNwbEdT/axRhzj4UhHxU7LiteoZ8D
         4WDdc3hKdxlB9Js13GCbEqwNVXG/K4tEvdeWflY/hBCx5bTnFhq59FBIfI+8lHNDgRvH
         YlgtMAnqMF8K7othT/uem5SEN0SyzQ5EqVoCtehIR66f5Z2LBG1C5VTpWLQ+3jvUa2KU
         3ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DK1kq+UORspwzlcL44O0F5OA7o6ZQNGRnMf+1R0tFOc=;
        fh=2iKZssqLhP6mh4k4QHAU9+AdHXupeUDFcW+atNxN2d8=;
        b=BtjTZNtAdsHFoMc7UV7aFz8mmP14hOdM1jPaVPmGaUxRpjMbEC6GH0euOMUPVY9p24
         ruAx6wtEwGqAzELVVctSXvQhCuQWHLDCocsB+gz0C9Cueyrx4+3BnuoujgkWebQEXT9u
         dRnto5lBV90JO+/cQWCcN2zvqNCL+wtXL3EMZmrBQR+m5D0/4ZCRFadsFCjzXzbd3nr5
         Pt8O2Z67CJqpycZzTfw0JzbUwD3vcLSLuFCkyX/RCY0vSTBIPsyD5P0bzE7tiZbcf3ZG
         K/oSl7CObz/QBRqRdPC0mRCc6mExI4CySb1wDrc2owlmnwWXVoCLjtEg0chvJftw2Nm7
         hQzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787599996; x=1788204796; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DK1kq+UORspwzlcL44O0F5OA7o6ZQNGRnMf+1R0tFOc=;
        b=rWbvmCWmjcCMV6cmRGcdr3+XqqhuMWDGjRX1T5jRxsvlEvHcuEqtIU8Ara72ZK/KBC
         Fo3btCJeMyC+8K71XbO+ycgkyzflH+/WAU7RjJ+jWdNq4ZIUVDtoY46nzEbAYFajZokv
         WbFxgJPYPnzHMK5AKBCgIKfsa0iEZf2co5VII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787599996; x=1788204796;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DK1kq+UORspwzlcL44O0F5OA7o6ZQNGRnMf+1R0tFOc=;
        b=pXqGY/hSiIG0MyOq8rleMVPSW3tmTLGKC5ZJMGnPyZMj+2Wk7BnLlk3zvorvObNz4C
         C1Emfx5snkbfOxwofOsYrXGNYptBxBY5/5X4DM2hzLYMOpI8nbD/MJI9pLOwKVa83Ueq
         wiRg38myxLNLbSr9l4r52OCwYPVpIAFEJ3wTBTpVkjacULl+jerXne/uHUgRrUYY6RHR
         xR4R5wATPH6A6JqkjHLvvTTofIcnksGPQ51nG//BT8uhwReAf+kOfmDe3BCwtkPnDBbS
         d8WA7DtKU+MoR0uKmB6/GgdlRdRoVx3SrfhK/jz3R3R3PLaBQjywaHAlYUycU2TzRoAR
         6eTQ==
X-Forwarded-Encrypted: i=1; AHgh+RqPRH1A+tP7TPCOoIfDUrKJghVM+tPPEfZz2fZOq4X6h2mArnKaZ5cQ0HIzq5IwWYjdmeQQuyUx4jT6AQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mu+qlO/C74yj6lm0i+ywp3Y9fVKVXOZIy/P0oVzDoETZ8hIhgM
	W4TosRZWeiv/HBSCCxH0yjAsFpUscwm1UkHDlDLGsUl1yqCLxRtlZkB0bEeGVFTbw2jVtaHbJew
	LytNCCqWenY+RDyhiO6ZlBwh28NuXfQzOYhTugM2lcg==
X-Gm-Gg: AR+sD10JFFWMN2/RdEHWVkJgWz2QAiMiQli1SyNrwVc5Q4Id0RGkWBZyM8U3gBljKqE
	siF/epcRqRHxfeDe1w4lqsE75ig4g4hUEk6twZEsPF+0owmCx+Aiy7EJqjs/dog8rEdmBZWxyuC
	F50gpGRSZq052rmDOo3Mn/GoxlAqiuIml1v3CX8giiR42kRq+3jSno9Qjm7LSqavqzCAeU/5q27
	4+D5lpBwCvY3Ui0W0qCIvXpflCjCeZCtqNPMgW14Ch0iq6udh2pj5wmAEaPzXT46zhBf+PJgu/Z
	nONuaCzBcSSf7DuMypSLZQA96O3KO/XtPt11YGHRKRwmKrgt+poP0boJ7sVaglm7SYpY+DO89YT
	yt0k=
X-Received: by 2002:a05:622a:411b:b0:517:78c7:d93a with SMTP id
 d75a77b69052e-52df57324bamr286714031cf.16.1787599995881; Mon, 24 Aug 2026
 12:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org> <20260820193343.3852967-3-willy@infradead.org>
 <CAJfpegvP3i8ZJc2T=+f4rAhZ4E1QcT5+jC6mQPLxtB-yoK9Brw@mail.gmail.com>
 <aoxHOSC9kTPbKeNq@casper.infradead.org> <CAJfpegv3Ak+qNLb=fTSCSz7-taQ3Ui-Hkmqgn4PaGPe=CR4cbQ@mail.gmail.com>
 <aoyKxvdQdeJQfPHj@casper.infradead.org>
In-Reply-To: <aoyKxvdQdeJQfPHj@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 21:33:03 +0200
X-Gm-Features: AcwNN1WHKWPg-gulrL_ybc1YuKIIGquGv3tDzpc2zs94XwMFk4U-dS3q1iLbtfs
Message-ID: <CAJfpegtgenUaudDcvecJuV2_WkkVw=gdcB0Eqg=UFKPMZP1uKQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: Use filemap_invalidate_pages()
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Aug 2026 at 20:17, Matthew Wilcox <willy@infradead.org> wrote:

> Before:
>
> fuse_open()
>         invalidate_inode_pages2()
>                 folio_lock()
>                 folio_unmap_invalidate()
>                         folio_launder()
>                 folio_unlock()
>
> After:
>
> fuse_open()
>         filemap_invalidate_pages()
>                 filemap_write_and_wait_range()
>                 invalidate_inode_pages2_range()
>                         folio_lock()
>                         folio_unmap_invalidate()
>                                 folio_test_dirty()
>                         folio_unlock()
>
> so what's the serialisation that the filesystem can perform in the first
> case that it can't perform in the second case?

In the second case filemap_write_and_wait_range() won't write protect
or unmap the page, so it may become dirty after the writeback.

That can't happen in the first case, since the page is written and
unmapped while under page lock.

> or alternatively, what's the serialisation that would be useful by
> adding a lock/unlock of the invalidate_lock inside
> filemap_invalidate_pages()?

Nothing.

What would prevent this if we'd have writeback + unmap + writeback.

Thanks,
Miklos
