Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F75F319857
	for <linux-block@vger.kernel.org>; Mon,  8 Dec 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765184599; cv=none; b=PHyvJXvRXdjlxbSc+SSByC5tqJQ0FkY8hR/8dAXTHQzoWzD47JratQ89LhVj+uXKib3LNvb7ibxWW1OQM5UbEcF4rUERsp/BVoj7O3tIGPXgKu7wb59/wEqd8kZ9g57sNwwjTyHVDP4LGfliVvA0dd9FH5nB7H7nPc8YBhOwDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765184599; c=relaxed/simple;
	bh=xmR28IaaF9nKj4dqQJUQXvae3UpVRNnFUf/OMWTEm0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKmN+ItU0QKh8gm3f44e1wcFvp3afBpULJe2YC9FNh93H4LC/wXY5NBVOxEpERT+8DKM7CJdINzaqB21cao2iGL6QWFpHr1RxyH1nxEFufYUmi319iDNXGvfW8dLLY69LRD+YYjxrg8hdz/DfL7K3SUR1BGfk1ZXpjFwAWj8Kqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SL4qP5uC; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SL4qP5uC"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4edb7c8232aso55961851cf.3
        for <linux-block@vger.kernel.org>; Mon, 08 Dec 2025 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765184595; x=1765789395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFNPtodxXWt5Thf93tD054e493TCPaIRwICEb5+aRZ4=;
        b=SL4qP5uCCpmULw5Eu9O4BD6HWoTa99JO7h/8si2gsyGa/VIha5u+FePjtE8c8hpkmV
         6V4hls5yJFtsnejuDesheZh10gzcYZWCb5FrJteDzxMR2kcwKMseqKw9zQcTiJ1e4ZZi
         7u+K0UVVYElhiFkAtKnS2t848TYyXKsRJ1Md47nwdnxSSeUbDFapgK8s0POotpVHv9Wc
         eJzXAXNrH5uCxfQ9HqUyAzY/XMXw3TkOZOyHjMbsYUmoLYbIXJMCRmhsBojTFKw0pGvs
         zOOyD9WFW78hhtlelbrxbhaX7r3IW64i6mpPAot5pkJrohEKvvO79ia3ark8XzRj6gVN
         bHLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765184595; x=1765789395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sFNPtodxXWt5Thf93tD054e493TCPaIRwICEb5+aRZ4=;
        b=mu4sG2eceBn0fRfK3sCtTRc6qNStU2iPAVtj9gHRT53F+dIsFzdj4TG5TvVYs25Hxr
         ugAf3R1EkOQuC8FwTHffCT+vKiDDqqmU7BBPyvQZrQHWH6E79LfRzRwyYxCrjazFf59n
         8nRSO2++rc0ljL5fzcIwO5HcHY3BGA3tPMxLt7NN6gfrqRhCGj7CZCPuCRqf4gMpP6Kc
         7v9T0h0h7FdFEGVfutwr6wbkEQzGQAzG8itfNU3aDiiFraF2ZpGXPilBlRGx5MzRY13N
         dWPKWHgWo8SnUCQqFRWsP9gcpnG3rrTBnX5pGLnbauJR/aRn2jTZLu8Nuke55LDFTVf5
         A93A==
X-Forwarded-Encrypted: i=1; AJvYcCU6HWaJRmfF3Pruz82c4o61A/xphTxl/2oflp4tsKf+fQUEEVN78DIHEJYUtQYIgt00NZZvQzT2PZsN/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIx5r7J87poOp/j+EjIgbUiR9f9Qmr2B3EUaPfPKkA9a39TwHQ
	HV/RYjDIA81Fc+TnxYBMSB/mDFsoltJ4VBLy7JmU/B2hRM//8uOAS3oU4V/aqD14TzANhsIdHUO
	W8rLkxj6s+AAF22gaNM5Py8RUHIBlOAc=
X-Gm-Gg: ASbGncsTStOUdDLwY8E8mTj5xmkE+CkFf4BcQy4xJnOomDzi2D4KV1mw7+WvZPNwwsz
	UJcf0Pv+Klv73t4HZGC6Bhqq34PKdOe9GTWFI8eWDY5915B6aq5WyM978Swai9OI78vNCP8PF/d
	jDclPC5x5ffJamJ1Zt30URzGUykKEZfCagcuoi7vOvOCO9EgAxZaMLcspBZMJiXE5rjdbWd9am6
	3livliVJqQeNEFrop+hTgBLCGwmO5RCEp+KheQsZ3eaXLHnLuFqgZ/SqDkuJOnh06I41Nk=
X-Google-Smtp-Source: AGHT+IGIkzL28sT6p6sHHt80WO2WaduAwsABGOknJWn3+PKdTWs//JTVokCkbxDwbiaJN5b1fBdoaRLK+6PY3xW0EGs=
X-Received: by 2002:ac8:5a4c:0:b0:4ed:af59:9df0 with SMTP id
 d75a77b69052e-4f03fef2e6fmr113096381cf.40.1765184594906; Mon, 08 Dec 2025
 01:03:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207122126.3518192-1-zhangshida@kylinos.cn>
 <20251207122126.3518192-4-zhangshida@kylinos.cn> <CAHc6FU5urJotiNOJEC4hyJz8HsNechZm9W07e_-DhgkYJmuDmA@mail.gmail.com>
In-Reply-To: <CAHc6FU5urJotiNOJEC4hyJz8HsNechZm9W07e_-DhgkYJmuDmA@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Mon, 8 Dec 2025 17:02:38 +0800
X-Gm-Features: AQt7F2qzVM3qX0lIGsVmmMGQ2bZcm4pD2OyMECaPkDdNJjgAQX0YAAlAmy5mJrg
Message-ID: <CANubcdXUvVdMeMK_dJ0eE+A3Un_UzQ6PfjW8m6pGofmFnt+69g@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] block: prevent race condition on bi_status in __bio_chain_endio
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn, 
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
7=E6=97=A5=E5=91=A8=E6=97=A5 21:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Dec 7, 2025 at 1:22=E2=80=AFPM zhangshida <starzhangzsd@gmail.com=
> wrote:
> > From: Shida Zhang <zhangshida@kylinos.cn>
> >
> > Andreas point out that multiple completions can race setting
> > bi_status.
> >
> > If __bio_chain_endio() is called concurrently from multiple threads
> > accessing the same parent bio, it should use WRITE_ONCE()/READ_ONCE()
> > to access parent->bi_status and avoid data races.
> >
> > On x86 and ARM, these macros compile to the same instruction as a
> > normal write, but they may be required on other architectures to
> > prevent tearing, and to ensure the compiler does not add or remove
> > memory accesses under the assumption that the values are not accessed
> > concurrently.
> >
> > Adopting a cmpxchg approach, as used in other code paths, resolves all
> > these issues, as suggested by Christoph.
> >
> > Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
> > ---
> >  block/bio.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/block/bio.c b/block/bio.c
> > index d236ca35271..8b4b6b4e210 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -314,8 +314,9 @@ static struct bio *__bio_chain_endio(struct bio *bi=
o)
> >  {
> >         struct bio *parent =3D bio->bi_private;
> >
> > -       if (bio->bi_status && !parent->bi_status)
> > -               parent->bi_status =3D bio->bi_status;
> > +       if (bio->bi_status)
> > +               cmpxchg(&parent->bi_status, 0, bio->bi_status);
> > +
> >         bio_put(bio);
> >         return parent;
> >  }
> > --
> > 2.34.1
> >
>
> I thought you were going to drop this??
>

Okay, I will drop it.

Thanks,
Shida

> Andreas
>
