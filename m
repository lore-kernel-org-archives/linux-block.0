Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61481BC2A
	for <linux-block@vger.kernel.org>; Wed,  3 Dec 2025 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764726705; cv=none; b=UkkLpBMbNWoZRgnUNqws183FLdj6IKh4JcQFLdC8QvE/+TS7LEjsYbc7YDGaaKQKWAAaxO1audF5srIQXT+WJw+I0MlUeyGHIpU9q5V6jqAfJ+ebVdJD1s6jOAYPz0TWmO7ORCz0xr4JWe+2n55sbNBHX8Zz8WdpdBhccJIIQK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764726705; c=relaxed/simple;
	bh=9dM7t/x9Pd+ZbM9rUoMJiiZhZigihD98RMT1wtBkj2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSySkR5Ls+bD4MPV1JvtnEOL1PciWqCZZWf3+/D+WOArp4Mcy8RSW7DxCdS4fx27j7S8s/rvr/F6E/m9A5rqaLfNw9eqCGS+/kvHu7DK4N5NI39Kmanl/EQE+DlDMvH17+pTqTR2LUOruYyk9UBjvOcUp24Mwb4CRDyWVK/xmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBIlYA6l; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBIlYA6l"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed82e82f0fso48737781cf.1
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 17:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764726702; x=1765331502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29HfRhtowelPyFq0bm7t4v7lXxLMZQ3G+lwt5TZkuog=;
        b=IBIlYA6lg78c1qPhUH6r/N7sB3CaIC3qyvfIGJR1udvgTFDTBtfaCnw80TVplJPQCp
         lUFmX4yn6ZAMgdblZIelDmm8WNBH0YvkbA2MFQTAt5EiFc977l3/gm/kh154MxI/wJbX
         0ZRBbw8HuWo1o8y4D/eeU4yvXEnqxG+T0tziI1SOkaVhai4xhEH32Woq/3fPnvYSU6R4
         sAnT/PySdjYCHUEMy8FPudyYVma4xR3SVqfqJbNS9E69JzleiI4T2iOVErkAbahf6H7n
         L8NeJE8l3epIFWKlORm9soh+KfE+9+cOmRLWkKcfqqJzgC7UiJNmsG6oJ2UO1++ldxgB
         CNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764726702; x=1765331502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=29HfRhtowelPyFq0bm7t4v7lXxLMZQ3G+lwt5TZkuog=;
        b=sAnbmPkgT18dp+a9Xez1B2wyia/ILBnnjg4QNkH8Ap8XyM2H1G/GDV9NkJVeirG+Zd
         B/Q/ufHHuNR0849EKJvwCqbQW8rGhss+z1rrb7gPY6FV80kM/Az1mB5Jd4WQSIbrLWcp
         0x+8i1RJgFBISFqCLHrrSYrumMwhbhFW/taHCD/rjgIy3H7vzJQKyNTLpXOODlYcWIiM
         TKefG1b4kbz/UKF4juYyVyUOO1JH9JTsCPxEkTmnDou48UNYQEC7gUytqQqPxM5sgw7R
         AVGK8OujPE1UJU/iz94HXaNbKjIb9sDVujuVgNBytiAb5pSDnYyocBXALvMWhCAHCZ8f
         LYFw==
X-Forwarded-Encrypted: i=1; AJvYcCUtX5iSfVSQtcQ18MobwGvY3gDf89ziE4itLLMgY+AXHEnKSy69vwiPTuF+5xnPKhhZoIrd77QbqVxXqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3bE0AYiMVZKF/PSM5Y/AnCzjjB0IF0k57b0GIN1CVQwLnpdG8
	HHxX7hS9KUObZWO+j0Rx56CMz9yzwpUyvEEgSjL9oz6NzsBws13nHcA6AjvjNWXOMYt9vbYlzJ4
	eWBh0aA+duKIxYHhtvhEcXNlknPmewgk=
X-Gm-Gg: ASbGncsujQ204oQVW5hkqHbWziqKGkaqhjiEdKSPMIsYAjKzGo7F9/1E4XUr3ACx4C0
	SCFYB87l2jqaqLn78o2UdxnktWQM7Y/VB4ARGUMJf+s9tzX82aSSDc8bi76TQvaEcTMdMW6zhyv
	rCoytpvYmWCa+wHU0QQLQCKts7cN/m2rQd2XfyB8jMpUnJB7pDmpsb17T7BifV/68WOo1muj9au
	SmziBWJNe3RlTQ8kBPHg+67DBAaAcj6bX19cb/mwzTuPOekks4TXFZ5IQLvJs5WAPg/UXA=
X-Google-Smtp-Source: AGHT+IG7vBpednoopH1DKxZOoSo8zpv84EdVF+k41o0sX1zR/8W3FEVNG8uFv3gmerv3xFbLF+STWsZgh/6ESAaBVno=
X-Received: by 2002:a05:622a:30d:b0:4eb:a0aa:28e with SMTP id
 d75a77b69052e-4f0176566f0mr9901431cf.64.1764726702214; Tue, 02 Dec 2025
 17:51:42 -0800 (PST)
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
In-Reply-To: <CAHc6FU6B6ip8e-+VXaAiPN+oqJTW2Tuoh0Vv-E96Baf2SSbt7w@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Wed, 3 Dec 2025 09:51:06 +0800
X-Gm-Features: AWmQ_bk3Wx_6JA9rlYJqME-wTYEbXZg-BK2IuYtOy-m-WqmSKhAL-wpGdfR7pkk
Message-ID: <CANubcdWHor3Jx+5yeY84nx0yFe3JosqVG4wGdVkpMfbQLVAWpQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] block: prevent race condition on bi_status in __bio_chain_endio
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Johannes.Thumshirn@wdc.com, ming.lei@redhat.com, 
	hsiangkao@linux.alibaba.com, csander@purestorage.com, colyli@fnnas.com, 
	linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
3=E6=97=A5=E5=91=A8=E4=B8=89 05:15=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Dec 2, 2025 at 6:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> > On Mon, Dec 01, 2025 at 02:07:07PM +0100, Andreas Gruenbacher wrote:
> > > On Mon, Dec 1, 2025 at 12:25=E2=80=AFPM Christoph Hellwig <hch@infrad=
ead.org> wrote:
> > > > On Mon, Dec 01, 2025 at 11:22:32AM +0100, Andreas Gruenbacher wrote=
:
> > > > > > -       if (bio->bi_status && !parent->bi_status)
> > > > > > -               parent->bi_status =3D bio->bi_status;
> > > > > > +       if (bio->bi_status)
> > > > > > +               cmpxchg(&parent->bi_status, 0, bio->bi_status);
> > > > >
> > > > > Hmm. I don't think cmpxchg() actually is of any value here: for a=
ll
> > > > > the chained bios, bi_status is initialized to 0, and it is only s=
et
> > > > > again (to a non-0 value) when a failure occurs. When there are
> > > > > multiple failures, we only need to make sure that one of those
> > > > > failures is eventually reported, but for that, a simple assignmen=
t is
> > > > > enough here.
> > > >
> > > > A simple assignment doesn't guarantee atomicy.
> > >
> > > Well, we've already discussed that bi_status is a single byte and so
> > > tearing won't be an issue. Otherwise, WRITE_ONCE() would still be
> > > enough here.
> >
> > No.  At least older alpha can tear byte updates as they need a
> > read-modify-write cycle.
>
> I know this used to be a thing in the past, but to see that none of
> that is relevant anymore today, have a look at where [*] quotes the
> C11 standard:
>
>         memory location
>                 either an object of scalar type, or a maximal sequence
>                 of adjacent bit-fields all having nonzero width
>
>                 NOTE 1: Two threads of execution can update and access
>                 separate memory locations without interfering with
>                 each other.
>
>                 NOTE 2: A bit-field and an adjacent non-bit-field member
>                 are in separate memory locations. The same applies
>                 to two bit-fields, if one is declared inside a nested
>                 structure declaration and the other is not, or if the two
>                 are separated by a zero-length bit-field declaration,
>                 or if they are separated by a non-bit-field member
>                 declaration. It is not safe to concurrently update two
>                 bit-fields in the same structure if all members declared
>                 between them are also bit-fields, no matter what the
>                 sizes of those intervening bit-fields happen to be.
>
> [*] Documentation/memory-barriers.txt
>
> > But even on normal x86 the check and the update would be racy.
>
> There is no check and update (RMW), though. Quoting what I wrote
> earlier in this thread:
>
> On Mon, Dec 1, 2025 at 11:22=E2=80=AFAM Andreas Gruenbacher <agruenba@red=
hat.com> wrote:
> > Hmm. I don't think cmpxchg() actually is of any value here: for all
> > the chained bios, bi_status is initialized to 0, and it is only set
> > again (to a non-0 value) when a failure occurs. When there are
> > multiple failures, we only need to make sure that one of those
> > failures is eventually reported, but for that, a simple assignment is
> > enough here. The cmpxchg() won't guarantee that a specific error value
> > will survive; it all still depends on the timing. The cmpxchg() only
> > makes it look like something special is happening here with respect to
> > ordering.
>
> So with or without the cmpxchg(), if there are multiple errors, we
> won't know which bi_status code will survive, but we do know that we
> will end up with one of those error codes.
>

Thank you for sharing your insights=E2=80=94I found the discussion very enl=
ightening.

While I agree with Andreas=E2=80=99s perspective, I also very much apprecia=
te
the clarity
and precision offered by the cmpxchg() approach. That=E2=80=99s why when Ch=
ristoph
suggested it, I was happy to incorporate it into the code.

But a cmpxchg is a little bit redundant here.
so we will change it to the simple assignment:

-       if (bio->bi_status && !parent->bi_status)
                 parent->bi_status =3D bio->bi_status;
+       if (bio->bi_status)
                 parent->bi_status =3D bio->bi_status;

I will integrate this discussion into the commit message, it is very insigh=
tful.

Thanks,
Shida

> Andreas
>
