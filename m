Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB04EFFB3
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792166974; cv=pass; b=N8WHiT9PLTLMZ0vJ5q3rO1/2CgEcXrK8XRxpkOv4pdO9e2qXiaLGfhgikJbPpwm9N/tFR6zg/xGyLROxiYAKbz2X9C4P0HzC6IBK1JnY6D6nLdPvxcz2yS1Lzfl4tU1RcKSuSzZ1/9VpJedhKtxWq9IguRAssPB9MJTHtN53M3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792166974; c=relaxed/simple;
	bh=JK1d3K7g5Jktfb+qNEOacma+tvhF8sNAGrJHfx8GOGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqCuavSip4puwkEYBR8USTwkXl5IiSFRFSRNQiLtiYvWSCtDS37lTj7yruN+uYpTV5FvvN4A7eecn15fIaMxAB51qddinZRUvRL8vgD1U4GuRBnwtobpHPZf9HDIjeZBZYpOQUJyGTmsmhhQ51chUyhICSfZQz/YvxOL4cdAAng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p+BnD9PS; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+BnD9PS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1d484b4a9so1707765e9.0
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 09:09:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166970; cv=none;
        d=google.com; s=arc-20260327;
        b=I0AwLpHAqu7A2gaTwfd0T9g0OFkheYCope1smUsYilAGN1ES9S5/mr242QRbXE9j/f
         TzYIsceoi4pLU9IKw0MS6K2Ew2F+IVLoZK7dD4I2+n/jlACZStgRf2X1G/GehQcfmlmq
         M8bYM9Z4/IqUk29Wk6SlihcBRzIGR3vg7SHNLfQsp9WaZ1rZchlx3ddDiaW7rFxn8q9X
         a7jRPGls+cAmCKgxIO72GsdBR+XeVKFqM+5yMCxM1WldNgoaDcOdKkBhNv1sPUtyYMkE
         I1ENQ9qfKHNo7Gb25l1kmRRcooa+XR85Q/WA1h/ekQCPFscK7M+fjQmlMIUBl60BpBKo
         eojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=01clFvS8PqYDYJUml8Ul3JDl8oOLRSNhVNdWYi0v5ig=;
        fh=ejuB/BKPZ7Y1T4amYgIL/gvdCDp37aSo6muD6kGI3Bo=;
        b=TBpFEPwid4RsLtPSvPUV0ArlLAlb8GnOFP8tqd6dxdeyf5nOnvsJbp/LXKz3d6P7B8
         u+j2QPvmLuqV2lFXox2BetveQ4V90axkZuU5L2M2TtuKIPieU6sguiJ0zuoxXjB+24GJ
         5ogUndOnShZqi+972X3sxhAF6ITIUiUOd3CirnV3HdeVqdO1/GSL9v66G8cAFsyRNV4m
         auz4mbLC1QWHgsrZGRv5JWJ79eE8kbbex9wUhORxkY9CPxaxSZnPrMVmpna8NOVL0gu3
         n/Xy3bXBH1vQ2H3yIlGLmLozedOEwj6/sZIpyHSFmigaQOKRImiWI+vUdvdGDxJD4meY
         3dwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792166970; x=1792771770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=01clFvS8PqYDYJUml8Ul3JDl8oOLRSNhVNdWYi0v5ig=;
        b=p+BnD9PSSMRcJuKdrC3LejFYMI6nR7EbIYmJoQwOoEdmLZznQBqATm2IDh1pijsF6q
         LZgLDsre7xnRbLHBSfSrAjCEzdMMLkMytG5dpAtlgtbPlcT0Bl+yy76B8flVmmUbB3QR
         R7cJsgqQrRfIlalslrKG03hpEA04L2ClhnUv88v/xVTjkdAT07e7csQyqyWly0WbWHeB
         YWAFtYWxj7Le+b1jK+BRJqWalSVKjwd/9s2LMHuFzs64SZJlrUVXItPt7W5wW5sxSoUF
         s5SBeczxn4hhoohd1TuqrRsTHxR7pnph3f+H5dQ8LTim6NOhWsgBkIeXmeoib88zU0DZ
         kxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792166970; x=1792771770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=01clFvS8PqYDYJUml8Ul3JDl8oOLRSNhVNdWYi0v5ig=;
        b=fpwHM3tJkHVkP39vU69xXCs8zNjIbHHth2hlt8DtH6ka7XlXF4lqMIEfpz0jXNv67Y
         lzYRO4XRzheLsyEWimfIoCi3UkhYsS4qUD0mtV0MUSmU845TXAwHz1rl9PsGhJs253ih
         UjGf2IC7q2W715iAUqHCioNn02IxswRgOEKOSMW5gcE2ZLG0FX7qd1BAPK/2xbA+CEUU
         otlgqnxI4uqNTElgd55rlripYhQBPkxF1u2G+reJgYto49sS4J1gNJ0e21i2z0QyiqAu
         rlId+LdIUN3Q/+rtvMfVvxujdzb7E+PHWpN141NM6RdJDYUJerL8RuWL4duCKlumwUF6
         cnwQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3ZRSDumYQxM/rAHrq1HXQDCf5AKZcLd6/+7iujKe7UpC5DkLDTebTAJeFiRmV9nOIw4rh8kKdbf3bbQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLdGd/sJutlx8NofxD2gPGsFCoXf3ZsUKvu4rhRDGxlKZoo37VD
	5XQtmct7B5lPjD5YWqkgfda8WqdzcMq+cC+HGA9MOv+88jLIdjKJlIlYJgQt2orD1fQXfMTE0dr
	Cj4s1D2/CnX8UeHNbmZjJ9G69HjvDXp8=
X-Gm-Gg: AYBFou1cZZeUDhSt600/IkMmxQDYh2UHONtvNK6PHmYDdHtXCBcStUAaMT8TBrP1jLe
	tlOBo0VDJfT7KBpftolCILKSlMwAkBoB2+5q5AGLGcjAv8ETad8IM+JwEsJwPv3LLTOQnbLzCEm
	op2POY4ij/CIGIA0UozAxFQ98+6rZHdv7HTXQeLVTgoVy5Ic437TkCgb3dJ/Jz5mC64MByhfRD6
	7UiFqNM6Umnk+NqgD1Unr8hK+8wU+zjla8rPSHVawTn/tCttN2z6x/uLlihtFWMrg1OKsj9gy0I
	jQJn7KD/uOm3d7fU1RRrX6CXjICxiHbDIGYzg+DaZjmkxPDU6f1gUgbsTxe9VATlznmRswDI6TZ
	cz+GL1sG2PYJ9WV9TYM6XlxpbeemAQ2QHrRtZXyvFiEYLuhf1mRgZp1xbN3+l9cV0ga/Tw2FWKd
	VpoVhV3A==
X-Received: by 2002:a05:600c:6215:b0:4a1:d41b:5060 with SMTP id
 5b1f17b1804b1-4a1d762b705mr4918205e9.22.1792166969428; Fri, 16 Oct 2026
 09:09:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
In-Reply-To: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 16 Oct 2026 09:09:16 -0700
X-Gm-Features: AclHuK_3q4fgvpP3PqMsH4m0BzcVF-oc6GrjQvM0hL6t6dEcQtFu56enbmqvAPg
Message-ID: <CAKEwX=ONniSwdiZAe_8NT5XwVj=Mmc-WJs_rWE4Y5snjFg2=Eg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/2] mm/zsmalloc: defer object free to per-cpu batches
To: Hongfeng Chen <chenhongfeng0212@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, 
	Wenchao Hao <haowenchao@xiaomi.com>, Wenchao Hao <haowenchao22@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Hongfeng Chen <hongfengchen@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 5:10=E2=80=AFAM Hongfeng Chen
<chenhongfeng0212@gmail.com> wrote:
>
> Performance results:
>
> ROCK 5B+ (RK3588: 4x Cortex-A55 at 1.8GHz, 4x Cortex-A76 at 2.4GHz,
> performance governor), single process munmap on A55:
>
>   times in ms, speedups over base
>               Base       Patch1       Patch1+2
>   size        time    time speedup   time speedup
>   64MB       13.81    3.62   3.81x   3.28   4.21x
>   128MB      28.50    7.18   3.97x   6.49   4.39x
>   192MB      42.19   10.71   3.94x   9.69   4.36x
>   256MB      56.06   14.26   3.93x   12.89  4.35x
>   512MB     109.50   28.43   3.85x   25.66  4.27x
>   1024MB    217.10   56.70   3.83x   51.15  4.24x
>
> Same machine, single process munmap on A76:
>
>   times in ms, speedups over base
>               Base       Patch1        Patch1+2
>   size        time    time speedup    time speedup
>   64MB        5.59    1.58   3.54x    1.49   3.76x
>   128MB      11.86    3.16   3.75x    2.95   4.02x
>   192MB      17.18    4.72   3.64x    4.45   3.86x
>   256MB      22.89    6.29   3.64x    5.87   3.90x
>   512MB      45.15   12.52   3.61x   11.64   3.88x
>   1024MB     89.16   24.75   3.60x   23.12   3.86x
>
> x86 (Intel Core i7-14700HX, P-cores locked at 2.1GHz with turbo off),
> single process munmap:
>
>   times in ms, speedups over base
>               Base       Patch1         Patch1+2
>   size        time    time speedup    time speedup
>   64MB        2.87    1.50   1.92x    1.14   2.53x
>   128MB       6.00    2.93   2.05x    2.21   2.71x
>   192MB       9.33    4.35   2.15x    3.33   2.80x
>   256MB      12.51    5.78   2.17x    4.38   2.85x
>   512MB      24.96   11.39   2.19x    8.62   2.90x
>   1024MB     50.19   22.78   2.20x   17.05   2.94x
>
> 1-4 process munmap of 256MB each:
>
>   times in ms, speedups over base
>               Base       Patch1        Patch1+2
>   mode        time    time speedup   time speedup
>   1p         13.18    5.78   2.28x   4.35   3.03x
>   2p         25.83   14.41   1.79x   4.57   5.65x
>   3p         35.70   22.14   1.61x   4.68   7.63x
>   4p         44.25   28.71   1.54x   4.75   9.31x

The numbers look nice, but I think it's a given that if we measure the
process whose work is offloaded, we'll see a speedup.

But would this come at a cost?

1. Would memory freeing be slowed down? Could you compare the host
memory usage over this period of time etc.? Hopefully the parallelism
would cancel out the extra overhead of setting up the work offloading.

2. Would this introduce isolation issues, especially when this work is
not properly accounted? Say you have a busy-ish host, with multiple
tenants. One of them is killed. With this new mechanism, would this
affect the performance of other tenants? (for e.g if we need more
cycles for the async overhead, or if memory is released slower overall
as stated above, etc.)

Some more benchmarking to show this would be nice!

Another thing I wonder is, how much of this slowed down is because of
zsmalloc's own inefficiency, and how much is because we just have a
larger logical footprint because compressing memory allows us to
allocate more. If it's the former, we should dedicate more time
towards improving zsmalloc. If it's the latter (or if fixing zsmalloc
is just not possible) then yeah maybe parallelism/work offloading is
the answer. An interesting setup would be, turning of zsmalloc, but
allocate just as much memory (logically-speaking), then kill the
process and sees if you observe the same slow down.
