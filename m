Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBA531A57C
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698591; cv=none; b=qPz4ZRUBuGAQpSqbBKpJKaLp2jVok+TugvGUNULZ76zUFSkGDlqFi9DZc91DRSzOqh3K35Q+wnXVl7/ASzLJsU3EKoivMqshO8jvRv1hkd4xqXtcsOltnYAjKkxls3xqsyznrOtyvYi6v75lCEb+Xna4QF4lwwhT3UehOu2Wxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698591; c=relaxed/simple;
	bh=yK0tz6ECng/GkzGWo1PQRHtl9PMBAN4W2lEev0pJQG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9nCHtpNHWaqP64+Nfh+dJvBWkWWPrzWgFdBqXrz5cPKjwKqB3hVN1KyKhpG88THT0XSxQ1okA6KleFhvOvvr6s9jVLhPQwiGTNVKiFG3Acv//ztEJdgsbTzo747ZOh5MkCQYALqHyriTC8CMkZ6O3vi/8zTLq9aU/Y9xpHlfE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSrwdj2h; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSrwdj2h"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b5fbd77f40so29302851cf.2
        for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757698589; x=1758303389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaoWmn122bkATHsMm2TW6koAeUnmN4wL024VSWi/QfE=;
        b=fSrwdj2h4HxBV0EQ5JI59iDya2AujG1smsOrVLSzq+AOqqKP2Od/OSmumRgPy1lgej
         aWI/JS9eE9CuBihOeiiuh+KH9UmsjoAq3shPuJv8STt+VBaCoZW5vNa++l5moePpPU2H
         Iqe5y7QyKcxO2HIb+wX9Ce1LpL7HrBPvEiJTq0Q0ndGvnWf5GVcz8NRZI8sbZf1NTN/i
         ndJSFDXies3ZQbzCPjSN6k3f3OBxY1Gsd0L0CJf4vaj+6GTqSjBqoD1cJhlFovTfzG43
         fbVTu2k266wjJMq33X6XQDhzpVC3M3WuBSHVAVH1wE73tKua79oQPp+VyRxQdQo385Pe
         1vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757698589; x=1758303389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaoWmn122bkATHsMm2TW6koAeUnmN4wL024VSWi/QfE=;
        b=StV06uOa3ZcPtkpEgPOo42GxFlKtZ8mPEicuJvZ4nIOGpQgea47pR0TnotkWY6dvdu
         6oA0Kb8oMdREbJVqR8lkVhlA+I1Emn455ov6s3A/GCWMvBr0pCNNdgcBZjoOA9Rl3toE
         1GvBlsLtYgeexFmlVFHHgM0lQLkDtqMVs1PTJkuBl9zSI8f7jyXTqOLqQGeNCTBCdT/s
         SaBb8KNuo+P+46jvbNU6wMPT281ARVVO0nNQ9ySSLlijI0tTxhd94eNHTmgZMqOa2zKG
         LYOqqLRXWFXsSvfWdRadjCXKf+11KiTMnpfX3s2cI9pnVF/mj1nK+jaNWDNTfffKWeXP
         I1ew==
X-Forwarded-Encrypted: i=1; AJvYcCUYNvHxC+QPGqHsPFy+yDtHxe6yMH1XudEweK7ZhcO5bR/WEhAeWSLACRjWoXYMTWC2yi+8bIQRuB+xfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyea3+UKmkTSn1d5G8Qb7JdUF4r8UorPGUvfwcfK2TKB0+5o6k5
	k3+qjKvUKXW9cYyiJxLK8k0IMip0bRSkUFMyjoTSoGMDmdyJO39OQ9iFudzASMoGPqg4Al67DEW
	GGSEUWn5FNl7JrF9qJ+oF1SuviyGF06o=
X-Gm-Gg: ASbGncu5FfhR96WkIWn5o/HzOWCgkla36BPUcsWMg2AnxADihCTgTtQjn+ynZ+pw3z9
	PblXt4QDI4ho0jNdDFDjYA/kW8K5db57zjxL8GnRWddXUX3NuCJjv9ves11MNQViyn0pQ84mc0q
	9zeFuvQlfV4BWAbqtu9osc1TX3codKs/D1SADXVQYJPJKESETx1wR7huaUebPRoqQSVdUqWYrc9
	gWxG3TVSr3Nfmd9MQExdExkKEfo0qd2EwErMdqMGw1qCQ6ikwIR
X-Google-Smtp-Source: AGHT+IH7GMrBmyVYd7mK7Xmpyd9r7k7cyb03zWtnoaxVf5aKJ9xehKSBV/1hqSTeEYXKWJdrlpEgvVzc7a+DG2b03cg=
X-Received: by 2002:a05:622a:581a:b0:4b5:4874:4f92 with SMTP id
 d75a77b69052e-4b77d0137b3mr62431321cf.13.1757698588919; Fri, 12 Sep 2025
 10:36:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-12-joannelkoong@gmail.com> <aMKx23I3oh5fN-F8@infradead.org>
In-Reply-To: <aMKx23I3oh5fN-F8@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 12 Sep 2025 13:36:18 -0400
X-Gm-Features: Ac12FXza_WwHTwR6ZN8SwpAjhAiC4oowkVj8eON9gC8viGDNCKpw6hOW6Wr675M
Message-ID: <CAJnrk1aKiKSTB3+c8BRbt+h9L5eq_Yy2y143fPUcUM04VTjd_Q@mail.gmail.com>
Subject: Re: [PATCH v2 11/16] iomap: add caller-provided callbacks for read
 and readahead
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, djwong@kernel.org, 
	hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 7:26=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Sep 08, 2025 at 11:51:17AM -0700, Joanne Koong wrote:
> > +  - ``read_folio_range``: Called to read in the range (read can be don=
e
> > +    synchronously or asynchronously). This must be provided by the cal=
ler.
>
> As far as I can tell, the interface is always based on an asynchronous
> operation, but doesn't preclude completing it right away.  So the above
> is a little misleading.
>
> > +     struct iomap_read_folio_ctx ctx =3D {
> > +             .ops =3D &iomap_read_bios_ops,
> > +             .cur_folio =3D folio,
> > +     };
> >
> > +     return iomap_read_folio(&blkdev_iomap_ops, &ctx);
>
> > +     struct iomap_read_folio_ctx ctx =3D {
> > +             .ops =3D &iomap_read_bios_ops,
> > +             .rac =3D rac,
> > +     };
> > +
> > +     iomap_readahead(&blkdev_iomap_ops, &ctx);
>
> Can you add iomap_bio_read_folio and iomap_bio_readahead inline helpers
> to reduce this boilerplate code duplicated in various file systems?
>
> > -static void iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
> > +static int iomap_submit_read_bio(struct iomap_read_folio_ctx *ctx)
> >  {
> >       struct bio *bio =3D ctx->private;
> >
> >       if (bio)
> >               submit_bio(bio);
> > +
> > +     return 0;
>
> Submission interfaces that can return errors both synchronously and
> asynchronously are extremely error probe. I'd be much happier if this
> interface could not return errors.

Sounds great, I will make these changes you suggested here and in your
comments on the other patches too.

Thank you for reviewing this patchset.

>
> > +const struct iomap_read_ops iomap_read_bios_ops =3D {
> > +     .read_folio_range =3D iomap_read_folio_range_bio_async,
> > +     .read_submit =3D iomap_submit_read_bio,
> > +};
>
> Please use tabs to align struct initializers before the '=3D'.
>
