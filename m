Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B62EC0BF
	for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926586; cv=none; b=grwwOY47uc8+fNlNRSTRaeEvZl57iYo/z3YIImIYLrRWSlfk7IlzhPvUZQzSvS6vzA+Ad5V4PDRa/6DGFATkBBIClx601OjAWQm4YlKEVJg79t5neWFiTrU32T8odEuTwhnh1r71ZUx5GAR4hGm7CMWNWBzW+8zgUPjZEbeWVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926586; c=relaxed/simple;
	bh=wOFtqKU5cY/H+/wFI62mVCydJUcPAJO0oOtjoN+GD0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBPKOtA6B/Q4IWMZxJpLSrZkB3lw1zOK0eUPKQfuzTuy5YtWv0yj3paDc+8xyqVxhCUZhSCZNCQ4sPmoTxLBeI5S0+0JcLB63fuW6W7h68xn+Jp2ihbyQiQ+pQxbYAqr4NCDuA0JyZMg8wuk32USjKC37EAswQo9RU+yK2TfqIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=EiH4IaWo; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="EiH4IaWo"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a432101882so98451b3a.3
        for <linux-block@vger.kernel.org>; Fri, 31 Oct 2025 09:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1761926583; x=1762531383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKLnpauphF64zVNd2V79/vxesQJj7qD0DUlSjcW6MUA=;
        b=EiH4IaWolqZhtZSfAi/GsnIKmWR9uLr1lp3OEaW197rzRgOE6hA9dsWLbCmQBJ8qXn
         FtQ+YMpMi27vPKlTHmfqz1U5e8dybW6SYPhBXIZHEeuoG+KCugMR+83PGsU1KBmpUpY1
         +bhpOUs+IAHAipZRzhQVwjpQX6jG24CAFyzHKvDzetKjLrHwGfJmjNjmeEst8zwdDUXG
         GpER4z6BbJ0Harcm4kBUGfCe0eK90fv05kEBLnVzHHsTi+sEYo6VcjvYevYWnTN3OTyZ
         vOFLJ+k6D7Owx2X67BW7geIfPt3wtcKNV6kwTN+JDc7duV1C3GUCR0pXvY8AGqwmHxXs
         iHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761926583; x=1762531383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKLnpauphF64zVNd2V79/vxesQJj7qD0DUlSjcW6MUA=;
        b=OkD4m2F56GMgupYp8+CHEjzDhT+wC31F4SyLrsMaPIODPYnXPZ+4iiqSqrCaxqvZlm
         4Ks/yeAhi1X/UKHSYHLnqraV0UNGjZCCOlCYWSL+pu7oSuyTabp92UXXAjf8yN2kqXAd
         EaCLdNmGGro8ibXIJOlaPlIjnkBopxmGMhM5Q138Hq1tCOaqlDsVcns8kTL+40XRETq2
         Y/9P7v11imU7EXCsXPeBq5CdjT0gSVVIAAmpasFvJNL2VH9F7X8WJJ/1+/yoLYo+RWqj
         KZnodQ6KNmWn75fy07j9GrS41Yb3jMjDmoqH46LEWO6ECJ4y2w7jYo256jvvLsjwxi6S
         7Ilw==
X-Forwarded-Encrypted: i=1; AJvYcCWsdXccjlDuWRAsEfERzJExMXtPVW09QB8XtjHiNVy3ClFiYNeGXc+Z/+II587NEW1zuqTjuxlmc/H0Dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdmxOsTX5Fxz+xY1UlXukJRKICeEix7LQZ/DpzZnapzZjXQkTe
	1s+Q037ip5s9Z6Hk9h/Od598Q0bI39ucUGNQzAEX6saHRna9w6k5ctu+9qU+HHfxgfH/LHBwHN8
	683H9PpPFYx5hDcH3LlCXk7fQhWzBAE99D+p6e4aAuA==
X-Gm-Gg: ASbGncvkXmXH+shBK66r8Xdw2NNgPT391VFv/6RCYmRrYgpAFJptSiLYNdUQm42bw0l
	6GPEzSrOfy0fYYt3Y3MgDQL58erxQ5BaNaWbaMKorN4nlyLi9HxVN4tWFItWwieNJ0AVFa/Zlrn
	V9cTWH90gaJBIyzWmB20jnFUDW6ANkx979pz5xlEZQtDBdGr2crwtqKNqcZCHbxDhbrZVa22q3J
	2uRhWyNWEp/8FzVY0gdvaa4PFn1/bWl4robDEqZb7cJrrjPc1yb1VFtm9TZM8lo2roEyFju9mvU
	OxGrui40Kh+fBRNH9Ws=
X-Google-Smtp-Source: AGHT+IHQNwuWDK2T/eNnooHACy3fG8LlSN+5KqjixEyYxsKgHxuFp/7yzY+VqxnhcGwGexzG2IWKvU/wfslm4s4hXyM=
X-Received: by 2002:a17:902:c40f:b0:294:c54e:88 with SMTP id
 d9443c01a7336-2951a566345mr32508655ad.11.1761926582838; Fri, 31 Oct 2025
 09:03:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031010522.3509499-1-csander@purestorage.com> <aQQwy7l_OCzG430i@fedora>
In-Reply-To: <aQQwy7l_OCzG430i@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 31 Oct 2025 09:02:48 -0700
X-Gm-Features: AWmQ_bllfNr7JNMeEI7t-sb-EdtYcOvAPuSji3rKtHyHN6KPL5msm9P2N6_ycpk
Message-ID: <CADUfDZoPDbKO60nNVFk35X2JvT=8EV7vgROP+y2jgx6P39Woew@mail.gmail.com>
Subject: Re: [PATCH] ublk: use copy_{to,from}_iter() for user copy
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:45=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Thu, Oct 30, 2025 at 07:05:21PM -0600, Caleb Sander Mateos wrote:
> > ublk_copy_user_pages()/ublk_copy_io_pages() currently uses
> > iov_iter_get_pages2() to extract the pages from the iov_iter and
> > memcpy()s between the bvec_iter and the iov_iter's pages one at a time.
> > Switch to using copy_to_iter()/copy_from_iter() instead. This avoids th=
e
> > user page reference count increments and decrements and needing to spli=
t
> > the memcpy() at user page boundaries. It also simplifies the code
> > considerably.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 62 +++++++++-------------------------------
> >  1 file changed, 14 insertions(+), 48 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 0c74a41a6753..852350e639d6 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -912,58 +912,47 @@ static const struct block_device_operations ub_fo=
ps =3D {
> >       .open =3D         ublk_open,
> >       .free_disk =3D    ublk_free_disk,
> >       .report_zones =3D ublk_report_zones,
> >  };
> >
> > -#define UBLK_MAX_PIN_PAGES   32
> > -
> >  struct ublk_io_iter {
> > -     struct page *pages[UBLK_MAX_PIN_PAGES];
> >       struct bio *bio;
> >       struct bvec_iter iter;
> >  };
>
> ->pages[] is actually for pinning user io pages in batch, so killing it m=
ay cause
> perf drop.

As far as I can tell, copy_to_iter()/copy_from_iter() avoids the page
pinning entirely. It calls copy_to_user_iter() for each contiguous
user address range:

size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
{
        if (WARN_ON_ONCE(i->data_source))
                return 0;
        if (user_backed_iter(i))
                might_fault();
        return iterate_and_advance(i, bytes, (void *)addr,
                                   copy_to_user_iter, memcpy_to_iter);
}

Which just checks that the address range doesn't include any kernel
addresses and then memcpy()s directly via the userspace virtual
addresses:

static __always_inline
size_t copy_to_user_iter(void __user *iter_to, size_t progress,
                         size_t len, void *from, void *priv2)
{
        if (should_fail_usercopy())
                return len;
        if (access_ok(iter_to, len)) {
                from +=3D progress;
                instrument_copy_to_user(iter_to, from, len);
                len =3D raw_copy_to_user(iter_to, from, len);
        }
        return len;
}

static __always_inline __must_check unsigned long
raw_copy_to_user(void __user *dst, const void *src, unsigned long size)
{
        return copy_user_generic((__force void *)dst, src, size);
}

static __always_inline __must_check unsigned long
copy_user_generic(void *to, const void *from, unsigned long len)
{
        stac();
        /*
         * If CPU has FSRM feature, use 'rep movs'.
         * Otherwise, use rep_movs_alternative.
         */
        asm volatile(
                "1:\n\t"
                ALTERNATIVE("rep movsb",
                            "call rep_movs_alternative",
ALT_NOT(X86_FEATURE_FSRM))
                "2:\n"
                _ASM_EXTABLE_UA(1b, 2b)
                :"+c" (len), "+D" (to), "+S" (from), ASM_CALL_CONSTRAINT
                : : "memory", "rax");
        clac();
        return len;
}

Am I missing something?

Best,
Caleb
