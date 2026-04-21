Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484223DDDA0
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 21:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776807776; cv=none; b=qwKEIqw+aeZYskRJ0Y3k9SkniBIif8lSSFtPA6hujDwpwr9jFg19tVXxxFWxz8PQFN3/vFtKVxfaQen7jtba+kiLzgpaBxgZixVKCL968Gxwe/INFkOUXb2//A7wqIP3Nim3M/Jm6d1ODmEBaX1UALg5BWN3dNNjN3o//IAC4G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776807776; c=relaxed/simple;
	bh=UMxodhiUIQJ4ZIMuAelzSaDlsTIfH42Gcrf1UZtpVpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nI7CL9n/XpyB64EBbFdrn2M9n4JkIrx+PaqgZq7mai0CKa1Hz8K0iM80+y7yYAlSGMZuKDook6qR0rQdveQSSE/KQ6Q6+lkyNOnV7nusg6ae+gkSdzEPy3oTg0m0sNF4ZaX5wzwY6SGUB7YQCG8quVkB68mITV81ckCKReaXv1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxkpFWnz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxkpFWnz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBAAC2BCC7
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 21:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776807775;
	bh=UMxodhiUIQJ4ZIMuAelzSaDlsTIfH42Gcrf1UZtpVpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fxkpFWnzCtPcVL/IznmhSmlmcL5lCgtVvLz5I8JmGrUrClMcsXXio4a/d+g3yhndo
	 n+nnbJpMXwAxPe+UE0d6T9BbcA6TarhkclSNf6SULvvrhwehh2YaOmPrnxgJwrmCU3
	 y8CQ4H+JW5D0H7aUZaSIgPB7UzyjiltRa+ibIFe6FRHqrN8aYq8259gt1P/9m58kPr
	 tqB72Z/maA+Mpzjo0z9Zj7NZb3sCibR7CoCJSknmgJvNVkX1nfU5ZzISK6HWLcP2H0
	 kgYSG7pXXKmAHWA0Od+ygseYAh6HEO1d0C0bDBeCsASd2jIMshENmPni5Ji+BHdtSN
	 7qy66W41I7XBw==
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-89f87257904so39123196d6.1
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 14:42:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+7ITr+eazqMqMIDrImOSxgJyPwh5rh3CjcjAcDq0be8s+VwhAd7CnlWyS0/7BzgLQPizNUlINJMp5btw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk4u6/80h5iCWDXAf9qGCPOrvhcMJnvQ5O1F6qKn31qrnWBeMi
	vbiid3UZ1JGErgfOLOc4EcvlyHCczCnwu1KpxqfWL5DvZf2FFRz0doPpyCcSwcH1bIuZ6cib6AY
	YdbFQ0q5CFv4F3IaN+F0vhOi/mUOhgFo=
X-Received: by 2002:ad4:5c65:0:b0:8ac:800f:10da with SMTP id
 6a1803df08f44-8b027fd15e3mr339383376d6.4.1776807775110; Tue, 21 Apr 2026
 14:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <20260421121616.3298845-3-haowenchao@xiaomi.com> <CAKEwX=P8_5qyou0KgvwvoPpRsUN4ohwsC7ysxjTW=Fbwk2uSOQ@mail.gmail.com>
In-Reply-To: <CAKEwX=P8_5qyou0KgvwvoPpRsUN4ohwsC7ysxjTW=Fbwk2uSOQ@mail.gmail.com>
From: Barry Song <baohua@kernel.org>
Date: Wed, 22 Apr 2026 05:42:43 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4xosgszLBGXdXGchgYW6ks_XB1vO35scrO0UUiQ1ZvVvQ@mail.gmail.com>
X-Gm-Features: AQROBzA4xqeiePpx2T32feC6TdzhaVn9AvlVPFTLGgoA55MmSZ4iPfF7r_PrN14
Message-ID: <CAGsJ_4xosgszLBGXdXGchgYW6ks_XB1vO35scrO0UUiQ1ZvVvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] mm/zsmalloc: introduce zs_free_deferred() for
 async handle freeing
To: Nhat Pham <nphamcs@gmail.com>
Cc: Wenchao Hao <haowenchao22@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Xueyuan Chen <xueyuan.chen21@gmail.com>, Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 3:47=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Apr 21, 2026 at 5:16=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.c=
om> wrote:
> >
> > zs_free() is expensive due to internal locking (pool->lock, class->lock=
)
> > and potential zspage freeing. On the process exit path, the slow
> > zs_free() blocks memory reclamation, delaying overall memory release.
> > This has been reported to significantly impact Android low-memory
> > killing where slot_free() accounts for over 80% of the total swap
> > entry freeing cost.
> >
> > Introduce zs_free_deferred() which queues handles into a fixed-size
> > per-pool array for later processing by a workqueue. This allows callers
> > to defer the expensive zs_free() and return quickly, so the process
> > exit path can release memory faster. The array capacity is derived from
> > a 128MB uncompressed data budget (128MB >> PAGE_SHIFT entries), which
> > scales naturally with PAGE_SIZE. When the array reaches half capacity,
> > the workqueue is scheduled to drain pending handles.
> >
> > zs_free_deferred() uses spin_trylock() to access the deferred queue.
> > If the lock is contended (e.g. drain in progress) or the queue is full,
> > it falls back to synchronous zs_free() to guarantee correctness.
> >
> > Also introduce zs_free_deferred_flush() for use during pool teardown to
> > ensure all pending handles are freed.
>
> Hmmm per-pool workqueue.
>
> Does that mean that if you only have one zs pool (in the case of
> zswap, or if you only have one zram device), you'll have less
> concurrency in freeing up zsmalloc memory for process teardown? Would
> this be problematic?

I believe so, as reported in the original email from Lei and Zhiguo,
which proposed introducing a swap entries list for async free.

>
> I think Kairui was also suggesting per-cpu-fying these batches/queues.

I guess a per=E2=80=93size-class workqueue might strike a balance
between scalability and reducing lock contention across
multiple classes, where the locks actually reside.

Thanks
Barry
