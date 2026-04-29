Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04437472D
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 22:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502668; cv=none; b=ATPATx0XimoAUEPtzP4jGv2QfBgZYV8BQB7o43qwhrsJijnDLJ8Cc9VK1Me91Ar2g/1nNCASRZqptdsfbWaVviQcJWhAdt6PSMQ62OXmZExQCeaURoG3OVucAM1qVgTeah8r5PrFa1tYMS1ciFFsW8iTUcOyjqPzr6WzeCCiWlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502668; c=relaxed/simple;
	bh=VOCMAkRoJHwievxrF6FKJtCf+0oZEcgrTETYmIWAirY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6Yfa3lUfN9EiXMHsrPuJrUrzi1LbnuFBKpi0sEHgldBYJw0kSgIEMJGq9MFEiQk/jIAv3Cogp+G6pi7xwv3A09YCb4KADsKEzobK/kV3b7k1Nhdxrrg3kvLzL28oonGQjLtczfWgHQT+f53AlnhvkS2Q9/ueFdNTEMjzbsPL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAHuEQ+c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAHuEQ+c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AC9C4AF0B
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777502667;
	bh=VOCMAkRoJHwievxrF6FKJtCf+0oZEcgrTETYmIWAirY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CAHuEQ+cwJmPgGnEoQdcHL9zahVo9WQ/p5V6DhnFaJeAyD8PgqpJRC59u2eK+Y1ES
	 stNtQxwPhxd9OuDKx6TWErcDhwGknDLKTRxSLlzLZXvLWPAmc+Vqn7pTRk0+EnMpsy
	 jMPfIhfnZoaQaBcgZkxBVG/HURZEhNB3RLC+TtR3ZHW4d6cT1PPrl9AmAJvkcppgNv
	 Qg3X1IJW+GFGKQSeOqifDr1ZCGQR8sMPrQjDG246efAtN/4pE4iPOQX5JWQeisrwFI
	 uQxHJykZCXTHzGPGpcLm/VQsLUlrnU9ZEbMJgPKQhqJMwPFpWKeis1u0LmIbncgn0y
	 mB4iIhPKjZ8Fw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so43047566b.2
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 15:44:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ouds2qITl2LaTMvpqCFwSxdcBof+Gc+1DVWVzrKzqDmTva4DiZizFyfAFr2mu5uSWzDHemCmIKM+YnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVkqye0dTIm/P2U1RfR2fWwY2LLbu+F25lCO/Yj6HgoTM8prMr
	9leK6irJSLbH+tCrPqa4b2EafIOX0AEBeI3YkfIHDRDTsLfGYjJe3ao7DTEan7++l71nRbBOFwi
	vsXlKJ4z47O1h0Xbk8sd6sxXuVdzfER4=
X-Received: by 2002:a17:907:6e89:b0:bb5:8592:b9bb with SMTP id
 a640c23a62f3a-bbac50eab6dmr40470866b.17.1777502666515; Wed, 29 Apr 2026
 15:44:26 -0700 (PDT)
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
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 29 Apr 2026 15:44:13 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPV=c9v4Ar7t+xPxyptSUPrs-shrumsz=hCaNa3anGgAA@mail.gmail.com>
X-Gm-Features: AVHnY4IbBUbhbtmVGPu5-6mOXf4xr_XIz6rkf2s7ZdSXtIMyPqwBlQk_MqqyVNs
Message-ID: <CAO9r8zPV=c9v4Ar7t+xPxyptSUPrs-shrumsz=hCaNa3anGgAA@mail.gmail.com>
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
> Single-process shows modest improvement. With multiple processes,
> each read_lock/read_unlock atomically modifies the shared rwlock
> reader count, and the cost of these atomic operations increases
> with more CPUs accessing the same cacheline concurrently.
> Eliminating pool->lock removes this overhead entirely.
>
> This only works on 64-bit systems where OBJ_INDEX_BITS has enough
> spare bits to fit class_idx. 32-bit systems don't have the room.
> I'm still working on the compile-time gating to properly enable
> this based on architecture and page size configuration.
>
> > As others have pointed out, I don't want to just defer expensive work
> > without understanding why it's expensive and running into limitations
> > about why it cannot be improved without deferring.
>
> For the deferred freeing part: the class_idx-in-obj optimization
> addresses the multi-process scenario where concurrent atomic
> operations on pool->lock become expensive, but does not help
> single-process munmap. Deferred freeing moves the entire zs_free
> cost (including class->lock and zspage freeing) off the munmap
> hot path, which benefits even single-process workloads. The two
> optimizations are complementary.

What is the extra speedup added by the deferred freeing on top of the
locking improvements? I couldn't immediately tell by looking at this
vs. the cover letter. I wonder what portion of the improvement comes
from the deferred freeing?
