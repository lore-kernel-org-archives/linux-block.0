Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DCC1F37A1
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 07:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763794970; cv=none; b=iqUB7vTjH28n+n/VtVir0mub6Iph7nc/CDA0Na9qDZw9OzKCg+u5mpKzfLON3trCJDXMZ6rGzfhjgli8OtPJw2H0KHDQ5Sf9oCSuSkBDQq9k6498G7lGPRe/ThEVNrXv8N5pnJ8SxopH6DSOnz1aCNvdsjgiTGLYU40eIgMA/vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763794970; c=relaxed/simple;
	bh=3qML6mAdP3XOHu6CRgEfvtbrG4LVKi3a96yUcu5LMO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCLX62FbjC0yoV7M74PZ4xsKvWfACnoVfWtWCsrSMvwUqilKuN8PgvcsA1Zb1SwTceZYlKOMWKbWK/+fm8mj0SZ/k1e5y/K/4yhbOo/0RGXvXGEM/dzrKoO/KhrcFmSvqW5yxQyvO1wk2gVH+3TRc6Cp+OvOaAGFkSw19y1HPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAOMxhh9; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAOMxhh9"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b1b8264c86so268539885a.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 23:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763794967; x=1764399767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLckKOB/6XWKdTlMPCvOWJYhseDg7RVjB2FyFDWqsDI=;
        b=JAOMxhh9kJLyZv1WOtnIB96WIL5gbExrB4vzocj1PttnoksXSzoylwX4IhmFHcnhNf
         RtqQHEFItnsnUykv3q4F10GMDNn4KTgVtYDnviZJeMiTIzUpy6xynA+NVW5e7v4GrL6e
         S0I5QHYsSe6q1JpNx6yOWLQIcrZUghawz+DuZiiRLolpnsqiwaZ5E82+lDth/Dtn83Xx
         JdC0MtWe746J+twJjE7he+1jZusWcVSarZ5FDtDAkjF9p9UhdJq3q7iYsvMZW3ejHsYs
         uZHgEquDp6RyXARv75BlcVkgzSJOlkQvpRhvvUfL6E2/3lauVrBZOBNtW9cv5Qq3GR33
         AtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763794967; x=1764399767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLckKOB/6XWKdTlMPCvOWJYhseDg7RVjB2FyFDWqsDI=;
        b=p3QF6Pyat7dpDtf3c/mCZcSk9+bt4hIoOZKf47mE6XwV4MkEMTvlNpHFiuQKdQ8pqT
         gqUiM/icuYTVw4iPzgSh89dwplJq87zvdvIgvtWLNZRdr/VQ2fh3qMM5LkJaYDWKMYu1
         fdRRmUt5pGtclyTQVnZS0RzOMd6SZ5pCvzGjgAewuLQ0is7g+0d9uymkKrUD9btv4SpK
         UpMSsXVLVfVsNkQ98X2NILZlDFGYZjnxJjEsb3bOY6XnoG1Xhv4WTa7e3FUnytKLErQm
         z77VvBhLyjlj1Fq06GMDu7qNW+Xn/LIyQMNjneU609JyYznMMJHzNE+ejOZR1XSPaJSz
         B7QA==
X-Forwarded-Encrypted: i=1; AJvYcCV91v/70HIDGnLNb0oLzPVFDcpV/2jub9DD/fYVk0oXxJ/z96s2IP74opWa9YR/OqJTLJgwjYTcEw2ZKw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz10VAtTo9rTIx2t2ep9tBPu1qKCnbgrG74UzcyjIHjlNXFR5Hc
	mfkSjzYx6nRZ/ynh3OfjGyg6F3+t7xwgNBHhbRKHYqv/H1P/tIfwlYCXBg8Vu59dKVHD/+GjDzF
	GQxo7x+8jnL/9LgbTK+coZehdCm4HcIU=
X-Gm-Gg: ASbGncsdh4+B3oaE/fMbr4Ufn1mS7AtBPm6GcyXxkJp3EvsZm3iTN12/hjZazqgpwe7
	7i8GgE9pLuI4aNGRGkrMb+gjikPQCAjUkjWiKWseVsW2WX9MHLSVt/qLNxpHqmVPjCOwcMjtef8
	8T5m5taspO6N02PX/EAqazIRQS/xkuYTWr8gINalnN3NGGeO2f5znCHkDeh6TXhQe2YK0RT3uS9
	ETVf4UA/k2TxQ9rp1If6h0UurV+S0L8hox/HIKp+nI67UH7gTaZDrZ/dYctfgJJk9eArBI=
X-Google-Smtp-Source: AGHT+IEjcPOv6aPW6JO4Bb1jDowgVciSWSsWd+FNjyx3VBhgbx3Pj6ddYbo0M3Mtuw+ANHFx2AKfX0TCp1WB72JEhOk=
X-Received: by 2002:a05:620a:7106:b0:8b2:e5da:d316 with SMTP id
 af79cd13be357-8b33d48b7d4mr603659585a.87.1763794967475; Fri, 21 Nov 2025
 23:02:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
 <20251121081748.1443507-3-zhangshida@kylinos.cn> <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
In-Reply-To: <CAHc6FU7eL6Xuoc5dYjm9pYLr=akDH6ETow_yNPR0JpLGcz8QWw@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Sat, 22 Nov 2025 15:02:11 +0800
X-Gm-Features: AWmQ_bnR6g2ivQ9YSC5w0bIwME61y28InS6FucoZ4PBrcXjaLHV0KwJ_bufirnM
Message-ID: <CANubcdXx8Lp1JsqG3ctAE2V6jpuvJL93UH+7yHaAFtdMjHdijw@mail.gmail.com>
Subject: Re: [PATCH 2/9] block: export bio_chain_and_submit
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev, 
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-xfs@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=88=
22=E6=97=A5=E5=91=A8=E5=85=AD 01:12=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Nov 21, 2025 at 9:27=E2=80=AFAM zhangshida <starzhangzsd@gmail.co=
m> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index 55c2c1a0020..a6912aa8d69 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, =
struct bio *new)
> >         }
> >         return new;
> >  }
> > +EXPORT_SYMBOL_GPL(bio_chain_and_submit);
> >
> >  struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
> >                 unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> > --
> > 2.34.1
>
> Can this and the following patches please go in a separate patch
> queue? It's got nothing to do with the bug.
>

Should we necessarily separate it that way?
Currently, I am including all cleanups with the fix because it provides a r=
eason
to CC all related communities. That way, developers who are monitoring them
can help identify similar problems if someone asksfor help in the
future, provided
that is the correct analysis and fix.

Thanks,
Shida

> Thanks,
> Andreas
>
