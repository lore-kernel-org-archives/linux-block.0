Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5773A5E90
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776794892; cv=pass; b=Ja9BsqMURsMEzm9XYz9p9akyVfaDIyCzyok8dpAyoLKfkmru/Bs1eCShWtj9Nm/BGHidSOrqxpMfm1o6QK+QGwmIHqmXd0P9JXBHcodIgOvgb1UVx2ZMPwNRsGLqijM+Yk3UEgN1T1YVa7ktPldwY3daUCG1+dXLd2VM5TJ6dxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776794892; c=relaxed/simple;
	bh=KsgX9m6C8CxQkQ37nZ4Tnr3XLVgFk8OeqKDAsOzJgs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wmb36slH2QS9nwKMKZmzCaBIxnHVTf4PwqVNkb0NVkIf+LeEfuxafWl5j1H54r+noCqhBD1x0UelVCqzrP6lsHArzqbbmTm1XUWmQ+uQ0tAUV3hP/d5SYNJxOr73fUDSrH82pOf6Si2u0L6ZNkWZDxm2uQSeFs93PpZcxz2hvU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3tPySav; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3tPySav"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7badbd7dso2192300f8f.2
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 11:08:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776794889; cv=none;
        d=google.com; s=arc-20240605;
        b=WP0YYqRsq8qKCSCTKqezGhQCJCifhcQi6It44D5+9L6WiFm1Sp5+D4+jB9f0HgeXGH
         dSv+YefQ0eedn8Y3NGeaaUeftCMDYhatqRmCnLNb2PtHQzHzNQRovM2nDIrozuyoohBM
         6BKdhmUobs6+le209U2x/4hPsWhZeZTRvqNWMSxEiBnkmsM9cDenD4Fy3E8Q0+pnnzly
         H5JJX5mJ9SP4yrW5w15eKF9Wdy21GGzwGD+4Ipu/wH9DJ9puw8J9G036leAQOvhudVFT
         Yszih9jyG1TQtyQ4ycoTRoIEgEFL4OYfVo6Vbz14hzsEBelMCeO9mlWfzEOwIq+h+62D
         2KLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KsgX9m6C8CxQkQ37nZ4Tnr3XLVgFk8OeqKDAsOzJgs4=;
        fh=kFRAlb6YOqCIM5ccSBTBrdesssd36jxupgU/UCz8/+A=;
        b=HOE/g27KH4HxbZ/6vI9vp/CZMXRaIwIQvi8zOIL414xn9iQ/qnKxry/MBsTIWdF5mP
         wVl2OWrmBeRATx3kKgIVilloUpRsOO/nxhOCSt+Kd7UNwoSKtWhGkuyBiQShZ/rwo8f4
         Bh2BeKyz8Bwo0KKit+WCwThi3+/AU/1nKW19KV7Hny2DDlhqeOpOhZijsoxQFQrJJB+Y
         P+9GHag3cNiHsyLEBJ1F1jjTvwoeN4Jnnz0SDdFpHSRhmTeU0tx9oTokSblJFL/THJpE
         2ANIMrnxwwHmp3IX+paPp4rDiCCm4kfx9VnN39NIPhUYvzd5Iscifc5MD4yC4WZfDOIH
         xsDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776794889; x=1777399689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsgX9m6C8CxQkQ37nZ4Tnr3XLVgFk8OeqKDAsOzJgs4=;
        b=J3tPySavSeQa+wZ8Qr0Y0IXZI/WjoLSG7aLExZ0H5rHXYzlJdFFvXXBxViKMKzjUZ/
         JFxXRgCzevUM5Wedn1zYeAFTXcbW5/v/GvUKjDYLfaR3dFnYONbQLA7URkh+J07GcHXc
         3Ty69+RYzPLtNw6iqx4KuG7doB1zduY+UTYDqaO/BX8L369ugWRGUgU9y64g4nQvZRbU
         vLCMnjaRaduQt20f47C0rMfAkNHUj0kSesc88tTf+dYDpeYFZIDQfYZpop7w39Irf3me
         f4ZCSgc0tQnF6yD01bj9rbfg9q8Bi1abqCfO10gZyJqu+cbq0eaX5jGc/3bVCixE2/Zq
         Ik7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776794889; x=1777399689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KsgX9m6C8CxQkQ37nZ4Tnr3XLVgFk8OeqKDAsOzJgs4=;
        b=SS+ZhJikXRaD6BbKgl58T8SEidOIPFd2dnS0WR+XOA61Ncr2JlPLbIjvJn3kliytqj
         njFqdf5vC+IoU9sQC62wZl1dEVRpRBvMIyB9LOLcVhLDUganPyDCrM6zgns5q+ZWgoTa
         3JgPcQuwXSI7KxoXHSvQp4EQ5IsFyPIDlcodlMGciKdSWf3/DboGB2UOAEcU/599v9CG
         xmciZ3NUJPBjd/ZpTqGmb+HyxCDdhntzoz/uCDwjA+IImiUHtCWta9ttHDcwiZSpqs29
         CSc/dwC04VLXKt2Yu9yfhgf0PrkbhrDVV5ps9h6TfXQM2R0BwlpMtJwoGxgc/TcORByt
         R4Tw==
X-Forwarded-Encrypted: i=1; AFNElJ/oW4ZgqDX1xeerLvjlWwLHa3okSEnI5I0jxQEZb8wwW+zMetKtdB6dPZU/yHoxAtM5LoHif0SMiyWvww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzqL7fGddBh4TzimKgBZvg38ngYdOUTRNWNqxq7usUkEM77thRg
	yNYOKnMRetDz7gwtfdDsiGws81pfqvHympB6DVHTJZFuSxBr/f10xfBG4aXI7HNfSH+P7NGFr/m
	LEqm8FMyfCk68PCjD9mqnwSkKlhbT4OQ=
X-Gm-Gg: AeBDieube0Y3iTBcZs1NnmDJu8AW1qwFBZ+vs9veIx5xylLzLS2cS1ZCQSAqxsTo/C9
	7yCbJoCIO5FC0HJcAzBrifnlNQFp+cunlBXTjBT2yOo9W2zGYnDx6WhTGuhf4EdYNTBk7l/h5Hy
	lxBndgTIXapCApzPQoVtaHneXBGPcDn0X+b43W4LYTrM08Mam10DhPpdVFjdHQDZwVCL0DVmhbI
	JG3f/ben8PVa/ork5JM60RFNKEavWhrLsGQB/twb76Dknq++rczrtcUmFH05EZHkW1NB98r3KCD
	Hl9B1n6KaMnOf63w9254ti5kbOpnIkHgLajp6LK0FmX5vWzM7IiDUXX3vZl2WGMnTtpkTzWgFyq
	a
X-Received: by 2002:a5d:4b81:0:b0:43f:e721:76ca with SMTP id
 ffacd0b85a97d-43fe7217864mr16856624f8f.45.1776794888852; Tue, 21 Apr 2026
 11:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <CAKEwX=M5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWodwbf1Fe=gzew@mail.gmail.com> <CAMgjq7Ae_VH6mLQito5MFnxmp7ScZvF9xw4P-yU-yUBkPZ9_YQ@mail.gmail.com>
In-Reply-To: <CAMgjq7Ae_VH6mLQito5MFnxmp7ScZvF9xw4P-yU-yUBkPZ9_YQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 21 Apr 2026 11:07:56 -0700
X-Gm-Features: AQROBzDE8Aq5HdmW60NHS0U7vvLQGFi9pUSjLXorhoU341mxwA5GKtAt9XQb5K0
Message-ID: <CAKEwX=PkFiP+u+ThrzjTKBi+usQf2uuhTZcfB2BNNA8RboOFDQ@mail.gmail.com>
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

On Tue, Apr 21, 2026 at 10:18=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Tue, Apr 21, 2026 at 11:55=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wr=
ote:
> >
>
> Thanks for adding me to the Cc list :), Barry started this idea with
> ZRAM, which looks very interesting to me.
>
> > On Tue, Apr 21, 2026 at 5:16=E2=80=AFAM Wenchao Hao <haowenchao22@gmail=
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
> > > When anon folios and swap entries are mixed within a
> > > process, reclaiming anon folios from killed processes
> > > helps return memory to the system as quickly as possible,
> > > so that newly launched applications can satisfy their
> > > memory demands. It is not ideal for swap freeing to block
> > > anon folio freeing. On the other hand, swap freeing can
> > > still return memory to the system, although at a slower
> > > rate due to memory compression.
> >
> > Is this correct? I don't think we do decompression in
> > zswap_invalidate() path. We do decompression in zswap_load(), but as a
> > separate step from zswap_invalidate().
>
> It's not about decompression. I think what Wenchao means here is that:
> freeing the swap entry also releases the backing compression data, but
> compared to freeing an actual folio (which bring back a free folio to
> reduce memory pressure), you may need to free a lot of swap entries to
> free one whole folio, because the compressed data could be much
> smaller than folio and with fragmentation. And swap entry freeing is
> still not fast enough to be ignored.

Ah I see yeah. That's the not "as much bang-for-your-buck" as folio
freeing category. I agree on this point.

>
> >
> > zswap/zsmalloc entry freeing is decoupled from decompression. For
> > example, on process teardown, we free the zsmalloc memory but never
> > decompress (if we do then it's a bug to be fixed lol, but I doubt it).
> >
> > Zsmalloc freeing might not be worth as much bang-for-your-buck wise
> > compared to anon folio freeing, but if it's "expensive", then I think
> > that points to a different root-cause: zsmalloc's poor scalability in
> > the free path.
>
> That's a very nice insight. I had an idea previously that can we have
> something like a zs free bulk? Freeing handles one by one does seem
> expensive.
> https://lore.kernel.org/linux-mm/adt3Q_SRToF6fb3W@KASONG-MC4/
>
> It might be tricky to do so though.
>
> It will be best if we can speed up everything, doing things async
> doesn't reduce the total amount of work, and might cause more trouble
> like worker overhead or delayed freeing causing more memory pressure,
> if the workqueue didn't run in time. Or maybe a process is almost
> completely swapped out, then this won't help at all.
>
> I'm not against the async idea, they might combine well.

Completely agree! I was thinking about batching the free operations
for zsmalloc. Right now seems like even if we have a contiguous range
of swap slots to be freed, we call one
zram_slot_free_notify/zswap_invalidate at a time, which then call
zs_free one at a time? I wonder if there's any batching opportunity
here. Might be complicated with the pool lock and class lock dance in
zs_free() though :)

And yeah the async stuff is orthogonal too.

>
> >
> > I've stared at this code path for a bit, because my other patch series
> > (vswap - see [1]) was reported to display regression on the free path
> > on the usemem benchmark. And one of the issues was the contention
> > between compaction (both systemwide compaction, i.e zs_page_migrate,
> > and zsmalloc's internal compaction, but mostly the former).:
> >
> > * zs_free read-acquires pool->lock, and compaction write-acquires the
> > same lock. So the compaction thread will make all zs free-ers wait for
> > it. I saw this read lock delay when I perfed the free step of usemem.
> >
> > * If this lock has fair queue-ing semantics (I have not checked), then
> > if there a compaction is behind a bunch of zs_free in the queue, then
> > all the subsequent zs_free's ers are blocked :)
> >
> > * I'm also curious about cache-friendliness of this rwlock, bouncing
> > across CPUs, if you have multiple processes being torn down
> > concurrently.
>
> That's interesting, when I mentioned zs free bulk I was thinking that,
> if we have a percpu queue, at least we may try read lock that on every
> enqueue, free the whole queue if successful, then release the lock.
> I'm sure there are more ways to optimize that, just a random idea :)

Yep! Would be nice to have some perf trace to pinpoint where the overhead i=
s.

On my end, I perfed the free phase of usemem. It varies a bit based on
exact build config, kernel version, or even between runs, but the
cheapest I've seen for the pool lock contention overhead is about 3%
of the free phase (this is on baseline, not vswap kernel). That's
pretty big (bigger than vswap overhead even on the kernels with vswap,
which is kinda silly). Obviously the host was very overcommitted, so
compaction was running in the background at the same time, but
still...
