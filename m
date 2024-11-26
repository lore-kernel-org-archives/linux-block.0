Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E691DDC35
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652451; cv=none; b=DQgZ/9JUg+rfjkJeu3JxDcM0ee2UCl7w+7JUacszykHaWQwDmGKuK4HFPd2vy7Nsqaws9djXjTDkZJygxxgxsyWPmeLTzKYcS05uUos1kloEqier7CAuS/7VlVjvjbfYlsEaXN3+xQ9nfGF57VjCrrJzFftqjtpbdqas+nqIV1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652451; c=relaxed/simple;
	bh=oV2CspVj8AdhBCqTiYrqHLiKtPmvOuPGp80JRoC8anI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeV1X/oHBhiXBrxJXT9C6o1Q5fTaa10fWsz5Fry7HLiZJzQwy4e68qYVai0LoRFypSMdtRXnm604Yg1yKg0q+/Ze879OwotO7U8wzIOfqt+JXZXwtbK7NIkk4nCI8TpGdpYp/H9girKNKTYXmyul4H6Qg6jM/gz8lxBsguFZglA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjCyZwm5; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjCyZwm5"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5f1f81e51b1so994404eaf.3
        for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 12:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732652449; x=1733257249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQql4Y5I+YPwVO2ky+hnTzFQ7Ll10AQ/5pNTZ0v08Yw=;
        b=UjCyZwm5mMBavvvYCKcBwU/It0XE5nKYeCMm/Mvwqd+bQ9xayTfINqK+GIv5kiQSt6
         jOsL9bywrf72rH1409As6D6aL2S3xPe9LtSuTbvPgSGnZnbr43WQz54fH9DpCKhHMg3Z
         wGXR5IXdDtYyOj1s2rGiAU+2BdmymAPlu2mG+C/+Zx688X2a4n3TRm4iT/l5EZ0UQPyR
         JjG5d+eL3uUQWZ0pwGY8KaYQbG+zF/ggmnXcwBZSyhH6ylXN810lDtBNyAqd7cQuoE/v
         m1sYkqU/UD6E29LdKHCQouun9VVB4JdTUmfyFi2toAd7S16eBCUzkBYi20m14YNcepx1
         gjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732652449; x=1733257249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQql4Y5I+YPwVO2ky+hnTzFQ7Ll10AQ/5pNTZ0v08Yw=;
        b=O0UFoNokAhD8U3zMytTMRelSBX5BsiajqIR2acMjsVnFngxceW7x2pK2UjzuwDJHVa
         ypySwSzQfZlZAJxLIT9uYm+URuDQG+Ribe7l0q/5NniH0z9MDg30w+Cxk9b7agOtu2MA
         fWrTwW5I6BUPYuB2XpR18LpDjIupAlTLhmf4HpGdyllj2ht0YbdApuOKZdTe0VrMBBN/
         P3aEiaJRRJ43GMWjD46CnCBaGnhnVxit04ru+S84D4MM2YGw/4J2JxQyWrDbXYz8Z41K
         ytZG0seJOFd3aF27SSpzwrUGuxWULj1prrtJFHcAfExO9kwuIL4gDQ5dzenkU6PJSuDY
         J73w==
X-Forwarded-Encrypted: i=1; AJvYcCXwTIJiCl8I2e+NgqdmYrLJtpLT2tXjz/jlUeL6oY+lf0EGPAkFWRB6jMaiVkib8njGi3+RqA8Nrxa4xg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1aqJdQ9i+s4ovMncQiciH3v0NeupONGD3XnV470cAE6G48ONL
	5HtQfxw3AyZmZlxNgAqSmgzHRsRaStB281oK7EuHF7rDyxn1Rr+fb3MQdXEFVAtpLtfpoNQ7/AP
	4OJi6SfEW8w4v0mO7nt44OpTnvwZYDP3w
X-Gm-Gg: ASbGncs6izOePXyxClt32TAoxDo9lK0UaAcYnYDXv0O2iHqdtAklsDsuGcchP0s0T34
	WF7uV4ZN/NHEbzhAAwpARlcmIrZnFkllPEjdIYKOI3VL+/vRYCedcTtCEWCy3fgAihw==
X-Google-Smtp-Source: AGHT+IGvxWf6P3bvvD29v+jrSBd3DPZLplPo9lbJC1ZwvkWgel8Rr3anmPdeC56rfKubNGneB2SnNqI1WAtilsQT+jI=
X-Received: by 2002:a05:6358:7184:b0:1bc:45bc:81f0 with SMTP id
 e5c5f4694b2df-1cab15d3a16mr104283455d.11.1732652449165; Tue, 26 Nov 2024
 12:20:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121222521.83458-1-21cnbao@gmail.com> <20241126050917.GC440697@google.com>
In-Reply-To: <20241126050917.GC440697@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 27 Nov 2024 09:20:37 +1300
Message-ID: <CAGsJ_4z8BM3SwSsjUd5LMA82y-Ju9Bgo_re18wW2k-nKpLWXyA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/4] mTHP-friendly compression in zsmalloc and zram
 based on multi-pages
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, axboe@kernel.dk, 
	bala.seshasayee@linux.intel.com, chrisl@kernel.org, david@redhat.com, 
	hannes@cmpxchg.org, kanchana.p.sridhar@intel.com, kasong@tencent.com, 
	linux-block@vger.kernel.org, minchan@kernel.org, nphamcs@gmail.com, 
	ryan.roberts@arm.com, surenb@google.com, terrelln@fb.com, 
	usamaarif642@gmail.com, v-songbaohua@oppo.com, wajdi.k.feghali@intel.com, 
	willy@infradead.org, ying.huang@intel.com, yosryahmed@google.com, 
	yuzhao@google.com, zhengtangquan@oppo.com, zhouchengming@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 6:09=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/22 11:25), Barry Song wrote:
> > When large folios are compressed at a larger granularity, we observe
> > a notable reduction in CPU usage and a significant improvement in
> > compression ratios.
> >
> > This patchset enhances zsmalloc and zram by adding support for dividing
> > large folios into multi-page blocks, typically configured with a
> > 2-order granularity. Without this patchset, a large folio is always
> > divided into `nr_pages` 4KiB blocks.
> >
> > The granularity can be set using the `ZSMALLOC_MULTI_PAGES_ORDER`
> > setting, where the default of 2 allows all anonymous THP to benefit.
>
> I can't say that I'm in love with this part.
>
> Looking at zsmalloc stats, your new size-classes are significantly
> further apart from each other than our tradition size classes.
> For example, with ZSMALLOC_CHAIN_SIZE of 10, some size-classes are
> more than 400 (that's almost 10% of PAGE_SIZE) bytes apart
>
> // stripped
>    344  9792
>    348 10048
>    351 10240
>    353 10368
>    355 10496
>    361 10880
>    368 11328
>    370 11456
>    373 11648
>    377 11904
>    383 12288
>    387 12544
>    390 12736
>    395 13056
>    400 13376
>    404 13632
>    410 14016
>    415 14336
>
> Which means that every objects of size, let's say, 10881 will
> go into 11328 size class and have 447 bytes of padding between
> each object.
>
> And with ZSMALLOC_CHAIN_SIZE of 8, it seems, we have even larger
> padding gaps:
>
> // stripped
>    348 10048
>    351 10240
>    353 10368
>    361 10880
>    370 11456
>    373 11648
>    377 11904
>    383 12288
>    390 12736
>    395 13056
>    404 13632
>    410 14016
>    415 14336
>    418 14528
>    447 16384
>
> E.g. 13632 and 13056 are more than 500 bytes apart.
>
> > swap-out time(ms)       68711              49908
> > swap-in time(ms)        30687              20685
> > compression ratio       20.49%             16.9%
>
> These are not the only numbers to focus on, really important metrics
> are: zsmalloc pages-used and zsmalloc max-pages-used.  Then we can
> calculate the pool memory usage ratio (the size of compressed data vs
> the number of pages zsmalloc pool allocated to keep them).

To address this, we plan to collect more data and get back to you
afterwards. From my understanding, we still have an opportunity
to refine the CHAIN SIZE?
Essentially, each small object might cause some waste within the
original PAGE_SIZE. Now, with 4 * PAGE_SIZE, there could be a
single instance of waste. If we can manage the ratio, this could be
optimized?

>
> More importantly, dealing with internal fragmentation in a size-class,
> let's say, of 14528 will be a little painful, as we'll need to move
> around 14K objects.
>
> As, for the speed part, well, it's a little unusual to see that you
> are focusing on zstd.  zstd is slower than any from the lzX family,
> sort of a fact, zstsd sports better compression ratio, but is slower.
> Do you use zstd in your smartphones?  If speed is your main metrics,

Yes, essentially, zstd is too slow. However, with mTHP and this patch
set, the swap-out/swap-in bandwidth has significantly improved. As a
result, we are now using zstd directly on phones with two zRAM
devices:

zRAM0: swap-out/swap-in small folios using lz4;
zRAM1: swap-out/swap-in large folios using zstd

Without large folios, the latency of zstd for small folios is
unacceptable, which
is why zRAM0 uses lz4. On the other hand, zRAM1 strikes a balance by combin=
ing
the acceptable speed of large folios with the memory savings provided by zs=
td.


> another option might be to just use a faster algorithm and then utilize
> post-processing (re-compression with zstd or writeback) for memory
> savings?

The concern lies in power consumption, as re-compression would require
decompressing LZ4 and recompressing it into Zstd. Mobile phones are
particularly sensitive to both power consumption and standby time.

On the other hand, I don=E2=80=99t see any conflict between recompression a=
nd
the large block compression proposed by this patchset. Even during
recompression, the advantages of large block compression can be
utilized to enhance speed.

Writeback is another approach we are exploring. The main concern is that
it might require swapping in data from backend block devices. We need to
ensure that only truly cold data is stored there; otherwise, it could
significantly
impact app launch times when an app transitions from the background to the
foreground.

>
> Do you happen to have some data (pool memory usage ratio, etc.) for
> lzo or lzo-rle, or lz4?

TBH, I don't, because the current use case involves using zstd for large fo=
lios,
which is our main focus. We are not using lzo or lz4 for large folios, but
I can definitely collect some data on that.

Thanks
Barry
