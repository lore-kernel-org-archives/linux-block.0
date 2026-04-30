Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A43DEAF6
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534743; cv=pass; b=KUkepNiqgQCSSdtUEnRfGmLtL3gARAQjFysKNOTF74tAr/N/z+qicUvSgFoflj4C51vtlAS48tFVHpiEh5awaMf66SdhmVBNnO/MNhg/WEj6LceReKzvTm1IFc2dLfIoKM5wxJeM+EiyY2C0CNPZplin5TzMRuDfX/wh1eZ5bPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534743; c=relaxed/simple;
	bh=6rlHOqoWvtpeTkocXToX+8Pu/qNbgeTpnpCUrAvSf5c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpY5PgbyB75v7XpAk4x1L0MbFWLC0rH3fK9nWHCeO3Wzm2agvP7sv3ISelFQna/ncNsrHuthKJqON8EyBDfywGruxJSowGRBcdoXoRxmgx0tjszv0czQkob/fWCWAZp1ccm9+f0g4so8ZCYEMQnIhap91PAJ1NYw+kAVrWsESt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZFnFWrE; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZFnFWrE"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6501d242e2fso545956d50.3
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 00:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777534735; cv=none;
        d=google.com; s=arc-20240605;
        b=WO7GiTP112Ny1UuwhwrhrKS2BE/0rlnd3/2F+gspN0/ddQyAJZqe9BBDxpFMBCaCWp
         Iu3tNdUs2socohyK2/xSpbyGfISoCqFz1oRLcQYo4d+CgyX7XYOUF7F0NOBfaIIpyCr6
         DGcBbxT9bDrWE9Xq/+uawZX2Q53BuI7zzduOLTVUVc+2t/0OfPINultqVMeekd3oJh9g
         WjrYgVZbL1gLKg/Pp5YyFDSgm6nNE8NmKnk6wwM1W85hnTiB7YH3vnowIZutHNY9StA/
         rUcrXD0WCHyRaCA41bNqk66xhJu5JGjrY8ta+3owB6NCwjyBKX7RXwyphKKG1EZWMtc3
         t7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXP0rjq6f9ivjYP+86z3oZz11J3Z1DaKAvZEEb/Awds=;
        fh=4NfSgm33soXKqvPloqroR2S9pCLNaLq/mKg7fnTlfdA=;
        b=KbxllwSrV9bFLP9IMzYef4cBLgp9zJOFyK1JHERRNRQrQk5Q2QIgozRl6JpkBtIJiz
         p/RVknN5uqpjXBEq8n8CaqffJ1GmmLnq1hq6AohDXar1xRuQ1e/YhcS3vhv0698zlljo
         mnzUH5LtowdgbP7+tff9HGup9y8RUNwVle1xKeBxEF8JcBHX99zwu/Bj7xoy2k/CMnWM
         UKXew579jMAuONI4tgX+4hG3RO56XbEQz7vu1bhePODiw2+1KR9JyCnpA1M+J0lHn3XM
         UyiTr+qT2J/GFo4TwHs347XWLgykzHXFxxWioY4YTOwqR8MSkeow2haOnR8igwY/MEDs
         h1RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777534735; x=1778139535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXP0rjq6f9ivjYP+86z3oZz11J3Z1DaKAvZEEb/Awds=;
        b=LZFnFWrE8RMPHFJ5hd9fbpZLBBWv8MP6DzWZOBMEwd61z7QSDyp+iwIG2T0NlVw3IJ
         xyAnGJIZlKjpoxC0OtD76N3AzC0zPDAznuVBiv/tGrLx7+A6J5aMCqgkjSSPOkcwGZRD
         94hhTWQ98ihtJnoW2oYK+nxO2LaoyjHurNypAb376H4m7C4IiQYyYH0OnPmd1xZH7gIV
         /UNOjbGQU/9DCJBtwQcBXVd+GOt2fadZd2DZjp3pw8iOVmQS49SDQFN1PD3qepxjQUhY
         D9hFg7SeTRXKqJwMbIqRrxZB7uzH4C0z10u9ocdjz8cSxFJ4DExWKBx7c2G1Q1Jzj30S
         X+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777534735; x=1778139535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cXP0rjq6f9ivjYP+86z3oZz11J3Z1DaKAvZEEb/Awds=;
        b=rglhjaS9qnK341BZHVYuEs2tcBOukcQ8M4Tr+b/yC445sotauHQA7fH9JXfHbNBaal
         jmWxzZkqO9g5F5kf6BqR5hYsK/AVXP3+B8huigz+eSwC+g6Zhi6VITHbIh8jto038+Nj
         ppITJjF7Pw2Zh9FN6q7M5PxuvT+Wa0/SOObAFJt01sFVoiy/emite3F22uKeDSGcLr7b
         LfoeEwu1mFnXQbqU95VHtgIUsL35LaRPF2kBEMDynHBQZje6TKaD2pj0KtQIhJ+SR2ea
         lJqsQ2nQC6jaD8uXJKOK+bOc+CB0jYifo5duThpmouXLCOjj73SoezyNGK6nC92lQ5QQ
         9w+g==
X-Forwarded-Encrypted: i=1; AFNElJ8eFU7qprhbwETVIlvcXFvL5+k6Ik5tNuAHDnYI4fqdQyMWfuBgsQpDJNLOLJDBd5HBEyyegC1G2AoumQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YybDd3/KwhUWn0x3gy/5aO2XGQg+rMIJXG3XMl6YIC75NrywQqm
	mHvlRYvvOiu9+VXIxS7WEa3Kj9cGbYbOXb3OsB3rriQK0Or3GrbshbY0SUG+69IdUm72uY3Lhln
	IfmM/Ytb7dCLWGFMOW05y0rfP/GR5TMM=
X-Gm-Gg: AeBDietGyZS7WXbJXBq8lYkwNoeBGV/v9NzRbJ/JFJkOJveFlZyjCxdiA6dMQNpuWWB
	GDdJjjcXtqZWYnbNk/KVeVIm7iAUPeMxHlaM5TlxiwtkZqtNaYqMei8r4D+U1h5bhr5ZiwJWgE+
	edSTI35Y7Igi1DarbN8IMYtRGNBqIUswlpZkrZ6D1nqTKj6RaMdcAnTDS4z7VHSIKjCbYOQCMvw
	mvUA1ejzF/EjOzAxzwz/02XSSoNlCzB3aV3Sc+awbZlZLWzEw4oxYA4X0IGBGWmSLGgbiv8eUIV
	5oHKiWzxm/4TcceT/DA=
X-Received: by 2002:a05:690c:86:b0:7b8:8474:1a7f with SMTP id
 00721157ae682-7bd52a648b3mr16570207b3.37.1777534734687; Thu, 30 Apr 2026
 00:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
 <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
 <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com> <CAO9r8zPV=c9v4Ar7t+xPxyptSUPrs-shrumsz=hCaNa3anGgAA@mail.gmail.com>
In-Reply-To: <CAO9r8zPV=c9v4Ar7t+xPxyptSUPrs-shrumsz=hCaNa3anGgAA@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Thu, 30 Apr 2026 15:38:43 +0800
X-Gm-Features: AVHnY4KrPoCOU1mZFCP1DSbJ1ZSteeXm91jd02ADS1dVFQY0nqpw-GDhCwDxV_A
Message-ID: <CAOptpSMLLz0yzg99nkAp7rxO5RphTDU3Cdqd8020mysijN_Bvg@mail.gmail.com>
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

On Thu, Apr 30, 2026 at 6:44=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> > > How much of the benefit do we get with just these locking improvement=
s
> > > without having to defer any of the freeing work?
> > >
> >
> > Hi Yosry,
> >
> > Thanks for the review. Great question =E2=80=94 we tested exactly this.
> >
> > With only the class_idx-in-obj encoding (eliminating pool->lock from
> > zs_free, no deferred freeing), we measured on two platforms.
> >
> > Test: each process independently mmap 256MB, write data, madvise
> > MADV_PAGEOUT to swap out via zram (lzo-rle), then concurrent munmap.
> >
> > Raspberry Pi 4B (4-core ARM64 Cortex-A72):
> >
> >   mode        Base       ClassIdx-only   Speedup
> >   single      59.0ms     56.0ms          1.05x
> >   multi 2p    94.6ms     66.7ms          1.42x
> >   multi 4p    202.9ms    110.6ms         1.83x
> >
> > x86 physical machine (4-core Intel i7-12700, 2 rounds averaged):
> >
> >   mode        Base       ClassIdx-only   Speedup
> >   single      11.7ms     9.8ms           1.19x
> >   multi 2p    24.1ms     17.2ms          1.40x
> >   multi 4p    63.0ms     45.3ms          1.39x
> >
> > Single-process shows modest improvement. With multiple processes,
> > each read_lock/read_unlock atomically modifies the shared rwlock
> > reader count, and the cost of these atomic operations increases
> > with more CPUs accessing the same cacheline concurrently.
> > Eliminating pool->lock removes this overhead entirely.
> >
> > This only works on 64-bit systems where OBJ_INDEX_BITS has enough
> > spare bits to fit class_idx. 32-bit systems don't have the room.
> > I'm still working on the compile-time gating to properly enable
> > this based on architecture and page size configuration.
> >
> > > As others have pointed out, I don't want to just defer expensive work
> > > without understanding why it's expensive and running into limitations
> > > about why it cannot be improved without deferring.
> >
> > For the deferred freeing part: the class_idx-in-obj optimization
> > addresses the multi-process scenario where concurrent atomic
> > operations on pool->lock become expensive, but does not help
> > single-process munmap. Deferred freeing moves the entire zs_free
> > cost (including class->lock and zspage freeing) off the munmap
> > hot path, which benefits even single-process workloads. The two
> > optimizations are complementary.
>
> What is the extra speedup added by the deferred freeing
> on top of the locking improvements?

The data I shared earlier was class_idx-in-obj only =E2=80=94 no
deferred freeing at all.

> I couldn't immediately tell by looking at this vs. the cover letter.  I w=
onder
> what portion of the improvement comes from the deferred freeing?

On top of that, we added deferred freeing in the zsmalloc
layer (per-cpu page-pool based buffer swap + WQ_UNBOUND
drain worker). With both class_idx + deferred:

Test 1: concurrent munmap (256MB/process, RPi 4B):

  mode      Base       Deferred    Speedup
  single    56.2ms     17.2ms      3.27x
  multi 3p  153.2ms    51.5ms      2.97x

Test 2: single process munmap (various sizes):

  size      Base       Deferred    Speedup
  64MB      15.0ms     4.3ms       3.47x
  128MB     28.7ms     8.5ms       3.37x
  192MB     43.2ms     13.0ms      3.32x
  256MB     57.0ms     17.3ms      3.30x
  512MB     114.4ms    38.5ms      2.97x

However, this is not the ceiling. Profiling with perf
shows that after deferred zs_free, zram_slot_free_notify
still accounts for ~65% of munmap time =E2=80=94 mostly
slot_trylock/unlock and slot metadata operations.

To understand the theoretical limit, I tested an extreme
version that removes slot_trylock from the hot path
entirely (not safe for production, just benchmarking):

  size    Base     Deferred   No-lock    Speedup
  64MB    15.0ms   4.3ms      2.3ms      6.50x
  128MB   28.7ms   8.5ms      4.7ms      6.14x
  192MB   43.2ms   13.0ms     6.8ms      6.31x
  256MB   57.0ms   17.3ms     9.0ms      6.30x
  512MB   114.4ms  38.5ms     33.0ms     3.46x

I'm exploring ways to further reduce or eliminate the lock
from this path, any suggestions on how to approach this
would be appreciated.

Unless otherwise noted, all data is from Raspberry Pi 4B
(4-core ARM64 Cortex-A72, 8GB RAM, zram 2GB, lzo-rle).
Test: mmap + fill + madvise(MADV_PAGEOUT) to swap out
via zram, then measure munmap time.

Thanks,
Wenchao
