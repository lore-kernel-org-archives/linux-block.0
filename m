Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22938D011
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326953; cv=none; b=bqyYDfEpWJTCEap/hkQcLTXtrYMYZil5YIMMDmLB3E+MX8puRZFibL22x6Pw7jsvvsD6k5CjFjKrhkyRwM8BqjpwfV3ZOjIFJJ41OC0d6+sXsQ7lBSSchtoxgGL9hgKRql2nwyOcYFrb0xIRz9Rco2ns5JoFAb7CiauWEi/oCHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326953; c=relaxed/simple;
	bh=OWjwJArMxxnuWCNcVjFmcPIsiycq2qmQ6eEqyuLfs8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvTV3zRasPwpoInj5IpvWAfeyl9LmneHRL78PjL2fbGVtl5oOMKxwzmvSmyzaaQGjQsVIhJpVhlIBYt9nwPWirHj144hHa4bY4pxJTQziySlWgx21PcB+bm24m0MZsoqRnwubI4mOnB/PZd3DOtPruPfEp/ZkZe07ov203b4tGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQcDjpaf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQcDjpaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA02C2BCB6
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 08:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776326953;
	bh=OWjwJArMxxnuWCNcVjFmcPIsiycq2qmQ6eEqyuLfs8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vQcDjpafhjSPyLMUbB0g/MeIsax/hB0tHYmEDA4FSK1TOOpNpTloVkpFrmMreA/8l
	 cen4amP3/KQ69Xq2rSh9ytCMzj8/54ADWVAXOHSBeBzXZP0KgH8A5SGapW8ETmbE8o
	 8NfD6zs7vsyC1gsakGJJ93lZjLcPAyTIpn+yhyd/VxuzfhI1SYH1IBa2IJ+pwhRiNB
	 TLT7mW/XD9TI4u5fVd5nXC2F6EInDrMtexJlsrb5+l5QZ4I1eRqKwXufbUI6pZfFHT
	 2QbI8HYzYII5ZGJ2uIT9UL7BAjJ0jD3TAvPlNZRvlwre+V16cBX7/pe5/sDtOAekti
	 xB2Yo62FmjLZQ==
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899a9f445cbso86075756d6.0
        for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 01:09:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8OjRdP4zZkNuNqChrh7N91lRRhLzUc2PnRW+n3QLFW9wIZ66keBalz0l0q+eE4YU87oJbrJlh9+C2YvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMDoM11EiTpm18ces1sBjspp603IO2i2yxIJgnZWBmV2NNcHI
	6eMBX9ncQxC2doM0+Q+DpVWb8gzkrj+3xKMIWMtE1aU/qGq5/rutUJWLt2oj3SDxbHmnSRAy0kL
	MK0QVxE3468FVmp4p9SFcCmpk2AQq/ds=
X-Received: by 2002:a05:6214:f2b:b0:8ae:660a:be74 with SMTP id
 6a1803df08f44-8ae660ac6b8mr126936876d6.7.1776326951804; Thu, 16 Apr 2026
 01:09:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adt3Q_SRToF6fb3W@KASONG-MC4> <20260414054930.225853-1-xueyuan.chen21@gmail.com>
 <aeCRnAhfg3fNi6Ey@google.com>
In-Reply-To: <aeCRnAhfg3fNi6Ey@google.com>
From: Barry Song <baohua@kernel.org>
Date: Thu, 16 Apr 2026 16:09:00 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4z-3WQQR6f_mMYHNEMAc07h+JPMxQTsoR0+GWgkvQVRTg@mail.gmail.com>
X-Gm-Features: AQROBzAxRhEQrDRQPKtEY2UjI7ERhEcteUuBlCcyMo8dNRYtEUx3JeOHDKYsMK0
Message-ID: <CAGsJ_4z-3WQQR6f_mMYHNEMAc07h+JPMxQTsoR0+GWgkvQVRTg@mail.gmail.com>
Subject: Re: [RFC PATCH] zram: support asynchronous GC for lazy slot freeing
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>, ryncsn@gmail.com, minchan@kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, kasong@tencent.com, 
	chrisl@kernel.org, justinjiang@vivo.com, liulei.rjpt@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 3:41=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (26/04/14 13:49), Xueyuan Chen wrote:
> > On Sun, Apr 12, 2026 at 07:48:48PM +0800, Kairui Song wrote:
> > [...]
> > >What is making this slot_free so costly? zs_free?
> >
> > Yes, I've captured some perf data on RK3588 cpu2:
> >
> >   -    3.79%     0.42%  zram  [zram]  [k] slot_free
> >      - 89.04% slot_free
> >         - 65.40% zs_free
> >            + 77.29% free_zspage
> >            + 21.75% kmem_cache_free
> >              0.68% __kern_my_cpu_offset
> >         + 13.19% _raw_spin_unlock
> >         + 4.86% _raw_read_unlock
> >           4.75% obj_free
> >         + 4.72% _raw_read_lock
> >           3.64% fix_fullness_group
> >         + 2.02% _raw_spin_lock
> >         + 1.31% kmem_cache_free
> >
> > It's clear that zs_free is the primary hotspot, accounting for ~65.40%
> > of the total slot_free cycles. Beyond that, have some read and spin loc=
k
> > in slot_free.
>
> Just a random thought, if zs_free() is costly then it likely also affects
> zswap, which makes me wonder if doing something on the zsmalloc side is a
> "batter" way forward.

Xueyuan's perf shows that 65.4% of slot_free is spent in
zs_free, so there is still around 35% elsewhere. However, this
might be a measurement issue. If we confirm the number is >=3D90%
or so, moving GC into zsmalloc seems like a better option. My
real use case is zram rather than zswap in the Android industry,
but this would benefit both zswap and zram.

Meanwhile, I would also like to try whether combining many bit
operations, such as clear_slot_flag(), can further help.

Thanks
Barry
