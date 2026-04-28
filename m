Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B07542B75E
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 13:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384553; cv=pass; b=ad/4dwjvgZ7jsbbOOR0fUCddX+GICid5LmnlbbykJhjmCxQCgKD2P93aOtQjlxm1gjzl4l6dO8Gd7BwOkEgyedPUmtcuHpmAqEjqoHpK7ddpBR/HUXI1XZrKX59z7tDtCIRnp5GlzXiSV3MH262sB/oLnhOZM7wEZma5WhrfcxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384553; c=relaxed/simple;
	bh=3BatyB9oysYALflr3qq3jidnkz879rzZjXitenrWeJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdWrCUapMn68gZ1ep9VG3zPwY52LMQjTjNhMXFbAXbdubgIZqUw3WMkB+K7CpFLm/MoFXdyY2uEfPcQYJdkdLTpJYdgfenjvGWzeG6ryhTjGDi/AVwhrzVXkpjbQbrxJIf+6tlwHBQlXLNKu4/PORTjJA9txhRfSoq0Qq5SiO2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mmw5A4Y5; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mmw5A4Y5"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-797ab169454so130052217b3.3
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 06:55:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384551; cv=none;
        d=google.com; s=arc-20240605;
        b=GUp6Apwm8fRCAIECc7OrtNBE4hhabAWP+rteb6DI7YWCX5BffTgDSMlr+JEhs9wGgT
         QZP2z5B9SBE3EkYRJjmjWfC9cWduTWSC2CQbhspLC35M9tlNAuR6gTEDHgFV162FDKFw
         j7l1o1rcXsodYKvcH+cHFCfskJuXF6X8AQRjfCq5RlUJuCj9wwU6+7mbDlQSH8EVnXRF
         Uuno2Z3S6/QcHEdsy2tPnRlMzEOapFZilFli+kkA4JuLOQlaCvwFiWq8+8f8vx/+nAOn
         db3kpIL/K0+5cGtlp3Kix+1H9JNgQYgE4D3RM1eSsEJ41Al1ba0XJ1o+GwOMXhtEia0R
         8RIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BbbNkttGRsdp0UF5vHVPSBq8ozj7GYPtZZgWOIuuk20=;
        fh=ubT3LS6HaWdU/FcNp7/li5mV26Cw/FYDgqUCLvB/2Gk=;
        b=MZ7kyJfcEt1GaWOoc2r+Zz5Xd211p41Tjywk2yzjd4EMNan1P3IkcmtgyaJHMaGTXH
         Qb/+/wGKiInt0eoCmiavIMOCCxQfqVwwL7cCI2LnvtaIhlK97/54b11cG2+YcrEGvPD0
         8w4WR+S2ODgJiTNmg0Lfq2kzcuhGYGPSEGhRxtkgupVElh870pX43Iv5Osi6NDjSHokP
         1+Uok6PuAnX+4OuYfYGekwcZ/Bpz1FX3ZA+fWJNSLdqV2KYWHEAkYTf9TAiiWWCuq8Cz
         jBDzCO1geUQx+9MNxcwVKQxl12pIfUeoveoZmh7RZxjKPnpnlm1WBWZk0mLeii82dMxI
         aiHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777384551; x=1777989351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbbNkttGRsdp0UF5vHVPSBq8ozj7GYPtZZgWOIuuk20=;
        b=Mmw5A4Y5cIZgteYQRmkt9v+vTekoEgVIZnOBMYtoasYMCb841x+ELM0eC53lT93l6S
         yo9PdpnAjRHEqfJjO8J8uknbwiNeLotZjyF+Iyk+5Oujl16CRY9bCI4P4wvPyuqkl7F9
         ss9BMTnwA+DP08sYM7OrpZ7OMBqrtyVf+qXxWGWXFp21vpnRcQSmylzP2fY/HwUcH4GP
         YzN9Haw64z7wjNf7uRrhRkWRfRGDRUOYj4iEsMomuqZehrqZNcOO1bv5teE1GcG/kWbP
         PsxpNzQIFetXtsAK8xsPSV935ewZgchFM1tXAspApTLwHQrmEJLXzPV/eIrED9x77IQX
         cx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777384551; x=1777989351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BbbNkttGRsdp0UF5vHVPSBq8ozj7GYPtZZgWOIuuk20=;
        b=pKBx4KHySGMEKLv+42vMDgBEh9twnN3yQpGpeeb/JRPbk2PSCuEMEhaIkJVlJ/2p9u
         qFBzAEWDFzsizn4KQwQDyT1m9X//BwCpVpFNpsK0CGtapDBS6IFp/DP/Lvw8EO7mNzTE
         gM3/ldgs9KVKoAOwReTeEdQ5pAyJa3r7KK0fwsL0R1UYnukH3Nei8Y8+coGg+9sSe7oR
         qkAVyM/fMptT9Kr/wrnpj7OPdhqlQMMbn2TmoUP4ZzvwpsAvZqmQ5V68RgIXIEt3EeDK
         vwBZ9aOvpPmamc8AxnHCwyU2u8bWWSmy4ysORxB53FSbxHYiAexpbCiY+gyTtGOb3eg6
         7usg==
X-Forwarded-Encrypted: i=1; AFNElJ/B15mSCOiSTuOlnFvrkma4TB5Cb3Mj0ovI4n2KfwLVS39JAz2qUy7U5M8HRyL2oS14qNly8fIUsdAMUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4klhM8UxcKEWxm2jIFpiBeC2FVzLD+ewCvnWLwOu7P1NHoYbb
	4S5Lm7e1keQoJq7fcrXXf1XpFgmuMYNnUycHVpPhgBCcyklMpRyWFL0g5m4ngSmEQlsnEfrulgK
	ZLHLVc4+W6bieGYONm7BUiT8a41kLSTc=
X-Gm-Gg: AeBDietgPN0eOAOmzX+Lk0zFaC9PdPOJZhONsVaqZjHZPNUT6K/iI5BGwEKobNGQbSZ
	ptC9I5ReUjzUwBJvgHNlha0nrBc+C/8jUh7QDfuctdh0HEQQsDh8YbsVsL0+UpZEA8mdQqtA2FV
	SVgZ4Bs1gmDFdF2rvcDs0IxHhjehHmjIFq3KlowlZ7hHJvZiSqdiYdhCoUaf5RKGjp5e15PNeAr
	niOgMRWVHqbEsL+KHGeiX4YuWWcbINyY2urh+qsf1PSiQ2oHsC7gr91pBOF74gzwkr/NvbOINUr
	x5EhsbTAnQ6kBIi5W/c=
X-Received: by 2002:a05:690c:c512:b0:79a:daf7:c4fb with SMTP id
 00721157ae682-7bcf58cde6amr29746407b3.50.1777384551189; Tue, 28 Apr 2026
 06:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
 <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com> <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com>
In-Reply-To: <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Tue, 28 Apr 2026 21:55:39 +0800
X-Gm-Features: AVHnY4IdYFVazQhWRf-bCyNur_5HOeGzyx6wM83z8Dkqm_NMzDCTYUO9hSgoPgk
Message-ID: <CAOptpSOO5o4HVUVEX=9D74EjswP0=XRA8aDuZQM8w5UCSoktUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Yosry Ahmed <yosry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 9:51=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> On Tue, Apr 28, 2026 at 2:17=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Sat, Apr 25, 2026 at 9:13=E2=80=AFPM Wenchao Hao <haowenchao22@gmail=
.com> wrote:
> > >
> > > On Tue, Apr 21, 2026 at 8:16=E2=80=AFPM Wenchao Hao <haowenchao22@gma=
il.com> wrote:
> > > >
> > > > Swap freeing can be expensive when unmapping a VMA containing
> > > > many swap entries. This has been reported to significantly
> > > > delay memory reclamation during Android's low-memory killing,
> > > > especially when multiple processes are terminated to free
> > > > memory, with slot_free() accounting for more than 80% of
> > > > the total cost of freeing swap entries.
> > > >
> > > > Two earlier attempts by Lei and Zhiguo added a new thread in the mm=
 core
> > > > to asynchronously collect and free swap entries [1][2], but the
> > > > design itself is fairly complex.
> > > >
> > > Hi Nhat, Kairui, Barry, Xueyuan,
> > >
> > > Thanks for the review. I agree with the direction and have some ideas=
 for
> > > an alternative approach.
> > >
> > > My approach: first eliminate pool->lock from zs_free() itself, then d=
efer
> > > free to per-cpu buffers with a lockless handoff, and finally reduce
> > > class->lock overhead during drain by exploiting natural class localit=
y.
> > > Achieving both per-cpu and per-class is difficult, so the class->lock
> > > optimization is a compromise =E2=80=94 but one that works well in pra=
ctice.
> > >
> > > 1. Encode class_idx in obj to eliminate pool->lock
> > >
> > > OBJ_INDEX_BITS is over-provisioned on 64-bit. For example on arm64
> > > (chain_size=3D8): OBJ_INDEX_BITS=3D24 but only 10 bits are actually n=
eeded
> > > for obj_idx, leaving 14 spare bits.
> > > We can split OBJ_INDEX into class_idx + obj_idx:
> > >
> > >     obj: [PFN | class_idx (OBJ_CLASS_BITS) | obj_idx (OBJ_IDX_BITS)]
> > >
> > > OBJ_CLASS_BITS is computed dynamically as `ilog2(ZS_SIZE_CLASSES - 1)=
 + 1`
> > > (8 bits for 4K pages, 9 for 64K).
> > > Since class_idx is invariant across migration (only PFN changes), zs_=
free()
> > > can extract class_idx locklessly, then acquire class->lock and re-rea=
d obj for a
> > > stable PFN. No pool->lock needed.
> >
> > How much of the benefit do we get with just these locking improvements
> > without having to defer any of the freeing work?
> >
>
> Hi Yosry,
>
> Thanks for the review. Great question =E2=80=94 we tested exactly this.
>
> With only the class_idx-in-obj encoding (eliminating pool->lock from
> zs_free, no deferred freeing), we measured on two platforms.
>
> Test: each process independently mmap 256MB, write data, madvise
> MADV_PAGEOUT to swap out via zram (lzo-rle), then concurrent munmap.
>
> Raspberry Pi 4B (4-core ARM64 Cortex-A72):
>
>   mode        Base       ClassIdx-only   Speedup
>   single      59.0ms     56.0ms          1.05x
>   multi 2p    94.6ms     66.7ms          1.42x
>   multi 4p    202.9ms    110.6ms         1.83x
>
> x86 physical machine (4-core Intel i7-12700, 2 rounds averaged):
>
>   mode        Base       ClassIdx-only   Speedup
>   single      11.7ms     9.8ms           1.19x
>   multi 2p    24.1ms     17.2ms          1.40x
>   multi 4p    63.0ms     45.3ms          1.39x
>

Correction on the x86 test description: the machine is a 20-core
Intel i7-12700, not 4-core. The test only ran 4 concurrent
processes. The multi 4p result (1.39x) is with 4 out of 20 cores
active =E2=80=94 pool->lock contention would be higher with more
concurrent processes on this machine.
