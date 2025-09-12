Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE424BCF5
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692893; cv=none; b=SHG4gyegItibuzDR+VmwheV6DwzzJcYvopR7DmTF45aZezhsR6+9L3DTimfH7DCOdpayo/HgxnhKnxb7OQUxiR3D5UsAvkEz5FJUnc/4AsR3kLfEsJxIsqOqQoEefg+RmlulDsHMfJIRqYaBrfgZeEeOOmu03iWM8ibqbfkV+ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692893; c=relaxed/simple;
	bh=MRVkhyLhBzuYU060K/KA1IS9FmS+Zv1ZvikNViDB1i8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEARs53PouCsW/1RbOEPO3orL94T2TNmWtzWu2XUN7xLPKDLAabIhJrNjGzCm1c3RP9lRMDUJhvqwC/aDdkUAP44fyEL7Vmslq9X6LTqC6Wp7ppkWySD+k2B2Lf+nvIjoJWp4KgH6o0Vty1rwWK3rf4eYv4N+ENC+N5ParQk1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGpt8Rvs; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGpt8Rvs"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b5ed9d7e30so24434991cf.3
        for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757692891; x=1758297691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOTrb4IXV8TTdWYoR9Od+Zkf9J1Lc0eHO5aRXijaq2Y=;
        b=AGpt8RvsOAhCTeRJL3LhbS6LxY4dCbTWGiTrmP8PM346aF5YnVVlt8JZkwY3zFKDi8
         1ELiPzumxjtp8N1VbuAAcOeseFODzlt+/fBQEEpqFdXnBkXNZAaBj16KFrQGEtzgRVBt
         dJmAK22od4FDQJUoF0ImLGCx6lKcnvoX8BBIjuQmEj/OJdEcitpQ4/7PwbfSzJPgrWEb
         bIyViWouxTdW6KN6Dj8nwaKVAmtr8zQYfs6mOKqRrszxUh4vM1fy3vYuoYvj3rPi4lw9
         263A/PaSBFBm3+57F5E3FfTBmBFSLzAcG4TYKU1eY/vXdR4GBlbxUhAcl4BgktPAd3eX
         iFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757692891; x=1758297691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOTrb4IXV8TTdWYoR9Od+Zkf9J1Lc0eHO5aRXijaq2Y=;
        b=R1nOwM9ys0jAwvkLVUiaySk+gmFmLk+GCV96QRxFjbcCA2M9UJq5I0y5rtuPROk6Le
         kYaQYqlBJV9fMvxHYMK7zq7lD131g5VOhuD0o/SHgZbYcLtfXM8FU7jenX2R+shVx9h3
         KXQWQjgHFSgZFACUUsB0Sl40dnOVYwRwVdtg/QdNj8JsNhqDiHK98AbO4S2QyKChHN2O
         J7J0xxemBtsn9J/PynuJSlUKDS0s/Z+KI/YFPJxElQeCbdTeM0JqbYeydT9GnqqG6Cau
         Vvr9ini136haYjuEa0eMGJUQR0f66X3eJez32w3FIi9MPCPJ9su46Xxo3PpdMbZBcPuP
         2ZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFMJpFQEP63V0yVINqhKdGHV0UVGUu24SPhb25RCPgvgGDW5PTK80vDUaoiq4mCwR1iorXgnLutNUpNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxryQ7L+0YnXW50V70tF+qlvr91P9wzP0OT0Qvx35Mof/vCLHe+
	xfvRjwUGSDghamiwtZWQoQpUk/HnDxz5Mgf7gJpxm4r+YXfz+bCmYJR4+6U5pCZEROqXSq5JQ+J
	7ncleb7p24nMcee8q840Y514IFSUv1d8=
X-Gm-Gg: ASbGnculGpGwSDUgirtbGvH8L4mG2Mg+cC499KZ2f7++pOcLWr8R2z7eXmHJb2TCiWL
	RLlyaN6scjTo2LzsnKvzadgDoK43Ava2J/QRszf2XrrZnTTl3Ccr3p+OX2wM/6o3DCcILHBZjU6
	fHytQunjD/xAJgPSxeiF4LqlPmrTzt0SeUKpmx03Zkk+0YHsF5j9boAumhVmiEEL96htf5aoxJu
	uX7zStY/1xk0Lcj1inJEBH68ONA2KbFDWe6WOzgrnpG1OuNYutF
X-Google-Smtp-Source: AGHT+IFpEJeHHGMR/+rANXvYCLHGXODc/LHx0ut1LxSgKOWEZt2yvx1hw4BgafRJMV62S+17la7+3LzfUFy0mc1meoE=
X-Received: by 2002:a05:622a:4244:b0:4b5:da13:3b70 with SMTP id
 d75a77b69052e-4b77cfab1a5mr44965001cf.10.1757692890378; Fri, 12 Sep 2025
 09:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-2-joannelkoong@gmail.com> <aMKt52YxKi1Wrw4y@infradead.org>
In-Reply-To: <aMKt52YxKi1Wrw4y@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 12:01:19 -0400
X-Gm-Features: Ac12FXyzQBWaHPsdA5p-aXewM42KENc2X1_esV-qMD6PmHLNB3vND9MBVb-40GM
Message-ID: <CAJnrk1bFQTKKBzU=2=nUFZ=-CH_Pc5VAj8JCJoG0hgNszMp2ag@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] iomap: move async bio read logic into helper function
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:13=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > +static void iomap_read_folio_range_bio_async(const struct iomap_iter *=
iter,
> > +             struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
>
> The _async here feels very misplaced, because pretty much everyting in
> the area except for the odd write_begin helper is async, and the postfix
> does not match the method name.
>
> Also as a general discussion for naming, having common prefixed for sets
> of related helpers is nice.  Maybe use iomap_bio_* for all the bio
> helpers were're adding here?  We can then fix the direct I/O code to
> match that later.

Great point, I'll change this to "iomap_bio_read_folio_range()" for
the async version and then "iomap_bio_read_folio_range_sync()" for the
synchronous version.
>
> >  {
> > +     struct folio *folio =3D ctx->cur_folio;
> >       const struct iomap *iomap =3D &iter->iomap;
> > -     loff_t pos =3D iter->pos;
>
> Looking at the caller, it seems we should not need the pos argument if
> we adjust pos just after calculating count at the beginning of the loop.
> I think that would be a much better interface.
>

Sounds good, in that case I think we should do the same for the the
buffered writes ->read_folio_range() api later too then to have it
match

Thanks,
Joanne
