Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBF03630B7
	for <linux-block@vger.kernel.org>; Fri,  8 May 2026 23:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283185; cv=pass; b=XvEbz+QzxAhdr2KCaiOpYyXq872DTfYsyGRo5GiCKzmdLVp6D/wuRYys1jEaRWGwHlh0wUOLU9NIBa994u6f0+Movonn5RRA8k1D8ZhFDYAMuvJWfUINwEAafLpqsLUkO9LC4vci1x8TLPmTcM0mX6XZEbrcKeXCOEETEFriUu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283185; c=relaxed/simple;
	bh=RBipzRmN0XYvIxuSGuKckHsMVzpx80+O83M8kOJtC0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CpsRyvz2vDdKQcF19t5UdKydm4tGp8efibpNwmqnUpKqwjO4xnvmnPds7V7KOuzSD6b0BELNOPRLhggWJXWvoc8AGBK1uQCqPkryj+2yPW+ZARN8EHUMwzBpMkgs2JQJkA+DboP77bb9qsj5DsKeB62fTEVGfhOb9FMa6jLLsNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVKBkRfm; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVKBkRfm"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43fe608cb92so1545179f8f.2
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 16:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778283182; cv=none;
        d=google.com; s=arc-20240605;
        b=FFod0M+BUvToi8VBLl8015DtaHBLC//ysCjM6UBw7s0NBPXTQ30HKCy0jwYxxIXQbH
         g5uIKV8c9UdNJNftBsVXYxUlT2jckoMSuZPPg0osetauvPNqRBZzZeBCINW0o6TONeKP
         09ipjIFc0G7BAdw5lCSIR9t2781Q4fRVHr1ZROUHu/kD9q6xAv2USwrJ8bwHaA45IPH+
         OKvsROc9ta1Qu65EJU+Yak7lIpOZIfPEbGDBAz6whNkny3snzpC2ld7/A3MuR85NWdzI
         fPXbmK4fsaNVQYdqVZRVtfkToofm3TpG5r16nNeFQlpjRUeqfqcm2UoFX5XzvPzkgMHq
         V0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oSOi2hfsCtv/FfIwJYFm2BLHlgEKmdNqcetZh+pI3Hw=;
        fh=TBbPS0C/1OR1l9zrrUQUXCplrh6NKHcefI7BlLrCsLA=;
        b=gT7MMHLxTmae6NyT/s4Yung9OL+AU45oxohS95QqcYmGuXMwqW2J9BTyay+v+EWafe
         /O6U3FvhnGV2vqQ4v6hI9iOjacaVMOcrcdHX4ShpY0i/aHLp08Ir+YwKXHOQBWkEBzHJ
         UJ9qDobPUAgRALy3yCIO7vADZfLf6I8Mpftz84VH/J+e7IfptoK2D+qCu0J7pS0LXcx+
         6UiS5yLynF8vLUOjZjbt0YRD3PkX3YxaZTG+O2qEps8gYW3T7LxnQRhYRK0zDvnj91u2
         /VY4+krqQ1zsrm26sfQWZROZwqbJHwTFmcIZ24HGu330yD5lOIevS5xrdFbaq90SKoAf
         8NKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778283182; x=1778887982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSOi2hfsCtv/FfIwJYFm2BLHlgEKmdNqcetZh+pI3Hw=;
        b=SVKBkRfmMYs1OpbsrnqjlyY1nLLr+m3J4jVMRoLSiqC/5DmlTXSXYJh3n9s/P9nSxr
         RFZEoWhCq3U6AnvTMzakimLaJPKOcQtNwyXMjy6lvCaGDAHEAh0ZTPLyIzI90SH/xu2E
         J4f72ysYRVGjjAaOvTYKYQ/ubz1ULcQ8+Vm6/8cMiujggh85RYl7s4Dl5Mf7OVpBCY/8
         CiplV7gSY4LGojaoq21yAsKlI+p2pRKYOPeG5GrWkoIecaPCJqstub0xZzjo4jheMGOx
         duFzdXAUwqakDHBQfvvMF6U6vkMCF+VFor8QjWm9vaMu+dpgTUmTVBx9A3Px0WayNebO
         rjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778283182; x=1778887982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oSOi2hfsCtv/FfIwJYFm2BLHlgEKmdNqcetZh+pI3Hw=;
        b=CF2DwtxRWDqmlSj7UsLnLB8s3rWPfY7L00jWqi/xztrQTmSVE3LC3jH4YEgs4OgxfA
         f1HAv+xcYXq2FYzkl+NgU3Py7GZnFohbZcp5T5mmyQwiPmIFGuqjPQ4k6fNjv3fuKOdW
         iOgqKzu1Awtxm4F9gTJ4W7e9JVkgz/f64/m7t0CfcKtwa2JGuHD6i+wf78fPAPdN/toz
         ATOhSl4oy5ehRooRJwnT5HTJR0sL4+IQWfDi4vXC2TJ5CXmVGcDkSn8552VXs1npMI8f
         HocaNFkkHmsZ4QWss8uEwyn9o6M9xQOYCbTXHKD9U5f6AXBt+cd2gz8/rcWvWHI8jSiH
         CW9A==
X-Forwarded-Encrypted: i=1; AFNElJ/eGWJ5NPSJO/jHdLhqYP0EXjokxL1tMu7LoU1EvOovEuugZksaVAAuN8OZgEPjdQxhKeGsI4/ko0KYIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXSrTqm8sEEz7/5fClQDGIukHmTnuNHQ5Wk1cvkjXDmqbI7W0
	1W5gUoLsyOqY2faxGDLIzkY01hOrXGI4Ci5Nwgi/7A+yXBeqXd/waEudHGLXBslVnFXrN8/R7g4
	IcKndJNcZuZU0jTDHwAxbHH5Ws7zno6w=
X-Gm-Gg: Acq92OEy31Fus5pvPgflVD88JQm5sVhJ42F1Fxloh77wxMLyJYR35nxc5ZnGEwW2JwN
	Sw1+N1VNibZh5t2K16hzYhiMiEgcOGk7yAIwdgk/rOs/hH9eeUabuF39HXvo2ZVxd6U5F1AWDUh
	qLL/sxgWMz0Y/MT4Bil9YmtxZzSRe9tNR1+mW8mQfct7DkGXK61cv2DpQigOxY3lcM3UIqPiE0a
	He/2V16Xcx8O+NsJ+BpEZTymcUn1vSWxBK2GXYOBcoFnUr92I8hdnlvz7dWrFkNF4oZ9egBbWtr
	ocugJO4IPmsLJ2xZugi//D02ValNr444cgTafkkTb9YYCEMe
X-Received: by 2002:a5d:588c:0:b0:451:bbe4:b48e with SMTP id
 ffacd0b85a97d-45460e406fdmr7146433f8f.5.1778283182084; Fri, 08 May 2026
 16:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAOptpSPs-1UrEa8AHg19e590=SiV6bpnex7gCbif8=aY7BtpuA@mail.gmail.com>
 <CAO9r8zOjugCwWqHP3zxXPmjp8TwpoROCjCqTZ_uxOBQwVqCWqA@mail.gmail.com>
 <CAOptpSMQyyb+q-VJdJ0RzNkjaer1CTePM5WkwEj_7cAO4aUToQ@mail.gmail.com>
 <CAKEwX=PrfrNys4ao7-d11J7r4pv5VmE8gTU_7iUHaHAKNaFuBQ@mail.gmail.com> <CAOptpSOnRCHo35KK5x3S0f5y9+7+dxfznpjNRH072jZvhYHwww@mail.gmail.com>
In-Reply-To: <CAOptpSOnRCHo35KK5x3S0f5y9+7+dxfznpjNRH072jZvhYHwww@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 8 May 2026 16:32:50 -0700
X-Gm-Features: AVHnY4LVPgaokRSD-yNzmbW3fcr5U2WsfiVX3TD22zLlG4u5QMOCyYiPo_GSa7U
Message-ID: <CAKEwX=PgsM4Z0URJcF5VSXX_jdy-cAs2JxDCCR1a8CGwV4tCAg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 6:55=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.com>=
 wrote:
>
> On Sat, May 2, 2026 at 3:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
> >
> > > With only the class_idx-in-obj encoding (eliminating pool->lock from
> > > zs_free, no deferred freeing), we measured on two platforms.
> > >
> > > Test: each process independently mmap 256MB, write data, madvise
> > > MADV_PAGEOUT to swap out via zram (lzo-rle), then concurrent munmap.
> > >
> > > Raspberry Pi 4B (4-core ARM64 Cortex-A72):
> > >
> > >   mode        Base       ClassIdx-only   Speedup
> > >   single      59.0ms     56.0ms          1.05x
> > >   multi 2p    94.6ms     66.7ms          1.42x
> > >   multi 4p    202.9ms    110.6ms         1.83x
> > >
> > > x86 physical machine (4-core Intel i7-12700, 2 rounds averaged):
> > >
> > >   mode        Base       ClassIdx-only   Speedup
> > >   single      11.7ms     9.8ms           1.19x
> > >   multi 2p    24.1ms     17.2ms          1.40x
> > >   multi 4p    63.0ms     45.3ms          1.39x
> >
> > Oh man, you are eliminating pool lock here right? This would help my
> > other patch series a lot too :)
> >
> > https://lore.kernel.org/all/CAKEwX=3DM5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWodw=
bf1Fe=3Dgzew@mail.gmail.com/
> > https://lore.kernel.org/all/CAKEwX=3DPkFiP+u+ThrzjTKBi+usQf2uuhTZcfB2BN=
NA8RboOFDQ@mail.gmail.com/
> >
>
> Yes, exactly. With class_idx encoded in the obj value,
> zs_free() can determine the correct size_class without
> any pool-level lock. The lockless read gives a valid
> class_idx because it's invariant across migration (only
> PFN changes), and we re-read obj under class->lock to
> get a stable PFN.
>
> > Well, the deferred freeing would completely move that contention out
> > of the way lol. But this would benefit all users, regardless of
> > whether we're deferring the free step or not (for instance, this will
> > reduce contention between page fault and compaction, IIUC?) I feel
> > like you'll get some good numbers testing in a system with compaction
> > and THP enabled, with lots of swap activities. Which is... a lot of
> > server setup :)
> >
> > If the deferred freeing is too controversial, this smells like
> > something that should be upstreamed independently.
> >
>
> Agreed. We're planning to split the series so that the
> class_idx encoding + pool->lock elimination can be
> reviewed and merged independently of the deferred free
> framework. It's a pure win with no behavioral change
> =E2=80=94 just less lock contention.
>
> > >
> > > Single-process shows modest improvement. With multiple processes,
> > > each read_lock/read_unlock atomically modifies the shared rwlock
> > > reader count, and the cost of these atomic operations increases
> > > with more CPUs accessing the same cacheline concurrently.
> > > Eliminating pool->lock removes this overhead entirely.
> > >
> > > This only works on 64-bit systems where OBJ_INDEX_BITS has enough
> > > spare bits to fit class_idx. 32-bit systems don't have the room.
> > > I'm still working on the compile-time gating to properly enable
> > > this based on architecture and page size configuration.
> >
> > /*
> > * The pool->lock protects the race with zpage's migration
> > * so it's safe to get the page from handle.
> > */
> > read_lock(&pool->lock);
> > obj =3D handle_to_obj(handle);
> > obj_to_zpdesc(obj, &f_zpdesc);
> > zspage =3D get_zspage(f_zpdesc);
> > class =3D zspage_class(pool, zspage);
> > spin_lock(&class->lock);
> > read_unlock(&pool->lock);
> >
> > It's basically just this blob right?
> >
>
> Yes, that's the blob being replaced. On the
> ZS_OBJ_CLASS_IDX path (64-bit systems), it becomes:
>
>     obj =3D handle_to_obj(handle);
>     class =3D pool->size_class[obj_to_class_idx(obj)];
>     spin_lock(&class->lock);
>     obj =3D handle_to_obj(handle); /* re-read for stable PFN */
>
> No pool->lock at all. We've also added compile-time
> gating (#if BITS_PER_LONG >=3D 64) since 32-bit systems
> lack the spare bits in OBJ_INDEX to fit class_idx. On
> 32-bit, it falls back to the original pool->lock path.
>

BTW, I've tested your idea with a hacky prototype, when I was playing
with my vswap series. It absolutely improves free time in the usemem
benchmark :) Idea is very promising - I won't scoop your work of
course, just letting you know that at least in my use case, it works
:) Look forward to seeing it submitted soon!!!
