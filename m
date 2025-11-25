Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4315C26F2B6
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764042089; cv=none; b=T4LriirP8ABeeSjdEsSIrH0iRYK+CUjKE7EavCmMC6CwvRz7LqghoapYpx6VTYyPI8whX3CDusJ1uprUej2FRktmIYLGjX3c7scYIS+0BFeV1iAeDmtPYxr1lepsvxEkRUErZXd+bkFirqYIWokSzEa9gDSokXM9kbBJIziMLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764042089; c=relaxed/simple;
	bh=6hX4p+pcHQX2zRBwuyuMz7wPOUrb/MLLAa4YYHu7zhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cER2sT/hTWGWWm1BcgXwFqpN5kYY1c4/JpyK6oN6bclgzbPmZsax2yNuNfgFY0I6ZDTTB8Ev57FzbacyWPukk+M8yECb5zeMyGvaKBjSeuA0+dOX9TLIFxky7wgwnz6n7Mt/BDW/Us4pbTErXhEsl7XIGxNUDyO5j2D/8/9CBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XyZrS6da; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XyZrS6da"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7ab689d3fa0so627143b3a.0
        for <linux-block@vger.kernel.org>; Mon, 24 Nov 2025 19:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764042087; x=1764646887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8STTHMEQ2FtY02yQMAJz7yi3iZVqLGCCDlJuLpB1khM=;
        b=XyZrS6daRjPiD/Of1Kxd51fIUVMb3nUk1bI5Oxj7ULeiv5JZ/V2jauXEVDJcs3cnJJ
         ENCrvHflQKa16IzDGvtwNPjRIdihMeLgh5LfXV2TL/CrFXuskX7RFEjeixF7ITO8TZdS
         7+Ewnh0/0APCVCm3l/MECu0hrzisvEb2gXxpvcme2ZMEltbpgnJoRFthqVaREG+fnJOY
         kjT05Dp632xAhnJs6gME4FzyhrH6loMnVkeR1UtTbP7h7D8FHJIMK5pOgW4aG/u4hMWl
         wuX+gAfA1xoRWmPkLydwP/XHVMsCHCGW9WZf79WvGit7aGa6yC8ONhz4Qt6U0XgIqrvD
         CuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764042087; x=1764646887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8STTHMEQ2FtY02yQMAJz7yi3iZVqLGCCDlJuLpB1khM=;
        b=lI40zOnkC9+BM/gr2JhHJ88S8Ayw12GpELO0WTQb9j2YxzMxbNqoCmbXRXYKC/+Uqu
         Uab2UojTfyQys279JxUI+GsDV3sQZTN0t9t1EDdkslIHldL7NkxzJPXB/ygvPfu6rL8G
         rloKkq++Rd5VhqEsBVla/XSiz42iiA7UENVgwh/QQ5g1Gj6HIuF6dK/BUrvvNG5k3NHi
         Mu/hhAecsJCLWBZT1zN/48/AClDTe5B5XqJlo5jYrbNdgZMFUnM3xWC5u1xLNfzZ/wQU
         T2W9tK3efqJe6YNLM7Mp+rMgJPfquU+IRYWzYT7MEBerwVNSA7hhMZWmffwERETUuBMN
         uOoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlP284GJbJ4rDqU4gChsLqVS+/xuj/SdB9YmVqoTG5nU4cOklpi7TLLa1kQZAfPRhXRoLEheHnalh/VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzglR5gimIOKzwtct4zn1hYxb7yzlJLxYtpzKMjHpLG/gzjAM+/
	fE8uN7j5DgkcIglO18xQrn+vy9ui/gNxbgxWY0cRId06S6iX13r9WpcxBlJAjz765LI7YYUi2V3
	mO4pTtawqxa0PeHkWOizaoT2hpaK2YloxImEXsi2pa1m8Z01Ahll4uXNnHQ==
X-Gm-Gg: ASbGncvu5jwS5vDwr/bUkfAW7wdg/C9zoq6++tilL5gOAVTJSPasu5glDq84Sl7a7Z3
	arcPPggjP03o/PeeAFF0YNae1out8QFl5xWWvZJ2K4fGBXS5URjo8O9dfJrs4quYzTAoMi6ZTSU
	PX4xUfYtte/ziwO6IZwu+TrHzQiQlEzMzUUQlC7ix8vap2b138qub0pt20qbUjA9/PhJ+eNIcH4
	wIM5vdpNXF9zvgdDuPRoVeut/3Zc99USBeqzgcWBPe5FLPcI86USHYxT8uNrFHFIyHALNS/
X-Google-Smtp-Source: AGHT+IH+7zTYmr0hGesLktBGUY+BvfoHVBlKCdV0+qaszs+Zxui4HvB146gLlXrtBqOod00+sWNqOoYpTx6cmbl451A=
X-Received: by 2002:a05:7022:68a1:b0:11b:862d:8031 with SMTP id
 a92af1059eb24-11c9f216eccmr8320215c88.0.1764042087326; Mon, 24 Nov 2025
 19:41:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124161707.3491456-1-kbusch@meta.com> <CADUfDZqrpJXLLU9V3eFJvRgth45-ht-yi4cSpmrBdnbfQGtWYw@mail.gmail.com>
 <aSTii9KbN6wQCvOt@kbusch-mbp>
In-Reply-To: <aSTii9KbN6wQCvOt@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 24 Nov 2025 19:41:16 -0800
X-Gm-Features: AWmQ_bnhWPpqG4nkwCkfwn4WNk3IdO-Vf51YR6PdN3XnDxWBafjhoaenDhNR3bw
Message-ID: <CADUfDZogsF53MENLLyd0iCGKUoSqap3bEfSbt72KPifO4tvzfA@mail.gmail.com>
Subject: Re: [PATCHv6] blk-integrity: support arbitrary buffer alignment
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, axboe@kernel.dk, 
	hch@lst.de, ebiggers@kernel.org, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 2:56=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Nov 24, 2025 at 01:34:03PM -0800, Caleb Sander Mateos wrote:
> > On Mon, Nov 24, 2025 at 8:18=E2=80=AFAM Keith Busch <kbusch@meta.com> w=
rote:
> > >
> > > From: Keith Busch <kbusch@kernel.org>
> > >
> > > A bio segment may have partial interval block data with the rest cont=
inuing
> > > into the next segments because direct-io data payloads only need to a=
ligned in
> >
> > "need to be aligned"?
>
> In the original text, s/aligned/align

That works.

>
> > > +       while (offset > 0) {
> > > +               struct bio_vec pbv =3D mp_bvec_iter_bvec(bvec, iter->=
prot_iter);
> > > +               unsigned int len =3D min(pbv.bv_len, offset);
> > > +               void *prot_buf =3D bvec_kmap_local(&pbv);
> >
> > Is it valid to use bvec_kmap_local() on a multi-page bvec?
>
> If it wasn't valid, there'd be a major problem with large folios.
>
> > It calls
> > kmap_local_page() internally, which will only map the first page,
> > right?
>
> Compare kmap_local_page() with kmap_local_folio(). They both resolve to
> the same lower level mapping function, and folios have no problem
> spanning pages.

Documentation/mm/highmem.rst seems to suggest that kmap_local_folio()
only maps the page that contains the specified offset, not the whole
folio:
The only differences between them consist in the first taking a pointer
to a struct page and the second taking a pointer to struct folio and the by=
te
offset within the folio which identifies the page.

And this is consistent with the implementation, which passes
__kmap_local_page_prot() the page at the given offset into the folio.

Of course, both are no-ops for non-CONFIG_HIGHMEM systems, so it may
be difficult to observe the difference on most systems these days...

>
> > > @@ -1874,6 +1874,7 @@ static bool nvme_init_integrity(struct nvme_ns_=
head *head,
> > >                 break;
> > >         }
> > >
> > > +       bi->flags |=3D BLK_SPLIT_INTERVAL_CAPABLE;
> >
> > Can just be =3D instead of |=3D since bi is zeroed above.
>
> It can, but these kinds of syntax are a courtesty to future changes so
> that you don't need to change this line later. You can also end a struct
> initialization without a trailing "," too, but that's just mean.

Sure, either way is fine.

Best,
Caleb
