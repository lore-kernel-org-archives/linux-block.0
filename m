Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629F337F8A7
	for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776962434; cv=pass; b=gXK0HsqcGyI9dM595R1e3S39U21OF/41qeP6plYc6KwSrxkeRrpvM0pS36EsU5XZXJjZ+FRe+KD0kSmXEdClTcywS0UWo0DnrCoXJiUqdaAgSq4Wm7yziKUa1FKidrwsCraiGA8BTF1GJgqxdo2kuK39TJ517icS8+qslMiIIHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776962434; c=relaxed/simple;
	bh=3PokA5EaZgDdzkAI1t9Qd6gl0E9Yg3pzz/mixh3rkBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nGU68rlZJont4kHvTrlce5UJN8BPUI4rXOVi+lh8kiIWXj9DTzIjC5ZYpIiFD1sPERqTiKuQqNJWrqlh8oaOvb/5QmQZBJ689sdD7ZCcoTV9VvkLEVNuC7QdQwruyKfdGatWj7llEQYlGObFK+3wF31bo2C8qkhnbjTcsuaw/Aw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUm5hYkR; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUm5hYkR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso69686475e9.1
        for <linux-block@vger.kernel.org>; Thu, 23 Apr 2026 09:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776962432; cv=none;
        d=google.com; s=arc-20240605;
        b=F7FB6zfqTlqBJpGLYsdSncxFqEg23bmZmVhFfnFD/ejFs4jQly0yK+ZQXIp7QrzDnx
         ckPMqXrl6urSxrmhEhYWhPuhX6EjtqCtkvzwiQ8A8WQTvuqeTUQXVMsIL0kZAWGxBf3V
         vknlSsoHUehwI75yMuNLZyWG0OzUEgvEToJ/TDcPANcwsT1t0OIUHA3tvrDJUbkm9WNd
         w7NbBkESyv5evdV9b9YBscv5Rr7bYT1GMWaOG/WeCfOYyX1+QtHLn0blxFEXTJFgzgh0
         vhWvG8QN7ol6YEHhgTm8W97NYtmqVIiXV72bX3CH4PyFj6aYWoFtvtBD1w0NecdK2DcC
         uuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3PokA5EaZgDdzkAI1t9Qd6gl0E9Yg3pzz/mixh3rkBk=;
        fh=Vf75fmavXV2iKg9uY0PNIiK6M5jWyCRBYlgl/U79Vqw=;
        b=DsIxPKkzkjLRhmy36TbRGSzAUEq0odlrxC7isiMbErWyZ0cEBfeGWLI/lxk4MDvwaE
         ks0+L7wpCwQqXpLL6Iw9YFl76cUZkUYySQ1dJlTcHXx8A3nBUAMGFnh+ZLvsRYZVb3iJ
         klhxiZ9CcbZ2pkfuB5XsFqilcjDuWQkx7mYpGOnPenqHRQBuSeVZ3AdFq94z7BaGE3z/
         niJbNOrCjMpQUyE1+Beh1D7OvLFTgICEbz2aToWhv3cAJYzAxjw3F19Qv/kAuXr5r2ua
         qA3uKqqROZwp8+EjLX8sjsunkFrTjpT3N2CBRnOR+cAIC8w+Ty4P/qny6vz0EMKFJn6M
         3g4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776962432; x=1777567232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PokA5EaZgDdzkAI1t9Qd6gl0E9Yg3pzz/mixh3rkBk=;
        b=IUm5hYkRdDNxWJImlEDFCJjd2XMfeSLYMP79IcXDLaZ7SZyvzlYnFNZL9nK6/aIzTh
         010xRBEnPZyiKCXYlTNtnRRO3abCAdso2VLB+JcZk4gGeJIVaG5ory/IigkmN6TwxzgB
         AW50kJMA0xTk4F4FCLv1bpKXCV8ms3ttlZWlzWfikIt4W/ee5PU/VOdB89y5rGozrdQm
         aIE1aCQb5K4j+LsTaKFZVnr6N2ny2Frgtp56wFFGNpFQWPJKs5dqY6KoIqEfsY0X+MJ1
         l9/IOySguOps2v2us8SBAF3b64mJAncEGC2JTFrlC5ffd4Xc4luDcHRPUBKRFOr4BgRb
         c/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776962432; x=1777567232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3PokA5EaZgDdzkAI1t9Qd6gl0E9Yg3pzz/mixh3rkBk=;
        b=DZ+6sDQjPtiv6CshnsO3Ik9ie3Sf24qdlT6U8/yiTPBqRN39fLbnHTJahgEJcSJwox
         s9oKOFvCnI8mKAFECORidL4s8SadO0Ei4Sxsf8Euc7b6ZmCF1ZJh5lxseyMAwdvz8/vc
         Rk0HRD7i2YzAePbJdLD8Ypt4lk9aVAauaOIskCNJcehFutzn5nK0MBNOPCb0OlNoj9fe
         k4zjkdl+7k/4X4OwqVU+Xz7FZEF/JLb6nSAj3mkg22MBXVFKnF52MBxE5gjqgBGduPyG
         xONR3NPUz3y+FygO3qTmz5cTt+3Fsd6t/QA/FHRAXTN51QyLnw/bGgeqs+pbGuvzZfD1
         C/IQ==
X-Forwarded-Encrypted: i=1; AFNElJ9yT8+WP5g7zi1zWQ34JtN+X2w4mbrbqrftEmVarEZGh2UJY3wAVzJ9EyXEi+tq4OoYLZvOuVi91n3yTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjpX5rVqbNH2KNmrMZ5VidYDx7LoiYdrqKKkt1xY3avZHwA68F
	2B3wk8a/RWaCmFRVD2MY4d72wx0NQUHw3swQdAvKIlNd25CTHse+IuORBS5TIDxSEueWFqbUoy8
	LjrrXXhEZec8LGZQB2nllk585xgIw0Vs=
X-Gm-Gg: AeBDietDFk7fpnOEQ6PSOu2V6GvpDyLA/2GjdPTxGNUFjAK+kf3QsJvhJSZQDl7b71T
	qfgbNwnOhX1Z2Iq0YgHkpbOtoArF5tJ8BO+KwfIHyk0Aa9q/2Td7vFUvEoFMzcqVKiyB8TKD3g/
	22v7sG0VUhlkFA3EHpiV0iV7LsZ5Dv8+RJbYLszClPwmMOrDIRiAZllNtyB9UkakIpkU3N1eGIy
	JDPIvBxaZjwNJJkoBGwe1vnUrraEvKIHgVKRibNj8ntQOk+jlmxolXqE8lBb9YPekPe01QPbtRq
	TUelZRM+FEFBGtXPUGcVg89+OS1Y9x9y9JC+jd1iMMX8rtlbJkzgqEkg1bb/
X-Received: by 2002:a5d:6f13:0:b0:43e:a703:3675 with SMTP id
 ffacd0b85a97d-43fe40329ecmr37687772f8f.5.1776962431493; Thu, 23 Apr 2026
 09:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421121616.3298845-1-haowenchao@xiaomi.com>
 <20260421121616.3298845-3-haowenchao@xiaomi.com> <CAKEwX=P8_5qyou0KgvwvoPpRsUN4ohwsC7ysxjTW=Fbwk2uSOQ@mail.gmail.com>
 <CAGsJ_4xosgszLBGXdXGchgYW6ks_XB1vO35scrO0UUiQ1ZvVvQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4xosgszLBGXdXGchgYW6ks_XB1vO35scrO0UUiQ1ZvVvQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 23 Apr 2026 09:40:20 -0700
X-Gm-Features: AQROBzDdE4pGGd6mO7mjlt9Pk8Ovl7lU8fEPEqM39shN4JBZIr2r2Cztec_PHnw
Message-ID: <CAKEwX=PX1yiYuZvQafQ-y0p-JHchdGKMHLpvsB+P-0zPoW4LMA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] mm/zsmalloc: introduce zs_free_deferred() for
 async handle freeing
To: Barry Song <baohua@kernel.org>
Cc: Wenchao Hao <haowenchao22@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Yosry Ahmed <yosry@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Xueyuan Chen <xueyuan.chen21@gmail.com>, Wenchao Hao <haowenchao@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 2:42=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
> On Wed, Apr 22, 2026 at 3:47=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Tue, Apr 21, 2026 at 5:16=E2=80=AFAM Wenchao Hao <haowenchao22@gmail=
.com> wrote:
> > >
> > > zs_free() is expensive due to internal locking (pool->lock, class->lo=
ck)
> > > and potential zspage freeing. On the process exit path, the slow
> > > zs_free() blocks memory reclamation, delaying overall memory release.
> > > This has been reported to significantly impact Android low-memory
> > > killing where slot_free() accounts for over 80% of the total swap
> > > entry freeing cost.
> > >
> > > Introduce zs_free_deferred() which queues handles into a fixed-size
> > > per-pool array for later processing by a workqueue. This allows calle=
rs
> > > to defer the expensive zs_free() and return quickly, so the process
> > > exit path can release memory faster. The array capacity is derived fr=
om
> > > a 128MB uncompressed data budget (128MB >> PAGE_SHIFT entries), which
> > > scales naturally with PAGE_SIZE. When the array reaches half capacity=
,
> > > the workqueue is scheduled to drain pending handles.
> > >
> > > zs_free_deferred() uses spin_trylock() to access the deferred queue.
> > > If the lock is contended (e.g. drain in progress) or the queue is ful=
l,
> > > it falls back to synchronous zs_free() to guarantee correctness.
> > >
> > > Also introduce zs_free_deferred_flush() for use during pool teardown =
to
> > > ensure all pending handles are freed.
> >
> > Hmmm per-pool workqueue.
> >
> > Does that mean that if you only have one zs pool (in the case of
> > zswap, or if you only have one zram device), you'll have less
> > concurrency in freeing up zsmalloc memory for process teardown? Would
> > this be problematic?
>
> I believe so, as reported in the original email from Lei and Zhiguo,
> which proposed introducing a swap entries list for async free.
>
> >
> > I think Kairui was also suggesting per-cpu-fying these batches/queues.
>
> I guess a per=E2=80=93size-class workqueue might strike a balance
> between scalability and reducing lock contention across
> multiple classes, where the locks actually reside.

Sounds good! Let the numbers decide :)

>
> Thanks
> Barry
