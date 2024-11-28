Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3E1C4A02
	for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732826423; cv=none; b=bf+4Cfn4NHSsqAav5eNJPWBp/afg+QQxF34w6nSfYgGR+jGADdlbKXdv96wdNW/bzpedRYA/3k9lLK5BzhQNpzjCk1cBaApxvEbQy48xrax8fqTLkdgseV5/xHnZvkKUkB9lmRsB86ONYSoaxwGC/FHUVr+jO1GBooic7aEFBBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732826423; c=relaxed/simple;
	bh=rT4bFkI4iX/dOqaY+yDnxGYI1X3HuNu0QM9S979dKNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8cMmmC8H4KcxTkynCm1T63zeMrmzziVmi+DRpmFlAmqxZLs1gK9SIPbi97MUcAnhPpFMHU0Bb0nS4CZbnlIXqWpiLga/20Zx87cWxY8wl1wVLqOr7Uzupm5FF9KnTvdZUmiAUmrdEQgByhDOkj4Eb+eqaDrJfHnFQ4yVrFiMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AibLprpw; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AibLprpw"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5151e429d53so297027e0c.3
        for <linux-block@vger.kernel.org>; Thu, 28 Nov 2024 12:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732826420; x=1733431220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3P1aoGC68UZcucLqzPRjBqozUFp63miBcm+36jYrHgg=;
        b=AibLprpwOP6Nth8iLfLJed2tk1bh39VS6bDjaRN0Qy8U1Z4uBWdUHI7KnGXwa0pj7J
         d8VqvhGFXIsdoCAHIqWVPF5i6UxHAkODhWKrhLrbO/9zBWIfUuw4N6PV1nMlL7kBglnA
         NtsYQHVd16wfw2U/wDHNZl9y49oMp9t8FNF5nyt4mLJ0IgVbOihYkolfb3Zpb4v/OnrH
         ZHX8s5iWOsWpbGuZkKD7HkMi/04T1lnbOkn+zP2LUGQo1MgxAj6G/WuwEUDnzvAufhdQ
         4nBKQfZkjhZYpgGjpuES2xRoMAYKDqhmz9niLN33Ngyzp5KejWMEe7YssTTlBa+FpBj2
         hpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732826420; x=1733431220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3P1aoGC68UZcucLqzPRjBqozUFp63miBcm+36jYrHgg=;
        b=OHFnmawaL0ZKPCKPMwZsS2KZJpBHrMmovQ7uJJKUYBX+m89WjZEj/SsVEH8RxRUxnf
         OjcxU/aVfzYQMEctNYhHGh2QV3Y2v2P+2wunqZfbVqEjJ9tbDQfPvYq6SMaGDmzFIT5Y
         jtTqbOlTh5W4OEAifQ1i0JydeVZAGCrQb94WirrjF93s+cJiIwUYQHkCPmkTpxhxXKam
         +B8/OVPi8x1pykax1OZTa/c2QnvI5iESJEAOQVwEnuwQVWSNyD8obWYFpwqtHFnIEPR3
         eysb9aONcPQDh6BCNgaeb/uUPwzwtxQnr1wfIGL9u136plcW31oI7LF6z4AhtQsG5LMW
         gCIg==
X-Forwarded-Encrypted: i=1; AJvYcCXMI4dMj9h3sRDrCS4I7L8YH4HvJqs8UtlUFwCSYaJRJC3XAj7fKi2MT4wv4+kn1T6DjZ0JLDftXf6+yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjCzkLNpZ+0qWwRQFsDJOoXJ+cG8YAw9vstZJUMXYcn19dJuMG
	yy09uzqhML8jrKRS0tAPkt8wJLfejvc4+CCsh/LD1iJV4lo5mqng1wJHZNbfBVkfVoWnPGBWsWB
	bdGasT9QouWix6eNKqvV1iFbAArQ=
X-Gm-Gg: ASbGncv7eLValQTRhTGgQDjsWfhc+S2wq6Ah0IrLop9k/0bWoX4D5y0Elx307n37r3M
	J1hXuSQIdZTpfN3vdgijcxCItoAUTzeypoRekUZpZ2vMHHBYgDo5U/uxC/NLxEOwgZQ==
X-Google-Smtp-Source: AGHT+IHDTpsJeK57qYZLuW01Xl7A/sNtOT1rOycHl5x7JLeEh5ZbQ4SCnLfOCOthSCh6hd2y+n9MnP3d2xkHzm6K6oE=
X-Received: by 2002:a05:6122:2a01:b0:50d:85d7:d94b with SMTP id
 71dfb90a1353d-51556ae31f4mr10725984e0c.11.1732826419802; Thu, 28 Nov 2024
 12:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121222521.83458-1-21cnbao@gmail.com> <20241126050917.GC440697@google.com>
 <CAGsJ_4z8BM3SwSsjUd5LMA82y-Ju9Bgo_re18wW2k-nKpLWXyA@mail.gmail.com> <20241127045224.GF440697@google.com>
In-Reply-To: <20241127045224.GF440697@google.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 29 Nov 2024 09:40:09 +1300
Message-ID: <CAGsJ_4wpHMoSk=6UXDNv_r+AR_-TwyQ5bM=sObvgcXinBOhFtA@mail.gmail.com>
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

On Wed, Nov 27, 2024 at 5:52=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/27 09:20), Barry Song wrote:
> [..]
> > >    390 12736
> > >    395 13056
> > >    404 13632
> > >    410 14016
> > >    415 14336
> > >    418 14528
> > >    447 16384
> > >
> > > E.g. 13632 and 13056 are more than 500 bytes apart.
> > >
> > > > swap-out time(ms)       68711              49908
> > > > swap-in time(ms)        30687              20685
> > > > compression ratio       20.49%             16.9%
> > >
> > > These are not the only numbers to focus on, really important metrics
> > > are: zsmalloc pages-used and zsmalloc max-pages-used.  Then we can
> > > calculate the pool memory usage ratio (the size of compressed data vs
> > > the number of pages zsmalloc pool allocated to keep them).
> >
> > To address this, we plan to collect more data and get back to you
> > afterwards. From my understanding, we still have an opportunity
> > to refine the CHAIN SIZE?
>
> Do you mean changing the value?  It's configurable.
>
> > Essentially, each small object might cause some waste within the
> > original PAGE_SIZE. Now, with 4 * PAGE_SIZE, there could be a
> > single instance of waste. If we can manage the ratio, this could be
> > optimized?
>
> All size classes work the same and we merge size-classes with equal
> characteristics.  So in the example above
>
>                 395 13056
>                 404 13632
>
> size-classes #396-403 are merged with size-class #404.  And #404 size-cla=
ss
> splits zspage into 13632-byte chunks, any smaller objects (e.g. an object
> from size-class #396 (which can be just one byte larger than #395
> objects)) takes that entire chunk and the rest of the space in the chunk
> is just padding.
>
> CHAIN_SIZE is how we find the optimal balance.  The larger the zspage
> the more likely we squeeze some space for extra objects, which otherwise
> would have been just a waste.  With large CHAIN_SIZE we also change
> characteristics of many size classes so we merge less classes and have
> more clusters.  The price, on the other hand, is more physical 0-order
> pages per zspage, which can be painful.  On all the tests I ran 8 or 10
> worked best.

Thanks very much for the explanation. We=E2=80=99ll gather more data on thi=
s and follow
up with you.

>
> [..]
> > > another option might be to just use a faster algorithm and then utili=
ze
> > > post-processing (re-compression with zstd or writeback) for memory
> > > savings?
> >
> > The concern lies in power consumption
>
> But the power consumption concern is also in "decompress just one middle
> page from very large object" case, and size-classes de-fragmentation

That's why we have "[patch 4/4] mm: fall back to four small folios if mTHP
allocation fails" to address the issue of "decompressing just one middle pa=
ge
from a very large object."  I assume that recompression and writeback shoul=
d
also focus on large objects if the original compression involves multiple p=
ages?

> which requires moving around lots of objects in order to form more full
> zspage and release empty zspages.  There are concerns everywhere, how

I assume the cost of defragmentation is M * N, where:
* M is the number of objects,
* N is the size of the objects.

With large objects, M is reduced to 1/4 of the original number of
objects. Although
N increases, the overall M * N becomes slightly smaller than before,
as N is just
under 4 times the size of the original objects?

> many of them are measured and analyzed and either ruled out or confirmed
> is another question.

In phone scenarios, if recompression uses zstd and the original compression
is based on lz4 with 4KB blocks, the cost to obtain zstd-compressed objects
would be:

* A: Compression of 4 =C3=97 4KB using lz4
* B: Decompression of 4 =C3=97 4KB using lz4
* C: Compression of 4 =C3=97 4KB using zstd

By leveraging the speed advantages of mTHP swap and zstd's large-block
compression,
the cost becomes:
D: Compression of 16KB using zstd

Since D is significantly smaller than C (D < C), it follows that:
D < A + B + C  ?

Thanks
Barry
