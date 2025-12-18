Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B102192F9
	for <linux-block@vger.kernel.org>; Thu, 18 Dec 2025 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766032933; cv=pass; b=gQorNAD3VJhylZm95e0mE6zi8HceANukQ1qHyfooi4VvKBx2xHgu19jRjjqCJPoHWEo6jasYIMTRXZt/hxYCM/sWHL1OlKJYKDCtZf65KjVX51KgIMCqbpCrOTJpfX1UpJ3zK5JcuSzzLl4pUT/zu0shuJvnjUJV2jkxlfavqLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766032933; c=relaxed/simple;
	bh=DUQdLf5edxnyzdl6Na/QaFWiKAg6z6Vl1CdVvMH/63E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeTYafTA04b2crh5nD0Htwx04RkWap4EPQxKzsobCf0iPnn3fpm6xgW1PnOpsaWzxuidmgFYo8H8KNVKt+SlA1yclnHA2RXCx8mqE/gvpu1Z/tzM/32R3TTcwBBU1/pD4ffUUpnmT2tQ/0Wai1aqx/1IBh7RI/i7Sj28nVYRiik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=K8QwAbx7; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="K8QwAbx7"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29f3018dfc3so533105ad.0
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 20:42:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1766032930; cv=none;
        d=google.com; s=arc-20240605;
        b=VKVFBvE4E9/sP8Rpa7RvtJjwZdyolSGrUSELwJUCvSAU3IyVYA+GYkSLAaNq9AGQxD
         pum5B9WGI7ZihHGjJemtXUeB/kopcgaontvvyXhe0uM6Vkkfh2ve4QGLdattVCeHa+l2
         Uqma5R+EAmMLhIbBgwU6nWrFXuxHbWPY8MlFCxx7JzVABdzfyfVEaNDOaClA28J5O36y
         TeiGMBPnEMtbwf13wTlWOzEPw+JTywV94YndyqFfbrBLX24qtsflpvq9BQ+3f8LJIIPd
         KGAGzTdEeT6aeDt9tv1GMOIMH7ef8ZVoYygV9ap8P7+x4WLgCHC46kBLscXIRyTCCyO6
         PjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2ua++xwk7WqtgT5E32GN0mAPrPB18PO58Noh2/9zjs=;
        fh=/h6GbD16F4nFaDgau21IaA6H6yWeNDC8NZflgyC1Cqs=;
        b=LMbma5sZbPJSYGSqsAR9qehI70M4D9T7IW7qw6CbflBgzyitbCpnIxGJPTPlq4vW7Y
         ofu33PeoVmTLbTHynpyBE8NeTTPTirkuLqRRSz6Q3Sn3/uudhH+VcoatgZfyM9BKeoPX
         VS22WoeBKOnpCqsLvIbr5CpnE+yTwuwpSAGB7TVPap1y4Mb7jkIG9ClHfSd5inAB4Xwf
         4MWgmhNs3TQpVYPgIfb1khhvg9+DUG+SqNe9B5ca5dZedFmwPpDIAelSkkegDX+tjLli
         RWPgE3OPwa8pBF6ZMCFACSatI72TSQO8KmxaCGdh4KJDfpGVWrZYV+lt5zmVag47MQsY
         ma/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766032930; x=1766637730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2ua++xwk7WqtgT5E32GN0mAPrPB18PO58Noh2/9zjs=;
        b=K8QwAbx7VUfhwpMxWuEx5brHRReLukfr6iSwThq0uog0DTj0pWFdg2BUEFEtWAwECD
         i9DJb/3AvVUpg5BB4XiGYgJzRtN9c5Ye9Ymh15P/6Gt8KxH843/BKcWlWbuVF+9OjdJG
         hEZFoOwmHwWZ+XRj14qm4u5UHXxHiE1QYbC+JWaG56c6AEHkM4f2+zW//10T5KRx6uic
         H4QqtWfRcxs4vukSvYDmhncduBke+kmYEikuClHhYLOcZIfnyNIpaQGKV51SqQM3OrRr
         drSqY0YZxN6Vp6NbntllmfITIXw8ip30jXtYMYlNslhx3jblKfU5AiUafDu+ax7R17Ds
         3tJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766032930; x=1766637730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2ua++xwk7WqtgT5E32GN0mAPrPB18PO58Noh2/9zjs=;
        b=Q4YJdAKXEkxDivXo9HtBHJu/o6hBZG0Im+nlX1lnJwcfOpAJgNuKjm+z35p747JVBM
         Sr5xnG3MEemwxPHIMfO9uCmB6QF/Rtn8DZ2sxIWAA+hfph0BpbuMrYCV4VhPdzFWGM4e
         t9DIK1KspcYKovcKOLHoB/L6qr0VvEZ7A7ArL04ykIeJA/+qzb1gi75ZgKFav6ng9oY0
         8yF+Joems7N+NiobpqzFeUETM4dl8hqoGGzAGVfAVQjPpvPg/2hjXtkUTfQnhwklntrn
         wTHj+Fcro6cxSFDPi3/CvHqZJfOwMYOE7dGBB9uoiG3VeIWHEiIF//DOAc5yEYwDvX7X
         Rw4w==
X-Forwarded-Encrypted: i=1; AJvYcCVg86yI4eh/QTxZi3PnvQRepvSJ9mEZhT7tnDOWqfeupDekJba5sjPpHhW5QZ5N0cVZKfvVNLorXk5KKA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9aZea7oJ60GZZukzQbxHdgYs8aqxSds7adpsZ2gR3juMzM+ps
	zCni4WGpLRxdKsetW+vyblhUDP/0NnvW4Qv8K8pSNS2LfonGDIwK0/kBHUhMBdKtgi/djjGr+MT
	gnt0PpRY891jYkYwlZ8kDP//4uo2MVO+WmxYNBIOa5A==
X-Gm-Gg: AY/fxX45DYxMHs3aUz2x9Teuaf3qy0dub5yHQ5F5hnQljI2XEzWkfbxuRLSpucbGgjG
	qrl6YJqRHKi938IZdyPSD6TID1pvnAYX8rHPYK7LMDx5seDAjZDgnBkhKKiputyNcbCu3ez9+J+
	FFkn7mXnaUusIfaXDmDg1/fcPaFHl22EPYgk4iU1B8sKlz64gQIxxNOf2z5TJu3AaBMwccIhggN
	2GuTF6LCFOuC0m68jZoPyHXH/x60qducB81lyXwewqpBVt69shcHbbWk7OjKTbxvcpIuz3Q
X-Google-Smtp-Source: AGHT+IH7PLY+aMKuPLLwBnwJetvrVAgAoTGIvbZNDgtT5W2bAkapV2c1tIFGS8Q3WfwOUbAlI0oOny93OAIxkTzKdrg=
X-Received: by 2002:a05:7023:90c:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-1206281cc05mr535526c88.2.1766032930132; Wed, 17 Dec 2025
 20:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212143500.485521-1-ming.lei@redhat.com> <CAFj5m9KVcKzEqpXt0J_28L+bHojeAv4+cu8hTyfdfA_c-q4nWw@mail.gmail.com>
 <7f5a7801-0403-44e1-8629-3196092f32a9@kernel.dk>
In-Reply-To: <7f5a7801-0403-44e1-8629-3196092f32a9@kernel.dk>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 17 Dec 2025 20:41:58 -0800
X-Gm-Features: AQt7F2o0wiLvAYjrGIfv5Nem1-WHBMNLrG6ETpfg3r5AWhvb1amPOGgduS0Z6UI
Message-ID: <CADUfDZq8F2YL-vWcbop4KDrZ1fz5nBP6dbXVB6765kpFgxuy1g@mail.gmail.com>
Subject: Re: [PATCH V2] block: fix race between wbt_enable_default and IO submission
To: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	Nilay Shroff <nilay@linux.ibm.com>, Yu Kuai <yukuai@fnnas.com>, 
	Guangwu Zhang <guazhang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 7:20=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 12/17/25 8:18 PM, Ming Lei wrote:
> > On Fri, Dec 12, 2025 at 10:35?PM Ming Lei <ming.lei@redhat.com> wrote:
> >>
> >> When wbt_enable_default() is moved out of queue freezing in elevator_c=
hange(),
> >> it can cause the wbt inflight counter to become negative (-1), leading=
 to hung
> >> tasks in the writeback path. Tasks get stuck in wbt_wait() because the=
 counter
> >> is in an inconsistent state.
> >>
> >> The issue occurs because wbt_enable_default() could race with IO submi=
ssion,
> >> allowing the counter to be decremented before proper initialization. T=
his manifests
> >> as:
> >>
> >>   rq_wait[0]:
> >>     inflight:             -1
> >>     has_waiters:        True
> >>
> >> rwb_enabled() checks the state, which can be updated exactly between w=
bt_wait()
> >> (rq_qos_throttle()) and wbt_track()(rq_qos_track()), then the inflight=
 counter
> >> will become negative.
> >>
> >> And results in hung task warnings like:
> >>   task:kworker/u24:39 state:D stack:0 pid:14767
> >>   Call Trace:
> >>     rq_qos_wait+0xb4/0x150
> >>     wbt_wait+0xa9/0x100
> >>     __rq_qos_throttle+0x24/0x40
> >>     blk_mq_submit_bio+0x672/0x7b0
> >>     ...
> >>
> >> Fix this by:
> >>
> >> 1. Splitting wbt_enable_default() into:
> >>    - __wbt_enable_default(): Returns true if wbt_init() should be call=
ed
> >>    - wbt_enable_default(): Wrapper for existing callers (no init)
> >>    - wbt_init_enable_default(): New function that checks and inits WBT
> >>
> >> 2. Using wbt_init_enable_default() in blk_register_queue() to ensure
> >>    proper initialization during queue registration
> >>
> >> 3. Move wbt_init() out of wbt_enable_default() which is only for enabl=
ing
> >>    disabled wbt from bfq and iocost, and wbt_init() isn't needed. Then=
 the
> >>    original lock warning can be avoided.
> >>
> >> 4. Removing the ELEVATOR_FLAG_ENABLE_WBT_ON_EXIT flag and its handling
> >>    code since it's no longer needed
> >>
> >> This ensures WBT is properly initialized before any IO can be submitte=
d,
> >> preventing the counter from going negative.
> >>
> >> Cc: Nilay Shroff <nilay@linux.ibm.com>
> >> Cc: Yu Kuai <yukuai@fnnas.com>
> >> Cc: Guangwu Zhang <guazhang@redhat.com>
> >> Fixes: 78c271344b6f ("block: move wbt_enable_default() out of queue fr=
eezing from sched ->exit()")
> >> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >> ---
> >> V2:
> >>         - explain the race in commit log(Nilay, YuKuai)
> >
> > Hi Jens,
> >
> > Can you consider this fix for v6.19 if you are fine? Yu Kuai has one
> > patchset which depends
> > on this fix.
>
> It was queued up on the 12/12, now I'm pondering if the "thanks applied"
> email never got sent out? In any case, it is in block-6.19.

I also don't see an email about this series being applied, though it
appears to be queued in block-6.19:
https://lore.kernel.org/linux-block/20251212171707.1876250-1-csander@purest=
orage.com/

Thanks,
Caleb
