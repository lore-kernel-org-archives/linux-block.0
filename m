Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6B40855
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 01:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764811119; cv=none; b=LaP9NmHUywdGNNztMYZoTzGqCAlrvqCa2s9hdzMUAtyChMgfA3zISpmYNm3JG0TdczOou1EEYbM2h2NIg2fCEhF37zZLMedqYmsmP5VceIFNzEe4e0ao1HBzDYGNVhwmVkuvX1OEzLFxmk2+L3kUaEHysOOYHySRdZt+7iORHdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764811119; c=relaxed/simple;
	bh=wC9lqEIoN8sq5g8JhY/4krcB2BXJ+ZczTeStEg6GGck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ha6tN/OYigIdmzBD17A5rk00o483++WjpnApBDFNuYOOW0ZTDA/2XadTot9+n4XT/CF5/+xMSY5xvGhjZXg4ZQ0AFntRzCQHTG+Be0oaq7J8vYHkXhfkpnG1Drlx9tq3pe/dLJuHbvMHm8K+3DAOZJJYk7E6yum6bOVeHuOdL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg10WYTv; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg10WYTv"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88056cab4eeso2601106d6.2
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 17:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764811115; x=1765415915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laiLiH0/HusFXriU7bmpWTj4dFA6FGxaKSRdrze3lyk=;
        b=jg10WYTv/Gxt0kev0zd5DS0NUc1IGgJUBqIMeveG88ohVK8YRsB7cwi3Ip623lNGP/
         Y5b+d/ve92R9ABd5u0WHl6VCMHsUMYft2twvvH0JIoHXS5DOFsJ23SEEMsG6QTVpQq4R
         rH3cZkX7eVvmXkn/RxqWSOs/9x1g0gFYDx7YqtgVAroEhWZ0lJPP1cHP+YhMOBQSSKV0
         xwLN0+z9NtfR3qB44+LU9dbShdAM9KEygAbRxiCpLeX7Dth/dg9urZ3ZI5VcESsRvPf8
         tJss4UKUGJvjFzQc2EwcWITabdxcaZOkVL9hGuZFXQ14x1sQ5D3+AFgpGQQqY72HgYYO
         Gfcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764811115; x=1765415915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laiLiH0/HusFXriU7bmpWTj4dFA6FGxaKSRdrze3lyk=;
        b=bdGFsDPuRAtuK13MG+gqV8rtsK2L9FNOBKs/sE3UooOqYuri2SXiQZCUl2OlxjKLBC
         lM+QSx/R3H2z7hEKt40c5GRN8Hwovk/21Iz4GV1ZZDKhMoZnMvc4pKWJ7J5u6lOEw2vK
         TIvgj8Vk0BcIDr1Hr5KfDQQpGS8E0jzCPdXSo8oH5pg0eH9IcgjGm+mFNdt3uJ2ygvJx
         hp/sOzZa3pMC2wtRxvdUvPge6amc0cPsDVqUDd8loHrebygz2B0XcfMVakpWB8KoHQNF
         mcIglPsbp7okEJqamtf7M9wAcY8k2PM6ggI8hsD6sCftjn+r+Uu010Gl007s2YB/9wUO
         1zxw==
X-Forwarded-Encrypted: i=1; AJvYcCUDltsS1x/PAyMck2C4FsOkZW1QZHpoiW7erhYVpIP9g8zRZaym8YTgu0E3TGS8TzdFfViH4V8iAvURFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywTSZ/6gkS/Q4osoKzef1vHPxJZ+Ou3ibi1HorqJDSUC/7A5WO
	pvXuN+Ym99wDpyBP4dID4zzoayCFGKYCa0/XH4LiHoQO96ezy93zqVZCT1YQb5C7tFYnt1zW7jI
	ZzM8B22hrnzzKQJd7UjmFTC3hO6CBenY=
X-Gm-Gg: ASbGnct62aoCvLNm3fh9ak6zbnHzZ8rGiKzJMyeCXN8loxTpT3ZYDjsW0RQWHJoF0P4
	mFI7F+yqO7V33/VNLrs60M1/dVlpV5B/kZT+OquKS/6M1HYAp/oj5UsLg0JBVTZCsCungXbblVd
	pgYCKGxGOeXQNlMrYuE9HqYFbL4V/BTQLddwXa1MqbCKuv3HoaB6RmnQOG5p6plsSu6NsUHJ95J
	BIIp+jlOkbDuygEQ+/vgGiYwuDeYwCUQGc1P+9d64SubovtzaTjzYn2HDeFVXemA9g+vcm3B2+u
	Q2xmAg==
X-Google-Smtp-Source: AGHT+IE21KasvmyCNqhdEgk2h7QhOUH0VPEKE5ffxcK3aRkFD34vSJuFO2kCq2OVEl95+NlsaexaOS6OAQX65H8UXlY=
X-Received: by 2002:ac8:5a46:0:b0:4ed:a9c0:1e30 with SMTP id
 d75a77b69052e-4f023a12961mr18362611cf.25.1764811115311; Wed, 03 Dec 2025
 17:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201090442.2707362-1-zhangshida@kylinos.cn>
 <20251201090442.2707362-3-zhangshida@kylinos.cn> <CAHc6FU53qroW6nj_ToKrSJoMZG4xrucq=jMJhc2qMr22UAWMCw@mail.gmail.com>
In-Reply-To: <CAHc6FU53qroW6nj_ToKrSJoMZG4xrucq=jMJhc2qMr22UAWMCw@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Thu, 4 Dec 2025 09:17:58 +0800
X-Gm-Features: AWmQ_bniayhQIzEfyEULK5EZFSw6I1TPfQlUIuPrClXqSdR1WYg5VtjGIi4Mihg
Message-ID: <CANubcdVXUS_i79=1Zx5R7cGC7JwHrUXRCZoQ0kes7gdZUTW0Dg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] block: prohibit calls to bio_chain_endio
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
1=E6=97=A5=E5=91=A8=E4=B8=80 17:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 1, 2025 at 10:05=E2=80=AFAM zhangshida <starzhangzsd@gmail.co=
m> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Now that all potential callers of bio_chain_endio have been
> > eliminated, completely prohibit any future calls to this function.
> >
> > Suggested-by: Ming Lei <ming.lei@redhat.com>
> > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index b3a79285c27..1b5e4577f4c 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -320,9 +320,13 @@ static struct bio *__bio_chain_endio(struct bio *b=
io)
> >         return parent;
> >  }
> >
> > +/**
> > + * This function should only be used as a flag and must never be calle=
d.
> > + * If execution reaches here, it indicates a serious programming error=
.
> > + */
> >  static void bio_chain_endio(struct bio *bio)
> >  {
> > -       bio_endio(__bio_chain_endio(bio));
> > +       BUG_ON(1);
>
> Just 'BUG()'.
>

Yeah, that=E2=80=99s much clearer now. I'll resend the updated version.

Thanks,
Shida

> >  }
> >
> >  /**
>
> > --
> > 2.34.1
> >
>
> Andreas
>
