Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2364E38D
	for <linux-block@vger.kernel.org>; Sat,  9 May 2026 00:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778285296; cv=pass; b=Ldt7rOc9Ey/QfX5K8i+hXW6mrEOyxjxhcaNziQOvORjS+VljvMuJr5O4QMI1ZC88tp6vfKg2xZegCZ9W+Pakyeo17GluQwptjSAaPewuk42YbYdKFBBPFoHxh9q5eaJSTxXAmI3VnAYj9z8eioT1QzoZIdUbJBrvYzxwlxg1+1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778285296; c=relaxed/simple;
	bh=mMU8ttRmfI7xOgz+LXLEUc+3WoqyF9JN0ux8LRvIpRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkwbXkMzwotqtuozq5TFPKVnzs8EUm4LKwJilzErg6i9AwW4pB46ma3vcrCZkw5LzC592lCMQroIzr8AXG9g4WWK+GBbB5iVdHaZKi6Rd52KUmYW+uXX5r6mBkqjpP4RWA27RKYMzBr9QYWdTawgGLPb73KlutMX2hz8gg300co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUaANKz1; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUaANKz1"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso2178059f8f.0
        for <linux-block@vger.kernel.org>; Fri, 08 May 2026 17:08:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778285293; cv=none;
        d=google.com; s=arc-20240605;
        b=ZwwvF2gCHl/P3Wgd9n68rRJ38PbDlVQIDhR2V0SB3Inqx4Vti9pgT4oxJrSqH8m9oY
         3mrg6U8ijwxWplVTbRNcuxRvvE8FU3POtufKZp/Hq82UxbpMeL95qzJavsjQdQ7OvdyF
         OcEGZCRlHp1egL8iu7QyoVvrkD/YDfQkgxAVpdSeSEN3a3BzS58kzz3Q5hKt3/mZnWiS
         Fkm2NeKPEhY1HBQPb0tnWcubiLgn3ab20j/UtueuED+v328PxVoC7lQBrhvrvfKn5JKC
         6tjaJfXdVC8kA1fe8zBLXSvgDYHH5uLjmgRNYs8D/bItVrnXKRbonSxy/C2lgp1epPku
         j/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2hAe5AS8Ymjlp2Wl032hmQa+iD3KTwFf8efNYcRmY7E=;
        fh=qqyrq2CnqdeQLwLZXD/8P02988wOe9yJw/Vbvq7MllA=;
        b=VEgCyV4vc+8hwxg/EIK+TchlWwsfVPxhAASrJe9LjwSiqEzuJegJNg2f8/oosHLtcA
         cemG30Sdj5/n7bLsMTooeOTfr0dzjfunXQTzpDZhxSkdBolQUBliBrJtJ2MSEpYbZdVM
         RlJYKn3+r3OSS5cYLM4SFndp5CydexzZKwxoB9MPkWrUxHTvTAEQ8of37kEHlfzobawM
         R2PkE2LCmOsq7dlLHmpgTMN/swcjVB5q9p6CchRTXQPDr4MPih0u15UDHCD5sDpd7bD1
         CSsLsbfTmuZKgbf91c0+7Wnxx1JJo61HRN6oDb53fBYZKHjiLpAS6rFdxgWbsTsjPwqH
         npcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778285293; x=1778890093; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hAe5AS8Ymjlp2Wl032hmQa+iD3KTwFf8efNYcRmY7E=;
        b=FUaANKz1/7xjdK4Ht1tjxLjoqRiTPLTNJE2JUVFW4Ta6ooTZufkcSRllIrFeHU0cLe
         iJiq5hAN8G9/mJQbUyiEB13E35RD033w/UW7ApJqlMJCZLkvdvvDjZsezS9ihP2X1/ZO
         sWePXdVtAQCS45GzcZ22EIqZQkB6edpnd7TYkTiq8a4YEaJ0GEEAgllvGD9DWSOX1uMN
         lIAdU6frQbNonnmZ7Jh/L6HGV0TxjGN/f4URtkPbDYN3cU/u5km2Oyk73sjJT7CmQ512
         9GlbJXXTl6kqkHQC5Q6eU+UJi8SUHU94ZrNRT89PXcw7/QN13FS5ZIxt0dGoTY8JAS5J
         2pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778285293; x=1778890093;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2hAe5AS8Ymjlp2Wl032hmQa+iD3KTwFf8efNYcRmY7E=;
        b=cW1lPWTQVKFcsIfTKuEpWR/2VpEmv77hQ6F5KcABw6TgAzh5GSu7zWRN/2rTUL6vga
         YjJJti5xlGiclE6Ns6jqCZCdYmo/xauEyeY38GpVZe7psWJXKJlVN8jY9k5IFwr43dEP
         qHAGN20toA4s3sfgFE1GcbKYIOr3BN08VSkM/55UGMUKdDTxQUEEI+Fcum/YDdLTGIQl
         iDbrKRKN3fmAclbfw6tjN6V2iDXaQmfm4XHSMgwXXF341kxedBrni4zCuRqtbQodHPMU
         zVJYb+VlEbB37nDx5JAKcjE4caNBfwJvmB2Ku3S9ZBr1DTRTyFmBhsADQYODBxPlhzyN
         YHhg==
X-Forwarded-Encrypted: i=1; AFNElJ9OQQ+kJrefpzuJuhn/ExDQX7EvFTjej0sW0s4g2uADN0UMYVXE+n+WV8Bw7Gi6o2ZeIhLUzkSMm0UrWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgwICziSC2vOph5mSjIJlgSjWC2UalRYsNjSwDR/t2hgsNFoGo
	LWtp2k4YFFhUcrU2a0CQy4DpoagXRNiVZp1KeH77cHainjAwypmJhgj8v4LKP/6HHz0GilEDJB6
	aKU63VbqKmXIfSythF0zAjhB5Dco0Aow=
X-Gm-Gg: Acq92OGbzBeZYjFt087mYWaSJ++yB18ixMhyBDrP3YE8yVpBDDFMg+QpiUeIxDehyAy
	2FJupzqIl/xwDS4c/OqzSjtLQJc2zHmRSdrVNnTKhkbignuicDXtfBfIiF7E5Jj0sve7epye5SK
	vNHstNGAQE9+mPmZE6GxqmkjbuKSsGP1hQKhLNC/+Fb1AKhvi/BX/yHhAEH7a0iRBVsGnRHVdlV
	7CLjsgnyfxQ5SeTAIxSnJe23blH8VYTWvcUp5w4gmQGlClwNUp6TBg9ZI2/8BYjJPpGg+HC2yQI
	qH5zCmy6VeWPijrtvp41XFzIt/bypV11TmXd/w==
X-Received: by 2002:a05:6000:220c:b0:43d:77f4:7145 with SMTP id
 ffacd0b85a97d-4515bae9147mr23715114f8f.19.1778285293382; Fri, 08 May 2026
 17:08:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508060724.3810904-1-haowenchao@xiaomi.com>
In-Reply-To: <20260508060724.3810904-1-haowenchao@xiaomi.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 8 May 2026 17:08:01 -0700
X-Gm-Features: AVHnY4KbA6937UtLfw7u1pC6wkI6O7XsgN0-eZFsAMS6V-1aa9ouZXB-HiwqhPA
Message-ID: <CAKEwX=Ood7Q4zv0zc+GCCGtWu2GLVdtod=4VC9151r87AZXpWA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/4] mm/zsmalloc: per-cpu deferred free to
 accelerate swap entry release
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <21cnbao@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yosry Ahmed <yosry@kernel.org>, Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 7, 2026 at 11:08=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> Swap freeing can be expensive when unmapping a VMA containing many swap
> entries. This has been reported to significantly delay memory reclamation
> during Android's low-memory killing, especially when multiple processes
> are terminated to free memory, with slot_free() accounting for more than
> 80% of the total cost of freeing swap entries.
>
> Two earlier attempts by Lei and Zhiguo added a new thread in the mm core
> to asynchronously collect and free swap entries [1][2], but the design
> itself is fairly complex.
>
> When anon folios and swap entries are mixed within a process, reclaiming
> anon folios from killed processes helps return memory to the system as
> quickly as possible, so that newly launched applications can satisfy
> their memory demands. It is not ideal for swap freeing to block anon
> folio freeing. On the other hand, swap freeing can still return memory
> to the system, although at a slower rate due to memory compression.
>
> This series introduces a callback-based deferred free framework in
> zsmalloc. Callers (zram, zswap) register push/drain callbacks to
> define what gets buffered and how it gets drained. The entire free
> path including caller-side bookkeeping (slot_free, zswap_entry_free)
> is deferred to a background worker.
>
> Implementation:
>   - Each CPU owns a single-page buffer. The hot path writes a value
>     via the push callback with preemption disabled (no locks).
>   - When the buffer fills, it is swapped with a fresh page from a
>     pre-allocated page pool. The full page is queued to a WQ_UNBOUND
>     worker for drain.
>   - The drain callback performs the actual expensive work (zs_free,
>     slot_free, zswap_entry_free, etc.) in batch, off the hot path.
>   - If no free page is available, the caller falls back to synchronous
>     processing.
>
> The speedup comes from moving expensive swap slot freeing off the
> munmap hot path into a background worker, so that intact anonymous
> folios are released back to the system without blocking. The worker
> drains at a slower rate since compressed objects are small and freeing
> a single handle may not release an entire page until the zspage is
> fully empty.
>
> Performance results (Raspberry Pi 4B, ARM64, 8GB RAM):
>
> Test 1: munmap latency for 256MB swap-filled VMA (zram backend)
>
>   mode        Base       Patched     Speedup
>   single      61.82ms    8.62ms      7.17x
>   multi 2p    94.75ms    54.11ms     1.75x
>   multi 3p    154.64ms   104.83ms    1.48x
>
> Test 2: munmap latency for different sizes (zram, single process)
>
>   Size       Base         Patched     Speedup
>   64MB       14.11ms      2.18ms      6.47x
>   128MB      29.45ms      4.48ms      6.57x
>   192MB      43.85ms      6.62ms      6.62x
>   256MB      57.01ms      9.08ms      6.28x
>   512MB      115.13ms     55.58ms     2.07x
>   1024MB     229.66ms     153.28ms    1.50x
>
> Test 3: munmap latency for 256MB swap-filled VMA (zswap backend)
>
>   mode        Base       Patched     Speedup
>   single      152.14ms   51.26ms     2.97x
>   multi 2p    186.56ms   105.42ms    1.77x
>   multi 3p    205.83ms   153.32ms    1.34x
>
> Test 4: munmap latency for different sizes (zswap, single process)
>
>   Size       Base         Patched     Speedup
>   64MB       37.83ms      13.26ms     2.85x
>   128MB      75.11ms      26.73ms     2.81x
>   256MB      150.78ms     52.97ms     2.85x
>   512MB      303.04ms     130.38ms    2.32x
>   1024MB     599.95ms     287.10ms    2.09x
>

Hmmm, why are we batching at the zswap/zsmalloc level like this? I
agree with Yosry that this seems like somewhat of an unnecessary
layering violation. For example, do we observe a lot more performance
wins by doing this instead of just simply:

static void zswap_entry_free(swp_entry_t swp, bool deferred)
{
    ...
    if (!deferred || !zs_deferred_free(entry->pool->zs_pool , entry->handle=
))
        zs_free(entry->pool->zs_pool , entry->handle);
}

(basically what you had in the last version).

One weird effect of doing deferred zswap entry freeing like what you
are proposing here, is that the zswap LRU will be littered with stale
zswap entries. Seems like you removed them from the zswap xarray, but
they're still linked into the zswap LRU? At writeback time, that will
throw off the statistics used in the heuristics, and will make
writeback go through a bunch of stale entries, wasting more cycles :)
Seems a bit inelegant, no?
