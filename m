Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362612F1FC3
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776791890; cv=pass; b=jpE3ZYhc+7e0sx/YzkMQhvSFIrSfRxURbjWJiLGWnJgDsVExbXaztNvUJPuP4xgA5PjRKYSpU2du8uDIwtVi1H+aPbwfIJ2dmrGUkLFeM7zMnbRpqLXf7ru50qsruhefvuY5z3I8Xw08vzU4y2E05nXtjwZgkD6qPljuCqXcKmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776791890; c=relaxed/simple;
	bh=E7ItgLjIpZNkuf5BX0aU2dqcjEZOqGH3BDxCcKBSagI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBo4gVH3mLDw1jCGXPcTWv8kXp+Br++0WOsYL8c1bPBJHramqf95XkORZnKZpTr/CGf8nuu2P/KvEoLZ9MfplfnFZTFCx3u5vC+Kokjs0D6m/SYdnwoLf4JOA/g101DwZ9+6p26fRAN3SNyTfrxvAfvT80hWSQH4wAmvCicY4ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8/A2SOz; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8/A2SOz"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba6838e76f2so358998566b.2
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 10:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776791885; cv=none;
        d=google.com; s=arc-20240605;
        b=Sm8MaJhKMPuZUact0A0KfYaEndFOSlRhlsM74RocKufyjrzIQzrlp+y6yb7l/7TZio
         1JxuN8QhZn6OpMO3yDUZIg9Fjc7PrCxi1jVvUUh276Y8iG1S8P6DHeciTIXixWNwUWbp
         kPIVRddYpHZBA2af1KJRPtDm1naoVUXUjdMg1aQVIL08Y4tvi/tlcN6VD3NdQm6B+zey
         6xRJor9BFKUbVyS2YjMKkwQo/BEugX6uuKe814vkX9W/b3oNDQe7MGKs2e373PKGXsiz
         stOJa/MgW7yOcyWwohXAT/HZCpDQG+bvUJxrfLk8trUD+qQDC4dJTPadRzz0moMLLCda
         KQmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E7ItgLjIpZNkuf5BX0aU2dqcjEZOqGH3BDxCcKBSagI=;
        fh=j180iUQE8tMerL7eQ8OgePU0M+gTYaSuCAIh8D+kf8U=;
        b=lhR8oyi1djgBmIt2sKinjGDp7EWPXHa8jnk1pWk1TtgNwBM2EGYR5pEO1LgrbBqmxY
         iMOjs6yBg5eycCwLyc9y1nBKTlo+ke+DKD92ciDL7oIqnrjPaHGd9nFBrS5dSg8C/DQo
         eOo4c+x2iKMNqgmpDtTCg2W6mBOwnmP1Xjf4jDjJvmTaZn2OjBs+audO+89BNbhz/Ubm
         N/AhOKly1oz0CEz14r9OT1KjQ53b9MoStOkdw857Na35X9JhPKqSpLQZrKcGa2PXEadZ
         BVJbUpnYsRjXHeV7Ttk6TSJntogSVZykTJx0J4UyWNxuX8KdcaZfwQcBF83Y/VUAdvqn
         mlXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776791885; x=1777396685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7ItgLjIpZNkuf5BX0aU2dqcjEZOqGH3BDxCcKBSagI=;
        b=P8/A2SOzq//yGxhl/VkLvjSwkZChAP0EmFw8SpkD59SQQMryfY60hSidszpbTdl3jr
         oV477Z1h+c6Ut/u5BdKdd0atW67TRWDRG3mw5h7Z84gPecIgplWmiV2C5qqVqzPIla/i
         WmKgaiTSCjF/fLFiY6xIaNQLJgg5teZ7n+1UXmQGClIjdkhME4RZZ1635oUUqcJbRo5+
         Dm+m1/u9BMZaEhfMv9re0RGhxx6Uxs/Adrpv6aRwX6fuQY+yAU0b7RtXJwYqYJFhq/KU
         jbU1J9n73IZYCpLFpQ4r4iln7S+vfi/0N3vdAwkkSuNxmaGXBpfpq/Zay58ZImqL7AyX
         G5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776791885; x=1777396685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7ItgLjIpZNkuf5BX0aU2dqcjEZOqGH3BDxCcKBSagI=;
        b=p5mXygD1CX5VyZ1x92r9NFQRJs3ci2ZowVsLEorPAKEwj078fIK7UoEJUkH0MEYL/S
         Xusn2w/m9BibP9gxhZJUUz7LyvVtcSd3SzMyoXEave45SzR/KjfABmarVbO/nDOuvtXt
         whdUtreZLhEVw4mJMSm+IFhDcDieUGbkMPfwgq52vfmHH1RK5BFXNZqzfkKb1wqxN9js
         c8jFe3ZuspvRmcYRbH/U1xQoBqk3HAxmo6UI+W7bGtqpiQCPPblRdP5UAiQwowDdKBxr
         cHnEaUdMMCWY/i36PZ9vqZrVwZe4oRe6oYw1cgJBowFcYrQHwym9H9J/yMRdJ7tu3qk6
         GVJw==
X-Forwarded-Encrypted: i=1; AFNElJ8eMQd9GotSODqoslWGtNzqlTtkyiI4FMxaZRFAPweI5OseIlV3QqRlrvDjGNTbReMK0BYBBzhT0glhow==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sk4F8q24Hl/cIMA1kFHNrqU0IlqkWhQTh0DlXJW8YOItVfcn
	RN5to3Yo8q3PS30qXFu0y98rzxUPiWx8UbzqhzDb1VF1fkbi3na3W6EW39d1kDGzY8saJlPFh97
	6ILEd0lqXY24MivoenbYLHwCovjfkJSA=
X-Gm-Gg: AeBDieuAxUnvx9rfaQ8dlxVX63Jd0t97RE7yUEpPNwqPTSsiDUUm7J/mXt+xWQbmYnl
	eDIburLD8aBhNFTN61Bribuwz9hPaZyzGDRR7ZSfqF7ILTOvJZ/iR3Y17W4pwerZfgH3qiMABIT
	by5ke4+OYW56F835O6ZIHWQwk8MqaPUWMXwXFGUdYw+soPh1AzL11hwm3Q9lXMu89P15JlF+sef
	BhOPGRTNUmvs5suANOAVinkSbIhQU6pvBvoYD+fsQia3NYB+t+AlJz7p4K9Ecal0oIUu2UZvhA1
	0+A86tbRhh7BW0R48bMNLRBYwzCVej9mnKmsnvXmd/BQfcjvyLo=
X-Received: by 2002:a17:907:705:b0:ba9:4db4:1671 with SMTP id
 a640c23a62f3a-ba94db416fdmr262191966b.22.1776791884727; Tue, 21 Apr 2026
 10:18:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com> <CAKEwX=M5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWodwbf1Fe=gzew@mail.gmail.com>
In-Reply-To: <CAKEwX=M5YpR0cQrryX_y4pm_BuxyUWZ_8MbhWodwbf1Fe=gzew@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 22 Apr 2026 01:17:28 +0800
X-Gm-Features: AQROBzBzKZZoRm3ovdQFueIgXrOTz3tmgRhk4RcaEKf7oJ2WCHZR_g8A6tDHomE
Message-ID: <CAMgjq7Ae_VH6mLQito5MFnxmp7ScZvF9xw4P-yU-yUBkPZ9_YQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Nhat Pham <nphamcs@gmail.com>
Cc: Wenchao Hao <haowenchao22@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 11:55=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>

Thanks for adding me to the Cc list :), Barry started this idea with
ZRAM, which looks very interesting to me.

> On Tue, Apr 21, 2026 at 5:16=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.c=
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
> > When anon folios and swap entries are mixed within a
> > process, reclaiming anon folios from killed processes
> > helps return memory to the system as quickly as possible,
> > so that newly launched applications can satisfy their
> > memory demands. It is not ideal for swap freeing to block
> > anon folio freeing. On the other hand, swap freeing can
> > still return memory to the system, although at a slower
> > rate due to memory compression.
>
> Is this correct? I don't think we do decompression in
> zswap_invalidate() path. We do decompression in zswap_load(), but as a
> separate step from zswap_invalidate().

It's not about decompression. I think what Wenchao means here is that:
freeing the swap entry also releases the backing compression data, but
compared to freeing an actual folio (which bring back a free folio to
reduce memory pressure), you may need to free a lot of swap entries to
free one whole folio, because the compressed data could be much
smaller than folio and with fragmentation. And swap entry freeing is
still not fast enough to be ignored.

>
> zswap/zsmalloc entry freeing is decoupled from decompression. For
> example, on process teardown, we free the zsmalloc memory but never
> decompress (if we do then it's a bug to be fixed lol, but I doubt it).
>
> Zsmalloc freeing might not be worth as much bang-for-your-buck wise
> compared to anon folio freeing, but if it's "expensive", then I think
> that points to a different root-cause: zsmalloc's poor scalability in
> the free path.

That's a very nice insight. I had an idea previously that can we have
something like a zs free bulk? Freeing handles one by one does seem
expensive.
https://lore.kernel.org/linux-mm/adt3Q_SRToF6fb3W@KASONG-MC4/

It might be tricky to do so though.

It will be best if we can speed up everything, doing things async
doesn't reduce the total amount of work, and might cause more trouble
like worker overhead or delayed freeing causing more memory pressure,
if the workqueue didn't run in time. Or maybe a process is almost
completely swapped out, then this won't help at all.

I'm not against the async idea, they might combine well.

>
> I've stared at this code path for a bit, because my other patch series
> (vswap - see [1]) was reported to display regression on the free path
> on the usemem benchmark. And one of the issues was the contention
> between compaction (both systemwide compaction, i.e zs_page_migrate,
> and zsmalloc's internal compaction, but mostly the former).:
>
> * zs_free read-acquires pool->lock, and compaction write-acquires the
> same lock. So the compaction thread will make all zs free-ers wait for
> it. I saw this read lock delay when I perfed the free step of usemem.
>
> * If this lock has fair queue-ing semantics (I have not checked), then
> if there a compaction is behind a bunch of zs_free in the queue, then
> all the subsequent zs_free's ers are blocked :)
>
> * I'm also curious about cache-friendliness of this rwlock, bouncing
> across CPUs, if you have multiple processes being torn down
> concurrently.

That's interesting, when I mentioned zs free bulk I was thinking that,
if we have a percpu queue, at least we may try read lock that on every
enqueue, free the whole queue if successful, then release the lock.
I'm sure there are more ways to optimize that, just a random idea :)
