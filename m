Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801DC363C49
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776795945; cv=pass; b=rGKMee4ZDonBiLe0TRPGq8DFt00xS5Hlyb1dWrs+JdnegYKELqVAySjiAtGNu30ralrHWVXoNTlj28Tl8CchXEJ0Jl6c16PeJH7NUt/A3c6MogkRfAfZ94shVluFzYTT4lHz98nFYsT7fJFP7PustkvPazeCNegIQVrhIiXaS0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776795945; c=relaxed/simple;
	bh=NGNVm9zrX5VPxV9fNljn1MfMSVg92KMIPymCnJ6l6Fg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E6ExFWML/KYMAfj5PO+NmsRTls45De51iw5a0ep83/eC8UhifQhD90TZ4lUsH3o92HlBlXT74sSY77Xd58TA40G12h+9vLunKN4YxQlSl05FqYlOIS5l10of6vZZvWarPxPbEI2lp86kmPfYgA7LLCBwKyj+WolRezlaGqg7XcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW9QDp+k; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW9QDp+k"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so35975985e9.2
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 11:25:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776795930; cv=none;
        d=google.com; s=arc-20240605;
        b=TQeB87i3ZnRs1QWHdi6AtRNOsPPre3XY0FAKAIR14BZ96jcxHwiOPKK8jeZ52btIOM
         vGCeAc9vKR65Y6gnBkiyvKuIaafRYo1iULPeHYh3SoI+WZ23E9/MVDUJuIgvmJSvi/yK
         1dQOEFshVlU4s69VogsIWnHtPcVrTbfiKg0WwIbzdjctUiumOK+zhRkSLYKZVlZBDDfd
         0RbUpnEW0vkaTHY38cbcw41Ai0RttF3ZI/zNrUfEAvrxwebSSKUmHQQnrBdAGQUfTBSB
         8O0BLeuIO4/HiJgNqDdYGJlX+/gzbqVT7ym30WAJgc11Uh0Khcs6TofY/GIVOZGHHgf5
         sEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NGNVm9zrX5VPxV9fNljn1MfMSVg92KMIPymCnJ6l6Fg=;
        fh=I5imLMfHZ0RJszjyDeNYnO8N//iRqYJh70ToQY6Ymys=;
        b=fNlxyOuNGyeiRiuUWUIgi3UHhjMFwf/hadtkCKKiAkdDGYSVMWKQ6W+4VgGLCQXR2D
         2eNpLlReaGwnDs11V0W6E1ZjkovKgeAfYdh4ouBP/xZrbtBQQ7k4DEitoPrunTm2X4Ch
         X0jpXwLMFMcxxBq4h81YIyOXKyNV9mqyTo+GnaOuopJ4l3GWwSO/xsWr1/W9VeQ2QV3M
         JkcDVHR1SwFBolIpIf2RDOXdKrICKF1OSMfH1zp42vRM91/LEbywV3oXjzvUPnQUr42t
         aEyRR81g3Y2o61CzMKpwn9nWrLFfHpalK1Gks0ZnQd3RMWZBhg/FghcsDwYw812vUquA
         xi4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776795930; x=1777400730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGNVm9zrX5VPxV9fNljn1MfMSVg92KMIPymCnJ6l6Fg=;
        b=AW9QDp+kIba3dfnamytZqOmmkB0JlWySKxZa6K/cY4KobZ0eGFH/VyakGHKLQNxmzA
         8ALLfaDZqxwFZl5bhg6pU7TVGWj5UmMd7t93BtSjPQlcIMEtJniLSQGPO8hlLaJxYpeb
         qVxrmEcSXdK6vZra4iUjIbsbmHIfdsgJrp22k39YzShDbttR+EQLl2cxHQA5bPPNZX+7
         79+zwmidzCsamiGJqUv2s4KWocGKUy2Oor2eOalRfGiQK0sAJCVjkNbVF1Rs2VttdSKz
         1y4T/VIFKavbdsxIB0vUiS3W7/Lt+fVeo9FHRIvmOpLZqrh7ShBp5/C/qVM4c5Ru8RU0
         /eEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776795930; x=1777400730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NGNVm9zrX5VPxV9fNljn1MfMSVg92KMIPymCnJ6l6Fg=;
        b=lLUKeux6UifFJ0RlXBZtNJ23XNdcANLpvqoi8I80golm2uMX+ESyALcaY6VIdyCp7e
         pDU8Jzewc/CZXwvrAYrtot43NxJfrHnOgSxXo4ayyTYDqBYffWpYGJLh2LUCtZ3GXf6/
         eE6yHiioQE5X/DcfEu3JPy8kNQudq+vbcU+RThKe5w4QNPQAzv0b3xT7IyAc5KjgIKB/
         oMzaSAxew6Jnglc8RieE5V0jbMmRzRHMQMeX74x/RnCpK9o+YRKElvbM0b7Rh7WnebHm
         EUfWYFRAAOVEhPs2/ZHjsWbM9eCXYm/4Xjx3BjS3QMZhGykNl/6jJC/XzPt8VARt6tvY
         Ak/w==
X-Forwarded-Encrypted: i=1; AFNElJ+m7oGmBIqg6ul2x+yNFtF97BGVXeKTRlJMg1Cu+bvyla/mmnZc5u888dIpMxnbGDa4u8OVXrwPZnPJRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv078U/KFn1mq6JRo99TskaqTfdT1Sl8UOzexhGWcf9Yt5na/j
	Aukothsyz6+oMNrIv5OXkEL/SQaBdzD6LI3f0i4ABnTbQcBZDYIAYBnJqkUXGzoVEb2YHqLFu0B
	bV6prmHwJ33C6ZAskk/6NAyhmFEQ0Egw=
X-Gm-Gg: AeBDies66+e5amA+xaKL0w2UwP5WBdg+JZkR5jTmoJO82y9ROgWEjenZTh6/nF0ScJ3
	10xvrUeAAsMSwi08bYBWXhXoN0oO2bissuKAlYL4jpFPUpEtkrsCcdsRSaKe2K6iTpkuYNNx/x4
	CjXwBmGIZTFgOwYGlN8a5bvHoYhU7iLb+3vb6AgmM8cg9XW5RKi8uop4VDlWjtecugIEbZ7pmjA
	jTza0tFFAv3IzSoWwmWBmVpDm0E6CHBFP0ZteE1cQHWscDZnR6NWEJHg/SF17QC/HfYxBUkXauk
	48SO7Dt0zqhFXYqTvYDmh+DehJO4d4f+IU0Q345TjHoyZqjBksLiPNqsdY6DyK1pAQ==
X-Received: by 2002:a05:600c:4f0c:b0:489:1c1f:35e6 with SMTP id
 5b1f17b1804b1-4891c1f38c8mr155126095e9.6.1776795930023; Tue, 21 Apr 2026
 11:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAKEwX=M5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWodwbf1Fe=gzew@mail.gmail.com>
 <CAMgjq7Ae_VH6mLQito5MFnxmp7ScZvF9xw4P-yU-yUBkPZ9_YQ@mail.gmail.com> <CAKEwX=PkFiP+u+ThrzjTKBi+usQf2uuhTZcfB2BNNA8RboOFDQ@mail.gmail.com>
In-Reply-To: <CAKEwX=PkFiP+u+ThrzjTKBi+usQf2uuhTZcfB2BNNA8RboOFDQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 21 Apr 2026 11:25:17 -0700
X-Gm-Features: AQROBzC-rJgxzCf4AEfBtKywwh9ODlZ3G4_DuI0Dp7qwX0yZHQjPPr7bI0C_LBc
Message-ID: <CAKEwX=P6L=CeJCXkC+cKbZKYk_ORho3pLy476c8=BbDianx=vg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Kairui Song <ryncsn@gmail.com>
Cc: Wenchao Hao <haowenchao22@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 11:07=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Tue, Apr 21, 2026 at 10:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > On Tue, Apr 21, 2026 at 11:55=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> =
wrote:
> > >
> >
> > Thanks for adding me to the Cc list :), Barry started this idea with
> > ZRAM, which looks very interesting to me.
> >
> > > On Tue, Apr 21, 2026 at 5:16=E2=80=AFAM Wenchao Hao <haowenchao22@gma=
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
> > > > When anon folios and swap entries are mixed within a
> > > > process, reclaiming anon folios from killed processes
> > > > helps return memory to the system as quickly as possible,
> > > > so that newly launched applications can satisfy their
> > > > memory demands. It is not ideal for swap freeing to block
> > > > anon folio freeing. On the other hand, swap freeing can
> > > > still return memory to the system, although at a slower
> > > > rate due to memory compression.
> > >
> > > Is this correct? I don't think we do decompression in
> > > zswap_invalidate() path. We do decompression in zswap_load(), but as =
a
> > > separate step from zswap_invalidate().
> >
> > It's not about decompression. I think what Wenchao means here is that:
> > freeing the swap entry also releases the backing compression data, but
> > compared to freeing an actual folio (which bring back a free folio to
> > reduce memory pressure), you may need to free a lot of swap entries to
> > free one whole folio, because the compressed data could be much
> > smaller than folio and with fragmentation. And swap entry freeing is
> > still not fast enough to be ignored.
>
> Ah I see yeah. That's the not "as much bang-for-your-buck" as folio
> freeing category. I agree on this point.
>
> >
> > >
> > > zswap/zsmalloc entry freeing is decoupled from decompression. For
> > > example, on process teardown, we free the zsmalloc memory but never
> > > decompress (if we do then it's a bug to be fixed lol, but I doubt it)=
.
> > >
> > > Zsmalloc freeing might not be worth as much bang-for-your-buck wise
> > > compared to anon folio freeing, but if it's "expensive", then I think
> > > that points to a different root-cause: zsmalloc's poor scalability in
> > > the free path.
> >
> > That's a very nice insight. I had an idea previously that can we have
> > something like a zs free bulk? Freeing handles one by one does seem
> > expensive.
> > https://lore.kernel.org/linux-mm/adt3Q_SRToF6fb3W@KASONG-MC4/
> >
> > It might be tricky to do so though.
> >
> > It will be best if we can speed up everything, doing things async
> > doesn't reduce the total amount of work, and might cause more trouble
> > like worker overhead or delayed freeing causing more memory pressure,
> > if the workqueue didn't run in time. Or maybe a process is almost
> > completely swapped out, then this won't help at all.
> >
> > I'm not against the async idea, they might combine well.
>
> Completely agree! I was thinking about batching the free operations
> for zsmalloc. Right now seems like even if we have a contiguous range
> of swap slots to be freed, we call one
> zram_slot_free_notify/zswap_invalidate at a time, which then call
> zs_free one at a time? I wonder if there's any batching opportunity
> here. Might be complicated with the pool lock and class lock dance in
> zs_free() though :)
>
> And yeah the async stuff is orthogonal too.
>
> >
> > >
> > > I've stared at this code path for a bit, because my other patch serie=
s
> > > (vswap - see [1]) was reported to display regression on the free path
> > > on the usemem benchmark. And one of the issues was the contention
> > > between compaction (both systemwide compaction, i.e zs_page_migrate,
> > > and zsmalloc's internal compaction, but mostly the former).:
> > >
> > > * zs_free read-acquires pool->lock, and compaction write-acquires the
> > > same lock. So the compaction thread will make all zs free-ers wait fo=
r
> > > it. I saw this read lock delay when I perfed the free step of usemem.
> > >
> > > * If this lock has fair queue-ing semantics (I have not checked), the=
n
> > > if there a compaction is behind a bunch of zs_free in the queue, then
> > > all the subsequent zs_free's ers are blocked :)
> > >
> > > * I'm also curious about cache-friendliness of this rwlock, bouncing
> > > across CPUs, if you have multiple processes being torn down
> > > concurrently.
> >
> > That's interesting, when I mentioned zs free bulk I was thinking that,
> > if we have a percpu queue, at least we may try read lock that on every
> > enqueue, free the whole queue if successful, then release the lock.
> > I'm sure there are more ways to optimize that, just a random idea :)
>
> Yep! Would be nice to have some perf trace to pinpoint where the overhead=
 is.
>

Ah OK - I found this thread now:

https://lore.kernel.org/linux-mm/20260414054930.225853-1-xueyuan.chen21@gma=
il.com/

Hmm, free_zspage() and kmem_cache_free().

* kmem_cache_free() is just handle freeing. Bulk-freeing?

* free_zspage() looks like just ordinary teardown work :( Seems like
we're not spinning any lock here - we just try lock the backing pages,
and the rest is normal work. Not sure how to optimize this - perhaps
deferring is the only way.
