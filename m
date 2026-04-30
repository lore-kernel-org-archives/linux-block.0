Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C762EA173
	for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777562120; cv=pass; b=Z+/XNEUd6GcQyL7gjFDC6O4xqu9jEPkJrD5izsM3LLwvbD18G1FhONhRsXdDY+H2DVzAWVxsyx7rJXynougEZBx960qFoSLsPD/+GIAjE2zYGvUryKdGgINSKjPE1bFn8b5V6zu4jB6YLhzcbIUhhDwLMh5ris4zk4570p9TtbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777562120; c=relaxed/simple;
	bh=4kIgxdNFUs1c+9bqp1jkRoU7x9h0VCpD7KVaW9GkfXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOwhcNImuWk+Rs/9ejx5NtLGKB4cceMKCf5NvkFGlTWho8zTm/Ee8immuZN0fMkFtcz9QYTd0qipg1FZxrGopX706Dyr2pfmCtmqq8dd3txL+Wtl5L8SOPb5VGfHBVAFa0mBEgpkxs7XsmVNTcfkdiMjqr7Ulm74EU12YihSpaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+qEWUNS; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+qEWUNS"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a46260385so13333687b3.3
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2026 08:15:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777562118; cv=none;
        d=google.com; s=arc-20240605;
        b=Yn7oH3c4WY55yIDgtjjPHCRocWiupJF9GEbltpjjVmMeFn/7GsWR4NDYAIgm+m3Xj/
         Mafi7w0mCDDTD4dxSw4zWOfyFQ2zgjgSZDWklaK+zPHIxOrteykxwpEGm8B3QMnG8XT2
         aOQvLDdF5q3iM4oArRLJNWeFI/Rs/bdCNkTslQZeQaIyTchixWcnKNdO+pjMQ7arniUv
         iTHcPwsc51Ws84C9UqkkLOFLsNCCyG06HKqzH9b3YL3crAxU3/fjPdWdp2wIwV4AhKfT
         S0zxllWfhj9WVDV2l+zXbdR4Dhrv4wBVwIyj1ItZ9RKEWQr9y6z82G5libZVB4Mm/5k2
         Cb+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KDRJaFjlBSoeRpqfVDKyshLRremrnk0uCfcTz7eq314=;
        fh=473pNiWbXhlqLvU+cJBAgmGbgfqnlPaYBFqM0QSLHRw=;
        b=LHs6Fqd4tPDBlF9RTYOartlBp25PrBo7+2dlyKNdCm918aSW+qn87YBs57aGbGu2Nd
         tRuIt+MxcLq2zL9b6zouPb3U18Qy84+yyo1f2L0IREYhv6NeZ+1+t95NTPeVUkL+mxWV
         NQFHrP2gG9qJK1KwRiKTIYOaHyO6BlOKa+aRwqsBXj6DNL9P7PzZoO47zGGzJt+HWobc
         STdnQ/AMqTQJvLljmigb/tFo2Um2zncm6BofiCzwL8Uzb0gcGfgAu9wBRvCY4F0Doz+G
         mFmQdFblQ2lKe+ivNDZnEcpJP7AfMx7s8+9HTkFYK0/fHzDMsKa2TbF1LrZ+vDbeGy1K
         Ucyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777562118; x=1778166918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDRJaFjlBSoeRpqfVDKyshLRremrnk0uCfcTz7eq314=;
        b=K+qEWUNSCZ9SNIvINGzLaebM6bTDTnQX2UuHGg7PGVqXbbV5nV4wus4+JYkxaPOT9n
         95XI49bozZxE1E2wxK4QZ+8dnLYOTSwRDKa3WfFM4FuBaP9SFvWCDzFu0sNvgMNkKoes
         xhOE5Kv7oSjapCFUHtHE72cda4S3k2c53y+HAMNgmHyhqRU4oZX/F2uoxcQ/JszMviwu
         GygfSeMC4o6ssrE+4a8QQkTqg++A2Z6/qolgwifCu0bb3Axe0cZnbRDWD8np1xJZiQPp
         bu5dV0pfzDXl1w1/Pw8y5X0P8IzIbjKdOUQ7C6+nMYE6/1aAIShJm8QzK14q6oeQczcF
         MElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777562118; x=1778166918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KDRJaFjlBSoeRpqfVDKyshLRremrnk0uCfcTz7eq314=;
        b=Busle1lMoaz1MjdDSGW+LZya6svJ3+1gWliVvsXBnUuNznIF76fHNRO+2SRNOJ13i1
         joYRHlromHBR7uVccdJpmKGogSqX1k3kWusNqWcEiU9NvXbeoATvoQdMX87BoewIaeSq
         A43JhSrddnxq8mPqJCJAlFt6exf0+XvUeivPvkeZPX6dJt/ZFj1rz0aZS/HssUiSZ4P0
         0X2MmHYAkXSqgmkqN4lhXz6jKOBvI/wOWNle52daKqdyUDcpHYap2uR1SQlrRPyQBcfa
         plC4shj2+8koU+fWNniugG9GcJgqyQPCyc3Gbsgs3deLHtWL+qZ1XsZZQEfMSmKhmh5r
         ZPnw==
X-Forwarded-Encrypted: i=1; AFNElJ+yDv4A6hGDpALubENemqWMa5rReReGHv08Su23tKHuOD9DvK5y4h5J8qpo5VwpBogRhfmErcmjwxMVpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyelGNSN6hUVNZNI2ngE4Lq/v/Em+9qS4i2lIVQWPzl6wbl8Ir
	NEZgEwrJYho4esFybRA4zloagbkwfx2YXgjJXWocb+ugUpO1XJ29V/a1in+X3gWY0u5VXcObdeX
	4ZWldzHD6osByrgZulBm3/HhECXXhUM8=
X-Gm-Gg: AeBDietWi4J2Yf+79wJoqOZimTuc1VSnL5Kcv7RPy72SkzrLScCPUQYeWu4c7jHXU7O
	jfLpfbs+nIazYEiTw0A1gvYvo62X25jeK3BM/YXNqfN6ReNDDtgyc9f2RZI7+ZIfeT67TP7kVmY
	zjnMuWyQG4rsxa65CmZMCtbYritRD4whOPGmW/3X38J1c+FaL3cZ6iIbl4nspn9p4P0QKYUehJf
	3TSbb/+RdTaD9pY7/i6PNFjqAuUg6dopMKoOXEpQZCF3NW/5zC/eDQ+wu4UpX0CYuPjcTK4nZBP
	CDpAuA52ZX/+ejIaNrk=
X-Received: by 2002:a05:690c:a01c:b0:7b7:5f48:d9aa with SMTP id
 00721157ae682-7bd52cf9397mr26452807b3.50.1777562117901; Thu, 30 Apr 2026
 08:15:17 -0700 (PDT)
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
 <CAO9r8zPV=c9v4Ar7t+xPxyptSUPrs-shrumsz=hCaNa3anGgAA@mail.gmail.com>
 <CAOptpSMLLz0yzg99nkAp7rxO5RphTDU3Cdqd8020mysijN_Bvg@mail.gmail.com> <CAMgjq7BTM1HKWwSTxkm7br+L2MDy7=OxEvF+yDRJfFfr24TiVA@mail.gmail.com>
In-Reply-To: <CAMgjq7BTM1HKWwSTxkm7br+L2MDy7=OxEvF+yDRJfFfr24TiVA@mail.gmail.com>
From: Wenchao Hao <haowenchao22@gmail.com>
Date: Thu, 30 Apr 2026 23:15:06 +0800
X-Gm-Features: AVHnY4JPRw9tshrsKiYQWjGPgU4Ll8OBvmSdcCSxAhvDHzHqd3kQJaCzs5QgF20
Message-ID: <CAOptpSNQNxPCesMYdT5856f_nL+pUtL9a2-Wz7SpxEZTGZA1xw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] mm/zsmalloc: reduce zs_free() latency on swap
 release path
To: Kairui Song <ryncsn@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Barry Song <baohua@kernel.org>, Xueyuan Chen <xueyuan.chen21@gmail.com>, 
	Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 4:00=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Apr 30, 2026 at 3:43=E2=80=AFPM Wenchao Hao <haowenchao22@gmail.c=
om> wrote:
> > The data I shared earlier was class_idx-in-obj only =E2=80=94 no
> > deferred freeing at all.
> >
> > > I couldn't immediately tell by looking at this vs. the cover letter. =
 I wonder
> > > what portion of the improvement comes from the deferred freeing?
> >
> > On top of that, we added deferred freeing in the zsmalloc
> > layer (per-cpu page-pool based buffer swap + WQ_UNBOUND
> > drain worker). With both class_idx + deferred:
> >
> > Test 1: concurrent munmap (256MB/process, RPi 4B):
> >
> >   mode      Base       Deferred    Speedup
> >   single    56.2ms     17.2ms      3.27x
> >   multi 3p  153.2ms    51.5ms      2.97x
> >
> > Test 2: single process munmap (various sizes):
> >
> >   size      Base       Deferred    Speedup
> >   64MB      15.0ms     4.3ms       3.47x
> >   128MB     28.7ms     8.5ms       3.37x
> >   192MB     43.2ms     13.0ms      3.32x
> >   256MB     57.0ms     17.3ms      3.30x
> >   512MB     114.4ms    38.5ms      2.97x
>

Hi Kairui,

> One concern here is that the total amount of work is
> unchanged. But when under pressure these workers could
> be a larger burden.

The total CPU work is actually slightly reduced =E2=80=94 the
batch drain eliminates pool->lock entirely, and holds
class->lock across consecutive same-class handles rather
than acquiring/releasing per handle. So the deferred
path does less lock work than synchronous per-handle
zs_free. I'm also exploring further reductions, such as
merging zram flags operations in the notify path (as you
suggested earlier) and reducing lock overhead. Suggestions
are welcome.

The key win is not reducing work but unblocking anon
folio freeing. Each folio free returns a full page
immediately, whereas zs_free may need many handle frees
before a zspage becomes empty (multiple compressed
objects share the same zspage). By not blocking folio
freeing with expensive zs_free, we improve the rate at
which usable memory returns to the system.

With parallelism (munmap + worker on different CPUs),
the process exits faster and memory is returned sooner.
For example, what used to take ~1s on one CPU can now
complete in ~400ms across two CPUs. Under memory
pressure, spending a bit more CPU to release memory
faster is a reasonable tradeoff.

> Is it possible for you to measure that part too?

Sure. Could you describe the specific scenario you're
concerned about =E2=80=94 CPU contention, memory pressure, or
scheduling latency? I'm happy to design and run a test
around it.

Thanks,
Wenchao
