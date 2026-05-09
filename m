Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829030E0E9
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 08:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778316354; cv=pass; b=OKPmhmU1s/qg5CF+zL4wKXerCS7ZsIuR2JW3HI1Ce2vGfUUCuI4UdIim0TUm7F8UUcQinIF7Kzr3yik6GctjH5r2qYQhvlmoQDJbRrxdyFXhH1FtYo2X6o/Yb1jEiDVaLu42ALbaWGJ7Xl15XBkCZXG5y3onoaahbDgs529XBY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778316354; c=relaxed/simple;
	bh=iWZ3dpBFgvLu/T0rFaUdDIfhUZFZx/QhIR5n6QoNJ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYTHNs9qCvzFu/HcbFDuuUWje4Uu94BOVhQIAmDT9CNorIElwrRNNT/sT077B9D9BCTxrr5BrWek9plISqFyyorMJAgJ382q3AAslWP6LzvPZDSE365y8A6BGlJ06oHTqkHDtJXvLaeO68ZANTo1FqspGL02KvQ6+zCZpkqr1+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JgSBF6oH; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgSBF6oH"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-651bf695701so2900951d50.2
        for <linux-block@vger.kernel.org>; Sat, 09 May 2026 01:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778316352; cv=none;
        d=google.com; s=arc-20240605;
        b=fDgKkO+LwAnUQCiMb5ot2FM0mIo+nSiXhTqAtnbzS3PssG4RnALjGQWSbtzV380HEt
         asMiD1FcVHY3289xBYybwsH521sOI93myNkSL+FpwNxyVVLX0Z9cu2KnSrH4Bs9G91Hp
         9Pn4JCJV839fhyE9PS1ZKoKH89JRgy2cfdRQ4CVfZ9vcUwRFPpSbsZXYBxemDqDh4amI
         5UiPwEb/oEwPUDs4RgZaMJPyBFkPsF5IFFhvHKr4uqTmT+Qkp01JLLSqum11ONrasXfX
         NEnlfEKyL3J+T4tbIXgUv4FUQQBTWIcdI0Vj/uneZ02CR4BrdKuFvrDf1hlL6KvZURTB
         VtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LEEs85gLt8c41rfe6nkdoU4jx5WLcVvqOUISi8My+7k=;
        fh=VeqoQjpE3r4qAwrtt8+ImygjkHRovgypOkBysOuiUIQ=;
        b=fneBcgI5xBiu1ruobokjFcxR9sbWJhIW+o8MRyEPQaE+TdVO0tulueIT9lc35hM8+s
         JlmliE7JcazJsG39ty5aWyB6Y2wFOR5icEctB1zqfQFGXYq/7oiaoKGghSnNaQw3ddDP
         fcsPWG0VSycNcI9/mmFyonxKPD3lGjWY7J2/RKWWkLM7S4m5SiACRdDsLAbg+03qIlDu
         Mgqil49OfXnV3k8EEugc7owqmvjCD1o3QpH/XlMOCGU5ZaccLOevr1YZB0PL6TY6HnZa
         EZBsfRYZ5Jr/Jrn5AtKYZhFBfnnlHpYorlv0nQ+FEQVrxzzzVdS1oOhWxHc8kva3PlVh
         3wRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778316352; x=1778921152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEEs85gLt8c41rfe6nkdoU4jx5WLcVvqOUISi8My+7k=;
        b=JgSBF6oHIxjj4sEObgDyhKy3u9T9W+yBEcMorOnK5LTZ9+79myTstAPYPEQ54ie/mD
         +e0YYJ4C8hpIbyJYG2G5o9G7H36oNG2g2vDIesYyka0Ohg4XcUcyAKLZrZ5enLgzn8LR
         GXRpmdb6Rk31vmdT1wIky6/cKSaNnubo408UBnUnkrw9D/eF2YKPNQDu5MCaEAa8aOmU
         kvscbAEFcDCv9R39BI+Zp9vqyoBY6Z4YKzD899GrLUfazYnpgaJJPmestsDSCBc1Iomy
         qTrCEo0nCJ+lHj0H3m6lwWchA+8RPGs0fatt+RWIlH4R50rVr4jQsttYOrPyhfKgsfcC
         Ovng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778316352; x=1778921152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LEEs85gLt8c41rfe6nkdoU4jx5WLcVvqOUISi8My+7k=;
        b=ixPu3qBzTRZ+idTGiCp46qoCjpOF185eb3ScawgRzPD78BQOliCufkUlN8Ldqyk/4e
         97+u4nmn+hvqPhigl59xrVXLZNuWSDOv1V9MGGxx1ZZuY7VOe5pCUy2Ek/uzKH+x8fPn
         xrNxUzcIzqkQRcSkvdZXjyA2+kFtjETn7DvdrSICMqysXUaUlapzxgvkdSIWBahqZ+AG
         2+ksCbpdHHvAuOo/XVKOAF19AqRI5Ck6mR0T2W8aThzsDFEzpvMPQIQZ01GT1p47HZo4
         46/PAOi2r7OBrpmZmAAqA6TTUfS9KxCK4VJiefAh+FsWXM2TUIvlw9mqAn2nba+hCpTO
         u9oQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fjYOmQdR+utmwLjhOas+rFInwVQjzg4CuagYjRTNEEw6lBXcj5fA8DIYFlwtG/WqfcqAyhvQKJd9zag==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7+llONI48X7wRUPzxWx5McYYOLN435hfH5gzp5zAyHXIkY0Dy
	bQ+hcsIWCcIW3ensmefVAHAHgN6Rd59JDaH5iC0/ZsgYxywOlJXMbprPb8vamyQUJ1qgwA2CHan
	27LVA86U6l9Dyy0WmdKbnyaTan9kBIcNphh0O
X-Gm-Gg: Acq92OHj5QKarR/Q4H/N8Z3PVrTyPhysdDjkuxhgSx6YKihLISN0DHpEgvazs8oukDd
	7eYBSxQ8L4kXn53etnAwi0pYOzRo5xHLFY72GH7OCXPtVM+aXJof1+1neYRLK3269Ntxlkf0Xc8
	U+n4g/Ll0TtR1PdmLcN5HwaV/aL3Y73g/Wdk/Jt1LJwDrN9ykx6YBhgq366yor+h/QZY9m0n5AJ
	OYqJ3WUk6VyrpvB8NM1P2f2pb/etgPlcQnrQGH3fQro0e2nHGAnNyGWPisrz88+GDabiiRXuuo+
	C7c2/i6p
X-Received: by 2002:a05:690e:480d:b0:65c:1637:9702 with SMTP id
 956f58d0204a3-65c79994bdfmr12597535d50.34.1778316351778; Sat, 09 May 2026
 01:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508060724.3810904-1-haowenchao@xiaomi.com> <CAKEwX=Ood7Q4zv0zc+GCCGtWu2GLVdtod=4VC9151r87AZXpWA@mail.gmail.com>
In-Reply-To: <CAKEwX=Ood7Q4zv0zc+GCCGtWu2GLVdtod=4VC9151r87AZXpWA@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Sat, 9 May 2026 16:45:40 +0800
X-Gm-Features: AVHnY4LqYFKPUFe8mDf2wOjhtL_IA_mI8Qb7K_9yOfvXtETfkxn61yoJx9h3qr4
Message-ID: <CAOptpSMQyu5oSbJoM5QsbbHgdPwm44XUHE3i-XuT9bujFLRG0A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] mm/zsmalloc: per-cpu deferred free to
 accelerate swap entry release
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry@kernel.org>, Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 9, 2026 at 8:08=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote:
>
> On Thu, May 7, 2026 at 11:08=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.c=
om> wrote:
> >
> > Swap freeing can be expensive when unmapping a VMA containing many swap
> > entries. This has been reported to significantly delay memory reclamati=
on
> > during Android's low-memory killing, especially when multiple processes
> > are terminated to free memory, with slot_free() accounting for more tha=
n
> > 80% of the total cost of freeing swap entries.
> >
> > Two earlier attempts by Lei and Zhiguo added a new thread in the mm cor=
e
> > to asynchronously collect and free swap entries [1][2], but the design
> > itself is fairly complex.
> >
> > When anon folios and swap entries are mixed within a process, reclaimin=
g
> > anon folios from killed processes helps return memory to the system as
> > quickly as possible, so that newly launched applications can satisfy
> > their memory demands. It is not ideal for swap freeing to block anon
> > folio freeing. On the other hand, swap freeing can still return memory
> > to the system, although at a slower rate due to memory compression.
> >
> > This series introduces a callback-based deferred free framework in
> > zsmalloc. Callers (zram, zswap) register push/drain callbacks to
> > define what gets buffered and how it gets drained. The entire free
> > path including caller-side bookkeeping (slot_free, zswap_entry_free)
> > is deferred to a background worker.
> >
> > Implementation:
> >   - Each CPU owns a single-page buffer. The hot path writes a value
> >     via the push callback with preemption disabled (no locks).
> >   - When the buffer fills, it is swapped with a fresh page from a
> >     pre-allocated page pool. The full page is queued to a WQ_UNBOUND
> >     worker for drain.
> >   - The drain callback performs the actual expensive work (zs_free,
> >     slot_free, zswap_entry_free, etc.) in batch, off the hot path.
> >   - If no free page is available, the caller falls back to synchronous
> >     processing.
> >
> > The speedup comes from moving expensive swap slot freeing off the
> > munmap hot path into a background worker, so that intact anonymous
> > folios are released back to the system without blocking. The worker
> > drains at a slower rate since compressed objects are small and freeing
> > a single handle may not release an entire page until the zspage is
> > fully empty.
> >
> > Performance results (Raspberry Pi 4B, ARM64, 8GB RAM):
> >
> > Test 1: munmap latency for 256MB swap-filled VMA (zram backend)
> >
> >   mode        Base       Patched     Speedup
> >   single      61.82ms    8.62ms      7.17x
> >   multi 2p    94.75ms    54.11ms     1.75x
> >   multi 3p    154.64ms   104.83ms    1.48x
> >
> > Test 2: munmap latency for different sizes (zram, single process)
> >
> >   Size       Base         Patched     Speedup
> >   64MB       14.11ms      2.18ms      6.47x
> >   128MB      29.45ms      4.48ms      6.57x
> >   192MB      43.85ms      6.62ms      6.62x
> >   256MB      57.01ms      9.08ms      6.28x
> >   512MB      115.13ms     55.58ms     2.07x
> >   1024MB     229.66ms     153.28ms    1.50x
> >
> > Test 3: munmap latency for 256MB swap-filled VMA (zswap backend)
> >
> >   mode        Base       Patched     Speedup
> >   single      152.14ms   51.26ms     2.97x
> >   multi 2p    186.56ms   105.42ms    1.77x
> >   multi 3p    205.83ms   153.32ms    1.34x
> >
> > Test 4: munmap latency for different sizes (zswap, single process)
> >
> >   Size       Base         Patched     Speedup
> >   64MB       37.83ms      13.26ms     2.85x
> >   128MB      75.11ms      26.73ms     2.81x
> >   256MB      150.78ms     52.97ms     2.85x
> >   512MB      303.04ms     130.38ms    2.32x
> >   1024MB     599.95ms     287.10ms    2.09x
> >
>
> Hmmm, why are we batching at the zswap/zsmalloc level like this? I
> agree with Yosry that this seems like somewhat of an unnecessary
> layering violation. For example, do we observe a lot more performance
> wins by doing this instead of just simply:
>

Thanks for the reply, refer following thread for the perf breakdown
and detail data:

https://lore.kernel.org/linux-mm/CAOptpSPY3YL5VFJW9KKP99Yb17+_rdXKsKj93FdEn=
3_Zb350ow@mail.gmail.com/

> static void zswap_entry_free(swp_entry_t swp, bool deferred)
> {
>     ...
>     if (!deferred || !zs_deferred_free(entry->pool->zs_pool , entry->hand=
le))
>         zs_free(entry->pool->zs_pool , entry->handle);
> }
>
> (basically what you had in the last version).
>
> One weird effect of doing deferred zswap entry freeing like what you
> are proposing here, is that the zswap LRU will be littered with stale
> zswap entries. Seems like you removed them from the zswap xarray, but
> they're still linked into the zswap LRU? At writeback time, that will
> throw off the statistics used in the heuristics, and will make
> writeback go through a bunch of stale entries, wasting more cycles :)
> Seems a bit inelegant, no?

You're right, that was an oversight -- thanks for pointing it. The
zsmalloc-only variant avoids this entirely: zswap_lru_del() stays
synchronous before the handle is queued, so the LRU never contains
torn-down entries. I'll make sure v4 doesn't have this issue
regardless of which direction we go.
