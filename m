Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C183E4C81
	for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384309; cv=pass; b=D8mHhB1O8LZeopg0ymZydPlDOfw49Yrwa9GTsTp/Z+XpU+1BaU72n8C57YarubrQoDvz17cOxO3Pfv04JD//lzMjEY1MUIy8ocTq5Cv8nwTM/tilk7k7vtNxSghuZajRrez6ZSKTFiDX+XMKj0UAkcDVQxAZyRBKA9GxZUX619M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384309; c=relaxed/simple;
	bh=T+msG+LsEess7L/aN4Vd1t+Eu7+AaJaHhWmW4Z2ybnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjS2LRYWMg0BonFsChn4JBhEVKwvxQ6sTC0NJX+8ii93+m/yfoHdijCRmqZKt7lny5LMOelJQxHjR9QS77qCMy7HWNz5gYA/Ts+wGfeg5LVs/jUbox+2mx9xx8Mv77ctl36xhU+Dd6nUZIfoVlApYUYEBFM3bVuv17cLD9weCmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UljV+jM5; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UljV+jM5"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fc4425b6bso115100067b3.1
        for <linux-block@vger.kernel.org>; Tue, 28 Apr 2026 06:51:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384307; cv=none;
        d=google.com; s=arc-20240605;
        b=K5EJEV+l9qXQ5stNNqLPI9IktkUZY0/dganN0XM4OE5+fapoUz70RKrtji9ZSs7yVm
         6G1gQ8S6TbrOJjmm1IGvC8gQAeay0+gQKZFbL0cIiY2gk+Bpk0YLSWz+QWlkBMTHjdrW
         SamEnIez6pIZJYWquGKHytAqRxhR1XVsMeEQJNCVRPLgTvIkJ/GMimJ8YtawW9wZx/J4
         WBOyAhEYM9R1BlfMh65wVdzIZ8kK2i4lrM72bJ3jWtBtU5nwkeKjnqa/Ov8R9sozpgtz
         YznKmYZHzpY1kpiZ8hCJ5GQUfokDKVQ1HXrjm5bqv7o+9gl+V8rHjV0UPSD5wAWFfJ8w
         Mpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IT9jA57kngE+X3yajSLSMobQf0P1+rq/CPccLhdmIvE=;
        fh=uD5QEnVTK3P9f6p9wHEOISTnl2v+2mE4mlBry1WgoBU=;
        b=J0R4iHNe5XxP3/4f/NNZDnxbh4YTjdgiDFycihulaFW2i4m3Q7eSTNABuNdA4LCbmV
         GNfIJGKGN5hXHCo8f+d2664Du0Xn+Uj3NTaSAArlEKh6br8iqZpGKPkcg0WjeG+3VyfL
         Oi/VaFytqg4kNticfSUrad41TcbO5NL9ngl1wZvWFA90fyMOlTe1385xgoofc4TJBFkn
         ZZUX+Z/OYYaYMTNdnNnRxX03fh6Jnhc8JHpoEkq2on667YaYAY1/7UQeAuC0itAO8YSe
         sP0NV6T9GGFWZT721C08TlBkq24gSxCVoqgFD4hEzB5V5/BzjeoOMLIlgXuYCT8+vjhT
         I+eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777384307; x=1777989107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IT9jA57kngE+X3yajSLSMobQf0P1+rq/CPccLhdmIvE=;
        b=UljV+jM5NUepUkbFswm35Q+7owLj/Lx9gQ6krZdVXxisYZFIMdRjRO+GOoapUfWSjR
         KjF+24Dq6SVJOfcp6aMjnBlIzVI9O7sgTSqzZvcg94OTFI7bVkRGHtrTpco7GyRqwS/7
         oGPfGzRMBvMtBcfFsBAWcFf5SNFvGYO3Wx1YBdGzt4Ge7hHf5jmcCy/IiL8AZqZSjboD
         du90cEXktDJ/9eKvoxn/FBjjqWBxIsKh0+AN3ImOM1qnttryCQ77l87EaOoLDHs6TpBA
         79Q0bVeJ9uXqk0Ot1khQrgZByAQReCzzDD4oNIaK84ZPTuFYT2yTwrVqBQqE3IauIKVP
         8G7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777384307; x=1777989107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IT9jA57kngE+X3yajSLSMobQf0P1+rq/CPccLhdmIvE=;
        b=sR8wvu0yeWSL9MHxf9IOs5RCaiEDLOjUYgl5VCHv7+5bLJGkZVSKF4zAN9T97QhndZ
         QxOdJHKbUZdRrQGqhvAG0P+ev1XaVNeP/S9efuGOX2rcP3KEQE8v8GF+30d0ycaO732P
         skzCXbWdXRmJpeaS6KzWeUh84rNnYncjR64acoqGqOvtHQZHdLUoAR8enSfCJrq9h6/X
         ex7k+3lRhgJOmFeQN77TQ2mYzT1z3ayAJUdPyeONDmdo9dAzlYWPe008iIAqo7rdW3+Q
         lBblzttpTffuR4mHAGxIPppMxEkvNEGu+xwfdMthYALLoJ0cJaO7hdBzVfRNxNCOCzDJ
         Hgow==
X-Forwarded-Encrypted: i=1; AFNElJ8E8a3t9+qbY1N/KSXzSe2AjPM2M+tXmxjSoAAIjtx5HbCu/kxagbxGAOBOVJ6J9qUgs6cXTWU06q/I3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBTS4gBkKij00EOlVw6d5sXqhCHV9LfwpU6aKwXoMfqnlDEByV
	A1gEXMrxnv2bYDFqq2Lg84EpKNl6pleFB8vzY7CR/PROJ5HZwZ2fwoI3OIgDEEk9SPxx7EXkbS6
	f7fpptsVXg8bZmHzuwJyo8xRLFBuEaLg=
X-Gm-Gg: AeBDiet2RKSx5tRelxsC0MFmhO6yIPPwqIduISoeuEQg0MkLPV8JOQnqOl6ZwZu4eUv
	Pyb5gi4MO3ZORceXy3KJ8z4nvS1b153dgvUnWEysgmZQ26ORrZcXnk5FIL7uuyLAUy17eEiTxG0
	2XQxf7cHsuai65S6azbmRasjCazP9fWw3bndyLjwKDvmIATovgw8ttxmInMyqkirn+BqdcBaalw
	Kj9u7bUEKUgaAxw0eWJGEmEcyPoKrmrveo4YRA6kUveUIZM1nCPoOjHE6bCHx+02+ArRzarBde8
	fBHl6+/wDJaVIaHJLGgnXa245xLEUg==
X-Received: by 2002:a05:690c:ec7:b0:7ba:f129:3770 with SMTP id
 00721157ae682-7bcf50d140cmr28884857b3.5.1777384307109; Tue, 28 Apr 2026
 06:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com> <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
In-Reply-To: <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Tue, 28 Apr 2026 21:51:35 +0800
X-Gm-Features: AVHnY4KQE_Mj9gpvMzdnnS_asaY09442_U9fmG6eXMks5pomkHazCuttZ-HneD4
Message-ID: <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com>
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

On Tue, Apr 28, 2026 at 2:17=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Sat, Apr 25, 2026 at 9:13=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.c=
om> wrote:
> >
> > On Tue, Apr 21, 2026 at 8:16=E2=80=AFPM Wenchao Hao <haowenchao22@gmail=
.com> wrote:
> > >
> > > Swap freeing can be expensive when unmapping a VMA containing
> > > many swap entries. This has been reported to significantly
> > > delay memory reclamation during Android's low-memory killing,
> > > especially when multiple processes are terminated to free
> > > memory, with slot_free() accounting for more than 80% of
> > > the total cost of freeing swap entries.
> > >
> > > Two earlier attempts by Lei and Zhiguo added a new thread in the mm c=
ore
> > > to asynchronously collect and free swap entries [1][2], but the
> > > design itself is fairly complex.
> > >
> > Hi Nhat, Kairui, Barry, Xueyuan,
> >
> > Thanks for the review. I agree with the direction and have some ideas f=
or
> > an alternative approach.
> >
> > My approach: first eliminate pool->lock from zs_free() itself, then def=
er
> > free to per-cpu buffers with a lockless handoff, and finally reduce
> > class->lock overhead during drain by exploiting natural class locality.
> > Achieving both per-cpu and per-class is difficult, so the class->lock
> > optimization is a compromise =E2=80=94 but one that works well in pract=
ice.
> >
> > 1. Encode class_idx in obj to eliminate pool->lock
> >
> > OBJ_INDEX_BITS is over-provisioned on 64-bit. For example on arm64
> > (chain_size=3D8): OBJ_INDEX_BITS=3D24 but only 10 bits are actually nee=
ded
> > for obj_idx, leaving 14 spare bits.
> > We can split OBJ_INDEX into class_idx + obj_idx:
> >
> >     obj: [PFN | class_idx (OBJ_CLASS_BITS) | obj_idx (OBJ_IDX_BITS)]
> >
> > OBJ_CLASS_BITS is computed dynamically as `ilog2(ZS_SIZE_CLASSES - 1) +=
 1`
> > (8 bits for 4K pages, 9 for 64K).
> > Since class_idx is invariant across migration (only PFN changes), zs_fr=
ee()
> > can extract class_idx locklessly, then acquire class->lock and re-read =
obj for a
> > stable PFN. No pool->lock needed.
>
> How much of the benefit do we get with just these locking improvements
> without having to defer any of the freeing work?
>

Hi Yosry,

Thanks for the review. Great question =E2=80=94 we tested exactly this.

With only the class_idx-in-obj encoding (eliminating pool->lock from
zs_free, no deferred freeing), we measured on two platforms.

Test: each process independently mmap 256MB, write data, madvise
MADV_PAGEOUT to swap out via zram (lzo-rle), then concurrent munmap.

Raspberry Pi 4B (4-core ARM64 Cortex-A72):

  mode        Base       ClassIdx-only   Speedup
  single      59.0ms     56.0ms          1.05x
  multi 2p    94.6ms     66.7ms          1.42x
  multi 4p    202.9ms    110.6ms         1.83x

x86 physical machine (4-core Intel i7-12700, 2 rounds averaged):

  mode        Base       ClassIdx-only   Speedup
  single      11.7ms     9.8ms           1.19x
  multi 2p    24.1ms     17.2ms          1.40x
  multi 4p    63.0ms     45.3ms          1.39x

Single-process shows modest improvement. With multiple processes,
each read_lock/read_unlock atomically modifies the shared rwlock
reader count, and the cost of these atomic operations increases
with more CPUs accessing the same cacheline concurrently.
Eliminating pool->lock removes this overhead entirely.

This only works on 64-bit systems where OBJ_INDEX_BITS has enough
spare bits to fit class_idx. 32-bit systems don't have the room.
I'm still working on the compile-time gating to properly enable
this based on architecture and page size configuration.

> As others have pointed out, I don't want to just defer expensive work
> without understanding why it's expensive and running into limitations
> about why it cannot be improved without deferring.

For the deferred freeing part: the class_idx-in-obj optimization
addresses the multi-process scenario where concurrent atomic
operations on pool->lock become expensive, but does not help
single-process munmap. Deferred freeing moves the entire zs_free
cost (including class->lock and zspage freeing) off the munmap
hot path, which benefits even single-process workloads. The two
optimizations are complementary.

Thanks,
Wenchao
