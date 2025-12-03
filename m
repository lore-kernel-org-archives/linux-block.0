Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E15B14AD20
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764731415; cv=none; b=sZ4ECR/YiLS2X0+dV7EACSuyPBDbheQF03oLZWmK2AimMt1Umk+hIRwDzm9gRW0q0l2MJN1h3rhy+J+LPpbpjhu/bC+4pgNylU+IlQ7JrgqQSG4DaHt4N/W7ke/pXpZowRv45mKqF387I3otUWFEg4hf2SQCUh+qxTeZOJKbP0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764731415; c=relaxed/simple;
	bh=dZN4WVnkipc85rk8nkTuXzZoX9R6uWz0FXNT3hLqQtU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q+WcxCHVnRueVhzSWYbb036AkfMkqyLOcY5sTq5cl+QhH+dVG9oyK96ndFSNsPp0xs1/7Fo3TQVLw7516ZUwBbtUGsSdOu8g+3BJsdpE95Qz9E7bGpufuPc8aghi5FSERnPQEE6CBQCap3kOSLKcJHzhb3WepkMFhs0wDM7CejA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqb0JAzv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqb0JAzv"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ee328b8e38so57660901cf.0
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 19:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764731413; x=1765336213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Da50DXWuPPV4XcN/IgeMyPMOa+pTGHDkioCpUx5+o3U=;
        b=Hqb0JAzv5Fetm6vvIzH0TVVffeUYQUyX5xcepWaVQB+KA2rG4trC/2lDtbbo1WsUK8
         qnMaX6t4wxS6AyJh0mdZwmeKakyLayvfGbxuqwkI4R9kyrwjjjzaKf6uIo343YcfrFVX
         xw/n0nCs/YxjMZATr33PxdcBRIbj6FjCviKV66z+obESxUZ3YmvJ9uUGNkDS2hfJwc5S
         TDacpLQzPoOUfn3Vya1o1eTwRQn2T1C5RQOnVTSNmrT1EPTONhQzhNwST9EgD1fuczG/
         pssLhfVfJ0fDeMLDpO4tLJE95UwdNPw2RXXwXkreMtvPLv2B1e9R5l0t6REHwj01y1pt
         wazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764731413; x=1765336213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Da50DXWuPPV4XcN/IgeMyPMOa+pTGHDkioCpUx5+o3U=;
        b=tCpqC/PNdrJDFNQkM7h0MGVQwdYwWJmfcfbtKp3gQ0/svQQhj5gwg/aT+lTsFTMHEA
         5crrhXaUQIvTWstBXujfN6/N8yTv4yS3g0dEdtQok6yC+lXjQ+Edhpq8tiU0XimBT4CN
         wTm6QlaQl2KcQjNVH6g/SEU98AUFmTbFaXlRHYzrErDh2jSURA4DGbv0dZ9McGDyCm5E
         n7sH7mNHBts9VPgUqNIdbiE4bjp+Q9IpagT1P6tcGgRyKnTEKYUYe4Yl4b9vUSe6Afn6
         lm0tcT4/5w74C7cjvnaQDNh5zMAP2nAgUwUeLm0oa7xc0mgam8n/2Pr559zdv3guNQoa
         lJhA==
X-Forwarded-Encrypted: i=1; AJvYcCVRg7kLKVU4/KUUtfdySWIJgN8dVJmbjWSzP4Wq99WSjtTo06IbagjHxvQkSGL49gNcoJ4/lrUXaWCXUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OmT6r40PWnx3kwxEDj8tIzHxxTCkuzanojDkcr1g3IigyJtt
	t7z7PD91CKw3/fL4PTuEkrTLgnBkDeEDCGIbXNmrSgupBJCdoU2vVINNxcTn1j0ZNxWsUeZQUzj
	E3wz3LVTG0sonYtgCEat7S4IENR/9SkE=
X-Gm-Gg: ASbGncs4unP19sFjDaEED+dZwTjhf4lCRMnWS5CT3uskbXY8SCYbOWl5UEnj9spcvsH
	RXC1zeN3uPsTjfvOEpOtO7oikSJUGdddZQ4Hxe2t3NDr4wU668G2ftlwqrk3jjGEC1ZtPx4vuha
	UxgXdk08U8ugy118o63wkbhgYpB+KV55xqFo/J0df8pjcS1CzGZvHwHU3+Y36RuTT+i67Jij7dG
	jE3yJXbSFVicC56qTvGsBB3lotVthFBpW+icgEBRQEbeFveIyWmdL3Rg5U1lvZANaSP2xEMxyYr
	QAhMIQ==
X-Google-Smtp-Source: AGHT+IFKj9nQ1yW2Qdi7amywixjfuhwbrJxLsfaLBhk60aClgLDyRt7rXIoN0mQ/5gg9IEpDjYYZGqQMKhBVvtX6Jyw=
X-Received: by 2002:a05:622a:15c7:b0:4f0:1543:6762 with SMTP id
 d75a77b69052e-4f0174fe734mr15479451cf.2.1764731412842; Tue, 02 Dec 2025
 19:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201090442.2707362-1-zhangshida@kylinos.cn>
 <20251201090442.2707362-4-zhangshida@kylinos.cn> <CAHc6FU4o8Wv+6TQti4NZJRUQpGF9RWqiN9fO6j55p4xgysM_3g@mail.gmail.com>
 <aS17LOwklgbzNhJY@infradead.org> <CAHc6FU7k7vH5bJaM6Hk6rej77t4xijBESDeThdDe1yCOqogjtA@mail.gmail.com>
 <20251202054841.GC15524@lst.de> <CAHc6FU6B6ip8e-+VXaAiPN+oqJTW2Tuoh0Vv-E96Baf2SSbt7w@mail.gmail.com>
 <CANubcdWHor3Jx+5yeY84nx0yFe3JosqVG4wGdVkpMfbQLVAWpQ@mail.gmail.com>
In-Reply-To: <CANubcdWHor3Jx+5yeY84nx0yFe3JosqVG4wGdVkpMfbQLVAWpQ@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Wed, 3 Dec 2025 11:09:36 +0800
X-Gm-Features: AWmQ_bn7qJQi1QOaQkYkEYIXtU-m8JUkCUbhC8-ZBvDQ79P6S19scEkkxp42Vgw
Message-ID: <CANubcdWBF5tCfrutAOiUkFaZb=9s4=bMKzi7dSwQxTGbC_3_1Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] block: prevent race condition on bi_status in __bio_chain_endio
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Johannes.Thumshirn@wdc.com, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Stephen Zhang <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=B8=89 09:51=E5=86=99=E9=81=93=EF=BC=9A
>
> Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=
=883=E6=97=A5=E5=91=A8=E4=B8=89 05:15=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Dec 2, 2025 at 6:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> w=
rote:
> > > On Mon, Dec 01, 2025 at 02:07:07PM +0100, Andreas Gruenbacher wrote:
> > > > On Mon, Dec 1, 2025 at 12:25=E2=80=AFPM Christoph Hellwig <hch@infr=
adead.org> wrote:
> > > > > On Mon, Dec 01, 2025 at 11:22:32AM +0100, Andreas Gruenbacher wro=
te:
> > > > > > > -       if (bio->bi_status && !parent->bi_status)
> > > > > > > -               parent->bi_status =3D bio->bi_status;
> > > > > > > +       if (bio->bi_status)
> > > > > > > +               cmpxchg(&parent->bi_status, 0, bio->bi_status=
);
> > > > > >
> > > > > > Hmm. I don't think cmpxchg() actually is of any value here: for=
 all
> > > > > > the chained bios, bi_status is initialized to 0, and it is only=
 set
> > > > > > again (to a non-0 value) when a failure occurs. When there are
> > > > > > multiple failures, we only need to make sure that one of those
> > > > > > failures is eventually reported, but for that, a simple assignm=
ent is
> > > > > > enough here.
> > > > >
> > > > > A simple assignment doesn't guarantee atomicy.
> > > >
> > > > Well, we've already discussed that bi_status is a single byte and s=
o
> > > > tearing won't be an issue. Otherwise, WRITE_ONCE() would still be
> > > > enough here.
> > >
> > > No.  At least older alpha can tear byte updates as they need a
> > > read-modify-write cycle.
> >
> > I know this used to be a thing in the past, but to see that none of
> > that is relevant anymore today, have a look at where [*] quotes the
> > C11 standard:
> >
> >         memory location
> >                 either an object of scalar type, or a maximal sequence
> >                 of adjacent bit-fields all having nonzero width
> >
> >                 NOTE 1: Two threads of execution can update and access
> >                 separate memory locations without interfering with
> >                 each other.
> >
> >                 NOTE 2: A bit-field and an adjacent non-bit-field membe=
r
> >                 are in separate memory locations. The same applies
> >                 to two bit-fields, if one is declared inside a nested
> >                 structure declaration and the other is not, or if the t=
wo
> >                 are separated by a zero-length bit-field declaration,
> >                 or if they are separated by a non-bit-field member
> >                 declaration. It is not safe to concurrently update two
> >                 bit-fields in the same structure if all members declare=
d
> >                 between them are also bit-fields, no matter what the
> >                 sizes of those intervening bit-fields happen to be.
> >
> > [*] Documentation/memory-barriers.txt
> >
> > > But even on normal x86 the check and the update would be racy.
> >
> > There is no check and update (RMW), though. Quoting what I wrote
> > earlier in this thread:
> >
> > On Mon, Dec 1, 2025 at 11:22=E2=80=AFAM Andreas Gruenbacher <agruenba@r=
edhat.com> wrote:
> > > Hmm. I don't think cmpxchg() actually is of any value here: for all
> > > the chained bios, bi_status is initialized to 0, and it is only set
> > > again (to a non-0 value) when a failure occurs. When there are
> > > multiple failures, we only need to make sure that one of those
> > > failures is eventually reported, but for that, a simple assignment is
> > > enough here. The cmpxchg() won't guarantee that a specific error valu=
e
> > > will survive; it all still depends on the timing. The cmpxchg() only
> > > makes it look like something special is happening here with respect t=
o
> > > ordering.
> >
> > So with or without the cmpxchg(), if there are multiple errors, we
> > won't know which bi_status code will survive, but we do know that we
> > will end up with one of those error codes.
> >
>
> Thank you for sharing your insights=E2=80=94I found the discussion very e=
nlightening.
>
> While I agree with Andreas=E2=80=99s perspective, I also very much apprec=
iate
> the clarity
> and precision offered by the cmpxchg() approach. That=E2=80=99s why when =
Christoph
> suggested it, I was happy to incorporate it into the code.
>
> But a cmpxchg is a little bit redundant here.
> so we will change it to the simple assignment:
>
> -       if (bio->bi_status && !parent->bi_status)
>                  parent->bi_status =3D bio->bi_status;
> +       if (bio->bi_status)
>                  parent->bi_status =3D bio->bi_status;
>
> I will integrate this discussion into the commit message, it is very insi=
ghtful.
>

Hi,

I=E2=80=99ve been reconsidering the two approaches for the upcoming patch r=
evision.
Essentially, we=E2=80=99re comparing two methods:
A:
        if (bio->bi_status)
                   parent->bi_status =3D bio->bi_status;
B:
        if (bio->bi_status)
                cmpxchg(&parent->bi_status, 0, bio->bi_status);

Both appear correct, but B seems a little bit redundant here.
Upon further reflection, I=E2=80=99ve noticed a subtle difference:
A unconditionally writes to parent->bi_status when bio->bi_status is non-ze=
ro,
regardless of the current value of parent->bi_status.
B uses cmpxchg to only update parent->bi_status if it is still zero.

Thus, B could avoid unnecessary writes in cases where parent->bi_status has
already been set to a non-zero value.

Do you think this optimization would be beneficial in practice, or is
the difference
negligible?

Thanks,
Shida

> Thanks,
> Shida
>
> > Andreas
> >
