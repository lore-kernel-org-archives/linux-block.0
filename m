Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02A944E
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 02:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314534; cv=none; b=qfRcBk6tZeShMajXsvhntyfLf8UL0GNWfLsfehx2ozW0YIi8JAtCjSHyX8DVpfMiTX2mxb038ZrSWMMPraIxfeYDG2KXIVO9DMmeiv1FesDqBzuUhv/da0hvNALMFrFzkFuaX4pglq0xLLO/2vxFCt2PxauCOMUNjiN0FRHoo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314534; c=relaxed/simple;
	bh=PHNRBklgQlxovQ84UyrbxxvlR1CbdJB09I/jjJGSSFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BaLfiKFKLZkq452pNZdnKDZMiIw4aLSu1Kkhm4rsPWtK3537ROiYMaWWdcvY1Fdi/sLF1wFEyjrXEs3WRHXFrISIpkBzqX0nIFbr9mOUy5rKijJdeeJPcARH11ctXkxu8M9pbttBCLnUTMR3m/R7rOc95dTjqKHfKzXos6gK8Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bZRyMzK; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bZRyMzK"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-474fdb3212aso166521cf.0
        for <linux-block@vger.kernel.org>; Thu, 06 Mar 2025 18:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741314532; x=1741919332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeaol7dKf5hDCsXX8j5PIosUqB5cxOjG0nyihsM76BM=;
        b=3bZRyMzKDYbYDJvxyV5dHWHn+WPoEqxQrbDLEDzDez12VbmvO6241fwfPNwfvbwc3C
         tD3/uRu7aqdOFySYoMDW3AljFf/Nm791sX1D0UEfqxA4LV82EP5xYCuCGxN+sRjEOC79
         WBQetGRIQMRjlMJTKw2VYN8hxQbG0TEJLvn9EAr+cbSaUgNCl7Dz0hgANQ/jk9DTyUtS
         vBewduhGyjun55wN50gAs0kg23vtIn2nXFhLHbewlCUDRJ0lJyDv8X9C966QEGobYQqn
         4/B8QmF5FtzpIkEu1XkYFmCYaHHsz5ylMOzoEtGXDfDEMIQFYGJIJg9Je6VE7fre2dxj
         5QZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741314532; x=1741919332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeaol7dKf5hDCsXX8j5PIosUqB5cxOjG0nyihsM76BM=;
        b=XmedPsSMSBqg+y7/P+fxK0gUbJusEq2FW5bHqCsOdKiOS6MUdyNigsdytWAY9uGWrY
         r0qJQ7NQa641EeDPnNoAIhqD0r+X1Wphy6Xgj5L7WagiXt/6qU6DUr6KEDltSIuF//Fj
         aGsEq1ROXGkRqj8FnEufGsQ9mlfsEMpyURjbAYovc/XzDpYL2FIv52aSmZ+JNsgu8j3z
         Iwt4+gZ3/whM9/Ih1p/IoIXkJzm0aw6inqSdCaIFb/jJssaWncYhnQbto16659gojVlM
         tQFHTB4qeIP+dGbzSOG+YYcymBNEoNnJd3c9Q4f25Yw8jg+gnICWRsVdWFiPcPzFN74h
         d+sA==
X-Forwarded-Encrypted: i=1; AJvYcCUE5Fe8Ubpm4Yq415SMoKUCQpBWcXSW1UOQ9/IkWwoH7gTr1dc5yXAQAsDDB6N+gAvKf8OJ+gdfjC1Aag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61i+UD/EPSHirL+3RV6+mDiMRAbVs6MHCIAGwjbJnROs0Av5D
	0BXf83urraK35GZcRO0+iT5zXmiKoo8TIYkcZgFpCZZFVEteqPUlDsD6Vl4sTA/gKEigCEdkbDF
	wRz3cfGvcdIMl3jKc4+mZbibU6nhAOFe0xlL6
X-Gm-Gg: ASbGncuJsW0rzNH2DH/f17r2CPl9xWX1yJUAxQ7oSyGfn7TypTx0eV36+NupL8GqSvX
	McdRbLQMvUrVI/KxWu2TXkNFDNM+cNHz0H1MAstupUNlDFQvm9XLFo9gSv8C3MUuxw+vIhmopmO
	j7F6I1p+lFMdlvzZpjZIMPfBJcgQ==
X-Google-Smtp-Source: AGHT+IEcdFFqgoC5v5nk1CqtfLvnIwlJrlCR79p6l3ceXCbmRcL3l4QYeOtwzNSmiBPLUOn0epow5zQ8pU2CygP8kjw=
X-Received: by 2002:a05:622a:48d:b0:46d:f29d:4173 with SMTP id
 d75a77b69052e-47620f3e2dbmr1917281cf.16.1741314531920; Thu, 06 Mar 2025
 18:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20250306074101epcas1p4b24ac546f93df2c7fe3176607b20e47f@epcas1p4.samsung.com>
 <20250306074056.246582-1-s.suk@samsung.com> <Z8m-vJ6mP1Sh2pt3@infradead.org>
 <CAJrd-UuLvOPLC2Xr=yOzZYvOw9k8qwbNa0r9oNjne31x8Pmnhw@mail.gmail.com> <848301db8f05$a1d79430$e586bc90$@samsung.com>
In-Reply-To: <848301db8f05$a1d79430$e586bc90$@samsung.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 6 Mar 2025 18:28:40 -0800
X-Gm-Features: AQ5f1JrGamsGt3IZusMGXc8vrCD2-uzcdGon8NJXEfXnTsNUgJLtgPe59GfjDWc
Message-ID: <CAJuCfpHjV=nRmkAGrf-tyCxEEygZ0CuW-PRp+F_vHwFbfYS8dA@mail.gmail.com>
Subject: Re: [RFC PATCH] block, fs: use FOLL_LONGTERM as gup_flags for direct IO
To: Sooyong Suk <s.suk@samsung.com>
Cc: Jaewon Kim <jaewon31.kim@gmail.com>, Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	spssyr@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org, 
	dhavale@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:07=E2=80=AFPM Sooyong Suk <s.suk@samsung.com> wrot=
e:
>
> > On Fri, Mar 7, 2025 at 12:26=E2=80=AFAM Christoph Hellwig <hch@infradea=
d.org>
> > wrote:
> > >
> > > On Thu, Mar 06, 2025 at 04:40:56PM +0900, Sooyong Suk wrote:
> > > > There are GUP references to pages that are serving as direct IO
> > buffers.
> > > > Those pages can be allocated from CMA pageblocks despite they can b=
e
> > > > pinned until the DIO is completed.
> > >
> > > direct I/O is eactly the case that is not FOLL_LONGTERM and one of th=
e
> > > reasons to even have the flag.  So big fat no to this.
> > >
> >
>
> Understood.
>
> > Hello, thank you for your comment.
> > We, Sooyong and I, wanted to get some opinions about this FOLL_LONGTERM
> > for direct I/O as CMA memory got pinned pages which had been pinned fro=
m
> > direct io.
> >
> > > You also completely failed to address the relevant mailinglist and
> > > maintainers.
> >
> > I added block maintainer Jens Axboe and the block layer maillinst here,
> > and added Suren and Sandeep, too.

I'm very far from being a block layer expert :)

>
> Then, what do you think of using PF_MEMALLOC_PIN for this context as belo=
w?
> This will only remove __GFP_MOVABLE from its allocation flag.
> Since __bio_iov_iter_get_pages() indicates that it will pin user or kerne=
l pages,
> there seems to be no reason not to use this process flag.

I think this will help you only when the pages are faulted in but if
__get_user_pages() finds an already mapped page which happens to be
allocated from CMA, it will not migrate it. So, you might still end up
with unmovable pages inside CMA.

>
> block/bio.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/block/bio.c b/block/bio.c
> index 65c796ecb..671e28966 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1248,6 +1248,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
>         unsigned len, i =3D 0;
>         size_t offset;
>         int ret =3D 0;
> +       unsigned int flags;
>
>         /*
>          * Move page array up in the allocated memory for the bio vecs as=
 far as
> @@ -1267,9 +1268,11 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
>          * result to ensure the bio's total size is correct. The remainde=
r of
>          * the iov data will be picked up in the next bio iteration.
>          */
> +       flags =3D memalloc_pin_save();
>         size =3D iov_iter_extract_pages(iter, &pages,
>                                       UINT_MAX - bio->bi_iter.bi_size,
>                                       nr_pages, extraction_flags, &offset=
);
> +       memalloc_pin_restore(flags);
>         if (unlikely(size <=3D 0))
>                 return size ? size : -EFAULT;
>
>
