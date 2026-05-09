Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8539A05C
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778317718; cv=pass; b=QXdaZYDeXfUGHiqZ5EeGBqGJY+w3hJCUtSzst2kPv3XXg95fMquOsHUxDOW9wRcIRF9hqhb5/RBNOA7A4H6W8yrTZqlccdq6FUQCtsrH3qr7oWYSgqNhT+JryYEBOLKTa4ms/KDgmDgns7Zmq1DvX+nVqu9bMvEkwRXCsocZgRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778317718; c=relaxed/simple;
	bh=HpJECKPCWn98B7gbdA38eNjL28bkoBw6bgxwkA1qVRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAWCmH8eh7E+cEA7ht0DPOOuclR7Xwdo0Naqji3LJL+BvN6w1aGdHxrlhafDyWOvrM7pGhaOTXK/xTav6a3foW/KyWyzxMcV9AOc6ktc3W8w2ZbfQDOtJX8qLy+lTy8tzAyZT2cQdZICKbNkh1IeDAWKOwNRWoanYI7hM8sc8dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAQ5Hv0i; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAQ5Hv0i"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bd5c582c47so26474777b3.2
        for <linux-block@vger.kernel.org>; Sat, 09 May 2026 02:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778317716; cv=none;
        d=google.com; s=arc-20240605;
        b=XKInXZVTgwInwuwYLDA3QIDDGFIMAejeAMM2pJPqegeDRviJ7qcG7girto6Eg8/RH9
         eyVEJG/psYiX4Lxhz38FEiVC9OxJsbhAUNKUdl4mWnSbwcns3F9IEHqBAgrrGMEEYzVh
         EcByoIgxS/x5kkykg6KU3K0VDTvJOmUnB0v31sjjo8rH6Go2pT+2GoKfNgqW9uGxl0Uy
         RK4Kqma+fsGDvBnyBatJVXt1v58YTqvSEKQefLfNCvSIR+QM4gktz8/+ZoaH4IZA88Ok
         izd3piFCGZ2e90urwruH7SY9Vzu3tExI6o40n430s0KTr4P/NxcKKqw/ukdlMBGkgN/V
         Qf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tVdwEh33FhmGvU050t774z8AFpJQif4TcQfckUPV3TY=;
        fh=Pu2n1NYnazqwDDBEFy4OfGIzjDA6zrQhLn4YBS1AqGA=;
        b=GtDE3wSvQkDa8rmKlj0zKxitDyZIKUsFokmNpExuWrU6YX48tN3xD97YORsx1QlPhv
         aQ4QgDJZyyzJ1rJGz7ba41ixQQWsT3j3T745osNr/5TIpGZNI7J34zunxe+I5ZpGQRSn
         KZTqDoL5lJeyUF91pIyU+9tSYlwdLTxan+wQ8FL5anY9+8aJ3y5ujP/qFqVsW3vgLrac
         6udsdh+qEoHUmOLqNBtXaxqrXYt49IlVIKAypurfrORn6kIz266B57AjUpG2uhcipwDc
         zKxOcFZbzqOmQQdxQxMKlLeAoc3zNxTLu2Bs3v3VT8ymCj5hNZsOyLu+har+bsnvFCUc
         flFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778317716; x=1778922516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVdwEh33FhmGvU050t774z8AFpJQif4TcQfckUPV3TY=;
        b=jAQ5Hv0i1w35/Leog188TvYMiDZZdAsizBFXKrIiS5oFnHmhsEexw6M6NtGPwBnfgz
         ewxrSCKOpmGTsovzKnY5p9mYLd1PbjZyFI5nG0Beo9E0xlwg8OC75FRHsJgxOpLdpoCT
         TTHHmtcG4SkXxMhNxt2ema+HwNLKsuDJmAO9iB5vy2d2J/5Y0P+WOMFgMR4VRbD7eM5p
         /NZko2O1QZgQPRrKEEGrTaJe/+g50RnK2Qz2qlj7O/ctbJwA3/PSdB6/myNJUQwQhbiu
         0d4ofh5L0Svwa9yK23mLPeLnQ0rHK2EV+86BTMpEYFuvIPPZez1jmvvKXb9zKXTeKpHn
         Y1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778317716; x=1778922516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tVdwEh33FhmGvU050t774z8AFpJQif4TcQfckUPV3TY=;
        b=lLgcTaOcdL92PG+2yAkLdSgp+lygkmOuI86qsPTjRbw45yA3k2qm0OUq4RI87J7Ld1
         BqFiBKk/pc2IOPtR1QKDv9vpAxlMauIWxSwwwRWfz+33I3BJ1PFGRjZmbR3xM9AUbhxC
         7qweJDNy89RUeexOVqODBCR1JV/EsWung7laXV1nS23xyhnwp3U4H19uJSpf5LueP0pt
         633DiV4bn3v59xewML4VIM2xBsvutJFVRDESMvTpDNWGAqKu8fvRhUAw4HxgPT+OUxef
         bVzwy6ujmtBQoQSOqLXDPpmZy+jdLAOVnEvk2O1POSNu/5H8RZp/Ji3Qfy4iGYI+zzFO
         rtdg==
X-Forwarded-Encrypted: i=1; AFNElJ862m0z3kx1UuOri3T9lYgybgAAIYaukGasgnEq0w42vNr+/nNRgYUhk9ajRVMVvkQz8Op5HY3RgAfv9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVSKmPLtPfnYG2mjtvthlR1v0FJh7VeoomvFmi1P4N9UY5pnEI
	mUanLHW3vj9Hu/Wry7MdF+C7UV6mqCYL2SALq3MUV6h/SKVjFs2MBcqeuE0075BTRmcRWQH5lHO
	AXJqqI6UTDbD8ojo/vAlMKoUFKRcW0Wc=
X-Gm-Gg: Acq92OFOTYYvw61rNuEUa7566xS5g7TNwSpte62AF7d5bTeKlX0cW2Jd9qap78N5WVY
	TKUFkGIU3P6joWtqlo1STxiPatifqhqz5Yzytq0HceT9GjghoS4qFmeYsmatY1WbtbyCyBbccen
	d402/AsMYDv7H910PNix8HEodFgcsTpak4BCK2302ngwL+3rxudJOfWkdYJDJQytWpMRqjBUZd7
	zeADOKAXcHNk+FSlYB6wK1riWCFpmmO9qb9BzAwonE2FYZ4Bp/db8R8usTTo24PinE/JDGZlaEn
	4d+JYEWn
X-Received: by 2002:a05:690c:d94:b0:7bf:107b:f859 with SMTP id
 00721157ae682-7bf107c07f3mr101380657b3.16.1778317715853; Sat, 09 May 2026
 02:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
 <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
 <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com>
 <CAKEwX=PrfrNys4ao7-d11J7r4pv5VmE8gTU_7iUHaHAKNaFuBQ@mail.gmail.com>
 <CAOptpSOnRCHo35KK5x3S0f5y9+7+dxfznpjNRH072jZvhYHwww@mail.gmail.com> <CAKEwX=PgsM4Z0URJcF5VSXX_jdy-cAs2JxDCCR1a8CGwV4tCAg@mail.gmail.com>
In-Reply-To: <CAKEwX=PgsM4Z0URJcF5VSXX_jdy-cAs2JxDCCR1a8CGwV4tCAg@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Sat, 9 May 2026 17:08:24 +0800
X-Gm-Features: AVHnY4IXrMEe_-uQNRtiTfBHiBqbclVoh00lPISlO6-0pAUXbq9BaSPyawX3d1U
Message-ID: <CAOptpSMdFwQUxT7bP7s1GWyXvzUQrg3ROtGp3w_zYy2rSkDYRQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Nhat Pham <nphamcs@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 7:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Wed, May 6, 2026 at 6:55=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.co=
m> wrote:
> >
> > On Sat, May 2, 2026 at 3:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> > >
> > >
> > > Oh man, you are eliminating pool lock here right? This would help my
> > > other patch series a lot too :)
> > >
> > > https://lore.kernel.org/all/CAKEwX=3DM5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWo=
dwbf1Fe=3Dgzew@mail.gmail.com/
> > > https://lore.kernel.org/all/CAKEwX=3DPkFiP+u+ThrzjTKBi+usQf2uuhTZcfB2=
BNNA8RboOFDQ@mail.gmail.com/
> > >
> >
> > Yes, exactly. With class_idx encoded in the obj value,
> > zs_free() can determine the correct size_class without
> > any pool-level lock. The lockless read gives a valid
> > class_idx because it's invariant across migration (only
> > PFN changes), and we re-read obj under class->lock to
> > get a stable PFN.
> >
> > >
> > > /*
> > > * The pool->lock protects the race with zpage's migration
> > > * so it's safe to get the page from handle.
> > > */
> > > read_lock(&pool->lock);
> > > obj =3D handle_to_obj(handle);
> > > obj_to_zpdesc(obj, &f_zpdesc);
> > > zspage =3D get_zspage(f_zpdesc);
> > > class =3D zspage_class(pool, zspage);
> > > spin_lock(&class->lock);
> > > read_unlock(&pool->lock);
> > >
> > > It's basically just this blob right?
> > >
> >
> > Yes, that's the blob being replaced. On the
> > ZS_OBJ_CLASS_IDX path (64-bit systems), it becomes:
> >
> >     obj =3D handle_to_obj(handle);
> >     class =3D pool->size_class[obj_to_class_idx(obj)];
> >     spin_lock(&class->lock);
> >     obj =3D handle_to_obj(handle); /* re-read for stable PFN */
> >
> > No pool->lock at all. We've also added compile-time
> > gating (#if BITS_PER_LONG >=3D 64) since 32-bit systems
> > lack the spare bits in OBJ_INDEX to fit class_idx. On
> > 32-bit, it falls back to the original pool->lock path.
> >
>
> BTW, I've tested your idea with a hacky prototype, when I was playing
> with my vswap series. It absolutely improves free time in the usemem
> benchmark :) Idea is very promising - I won't scoop your work of
> course, just letting you know that at least in my use case, it works
> :) Look forward to seeing it submitted soon!!!

Thanks, Nhat, that's great to hear.

I've split this part out and posted it as its own series:

  https://lore.kernel.org/linux-mm/20260508061910.3882831-1-haowenchao@xiao=
mi.com

Review there would be very welcome.

Also, could you share the details of your usemem setup? I'd like
to reproduce it locally on the same baseline.

Thanks,
Wenchao
