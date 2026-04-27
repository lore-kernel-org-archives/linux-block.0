Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914D3537FF
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 03:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777259442; cv=pass; b=O33rGKLJW2aIHEqF/T1lJ274OKyk7gK/yDmpuEzsLykl4t3LQewe0wQTHIQvzni2zSX14Fyf8Gt1k3UkI547WfiMKo6zdybngEzWIndHjlhvrhk0sLCzWaSFZYGXcP/Rcc8XUukKMjV4+HETPRPp3C9Ze7D9MEXT5fM9ZLuWwcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777259442; c=relaxed/simple;
	bh=43r7dyf/5ZOnv+WKFbZLwQcqidntdpaAWj56m6AbFSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+4Z3Mnh+7I0HzjTWOun/Z8PVpwMMG8GYnTrMGgNHEvxh98rokGS92P7Rs4g/31n9n4ft1o4ljqNZHbfFepd3rHenKN4axs/lOdHYJRKDowEXALLB40NPB3ynnzrYZZndQR29Pi2edlJiORZhMCAqLvjhEL/cceWv8nQz54g8ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+D8XwGi; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+D8XwGi"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651b4d09141so12796648d50.1
        for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 20:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777259440; cv=none;
        d=google.com; s=arc-20240605;
        b=cdOGfbPVuOSvqRyJ3cQmhb7e2vKZXo7zTVP+jZ7YWK4jepP046tVkf2MKTc7RILDoL
         aYZah/zBk0OE7KBP9RxEl/bogvLBvUVjFZZk6sSuLQ9ZsVwm/T7FL+MNf7261OxImrbJ
         P0ESkVrwcPhJWlPRoVUcZVWrFPfHEbeoUsvTKow/b8f5oKgrMTXRGS4ZhnUUuPhe0NTm
         Ah6Gl21gudqt+nsJXnA1PmLaoFN77tSm2eys91nv2OiEDbZHXEkG//q4RyrHr0Ya4vi4
         6HheuF/N1MU1U0ksErbNhWRbREIZsi33PBkZxnBDIIUNPAgT8s3PFanld2yogRGBTP6z
         ZUhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KM+OtwEwd97Lcv7g7hL+Q7aqQp8IkPF4SNqpVzFRcpI=;
        fh=XVptzmOyni2zu6EbqEJTPrFWC0L2CecqcZ+PejoJVTU=;
        b=Ff96OdLq76KoL8yCqcUMP++FOM/vzthBOoDGDeiUHqVO9Nutiu+MdRC7nR0XIUZ0EZ
         m1DVmj8g6RuRVr+12sCThiLwE/v0oDG24DrNtRJQL8SDsbGv3TDvBpLZWsg543esRSqW
         uhz6oYfHA+zF19F8WDFADCJhHkAk6u9oEyBufTtLlkZodmbmah8gncF6waTgZ/DHoWT2
         K6VA5nlL2ETEWBg2JSgY2ZKGZFZozbPbAnZwIGZbuEyr9QmuoZ+4vczkMJPkNGCIUTBw
         5fUR/E+F4AUKMv/N1mLFicF7AbjIZBKvrCBm0Dn71cmBzgCfSMh7HoqiZlRmNzVfALV5
         9UjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777259440; x=1777864240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KM+OtwEwd97Lcv7g7hL+Q7aqQp8IkPF4SNqpVzFRcpI=;
        b=i+D8XwGi0fw8K3yX7XojwbudhWvuKqITgMwVvvu3+NxNydK+umhe4+mtXOcZ8xY34g
         AYqD3v2UGq6mzhAcf347QoAiLPw70Poggfq3wVjr8REVPOoc5cIgQ49AdcYlrWQQIvgW
         c6LIzk2v6vV5x2dh4n+HRT/n9j0YNXHyvVPhv1loE61LDLvLooR/C/7NttFTLxZouLbD
         f8+7qNz82NtMm2mZuTuRYFe3jjJgN14CXbFi8D8hfGLaG5yRxVYEP6axFZDCYJV4Be5y
         fC2m9AAP2FpWpCmfvymOVXvTkRAa/fqqe5KGCygSpCiC+hwWhbVA2YYMkjHXLWZ+Z/RA
         08Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777259440; x=1777864240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KM+OtwEwd97Lcv7g7hL+Q7aqQp8IkPF4SNqpVzFRcpI=;
        b=CDEdwTghEyuEtDWRpqYqfOfd+zc8Zl1FaeT2AGW5Cfx4GS1T0xBEkraxVDtdG4sWj4
         IrrVKPiyIbgXW1e++5mVhq6zqyR6/P5mbN0RWN+65ZQx9FufOlgHjrmH7CIUPkDg60WY
         0Wmd58h54sXEPRfUWkLTXskvXks5zqI2ZBio53uXofj8GjX4Pbjw1ilKZZDY0NMZqWb4
         xP+Uh5OJoJR3iw7SEz7kMKJE2vSKVrld4aL4/QOmuroZhzgWsvzYc7KODhVrtfmbEVSZ
         272OovFUf9bCkQU7D5hUz2TBzEuvtG/TP/AjjJQq8jZ9Nh6hJr3s/aV+nHYEc74eiNG8
         fTjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bDCrLhE+ofH3az6VNx3NaW/Sxhc7nVBXKd4fVVqDvzbyaUFMvFrYgM0Rkdwdxxvurw4HbQ1x4wiRxhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyowNcphxLkns6ZU1/NI8x289QGteOYLaHwW0UzOUsbxJ+TRnNY
	v9cIwG6S8lPm54BN6LNtE5vCkzuzFw5owyKTNqBTq5cpaPIaNasiLu3AICVQ3jAEvEFL0S/exBn
	zyyFvjTHBmW/PeWlCV7ysWfvoYDnIfl4=
X-Gm-Gg: AeBDietvKsRdBmBGfC3EhswkoCrC7We7P+YH+sHdt9iRjMGGilXIucToXBTFBdWMgHP
	g5eMXHupqzKxrLBrErOi72Woz5U/UbH8MqIetpFUjfputVMeaQcV25DziTPb53P+6oFDfQZx+Cq
	PdsrxZHf1Y2/08fmRJxEIWoiw46jilE9V3OKO9zlZpCEJTiEanrIrq09Yc8nYSwIrtKmQcaN3Kc
	xknBmzdbkqHKbstsz0Q0kD9TviAl6OD5uchwbKctFqRT1o9YqWede14HuAJ9KRPnmQVIEovNbu6
	ojrAMighxsIJ9NEW3eg=
X-Received: by 2002:a05:690e:b81:b0:651:c221:9649 with SMTP id
 956f58d0204a3-65311aa1c92mr26554121d50.19.1777259439835; Sun, 26 Apr 2026
 20:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
 <20260426085017.166935-1-xueyuan.chen21@gmail.com>
In-Reply-To: <20260426085017.166935-1-xueyuan.chen21@gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Mon, 27 Apr 2026 11:10:28 +0800
X-Gm-Features: AQROBzB9YuhfVPY5XmYPGQmtYvK6q1PqYnlzHDncpFTPb3tZG54wX9J7FqwHpiI
Message-ID: <CAOptpSNgA74W4SL-AEJNk4UVrabvaP58cs25qwYa+N-6C9OVEg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev, axboe@kernel.dk, 
	hannes@cmpxchg.org, minchan@kernel.org, nphamcs@gmail.com, 
	senozhatsky@chromium.org, yosry@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, baohua@kernel.org, 
	haowenchao@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 4:50=E2=80=AFPM Xueyuan Chen <xueyuan.chen21@gmail.=
com> wrote:
>
>
> On Sun, Apr 26, 2026 at 12:13:02PM +0800, Wenchao Hao wrote:
>
> [...]
>
> >2. Per-cpu deferred free with lockless buffer swap
> >
> >Defer zs_free() to per-cpu dynamically-allocated buffers (~2048 entries)=
.
> >Enqueue: one array write + WRITE_ONCE under preempt_disable =E2=80=94 no=
 lock,
> >no atomic. When buffers full, schedule a drain worker; overflow falls ba=
ck
> >to sync zs_free().
> >
> >Drain: allocate a fresh buffer, swap it in, reset count. Since
> >the producer stops writing at count=3D=3DSIZE, the handoff is
> >race-free without any lock.
> >
> >Pseudo-code:
> >
> >    /* enqueue - hot path */
> >    def =3D get_cpu_ptr(pool->deferred);
> >    if (def->count < SIZE) {
> >        def->handles[def->count] =3D handle;
> >        WRITE_ONCE(def->count, def->count + 1);
> >        if (def->count =3D=3D SIZE)
> >            schedule_work(&pool->drain_work);
> >    } else {
> >        zs_free(pool, handle);  /* fallback */
> >    }
> >    put_cpu_ptr(pool->deferred);
> >
> >    /* drain - worker */
> >    for_each_possible_cpu(cpu) {
> >        def =3D per_cpu_ptr(pool->deferred, cpu);
> >        if (def->count < SIZE)
> >            continue;
> >        new_buf =3D kvmalloc_array(SIZE, sizeof(long));
> >        old_buf =3D def->handles;
> >        old_count =3D def->count;
> >        def->handles =3D new_buf;
> >        WRITE_ONCE(def->count, 0);
> >        /* now drain old_buf[0..old_count-1] */
> >        ...
> >        kvfree(old_buf);
> >    }
> >
>
> Hi Wenchao,
>
> I suspect there is a memory ordering issue here:
>
> def->handles =3D new_buf;
> WRITE_ONCE(def->count, 0);
>
> Since there are no explicit memory barriers, we cannot guarantee the
> order of these stores. If def->count is cleared to 0 first, an enqueue
> might end up operating on the old_buf.
>
> This race condition is more likely to be triggered when the size is
> smaller. Perhaps we should consider using smp_store_release() to enforce
> the ordering?
>

Hi Xueyuan,

Good catch! You are right =E2=80=94 there is a memory ordering issue betwee=
n
the handles pointer swap and the count reset.

I'll fix this in the next version by using smp_store_release() /
smp_load_acquire() pairs:

    /* drain - worker */
    def->handles =3D new_buf;
    smp_store_release(&def->count, 0);

    /* enqueue - producer */
    count =3D smp_load_acquire(&def->count);
    if (count < SIZE) {
        def->handles[count] =3D handle;
        smp_store_release(&def->count, count + 1);
    }

This ensures the producer always observes the new handles pointer
before it sees count reset to 0. Will include this fix when posting
the formal patch series.

Thanks,
Wenchao

> Thanks
> Xueyuan
