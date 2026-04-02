Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E236BCF5
	for <linux-block@vger.kernel.org>; Thu,  2 Apr 2026 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153001; cv=none; b=LjoPrZTuyJs4hQ0bu6C36XA/nSRMdInJBdQ3FdFb9KipfByGBZu7osXAV4T5lT78YjLbFKOOOd07qA8wYEnHxM2cC/U0ci48FfM27iJnCbyqev9xyY9uhuyeeyT886CiWapiMS47RCjp20kK5Wx3k6Nz8ENM3/ADbKSS6CnQEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153001; c=relaxed/simple;
	bh=Mkn5kOCOSc/f+jR1oYFtQFgdWp3nxcr08jU8JPrnF/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lwk2Q6hHHOVrgasRHykV87J8eEFF5pLRJ1Hz6fKWeV0DCI+IryD2byygkKiDIvbZ7m/t0v3Wsltxu7fAKm/y2dwXfL4JSTrJJnqpDIGtgbuJLp+DVcsRuVZTjoSK56TAYqSWbwAdqa+7ERYY8LMxEZUeUSdsTbOq07OMFiO2ot8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sung-woo.kim
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b886fc047d5so188021166b.3
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 11:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152998; x=1775757798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0G68MehJuu7YEdcFaTp9lM+Hex+j/gEf6Oneakz4QDk=;
        b=CuPBcEGhuXOzMMBjFaN48Z5HxFC2bJx/tSwCrkhjG9Pyo5S1mQ4wVUoRiCpsWz6eAh
         wfJLT8pkM1JZ608pTv7xGqpHYLVBiUYhWMhVzBMbZ4SXXSqb9mFa8t3zB8ETqcLF8pPM
         79yxkozyZiP22WfqI3bRJY3z2Eert7rkmQsdzVjl8cT8GS5WNZxsDlpI9xERYnsL4mk2
         1EEelzdsvvVPfexKmU15B9phaCl60KtT3Om9yw94GTZaIJay6xDC/RsUDyX1JbsKtOr5
         +rq7SQIWNpGQCHqZFNsfr0HVS+xgjRs6cEPFU8LD97AtTQZR9FPnwPuE8PMdJOsSyqgI
         ez2w==
X-Forwarded-Encrypted: i=1; AJvYcCXxCKOxjWC+IBUgQnxsiZ592Ag5ZN1E88QEpNiPPoH5p4F7qayUwOxGtpN4zv7Bif/UhE8wuU96HLkh5g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbnHdrKSyTiI6u2dFKjzrQACpuDEExrLXLwVHS7dUDcqJmQpR
	fIpNaiJ40sgGt/QxZZbsWzk4RVOynq+lE1tytqPoLPGJpXLDXpnfbfg1b4ThY3KOcjs=
X-Gm-Gg: ATEYQzzrnY3YCAY868TNuHQO2eJ9INe8QnRRbbN3rtuksglJu87oPfZ9xJWBHzxjkXa
	Wbvz9paOvVZHX7SNOPs/iQXbF4py4zq++Dmmby2d+NnE0QDvoIVTDAQ+iaPoF6o/gCA6/rSByj3
	Zgrx4S2t/utVMOPi8fweE4FYjnmE/bZiMWcmhrHp2YRmJ+BGo0eqRjm2hC2qAts86ECiIFzOHg/
	mu5mv42BbNEBcnCMNCfXVkiuZseZXdSuz0/V41szmk6IfkHGW4C5FuJxN4rx1lIiJHETpq39JSO
	CUBw2n9k8ElL6oJyezWTdcYiE16J0w7poLsenpA1AF/ud2h4fLCYgZdVsmyK2ODg0J+dEehA8+1
	+P75qLHnOmen7tYnYbo6LI7EHtFGHxs62guEVxrZrHIlarcfNhwEfdypqvhHWSW55rqBm0yKh2p
	9n6d5A+pUC2SfR61ON7cr32DFoZKc3x4K/A13otWrcxZRFh+pJd5Eq2Oc=
X-Received: by 2002:a17:907:d096:b0:b98:2c44:6631 with SMTP id a640c23a62f3a-b9c138e425cmr568497366b.14.1775152998000;
        Thu, 02 Apr 2026 11:03:18 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c971f03sm113114866b.7.2026.04.02.11.03.17
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 11:03:17 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso692414f8f.2
        for <linux-block@vger.kernel.org>; Thu, 02 Apr 2026 11:03:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVkVvphHBw4ujEfUvSNZTOaAABuxgZ9TaUN0kyqtK0FQTKWa3818kZ26CEnRi4KeaZcwLt4Ogu2ZzaMxw==@vger.kernel.org
X-Received: by 2002:a05:6000:2885:b0:43b:3e34:7fe with SMTP id
 ffacd0b85a97d-43d292a8a4fmr18137f8f.21.1775152996488; Thu, 02 Apr 2026
 11:03:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330230256.4160820-2-iam@sung-woo.kim> <act0wKGUHCcQvAN8@infradead.org>
In-Reply-To: <act0wKGUHCcQvAN8@infradead.org>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 3 Apr 2026 03:03:00 +0900
X-Gmail-Original-Message-ID: <CAJNyHpK6ZPeRceCg5NWvvuRa23AMQYuwqhSQJcWJbNFiC6nrtA@mail.gmail.com>
X-Gm-Features: AQROBzDN96h0UD1_UsKsfoZXjcrv3-FTPiMPnbQJ80FE5rJS8xp2nBOYD3vcA9E
Message-ID: <CAJNyHpK6ZPeRceCg5NWvvuRa23AMQYuwqhSQJcWJbNFiC6nrtA@mail.gmail.com>
Subject: Re: [PATCH v2] block: Fix general protection fault in bio_integrity_map_user()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 4:16=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Mar 30, 2026 at 07:02:56PM -0400, Sungwoo Kim wrote:
> > pin_user_pages_fast() can partially succeed and return the number of
> > pages that were actually pinned. However, the bio_integrity_map_user()
> > does not handle this partial pinning. This leads to a general protectio=
n
> > fault since bvec_from_pages() dereferences an unpinned page address,
> > which is 0.
>
> Can you share the reproducer, or even better wire it up to blktests?

Thank you for letting me know about blktests. I'm learning this and
finding a way to reproduce this bug.
If blktests is not suitable for reproducing this - it might be too
early to think about this though - I have another idea to reproduce
this.
I can modify the pin_user_pages_fast() source to make it always
partial success, so there are always some unpinned pages, which is a
precondition of this bug.
I'd like to ask for comments on this if it doesn't make sense.

>
> >
> > To fix this, add a check to verify that all requested memory is pinned.
> >
> > KASAN splat:
> >
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc0000000001: 0000 [#1] PREEMPT SMP KASAN PTI
> > KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> > RIP: 0010:_compound_head home/wukong/fuzznvme/linux/./include/linux/pag=
e-flags.h:240 [inline]
> > RIP: 0010:bvec_from_pages home/wukong/fuzznvme/linux/block/bio-integrit=
y.c:290 [inline]
> >
> > Fixes: 492c5d455969 ("block: bio-integrity: directly map user buffers")
> > Acked-by: Chao Shi <cshi008@fiu.edu>
> > Acked-by: Weidong Zhu <weizhu@fiu.edu>
> > Acked-by: Dave Tian <daveti@purdue.edu>
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > V1: https://lore.kernel.org/linux-block/20260308001358.1675543-2-iam@su=
ng-woo.kim/T/#u
> > V1->V2:
> > - v1 incorrectly assumed pin_user_pages_fast() returns bytes. Fixed.
> >
> >  block/bio-integrity.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> > index 20f5d301d32d..992ce39e8ab9 100644
> > --- a/block/bio-integrity.c
> > +++ b/block/bio-integrity.c
> > @@ -338,6 +338,15 @@ int bio_integrity_map_user(struct bio *bio, struct=
 iov_iter *iter)
> >                                       extraction_flags, &offset);
> >       if (unlikely(ret < 0))
> >               goto free_bvec;
> > +     if (unlikely(ret !=3D nr_vecs)) {
> > +             for (int i =3D 0; i < ret; i++)
> > +                     unpin_user_page(pages[i]);
>
> I guess this works fine even for a negative ret, but it looks really
> odd.
>
> > +             if (pages !=3D stack_pages)
> > +                     kvfree(pages);
> > +             ret =3D -EFAULT;
> > +             goto free_bvec;
>
> This now loses the original return value if it alredy was
> negative.
>
> I think the better fix here would be to switch to
> iov_iter_extract_bvecs, but that might be a bit too big for
> a backportable bugfix, so I guess we should merge your patch
> first once it is fixed up.
>

Okay. I'll find a reproducer first. And then let's discuss about a fix.

Thanks again for your review.
Sungwoo.
