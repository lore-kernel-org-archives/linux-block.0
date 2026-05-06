Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4441F4611C6
	for <linux-block@vger.kernel.org>; Wed,  6 May 2026 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075727; cv=pass; b=iKY9Zb2tmzCpxSUf2VxkzpsKvdgzp/nH5DMAvRyqLpJGCBSYBopkHNysY/Di9bK0e/W4EUf08DsLIsa8A7EVBGGkf2KKYbbC3bPdCDjGnEXzbD/Kn8xaIg3Y8TDgLkxdylYfoPLebcvDtkDmWa7g5BbUWaT+Q0ryq5jgObI9FOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075727; c=relaxed/simple;
	bh=2KP3Gj9aAfmR1sfpaUt/E/mXu4yFOIappvpZCpTNm+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LcVRifFBHjFX+A5pBXkPvkY29owm+6qxPqMcLcxu0GjWB5e76l2YOBPyHhHGXZzY5uTXZrZNpXjeAFokL6kNeEcnTGfBcFDTfD750+U3oAqDl8bMMD6QTaBMFLDatV7dhXScImZTbm7aDkx8hSdT8fb0kKfSlX8vKYFeQD6E6xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bxV7LGu1; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxV7LGu1"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bd5dde63dbso66576157b3.3
        for <linux-block@vger.kernel.org>; Wed, 06 May 2026 06:55:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778075725; cv=none;
        d=google.com; s=arc-20240605;
        b=Mzv8Gvz7io03SXQEEe5dlisHcdBQzPhBYI3gD23AS6Mg8ivBiDMLG5WCUZi8vprZ+Y
         hF5KnevMJ7+6ZPVAeW51ACVHaRgXYHRpXvHUcvtQr5IcV3GISVnt7PfqCyl7oMT5BIh+
         ezhyfSrxHV/+dTLzZY+kXch/B+bfygXs/REEbVF5r7b+LlqivsA1Xh5yv+mkcpYBsOZb
         J7iLHv7Ge7xt8qwjJbELeB6hNHn7gTBRWvt1i0Q1fwmvhnUCpxlFpoAUhilxWGRtk6eE
         0ZQtuvZr0FnC9rrslCWJlKRA1T399qJR7cU/Z4ODN3xYtU4eZL3uQmc8AkIIzaz2BfsS
         VeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aNRy0S6L3YSzMl7VPrdeXJU725FCyYdB61hcQ1UpLhI=;
        fh=ghioexF/rKMvoNMd/Mjc/MwsmP6jgMEDWcy3lKX3aG4=;
        b=U9JCc2Kto8dRtat2/iBJ4wVrdXezOJ/YdgVqawEvoJxSG2KUo4nW6sRsiJu0ymJ23U
         df9+V9nl3OTlToqp9lKdPWLz6M+SGCc6Htv1SioMcQKek2IyfSxogLup85B2c0KCPtIi
         SKgpUjfcPG6xTKTvlkHjsi/9pnWQQYf3SrQp9E/JSbEsfLCbwtWFFZy6thlU5nHJbtar
         xbeHArOXyGKt9xWrUhnnfzZMOm8GFlJo+7wXHKO4dKeqmHAQQYyapLEuFCzZEV4Hbn4w
         bRpipHNI1s6VHVKIAjpMD3TKVOFORunlNPY8N/X92bB9dIgClkI0v2T34WeyhfTKp/63
         y5RQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778075725; x=1778680525; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNRy0S6L3YSzMl7VPrdeXJU725FCyYdB61hcQ1UpLhI=;
        b=bxV7LGu1fI7cQSnMW5vL8lZW9TeJrT6Qde6oM7aSYLppHdfIxsnntwwnh6bbAyNYGi
         Vtl2nXxJlAwtmqYWRt8bMl9OOCS4mWoKPHUKs48/Qar74xMZU0DQraEwqpHOQYmcg4cG
         17m7H6aOuaCCdrdXsYmf4NnaUa9o9iJKSuHq6TlnHZvgWHuhYq9XOY1zbqJZOtwTKwbn
         zkEwyXhfQzKfbrcWhC0ZH4FceGtZLE50diiCZtXIIcG3VaKNWz8ArWi2mwdowwj4OJKa
         NW5AyhH48l00gZgP+0BbSpExrAaOOhezYZSMWBP4p3E8XfZoivip2+37Qxooj/eTYxQ+
         5Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075725; x=1778680525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aNRy0S6L3YSzMl7VPrdeXJU725FCyYdB61hcQ1UpLhI=;
        b=iR9T60GDxxtVfRIdHxMWw50CCQbz3Epny2U8iIpXnI5+p1aDx3icR3RThd/So4Bsgx
         VwF0fqj1qrNu8xcN+khfBPBFYMEj6X2yEhCi/u0RVv+R7kla5reQb6kQ+UtkCM6hQNSm
         K3JebX/0osQezN4HMZKaOhevedLSOyh8FKTGnhgwCcBY1kasj2pTQN13HlFyLWAOgoFF
         K0xqwdDJUT/ZQ8S2c9iJKarD5DZrf5kjyCCuW3VbtDaqx0KlU+GuZ0Hso436OMe2bLjX
         4blS9rjeOLw5rSRV22pDUDRsBGa8JlkzC/mnG6enFnociJoFhuhgUangLNPSmdqfznyW
         KsXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+g0a3MVfOvNiM+6XKQ23JDXLb0LqF+bbWhkH6PknwrvVWn9ZWFcXJaN3bGx/StQvaquRYxs0iYyvSk2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyobvJeMGVJfWl3PRIRACI5COd2xkOTmD6X9UrRPZ3EeO8nKYxm
	PhizWfXldl7OLV6K5s1Ohvi+iiYm5hSUFDZDS4RTktk5fVNEnfceSLl9kLqQ7de2qhAgAZRg1Dn
	7tljxC3VKEIHanDO9wWPmJ7i4s72NyE8=
X-Gm-Gg: AeBDievdJjR4KAZfhKyxt1KLc0Y0EVHJhtd82tnLKQTypgU+lt1KWPUjWZZOYycv8ox
	vK9eOXzCe/ml/PclK1L7pUaPGdEdkowogkBfLGVZLcEnkbUfgPB39soveX6NT1QNSNHS58LMnuI
	XOTA85G/r3B42jX9Xi3WQWlzEvnGMx1FsXY9aFSc/17uxKR/2pDCMbkq8msfqtRWi2NBIlZDPsn
	jjZ2F+g4K0+NsbDPZdLV6HO8fr0ICUJyU64D78svMUz31K6hlJLZ8UsLmN3bqjGOmFp5tRELA+A
	WLz4kW+I0mcu4aRYtaj+PG+hqtgyPg==
X-Received: by 2002:a05:690c:f06:b0:7bd:9ce7:164c with SMTP id
 00721157ae682-7bdf5ef293amr42572997b3.43.1778075725139; Wed, 06 May 2026
 06:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
 <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
 <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com> <CAKEwX=PrfrNys4ao7-d11J7r4pv5VmE8gTU_7iUHaHAKNaFuBQ@mail.gmail.com>
In-Reply-To: <CAKEwX=PrfrNys4ao7-d11J7r4pv5VmE8gTU_7iUHaHAKNaFuBQ@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Wed, 6 May 2026 21:55:14 +0800
X-Gm-Features: AVHnY4LF3aWQo3HGLZrYMNvLGHmAQYHlyMw97GRdhJ_YEuxrndl8XeHVPrQ1D64
Message-ID: <CAOptpSOnRCHo35KK5x3S0f5y9+7+dxfznpjNRH072jZvhYHwww@mail.gmail.com>
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

On Sat, May 2, 2026 at 3:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
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
>
> Oh man, you are eliminating pool lock here right? This would help my
> other patch series a lot too :)
>
> https://lore.kernel.org/all/CAKEwX=3DM5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWodwbf=
1Fe=3Dgzew@mail.gmail.com/
> https://lore.kernel.org/all/CAKEwX=3DPkFiP+u+ThrzjTKBi+usQf2uuhTZcfB2BNNA=
8RboOFDQ@mail.gmail.com/
>

Yes, exactly. With class_idx encoded in the obj value,
zs_free() can determine the correct size_class without
any pool-level lock. The lockless read gives a valid
class_idx because it's invariant across migration (only
PFN changes), and we re-read obj under class->lock to
get a stable PFN.

> Well, the deferred freeing would completely move that contention out
> of the way lol. But this would benefit all users, regardless of
> whether we're deferring the free step or not (for instance, this will
> reduce contention between page fault and compaction, IIUC?) I feel
> like you'll get some good numbers testing in a system with compaction
> and THP enabled, with lots of swap activities. Which is... a lot of
> server setup :)
>
> If the deferred freeing is too controversial, this smells like
> something that should be upstreamed independently.
>

Agreed. We're planning to split the series so that the
class_idx encoding + pool->lock elimination can be
reviewed and merged independently of the deferred free
framework. It's a pure win with no behavioral change
=E2=80=94 just less lock contention.

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
>
> /*
> * The pool->lock protects the race with zpage's migration
> * so it's safe to get the page from handle.
> */
> read_lock(&pool->lock);
> obj =3D handle_to_obj(handle);
> obj_to_zpdesc(obj, &f_zpdesc);
> zspage =3D get_zspage(f_zpdesc);
> class =3D zspage_class(pool, zspage);
> spin_lock(&class->lock);
> read_unlock(&pool->lock);
>
> It's basically just this blob right?
>

Yes, that's the blob being replaced. On the
ZS_OBJ_CLASS_IDX path (64-bit systems), it becomes:

    obj =3D handle_to_obj(handle);
    class =3D pool->size_class[obj_to_class_idx(obj)];
    spin_lock(&class->lock);
    obj =3D handle_to_obj(handle); /* re-read for stable PFN */

No pool->lock at all. We've also added compile-time
gating (#if BITS_PER_LONG >=3D 64) since 32-bit systems
lack the spare bits in OBJ_INDEX to fit class_idx. On
32-bit, it falls back to the original pool->lock path.

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
> +1 :)
