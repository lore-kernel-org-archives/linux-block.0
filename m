Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6C292918
	for <linux-block@vger.kernel.org>; Sat,  2 May 2026 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777706488; cv=pass; b=KzPzCqs2wbj0NiGbgSc/mF2KKsKEhEC4hJNrXiiWEIqlBV2y/oF8vUm4gMhSMTtBpHnFzJWXPkuCeE73wBKuW4plwdj1G+d03E8VLzbGwFjzPGYz1Aaq3I5sCQ+LnoBPlj1DI9N05F3q4/pPJIeTbfGZHSzf7YBlBpTlOf0czdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777706488; c=relaxed/simple;
	bh=7F84FqSVgdll/J3gfhxZgla2DXC4zz+PTtMk5XWN3dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1YeL4ymp1YKA6DoucMkUDYJGClB9vqjs/+bapNGiXku2aLFf5v56RS7GT5Wfa2HaqQxru3HshSnJmbHoYNG5tfNkkdn5GoDEm382AEnU/cu16WrbQrZL5od8uzeaDSNaVDXSgiOHi0IoWH+0PcKxU27bf3pBOi/XxzcKQ6j+CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNv6+itG; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNv6+itG"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so25534755e9.2
        for <linux-block@vger.kernel.org>; Sat, 02 May 2026 00:21:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777706485; cv=none;
        d=google.com; s=arc-20240605;
        b=Q7jV+kXYlh+men0qJETMNKe+35YGhBcFk4zW2NiNEjkRxv7+u/k00yoc8KuNQf/Wt/
         5oC3Vduiy9UMPkR9hT8Ev1k5ACyh3LrhjUA2/ngxVXTey+gakcy1MLZtUWTNditL1AU5
         ZwUxVNdJxRQWP/1GsQMBMBRRhhja9I0vHcRuIxTeoqXdGRfaNGIvDtei1EZ6I0R9xOkJ
         maKgXJqrrDO2u/99RmfF6tKea40+2fw+3+gz3+Eeq/AMVkvKfckfX8LGRmmCVuv/ThPv
         HFJEHtMYVX6jtKgLP1TW1GvPup8LIAUNQ5x4b217c7EE/biIj6svdg6Da3zXwN1YbhkS
         /K/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZpCDGLyqdlQwW4lsWNusxnqIO2tGN0lN9JL64dsGkB0=;
        fh=Pi21Voy3/Se/btEh/FvA/eJP1EzLdYDTkoKnxoEh+V8=;
        b=Xk6z9rR1dUEjpb98wcDuPLi3FJvLNM8+Ikp2NOKuXdVM5Qa+P8YTOhJ5DKyNJFCp9r
         TLUKj3mtiH29qrpC0bo0f7+zIkvqIaZ8dDnj88QfcDMekn1D7LIwCWxtbdwWdcc13aFN
         Odsiji+ydHzoe8gW/0uRn8tP0SC5JC9/e4x7+HKxGpYMthKtdXhDtZesI4BWYHx6cBDf
         pdZeeXd4l8b+RmB5wwYlIZef14G6v0u2/bzLsAuHdq1nYImW5IABYUvbX4hs0EBhhcz9
         C5By6AUTVf44ESGw+AYtxRuuAJqsBBV8CPcN92Y52/aSJGJm7jlImHY6zeyC6YAfk+2k
         v5dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777706485; x=1778311285; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpCDGLyqdlQwW4lsWNusxnqIO2tGN0lN9JL64dsGkB0=;
        b=qNv6+itGlTMeZopw/05Z6ZHI/ovpThMyMJdaffEsvc//w91TgrcSnV/K81f86Hx+X+
         2QSNV++LE6qO5yo44PPwfJe9gSuOXE+CGhRTsric69hIXp6kNBcq96qsIRFuf4di2YB3
         4IJizM7V6ChDCwf8G7w+GOxeLEOe9MAKNwAcOLtdMbkqQeSPPiETQHCFGoEePIeL6zyU
         HzKQ40Uj4Q6oqVxgf1gcGutltn30247Fbujheq6fm4NV+WPbaO7zr+JqT7CxciCep2lv
         8lWYlq7pT3UCCtnS7PhHHUuU81M354owE8WGO2mIJUrHAbaNXIOudjANF/GaDgBk/cbb
         QO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777706485; x=1778311285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZpCDGLyqdlQwW4lsWNusxnqIO2tGN0lN9JL64dsGkB0=;
        b=c2qFDuJPoveYOXlhwVid2DwEShWTjZtywJA8huOwXhDTVgysAuq6BFjPz+a2D77mhZ
         g6Yn30d5gRgHdlroz0vSP65+zodEoCywq2NdF87iDfu6RhpI/eErrFgQojiNWqJISQ3f
         gWD1c6t5Xk2ozN5wSBxjSmQrfYLbNlqvvh5hSt1sELXm0VLJjJzw8wdp526JFc/1uPFK
         7AUi/1I7JTt+8Me/t7WiRUiZ6VU/PHIOQFCwGRBAEyWEgGXxHKAQFXO+4aEO5vejBXgw
         sEIVP4ZCh3Ln0H0OcYKbu0vrMouH0t4tIpd268fOQ1euLjopqr5TgHfZ+fzs8CZpy0N9
         sRTg==
X-Forwarded-Encrypted: i=1; AFNElJ/h/X2crIWsmPGWf4ikFQesioMrSjdS5VV3Jbr7j/jPOBkWi9H9p7JBdQEDhUaq4Newe7FbmgCIjTU1vA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCLD+nYI7woAu2lCpczVsziwRzHkp5gmSaAhyR+bb3fZkOyrt3
	ihqs5/G8T2lEbVjdrXNvt7o2tb6o65pq67Uxji+CZg8nNP55oqKSzYgAlr8PGlBHUAeOsdZSQwl
	hdoZQSohF88wQCI3/a6uvWS57S4neKPxNfIy4Qs4=
X-Gm-Gg: AeBDievFMtqnKMeSviPCrf7rgpGOXhY5mNusgaJjrbWfwHbqk6QdmbTFa/lq+8VQHuL
	SjB1hmOEw1PpeeHpHp64s9Z7dOGDSkQdu4E4HWx3jNksx1t7zFvL1je9aH5jVx0/gc67xj8sQMT
	LDBK7kfUN79LygJEDyNjN6QJBdci1PKWL8vfYj/bG+HiVifjwoKLYIS+fZQO+HiYFvyg1s7heCB
	UeNvIpS1oY6XlLQJRk97mIU1wRzQdbzt3/pcKlUBION9FSxouJ6MPb/nPVW/E9tfp9WP374BQSV
	A+Ts7bVFhInWJur7ZlRWqccr7bEuAlrLOBvv1snBlbUqa8P07rF3VbLw5oQzh1Vm4g==
X-Received: by 2002:a05:600c:4f47:b0:488:b8bc:6a32 with SMTP id
 5b1f17b1804b1-48a988be27dmr31882145e9.23.1777706485082; Sat, 02 May 2026
 00:21:25 -0700 (PDT)
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
From: Nhat Pham <nphamcs@gmail.com>
Date: Sat, 2 May 2026 08:21:11 +0100
X-Gm-Features: AVHnY4JJPCx4iVzK4vXW7jpHkva-oYoA8F0sH-mKu9sI_gFhCrlz3UorVnkOfjY
Message-ID: <CAKEwX=PrfrNys4ao7-d11J7r4pv5VmE8gTU_7iUHaHAKNaFuBQ@mail.gmail.com>
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

On Tue, Apr 28, 2026 at 2:51=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> On Tue, Apr 28, 2026 at 2:17=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > On Sat, Apr 25, 2026 at 9:13=E2=80=AFPM Wenchao Hao <haowenchao22@gmail=
.com> wrote:
> > >
> > > On Tue, Apr 21, 2026 at 8:16=E2=80=AFPM Wenchao Hao <haowenchao22@gma=
il.com> wrote:
> > > >
> > > > Swap freeing can be expensive when unmapping a VMA containing
> > > > many swap entries. This has been reported to significantly
> > > > delay memory reclamation during Android's low-memory killing,
> > > > especially when multiple processes are terminated to free
> > > > memory, with slot_free() accounting for more than 80% of
> > > > the total cost of freeing swap entries.
> > > >
> > > > Two earlier attempts by Lei and Zhiguo added a new thread in the mm=
 core
> > > > to asynchronously collect and free swap entries [1][2], but the
> > > > design itself is fairly complex.
> > > >
> > > Hi Nhat, Kairui, Barry, Xueyuan,
> > >
> > > Thanks for the review. I agree with the direction and have some ideas=
 for
> > > an alternative approach.
> > >
> > > My approach: first eliminate pool->lock from zs_free() itself, then d=
efer
> > > free to per-cpu buffers with a lockless handoff, and finally reduce
> > > class->lock overhead during drain by exploiting natural class localit=
y.
> > > Achieving both per-cpu and per-class is difficult, so the class->lock
> > > optimization is a compromise =E2=80=94 but one that works well in pra=
ctice.
> > >
> > > 1. Encode class_idx in obj to eliminate pool->lock
> > >
> > > OBJ_INDEX_BITS is over-provisioned on 64-bit. For example on arm64
> > > (chain_size=3D8): OBJ_INDEX_BITS=3D24 but only 10 bits are actually n=
eeded
> > > for obj_idx, leaving 14 spare bits.
> > > We can split OBJ_INDEX into class_idx + obj_idx:
> > >
> > >     obj: [PFN | class_idx (OBJ_CLASS_BITS) | obj_idx (OBJ_IDX_BITS)]
> > >
> > > OBJ_CLASS_BITS is computed dynamically as `ilog2(ZS_SIZE_CLASSES - 1)=
 + 1`
> > > (8 bits for 4K pages, 9 for 64K).
> > > Since class_idx is invariant across migration (only PFN changes), zs_=
free()
> > > can extract class_idx locklessly, then acquire class->lock and re-rea=
d obj for a
> > > stable PFN. No pool->lock needed.
> >
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

Oh man, you are eliminating pool lock here right? This would help my
other patch series a lot too :)

https://lore.kernel.org/all/CAKEwX=3DM5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWodwbf1F=
e=3Dgzew@mail.gmail.com/
https://lore.kernel.org/all/CAKEwX=3DPkFiP+u+ThrzjTKBi+usQf2uuhTZcfB2BNNA8R=
boOFDQ@mail.gmail.com/

Well, the deferred freeing would completely move that contention out
of the way lol. But this would benefit all users, regardless of
whether we're deferring the free step or not (for instance, this will
reduce contention between page fault and compaction, IIUC?) I feel
like you'll get some good numbers testing in a system with compaction
and THP enabled, with lots of swap activities. Which is... a lot of
server setup :)

If the deferred freeing is too controversial, this smells like
something that should be upstreamed independently.

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

/*
* The pool->lock protects the race with zpage's migration
* so it's safe to get the page from handle.
*/
read_lock(&pool->lock);
obj =3D handle_to_obj(handle);
obj_to_zpdesc(obj, &f_zpdesc);
zspage =3D get_zspage(f_zpdesc);
class =3D zspage_class(pool, zspage);
spin_lock(&class->lock);
read_unlock(&pool->lock);

It's basically just this blob right?

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

+1 :)
