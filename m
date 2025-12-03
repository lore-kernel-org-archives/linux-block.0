Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2107415A86D
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764736466; cv=none; b=AtEWg2x8WT0ewGmvbpapLkhTXQMRpQoT7D+n11FppqFlK3pTl/23TG80FLvpGJwnFiNP1MYiI5Yqmw4vqOzDe1vB47ZxwPx0UuJgFgKn0+fudcX5x6A/2JJsj24VmGu0tojScqR/tDpFRlm8dGeRXSkmVto5uTuJgezzoh5pxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764736466; c=relaxed/simple;
	bh=J3ud9c+B59CpaGcXxCgeLWI/I7zbSGuZCKk9VSUdFk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Beq241yMwTERjQhH1reyWE4vqYjq1g05umh1SBk1i+yIsIYoOfSevUEgEx5M7y9GI09qXspaPz3XHrRFS07lV+aIX+kTF9X/PqrHQ3f5147+V3DIrESMizSrgC7nEuyrpL7jXzZPDEGXNh8x8rMQ9xKvZXEs6sqEcVjHVM7x9LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ZpX6ZY62; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ZpX6ZY62"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7a9fb70f7a9so544634b3a.1
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 20:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764736464; x=1765341264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxg6NZLOv9ZCG/sjoM6MZuhlX+NYCjdQCAFs3JbKTvw=;
        b=ZpX6ZY62rTnA4qp7sExNCrOPP425el2xtwYFD2N+o+4KsnD3WRibgAd2f/k5npQnJp
         wmM5g3RE24lcP/Hc1swtsctzcUb/Bas3qxmb6ug033VBVi/JEjAShcP/fyN2GUD5A741
         BqKQ98amNGtHeH/wUL5FWdZLW1GUcYd0a4upNAbnH6B8c8SSLFs66mHXQX/hv95n6ekS
         dT5uc0fGkW/zijOxIf9RXia1Hla6Y1F96WB72CWHLTbce86qTpl1CtZQUws7kZ7xAIQt
         AxucJ32nNSpvSnU5UYEDJMWAKBqXElw++Rez27lQo55WIiSHrT1V7B92d2B/tYNCP7HZ
         dcwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764736464; x=1765341264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nxg6NZLOv9ZCG/sjoM6MZuhlX+NYCjdQCAFs3JbKTvw=;
        b=M5fG731oGxYmvhcsuFXWMWTKinxMM2MA6pAAbcn/VD2WuI/91JBbm9jBlYEB9iA8ZS
         BK9o2Z5M/RdocJhI0rC1b+JGuGbXmbFXuCRVnKvdSDyvHjf4lgpf/prkz47P34/zFcrH
         f/n/o3m2P3h5I0H7DoT7VUUYROodIeff3aQA5njPK6WcsjAj9ifkJ5B8lz7Nc3v7mJ24
         kq//VKlCCOdtP4RctKJyjfdGQdjYtNIcqqLeJza6DZcKEft1egByU6x3Aa/0YC08LlzC
         P7e3EGOzXx9TutV7z9J6aecVfDCHR+ISPmE77LxYsiWg5ucHaifp9BNicqTN50nU/OUq
         tB6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyI4dYXtGMhIWC3Sx8Al04sfHaVkI9nPy5AOMgBz72EhtGuczrRQLpfjVk0jbmsfJbFU7ZnPPGiCRZ2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YylBIDcjMPGlqBlV2HO78nr29Y22IpCaXlj+ivPTCyouAJAmRIg
	XGt7Cw0m1v+1UUi2yAXOHFxh8ifNEeV5SvNxR4VZrSdRHnrfFMBzFOcFD6e3Gu1UAcNlkGKZE8d
	dWXOyXhhTMaYf3VJ/9f0GiKeEq/MYwL6XtuQLmJaM8Q==
X-Gm-Gg: ASbGncvnOyYLRp4GjHoLwYfV/jCl3NvOvlRKVg89NZugKmz76QwNmIFRfj7CShjc6rZ
	0fr/bUA2YdtPEfmAoGwGDaijjtxh3Z+tBMeqqI01ulQ72LNRx4ItaUsroCos01GSQd3e5G6gxcD
	6hywUPio9OZrc1JL7cGTTAJ0t9/iW6nrNgdaJChyU5EpoW5tFM2/9x2o8iZntr82atC0LHKlmYw
	8T2eKROVfQoELGIN54yOuTRupaBipA1YGqTywHLaOQ4qRos1QKPPUf6u2bNxzK0p1e0HZ3P
X-Google-Smtp-Source: AGHT+IECnDzApJ5NyNLW8rGHiHxtldS0FYY+rhs6YCEvY55DQGZQH4fAIX45fRAqvDe7ic9LbXXirxdXMRcmPw0X94E=
X-Received: by 2002:a05:7022:f902:10b0:119:e56a:4ffb with SMTP id
 a92af1059eb24-11df2491f44mr64587c88.0.1764736464174; Tue, 02 Dec 2025
 20:34:24 -0800 (PST)
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
 <CANubcdWHor3Jx+5yeY84nx0yFe3JosqVG4wGdVkpMfbQLVAWpQ@mail.gmail.com> <CANubcdWBF5tCfrutAOiUkFaZb=9s4=bMKzi7dSwQxTGbC_3_1Q@mail.gmail.com>
In-Reply-To: <CANubcdWBF5tCfrutAOiUkFaZb=9s4=bMKzi7dSwQxTGbC_3_1Q@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 2 Dec 2025 20:34:11 -0800
X-Gm-Features: AWmQ_bm3LS7Up9zs78OFsHjIPFx_Ldz_doIQ0KD7HcFfO0Yxjj_mgU4AGtQS6xg
Message-ID: <CADUfDZoWjSHRVFnxh=QK7HkQSB5zBZvePjkV-+2Esrf8jtnekg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] block: prevent race condition on bi_status in __bio_chain_endio
To: Stephen Zhang <starzhangzsd@gmail.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>, Christoph Hellwig <hch@lst.de>, Johannes.Thumshirn@wdc.com, 
	ming.lei@redhat.com, hsiangkao@linux.alibaba.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 7:10=E2=80=AFPM Stephen Zhang <starzhangzsd@gmail.co=
m> wrote:
>
> Stephen Zhang <starzhangzsd@gmail.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=883=
=E6=97=A5=E5=91=A8=E4=B8=89 09:51=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=
=9C=883=E6=97=A5=E5=91=A8=E4=B8=89 05:15=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Tue, Dec 2, 2025 at 6:48=E2=80=AFAM Christoph Hellwig <hch@lst.de>=
 wrote:
> > > > On Mon, Dec 01, 2025 at 02:07:07PM +0100, Andreas Gruenbacher wrote=
:
> > > > > On Mon, Dec 1, 2025 at 12:25=E2=80=AFPM Christoph Hellwig <hch@in=
fradead.org> wrote:
> > > > > > On Mon, Dec 01, 2025 at 11:22:32AM +0100, Andreas Gruenbacher w=
rote:
> > > > > > > > -       if (bio->bi_status && !parent->bi_status)
> > > > > > > > -               parent->bi_status =3D bio->bi_status;
> > > > > > > > +       if (bio->bi_status)
> > > > > > > > +               cmpxchg(&parent->bi_status, 0, bio->bi_stat=
us);
> > > > > > >
> > > > > > > Hmm. I don't think cmpxchg() actually is of any value here: f=
or all
> > > > > > > the chained bios, bi_status is initialized to 0, and it is on=
ly set
> > > > > > > again (to a non-0 value) when a failure occurs. When there ar=
e
> > > > > > > multiple failures, we only need to make sure that one of thos=
e
> > > > > > > failures is eventually reported, but for that, a simple assig=
nment is
> > > > > > > enough here.
> > > > > >
> > > > > > A simple assignment doesn't guarantee atomicy.
> > > > >
> > > > > Well, we've already discussed that bi_status is a single byte and=
 so
> > > > > tearing won't be an issue. Otherwise, WRITE_ONCE() would still be
> > > > > enough here.
> > > >
> > > > No.  At least older alpha can tear byte updates as they need a
> > > > read-modify-write cycle.
> > >
> > > I know this used to be a thing in the past, but to see that none of
> > > that is relevant anymore today, have a look at where [*] quotes the
> > > C11 standard:
> > >
> > >         memory location
> > >                 either an object of scalar type, or a maximal sequenc=
e
> > >                 of adjacent bit-fields all having nonzero width
> > >
> > >                 NOTE 1: Two threads of execution can update and acces=
s
> > >                 separate memory locations without interfering with
> > >                 each other.
> > >
> > >                 NOTE 2: A bit-field and an adjacent non-bit-field mem=
ber
> > >                 are in separate memory locations. The same applies
> > >                 to two bit-fields, if one is declared inside a nested
> > >                 structure declaration and the other is not, or if the=
 two
> > >                 are separated by a zero-length bit-field declaration,
> > >                 or if they are separated by a non-bit-field member
> > >                 declaration. It is not safe to concurrently update tw=
o
> > >                 bit-fields in the same structure if all members decla=
red
> > >                 between them are also bit-fields, no matter what the
> > >                 sizes of those intervening bit-fields happen to be.
> > >
> > > [*] Documentation/memory-barriers.txt
> > >
> > > > But even on normal x86 the check and the update would be racy.
> > >
> > > There is no check and update (RMW), though. Quoting what I wrote
> > > earlier in this thread:
> > >
> > > On Mon, Dec 1, 2025 at 11:22=E2=80=AFAM Andreas Gruenbacher <agruenba=
@redhat.com> wrote:
> > > > Hmm. I don't think cmpxchg() actually is of any value here: for all
> > > > the chained bios, bi_status is initialized to 0, and it is only set
> > > > again (to a non-0 value) when a failure occurs. When there are
> > > > multiple failures, we only need to make sure that one of those
> > > > failures is eventually reported, but for that, a simple assignment =
is
> > > > enough here. The cmpxchg() won't guarantee that a specific error va=
lue
> > > > will survive; it all still depends on the timing. The cmpxchg() onl=
y
> > > > makes it look like something special is happening here with respect=
 to
> > > > ordering.
> > >
> > > So with or without the cmpxchg(), if there are multiple errors, we
> > > won't know which bi_status code will survive, but we do know that we
> > > will end up with one of those error codes.
> > >
> >
> > Thank you for sharing your insights=E2=80=94I found the discussion very=
 enlightening.
> >
> > While I agree with Andreas=E2=80=99s perspective, I also very much appr=
eciate
> > the clarity
> > and precision offered by the cmpxchg() approach. That=E2=80=99s why whe=
n Christoph
> > suggested it, I was happy to incorporate it into the code.
> >
> > But a cmpxchg is a little bit redundant here.
> > so we will change it to the simple assignment:
> >
> > -       if (bio->bi_status && !parent->bi_status)
> >                  parent->bi_status =3D bio->bi_status;
> > +       if (bio->bi_status)
> >                  parent->bi_status =3D bio->bi_status;
> >
> > I will integrate this discussion into the commit message, it is very in=
sightful.
> >
>
> Hi,
>
> I=E2=80=99ve been reconsidering the two approaches for the upcoming patch=
 revision.
> Essentially, we=E2=80=99re comparing two methods:
> A:
>         if (bio->bi_status)
>                    parent->bi_status =3D bio->bi_status;
> B:
>         if (bio->bi_status)
>                 cmpxchg(&parent->bi_status, 0, bio->bi_status);
>
> Both appear correct, but B seems a little bit redundant here.
> Upon further reflection, I=E2=80=99ve noticed a subtle difference:
> A unconditionally writes to parent->bi_status when bio->bi_status is non-=
zero,
> regardless of the current value of parent->bi_status.
> B uses cmpxchg to only update parent->bi_status if it is still zero.
>
> Thus, B could avoid unnecessary writes in cases where parent->bi_status h=
as
> already been set to a non-zero value.
>
> Do you think this optimization would be beneficial in practice, or is
> the difference
> negligible?

cmpxchg() is much more expensive than a plain write, as it compiles
into an atomic instruction (or load-linked/store-conditional pair on
architectures that don't provide such an instruction). This requires
the processor to take exclusive access of the cache line for the
duration of the operation (or check whether the cache line has been
invalidated during the operation). On x86, cmpxchg() marks the cache
line as modified regardless of whether the compare succeeds and the
value is updated. So it doesn't actually avoid the cost of a write.
However, the original code's check of parent->bi_status before writing
to it *does* avoid the write if parent->bi_status is already nonzero.
So the optimization you're looking for is already implemented :)
If __bio_chain_endio() can be called concurrently from multiple
threads accessing the same parent bio, it should be using WRITE_ONCE()
(and READ_ONCE(), if applicable) to access parent->bi_status to avoid
the data race. On x86 and ARM these macros produce the same
instruction as a normal write, but they may be required on other
architectures to avoid tearing, as well as to prevent the compiler
from adding or removing memory accesses based on the assumption that
the values aren't being accessed concurrently by other threads.

Best,
Caleb
