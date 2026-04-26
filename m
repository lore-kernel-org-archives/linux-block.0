Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E589246BBA
	for <linux-block@vger.kernel.org>; Sun, 26 Apr 2026 04:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777176796; cv=pass; b=gQE/EMD1JmA9QAWowxwcwIuL/QGqyQw8cyF89nOMPhxSPTlua4lUHn1jmnzyGQWr6V1m+GO4avPf8mKtS+5M35gGL41xqGjfjhS5ug8sO1wdGMUy60xZNX2bn2PnhkhqK1pLAst6awNZ3OAOfwgCEyDAUgqpzzEqBj4VqgEYTQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777176796; c=relaxed/simple;
	bh=oxF3GEijWYUqiZkrWDx8oNS6coXkcxcRKD9/JxF1x10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcN9O/rlGwwjF7Uh50qaZZE0KTizfavF+FvuF8BONJ08D3yWsQrmlIsRH+UoSEYiskAuqqGj4MlkjlPRq9O9kIn90xCAQ9/UGXsXI2Y1pXyFxN8mPiLIYQga5jBE7H6QloYD3xWdNRhFOTaCLmca11lKNo15DIy+ZbdmydDB7to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l05+sefF; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l05+sefF"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-656d749109cso855301d50.3
        for <linux-block@vger.kernel.org>; Sat, 25 Apr 2026 21:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777176794; cv=none;
        d=google.com; s=arc-20240605;
        b=B+qrq873p5nJNKPE5EvbEqsIWkmGeZTtblN5t6AoE13O11Q57VH2m4tkN/5V2YgwmU
         PAKm+JL1JyRpyuz7yjtXZHaI8eTVKbu0GLP/4IdgvrnX/mND8ZVtrY6p6MWkXHIZWE1K
         oO4dv0q2xwoORwmJ6Ik8F68rSj7LohhsMqyk94CE8vdQQ6gkp8W/iCr4gZd0RkNUtO5j
         EVRj5CFWzU7DoDGZGVK1OzdhVhNAb13tMTHbqIORD3tjPWuDVSK5Q1H7vyZzu+R67Yq3
         YzMy+ytbC4s3/cjVcbJEStm8rtbJTu85helKDrJUqDHlBjo7FGQMdFQmgRxkegObKMKf
         NIZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1EJqe3X+xATXaKTJE8qE0IWMxPmt1lGZbCXxHX7SCDg=;
        fh=GRcNiliDhARTQZrdhRWdOo4waLnCzhlX2731rWsAqiA=;
        b=ILaEF6jpM6LAsV0cWRMgwSCrJExIVxUdLJnzL0sceu9qMfEbudiOsXBfeAKOyJ9K8v
         8adgn/8RY6JdFcVBupWbsEghPDUts7Khb/2yvOnNQk9xxjzVw3g1Gj3aoqFTT254/ZYg
         N8K7W6q4HNjsV5Rkz1h5QZM62PUdFyxzgQ0XMxt9hvXxga7DPgFF7wAPAD3kgMBALaem
         Hc8UToy2OORgRIq2T5YmuRetmxFawsdktaO3z4GUkUNUf5Oa0LkIW0JjwFHi5vZhAVNY
         Wlbfwfn5UamP3XPFHgE9fFw8mTP4xuaUXqJWWG+EngH15+mlZb3teWEVoiMUA68qywN4
         UmTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777176794; x=1777781594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EJqe3X+xATXaKTJE8qE0IWMxPmt1lGZbCXxHX7SCDg=;
        b=l05+sefFi6Eqh4wZPVV4oklpCAI/3nSAv2/6UXNEmmG+o8+rYkRC4x60CJB4Tl9bx9
         xDnzDsH839kL6BCvC98YCbTqIoiArpe6wcCK8uKEMi8vHzKIvOJgiFMxwB16hPq7wPti
         3dGAOKGARwZP0jhkmYynilU1FsRdJIbp7XRxekuW9HQXs3RA1DYxUSSW5dCEE33znVy8
         r6q6C17vlKFC3T/o49uc4nMKCLnuqSvKHeS3oFX3zQTLcC5VizYogI/i9hk+1NxtEh39
         uOhu35kj+/vmSyDJEImvI/TnME9g1H8AONsHJOkjINMLiRCZistk9TCOB5MZVMo46scd
         dsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777176794; x=1777781594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EJqe3X+xATXaKTJE8qE0IWMxPmt1lGZbCXxHX7SCDg=;
        b=Tdq7HvWHORjNFN1ED71W/3cPhG0mQyAH/3DUZuPWBftYavLdcQceA4ypItLvDRFnbq
         D4X6x0XI7BgpUKR9RIiOq3DMHb2XXEHFMql9OgrPe4n7XuWLDD0byJp+cEMuT2CqR2Rx
         1Lid3SRuOevIVj5BmjniNd+6R3H15meRsoq55NN7B5sIz5r02mXe2kt83Z1UgG6UgZn/
         90Q2eJrmp7aAGfxkmgEwMOD9aGlXaKxRfn+kHyC9zpWuvS2yuJLhHleQ0KRiJf5nWAVZ
         5yaNvNjWnIkMJrVRAG1VMstnIrHXEk92MaRSU3s3ufXUA5PdL+irTjZZ1vCqLhoK1njd
         rAMw==
X-Forwarded-Encrypted: i=1; AFNElJ8K+oN29RauRsWPm3ASxMh9H1+/uxC4PrRf2z8OSARk0noGeq29OOsW5nxlDBE78YbIbRvxjCCypNHDdw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6jGGILaDQNnNHhcMHZ0n3nZ0IUU12DWma0d0NeIicMkh73EM2
	Vt/hdQWiSrxAxyoP0GSexGebuIYD2OwgUeVu15Ug7S3Nge+viJxcG4mK52JulbBEK56ShWuYOJh
	rohseZ32mFJA9vj1dz2qziHCGRCpXnV4=
X-Gm-Gg: AeBDiet3lZhN1+l2Sv0nb4lHzpnLAMWz8bDCa+WPiMGyeRHW6mxNcJctbYkV5WzSeFV
	LuaJe4uLiyxN4P0VTinLh+MSqPm/hv4koFC7LdQrRyJV10hr5wZ6XtxJ5G2yxwnTzhdGzVz8Olh
	X4PS3FFPlrdTeq2mX1zfcR5t/92b6jiycbjHvLPuhzveR2QyPXL2x/Kx/EjHlcffGuSjHDn1bEB
	Arp6mMtN5ETpA4cvAtpjmGCi+GTMe58W4xVCHPPVPcABXMgk6hcjTvzKjoFjBmqcvoBgT42Cetl
	FiJEkebKuCtxjsMqgjc=
X-Received: by 2002:a05:690e:1913:b0:652:55ec:6a2b with SMTP id
 956f58d0204a3-6531086f9a7mr34230037d50.25.1777176793935; Sat, 25 Apr 2026
 21:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
In-Reply-To: <20260421121616.3298845-1-haowenchao@xiaomi.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Sun, 26 Apr 2026 12:13:02 +0800
X-Gm-Features: AVHnY4LfnBuMlVsaZ1GGaeUCV7InFGaYFFvq_d-yN1xzvXSxJKM8ZAXbAn1QiUo
Message-ID: <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 8:16=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> Swap freeing can be expensive when unmapping a VMA containing
> many swap entries. This has been reported to significantly
> delay memory reclamation during Android's low-memory killing,
> especially when multiple processes are terminated to free
> memory, with slot_free() accounting for more than 80% of
> the total cost of freeing swap entries.
>
> Two earlier attempts by Lei and Zhiguo added a new thread in the mm core
> to asynchronously collect and free swap entries [1][2], but the
> design itself is fairly complex.
>
Hi Nhat, Kairui, Barry, Xueyuan,

Thanks for the review. I agree with the direction and have some ideas for
an alternative approach.

My approach: first eliminate pool->lock from zs_free() itself, then defer
free to per-cpu buffers with a lockless handoff, and finally reduce
class->lock overhead during drain by exploiting natural class locality.
Achieving both per-cpu and per-class is difficult, so the class->lock
optimization is a compromise =E2=80=94 but one that works well in practice.

1. Encode class_idx in obj to eliminate pool->lock

OBJ_INDEX_BITS is over-provisioned on 64-bit. For example on arm64
(chain_size=3D8): OBJ_INDEX_BITS=3D24 but only 10 bits are actually needed
for obj_idx, leaving 14 spare bits.
We can split OBJ_INDEX into class_idx + obj_idx:

    obj: [PFN | class_idx (OBJ_CLASS_BITS) | obj_idx (OBJ_IDX_BITS)]

OBJ_CLASS_BITS is computed dynamically as `ilog2(ZS_SIZE_CLASSES - 1) + 1`
(8 bits for 4K pages, 9 for 64K).
Since class_idx is invariant across migration (only PFN changes), zs_free()
can extract class_idx locklessly, then acquire class->lock and re-read obj =
for a
stable PFN. No pool->lock needed.

2. Per-cpu deferred free with lockless buffer swap

Defer zs_free() to per-cpu dynamically-allocated buffers (~2048 entries).
Enqueue: one array write + WRITE_ONCE under preempt_disable =E2=80=94 no lo=
ck,
no atomic. When buffers full, schedule a drain worker; overflow falls back
to sync zs_free().

Drain: allocate a fresh buffer, swap it in, reset count. Since
the producer stops writing at count=3D=3DSIZE, the handoff is
race-free without any lock.

Pseudo-code:

    /* enqueue - hot path */
    def =3D get_cpu_ptr(pool->deferred);
    if (def->count < SIZE) {
        def->handles[def->count] =3D handle;
        WRITE_ONCE(def->count, def->count + 1);
        if (def->count =3D=3D SIZE)
            schedule_work(&pool->drain_work);
    } else {
        zs_free(pool, handle);  /* fallback */
    }
    put_cpu_ptr(pool->deferred);

    /* drain - worker */
    for_each_possible_cpu(cpu) {
        def =3D per_cpu_ptr(pool->deferred, cpu);
        if (def->count < SIZE)
            continue;
        new_buf =3D kvmalloc_array(SIZE, sizeof(long));
        old_buf =3D def->handles;
        old_count =3D def->count;
        def->handles =3D new_buf;
        WRITE_ONCE(def->count, 0);
        /* now drain old_buf[0..old_count-1] */
        ...
        kvfree(old_buf);
    }

3. Consecutive-class batching during drain

The drain worker extracts class_idx from each handle locklessly, and holds
class->lock across consecutive same-class handles.
On the exit path, compressed sizes tend to cluster, so consecutive handles
naturally share the same class =E2=80=94 giving batch-like lock
amortization without sorting.

Pseudo-code:

    cur_cls =3D -1;
    for (i =3D 0; i < count; i++) {
        obj =3D handle_to_obj(handles[i]);
        cls =3D obj_to_class_idx(obj);
        if (cls !=3D cur_cls) {
            if (cur_cls >=3D 0)
                spin_unlock(&pool->size_class[cur_cls]->lock);
            spin_lock(&pool->size_class[cls]->lock);
            cur_cls =3D cls;
        }
        __zs_free(pool, handles[i]);  /* free under lock */
    }
    if (cur_cls >=3D 0)
        spin_unlock(&pool->size_class[cur_cls]->lock);

---

Benefits over current mainline:
- Removes pool->lock from zs_free() entirely
- Deferred free path is nearly zero-cost
- class->lock is amortized across batches instead of acquired per-handle
- Producer-consumer handoff is fully lockless

I've prototyped this on 64-bit and it works. Still need to sort out
32-bit compatibility and Kconfig gating. Does this direction look reasonabl=
e?

Thanks,
Wenchao
