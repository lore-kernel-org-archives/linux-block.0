Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F394F31E84F
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777313849; cv=none; b=tocTY8MqlIrU7oevKErJTltihquxkJ7AqK/AupgLYL3HkO2oo3DLvi2gp9X3s+OKHCV2nU8uor/2D8xzXHStCkuvTAuleDklqLHibJ7Nnjw+aK8s+XmLjszETLV+3CG3i7INOYhhCgt4T+EU1F1ZOT9xZKz1ITPPOFcBWCXe3Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777313849; c=relaxed/simple;
	bh=FsvLa0WQ+ppWSL2ZBwu07rxJb0VFpJsdirmzSrdOFVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iZQExy9UBpdNIxuKr8vOzpfon+MmVkG1zWKRyZacL3UTZwj32iMU0QHIIJJOrutSMO86QOvg8d3EcMZEoNCvIxeTqSio6jrOwQlkiTnHK3n19w0wVGnK02VCCDNFTP8okLKar82xm8CxPUaN5EARxAE8bAuc+40WpUNPthL6nVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkHTm9+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkHTm9+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948CFC2BCF4
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 18:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777313848;
	bh=FsvLa0WQ+ppWSL2ZBwu07rxJb0VFpJsdirmzSrdOFVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SkHTm9+YjDbbZVDp5ZuhGykXVSnv8mnZhzMp4lRHTlUB6GdE1cRztG6Ni7bdn41Eu
	 f2uVqfgSLTGpvGv83QE4MIao3JMkjfXXVDTxy/6Ort+DBKR721YH12zmBOlF04AnM9
	 UeivVBVFnr7CKqktHdfi9hHlsbHqswZHA8fRmVz1nySVEW02sNBSdCGDiRuPKETIxU
	 Zihezih6dhde/++xQ1ichw+SBu7uXJLxCTBys3OWD88PBx+4f2Ssaq6TU7zS2wnarm
	 n5guPMFIOaAtlLpyZdDXF5+rhmBJzIZS5MvmGifiY5x/qmPP+ISs9SC6oKAVEYgU/U
	 v3PNcft2kMrUw==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b9382e59c0eso676215666b.0
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 11:17:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+SsF0XAaQIrzZcfNumk036KrBwQG189borqKFyNe7YBGskzdeK+l4RUFhBwK+0P2Ractc/dyqnTKgKSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyHkrHCnoACkxIKsz6D8agmCyjf2Q+t/+DxjoCN5/r5nRM9Qc2y
	0YwVhS+phECRRKIH9S/RUfozp1FdUexjnVsJkUBe1ROLNWwawM3Ng1GV/LaKH65DXePOsMR5DN0
	yrA8rsc5/81b5DdJOJ8mqI4i3TgUJ9eA=
X-Received: by 2002:a17:907:6c10:b0:bb2:71a9:37d7 with SMTP id
 a640c23a62f3a-bb7fc6b329amr331966b.39.1777313847341; Mon, 27 Apr 2026
 11:17:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com> <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
In-Reply-To: <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Mon, 27 Apr 2026 11:17:13 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
X-Gm-Features: AVHnY4LkdWo7aosvwMF_0ub38leF0QqpBslIr0st4sctLN5j8Y2EyELEuoMI2nU
Message-ID: <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026 at 9:13=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> On Tue, Apr 21, 2026 at 8:16=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.c=
om> wrote:
> >
> > Swap freeing can be expensive when unmapping a VMA containing
> > many swap entries. This has been reported to significantly
> > delay memory reclamation during Android's low-memory killing,
> > especially when multiple processes are terminated to free
> > memory, with slot_free() accounting for more than 80% of
> > the total cost of freeing swap entries.
> >
> > Two earlier attempts by Lei and Zhiguo added a new thread in the mm cor=
e
> > to asynchronously collect and free swap entries [1][2], but the
> > design itself is fairly complex.
> >
> Hi Nhat, Kairui, Barry, Xueyuan,
>
> Thanks for the review. I agree with the direction and have some ideas for
> an alternative approach.
>
> My approach: first eliminate pool->lock from zs_free() itself, then defer
> free to per-cpu buffers with a lockless handoff, and finally reduce
> class->lock overhead during drain by exploiting natural class locality.
> Achieving both per-cpu and per-class is difficult, so the class->lock
> optimization is a compromise =E2=80=94 but one that works well in practic=
e.
>
> 1. Encode class_idx in obj to eliminate pool->lock
>
> OBJ_INDEX_BITS is over-provisioned on 64-bit. For example on arm64
> (chain_size=3D8): OBJ_INDEX_BITS=3D24 but only 10 bits are actually neede=
d
> for obj_idx, leaving 14 spare bits.
> We can split OBJ_INDEX into class_idx + obj_idx:
>
>     obj: [PFN | class_idx (OBJ_CLASS_BITS) | obj_idx (OBJ_IDX_BITS)]
>
> OBJ_CLASS_BITS is computed dynamically as `ilog2(ZS_SIZE_CLASSES - 1) + 1=
`
> (8 bits for 4K pages, 9 for 64K).
> Since class_idx is invariant across migration (only PFN changes), zs_free=
()
> can extract class_idx locklessly, then acquire class->lock and re-read ob=
j for a
> stable PFN. No pool->lock needed.

How much of the benefit do we get with just these locking improvements
without having to defer any of the freeing work?

As others have pointed out, I don't want to just defer expensive work
without understanding why it's expensive and running into limitations
about why it cannot be improved without deferring.
