Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEB4396B96
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154288; cv=none; b=WbKd8ObGkwM2C9WpCmrrqYA328igk7BabyRi1C0DE2eukkr8T8lTpkyu90K2xyJfdQ6sgC1zTRNQBxlzRv0ZXortkGTMxngOMY6Anrn8sZHyBLJwQBRXrX+bcD/TpIhxRSi1B/zs1rD+qs7RKC7xhV4XDpctZ6+OdFbrLXee+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154288; c=relaxed/simple;
	bh=0LW6ewPllsE0kk3hkp55SYoeTOmeWkKlgWXGeZqqgg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lh+7OlseP0i1kLrdEecgZaEPQLh02ueO1rpKdeaWAToKKAsWtFoOAGwDANnn8gegNd3NkcO/EYmqDEjQticR/FNkWKb8p9Jp8uSrpSTrlYbJs0/+OG1DML+iUgAg48cajg8Y5dc4M/G5XIC/Cp2Ad56RF9Y1XzUCRMLh4OHc/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c04152730so180390366b.0
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 11:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775154286; x=1775759086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cy0GIkRcrSZ2c1GLhc0y0J/JGEyEQ2anDQt5EGzSXu8=;
        b=c8wj9mcJYlBX0hglhPNE9XOc/0MVIIui6X7acYCePcXCgaLGf+dQuJP+850IwTnzJH
         UwVEUkLlJx7WdlESTw4T/JZtDi3Z6NzjAQrq9bT4Chnf4XsiJfTiYALlFvq8lI9XY11D
         2v2yNqBfQiATOKs7t1mrpQR31RICtpAL6UO0jYUTIPekpsFV1mBrTNlcPvpb4nlSz2TZ
         ORA7Lcjbu8jNuSjL0m/AdHbVQmUHCgRuePl20rkGJoUmBi7J5nW8xToxSQLXRiGB4ZBx
         WKQDfoWNrNjXV3cEPJ2TCjKh3g2CxRpGR1xRXHuD81ROWysc9CkgojVSQX41a1/g639r
         inTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYEEvavcY/WWSJ19fQtRa0+/hRI4saS6/sET6IEemH8sN123um3iUti2EcTqaZ1mx1lRCmKzZtqaljvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSHSx89ZYotZLBxybUHySkxX08qL6/H7q1O+UinrG8PQ6f51gD
	kbDdY5CU2fdEaPFn2AOn1YkqRAiblvA/MMLTudgw2h/0qkX6ua54PK1f0zhCq8HW+4IfXw==
X-Gm-Gg: ATEYQzwRmGnVLVIlTIt2UKFBY3IcRYPvAEP+AWs+6SMTcNRx180EfpNP7zvbl3AH7Pa
	f6SZjZv8ByxSTCkGUOXsnJpMG+MDYtbbVfEATa4z28lLHBbrkWVIAA0/ZURI3Qbiw7AYkDzDE6k
	N6dbHmZQjol6I2Lhnu83EPEUidLNip7MTYnf2OGtmyokkK0xopcpF2wzOfEB7ReJkcbEiIJDjev
	kyBN0zWINZQaEP0mtht9VF3TnDd2mxvTYSG/lMyQJXW+sef0PpdWU29mxM14J1bL2ZCGxQU+b4L
	s+M14QQnsNHFR3ZFB7QakVKidNkstmES2GYPAZ//YVBsbSBxlkDU20XMAWzSF1+QwF2ZlONaa70
	Rpb7sCmXEuatEzXinO/AwSqBX1SMSK7my6TidME/IJvrNlrGbt1IEV51efbssaEyHlByp3mbK2F
	c04tvnrE/YnMXczHp+v4GMxAIld+OJOENUrpdK7GtUnHI/2RZfz094QF4=
X-Received: by 2002:a17:907:96a0:b0:b98:8cc4:4abb with SMTP id a640c23a62f3a-b9c3ef8ba96mr272674166b.23.1775154285279;
        Thu, 02 Apr 2026 11:24:45 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c97209csm122087866b.12.2026.04.02.11.24.44
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 11:24:45 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48891776099so12126085e9.2
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 11:24:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCpQ5clZpBORiGghtzVwf9e1cOGhJwu6BTPwISCRhLV4igR1OjhOUcTD7I95dQu3b0CbP+UJ8HcSfHKQ==@vger.kernel.org
X-Received: by 2002:a05:600c:4ec7:b0:485:35a4:939f with SMTP id
 5b1f17b1804b1-488997ebfbamr459685e9.28.1775154284710; Thu, 02 Apr 2026
 11:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20260330230512epcas5p3edfcbd6e163aab8b238c317418abb7a2@epcas5p3.samsung.com>
 <20260330230256.4160820-2-iam@sung-woo.kim> <c7c7d273-9012-47df-841c-156fedd8edb6@samsung.com>
In-Reply-To: <c7c7d273-9012-47df-841c-156fedd8edb6@samsung.com>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 3 Apr 2026 03:24:28 +0900
X-Gmail-Original-Message-ID: <CAJNyHp+0cXJixnZKSP9WEaWS0QzdNQKSrGTb52RNEAMdgX5ygg@mail.gmail.com>
X-Gm-Features: AQROBzD0KJTgHGfSZskahHOVF44DifMrSOkCzNvgu348WG2VPNMpdKaK2930A1I
Message-ID: <CAJNyHp+0cXJixnZKSP9WEaWS0QzdNQKSrGTb52RNEAMdgX5ygg@mail.gmail.com>
Subject: Re: [PATCH v2] block: Fix general protection fault in bio_integrity_map_user()
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[snip]
> > ---
> > V1:https://lore.kernel.org/linux-block/20260308001358.1675543-2-iam@sung-
> > woo.kim/T/#u
> > V1->V2:
> > - v1 incorrectly assumed pin_user_pages_fast() returns bytes. Fixed.
>
> But this function does not call pin_user_pages_fast(). It calls
> iov_iter_extract_pages() which returns in bytes. So v1 maybe better than
> this patch?

Thank you for your review.  If iov_iter_extract_pages() returns bytes,
this patch is completely wrong.

> >
> >   block/bio-integrity.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> > index 20f5d301d32d..992ce39e8ab9 100644
> > --- a/block/bio-integrity.c
> > +++ b/block/bio-integrity.c
> > @@ -338,6 +338,15 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
> >                                       extraction_flags, &offset);
> >       if (unlikely(ret < 0))
> >               goto free_bvec;
> > +     if (unlikely(ret != nr_vecs)) {
>
> ret is in bytes and nr_vecs is in pages. Almost always we will go inside
> and throw failures for perfectly valid case. No?
>

Right.

> > +             for (int i = 0; i < ret; i++)
> > +                     unpin_user_page(pages[i]);
>
> And out-of-bounds access here.

I assume blktests can catch this. So, it might be a good idea to
confirm the patch with blktests.
I will do this in v3.

Thank you again for your review.
Sungwoo.

>
> > +
> > +             if (pages != stack_pages)
> > +                     kvfree(pages);
> > +             ret = -EFAULT;
>
>
