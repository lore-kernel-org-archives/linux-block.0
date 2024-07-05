Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD411448C7
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 11:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179064; cv=none; b=Fx9b0XRCEysfhY94OecqtxRCsUS793PL+bKdFV+CGHJlupIJ5QgbMLZl7hl8bEDFIL7JUeqtQqSV5GX15HO1MoBPt1XFrbl8rSyMkMAecMx8dVqD5jOh0wBhF5qA9iGn6mpFhbsNJK0KrTko+MgG3wh000JUqYoEx9R1WPUQK/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179064; c=relaxed/simple;
	bh=EgcwXdIvXQDNY3GZ3aYCtzQQGGp7IEMKNKHVTI9HF18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAPHFYlM0q1qPzoybt4up1K5qLtEC+Vxv1rNYD6zaASrueEFyNjjxHK3QSnz2YLF2e/dydIkLA5W6XLPP48vEPcAWsT2jfJsw65Mz3oOmY2Lg3argGWdqMg5/fDSBrpg9GzneTKqt8zV3iKLX0laqBkviPslWAML/X9iV63YbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-64b29539d86so13287267b3.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 04:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720179060; x=1720783860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hbjZd5X+NaHX9Z8zRl3iN5Nokn1Qy+oFoxrA0AKjGI=;
        b=g9UZoLuA2ar1clbZxjn2w22o2NfCNcQSaAxSvXfKp6ZBhAX1f/G8V9AYkpZ0Xp9bct
         LSXP+mlAk9LRyRhtErNaT6JtI6uTaLuEJ0ZWeRTyHiXZaGD1hoNZZ9NFx6cxSMQgdRVt
         rqgvCbofL6oygz4JI63l3i74mFFfD9kzQKSkJU2rWMeQHHalIFuX4hK8b/DpnslQRd7s
         c4aiDOaonaNBIb0fuFnrPryaVONC3rVu+lu1FO+m1yw29vYt85NV7fiy0vRCfIZ6kfek
         R/ITTkZwlpeU+HGok7UxeKsfqCcVzfKOYlL8Qk6c4On27FSDxXZGkqXSlC1jZ7llcytE
         HqOw==
X-Forwarded-Encrypted: i=1; AJvYcCUcixcN951iEalFwDrrAWyiah75hzB1Xxky9Uv8U8JtXYASMMdzeQCURcaaaMCo7oTyvpu+HF/WphrLn3MldirU+As6yF7MGqnZ+WE=
X-Gm-Message-State: AOJu0Yy2F+R6Z9L9t7H6UZjGafXqFur9vM+rzctF+nWtUt/xttrTyCU0
	T7u8MhLjAdKybb1SSd84oxK+Rrg2VoYCyHoHPlO65ATv9OEqwuWXeDFlcqEM
X-Google-Smtp-Source: AGHT+IG3tDT8LcnekcUSQ3GR2w93DCVhMiKDaaKhq71TUtQyYG8tUpq6hBxoFjsrpb3lRPyNOzi7Jg==
X-Received: by 2002:a05:690c:f02:b0:62c:c696:5631 with SMTP id 00721157ae682-652d5448f87mr53507427b3.13.1720179060496;
        Fri, 05 Jul 2024 04:31:00 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a99c71a81sm28284697b3.14.2024.07.05.04.31.00
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 04:31:00 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-64f4fd64773so17247727b3.0
        for <linux-block@vger.kernel.org>; Fri, 05 Jul 2024 04:31:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUchBUH0jz5RhMIy6wTpVxCgMOylqf0miIoY+R409KczCsksJbFrDIVkX++4ycL5SopIIZ5ysq+KVX/W4OX8F22K+UhiWA43l4BULw=
X-Received: by 2002:a81:8b45:0:b0:63c:416f:182d with SMTP id
 00721157ae682-652d5444259mr42613887b3.12.1720179060065; Fri, 05 Jul 2024
 04:31:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705081508.2110169-1-hch@lst.de> <20240705081508.2110169-3-hch@lst.de>
 <CAMuHMdWmqRq2oBtgY0w1ZPcCchqBm7pmsWBGmqQhAPK6V-Tz7g@mail.gmail.com> <20240705112230.GA28636@lst.de>
In-Reply-To: <20240705112230.GA28636@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 13:30:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXaV+jQZ3+sPc5_BY_9CBr9t4pzy29bWn+okNC3squDow@mail.gmail.com>
Message-ID: <CAMuHMdXaV+jQZ3+sPc5_BY_9CBr9t4pzy29bWn+okNC3squDow@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: add a bvec_phys helper
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Fri, Jul 5, 2024 at 1:22=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
> On Fri, Jul 05, 2024 at 10:50:31AM +0200, Geert Uytterhoeven wrote:
> > > +               seg_size =3D get_max_segment_size(lim, bvec_phys(bv) =
+ total_len);
> > >                 seg_size =3D min(seg_size, len);
> > >
> > >                 (*nsegs)++;
> > > @@ -492,8 +491,7 @@ static unsigned blk_bvec_map_sg(struct request_qu=
eue *q,
> > >         while (nbytes > 0) {
> > >                 unsigned offset =3D bvec->bv_offset + total;
> > >                 unsigned len =3D min(get_max_segment_size(&q->limits,
> > > -                                  page_to_phys(bvec->bv_page) + offs=
et),
> > > -                                  nbytes);
> > > +                                  bvec_phys(bvec) + total), nbytes);
> > >                 struct page *page =3D bvec->bv_page;
> > >
> > >                 /*
> >
> > If you would have introduce bvec_phys() first, you could fold the above
> > two hunks into [PATCH 1/2].
>
> Not sure what the advantage of that is, though?

It would avoid having to change these lines twice: once to the open-coded
bvec_phys() variant, and a second time to bvec_phys().

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
