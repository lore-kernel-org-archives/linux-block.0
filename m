Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477151C84AB
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745262623; cv=none; b=dNSQh6Q34fSRQHtnQvJUhDztxNUCIRt0E9lqgV/+6VKsbI7QkBkPoWmnDcPKnAawDNnchDU7LTLNLSmlm17wg0xoi/35qGlkKVUKSmrCGFh/MjKe7zp4FXqbg+FHvpr76hABAkEKaX4m61tLBGU0LEy7FIY9rvibfDfFckw/YxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745262623; c=relaxed/simple;
	bh=EffN5AU/cdkBd8YS1Onj3cKs7xiTNrKttWUX5X5z1bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fLc18St9TLLYP5Va9Myd82AmyF0du7FUKKdNWtuYsuixpP2v02qEW4QAIcjKJTbwk5vrGIGshMCmlVOln124DFCC3GHv0Ew9hDJZfl5AoOJTptXqZUWQFd8PDL1zpXcHMkNN5LJ2J6TR7gpkQFyymKrvZsqoUFQEkkwsUlFDFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=OcKHr0zC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="OcKHr0zC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so5284590a12.3
        for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1745262616; x=1745867416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1S1uSa7FoRwaHzZSTsxi0LrpVP2lyVsfRagPo55QsM=;
        b=OcKHr0zCAcMmmtx2HFMAcExGvqxbLzveWfZhQNerWku3tg9GIqGKee9G+VVCnk7RwL
         YD5IPFn37SK/reR8Ae7bYSExFnYYY9K1vsDOxPXsvudi+cw53TLKiJ/DbO6djsrSB/p3
         OqahHeO0isMyzGBEXjx+uD7VSUlYJyLMzqOWe5jME5xk8peITCWlaj6vicYFSFrIJR0Q
         1auAs0xXJtcfsb7fIv1DbdGGoPllJMX78/Bg1fWKKPHJt4P9GwNqWRWoaAhhoSk1bBSl
         Ozd3o4o/uQ+VnE/cfNiTFv29lhaHydBKcaO40Ek39BmuBqQgmap2Z09OqoO6K1u2wPxN
         t+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745262616; x=1745867416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1S1uSa7FoRwaHzZSTsxi0LrpVP2lyVsfRagPo55QsM=;
        b=mvz2gjHk3xR6GsEHo99SEuJ3D0+GT97LCoRmRL+KDJKp0okMlnaGrGV5SZXzZZ2o3b
         W7eXFOTv/+E+x/FlIeJTAQ+sjjkR9/+Ukp37hzySSXc3yVcLE4+kjUD33N3lwSzrmwh2
         6isbBeY9/pYijsJyhHNT6+2spEXQtI0kdge/wrETbwPFXUm+rE/F+zrw0jFCdSHrR2iG
         iykXaLBT4s+IzFkGl/ALUyAvzbgk4rThVhNDpd+Nvzrd4EpemxBYm+YFLZFYYH4kv3Hg
         K67dFNG/JagWgWTobaqONvSEesqbEGrGkEJePMwy5bMDM67ZN1q8LULNglg/XRojCou8
         mMvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmIV+1Z/R6U2EtMDcoWnwvd+0JOA0uZtYF0V+Hq4RP49t6yYch4EJ7aw0sBRLIfYJiM2ZidOXNrVVg1g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3HadbcvNdhpQukEJlkAn7RM8B9zmSmAUe6egnkprONjxPC0/u
	2S7lcW00Rc0DC3rqR1AXmg+mzHFIcFBDY20sfe5QWcbhmHZIVIpJPaH82ElLGrQTQfNl5BiDaCw
	X6dZ3TRXrq60DvY0PunKL0yd+Y5kxzQlhxn6S4g==
X-Gm-Gg: ASbGncsmhmKZ1FQmEqfjNr0o7yQaJV2O0WbKWofnN1FuHWhAYZ3gfjI8RHN3KerIoGY
	qQUtFD4bukbNnnrqTAHEhfRBN0/VuwdR5xsctz2DeozL5Jtd9lmSlTx1mg1JXaiFx40+fH4/tq8
	WmwUPtIFniVJUAqcKcYxd84uqCbjWEZrklP+JFcQ==
X-Google-Smtp-Source: AGHT+IHhxSy1dhJgyP+n70dvP4JqFFWuHoYZvVjGROAgwVB1NczKG5HA5ih0gg9sQN9MV2VKnuG4visGOKD+PfLA8fA=
X-Received: by 2002:a17:907:94cd:b0:acb:126f:5315 with SMTP id
 a640c23a62f3a-acb74d655b3mr1228786866b.37.1745262616324; Mon, 21 Apr 2025
 12:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGis_TVSAPjYwVjUyur0_NFsDi9jmJ_oWhBHrJ-bEknG-nJO9Q@mail.gmail.com>
 <aAZiwGy1A7J4spDk@kbusch-mbp.dhcp.thefacebook.com> <CAGis_TXyPtFiE=pLrLRh1MV3meE4aETi6z36NWLrMkYKkcjGNQ@mail.gmail.com>
 <aAaUKenXzkFPZaMb@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <aAaUKenXzkFPZaMb@kbusch-mbp.dhcp.thefacebook.com>
From: Matt Fleming <mfleming@cloudflare.com>
Date: Mon, 21 Apr 2025 20:10:05 +0100
X-Gm-Features: ATxdqUHhg4My8tEKsLC6N8JZACE9F23SwZ1M4WR2RYDmsf3_2nCe3Gn1GdYAHvM
Message-ID: <CAGis_TU1V2_L227SP9Ut1gSTNx9-AT9nbwgJH6azzH8==35hBQ@mail.gmail.com>
Subject: Re: 10x I/O await times in 6.12
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Apr 2025 at 19:53, Keith Busch <kbusch@kernel.org> wrote:
>
> Not sure. I'm also guessing cond_resched is the reason for your
> observation, so that might be worth confirming is happening in whatever
> IO paths you're workload is taking in case there's some other
> explanation.

Yep, you're spot on. We're hitting cond_resched() from various code
paths (xfs_buf_delwri_submit_buffers(), swap_writepage(),
rmap_walk_file(), etc, etc).

sudo bpftrace -e 'k:psi_task_switch {        $prev = (struct
task_struct *)arg0;        if ($prev->plug != 0) {
                if ($prev->plug->cur_ktime) {
                        @[kstack(3)] = count();
                }
        }
}'
Attaching 1 probe...
^C

@[
    psi_task_switch+5
    __schedule+2081
    __cond_resched+51
]: 3044

> fs-writeback happens to work around it by unplugging if it knows
> cond_resched is going to schedule. The decision to unplug here wasn't
> necessarily because of the plug's ktime, but it gets the job done:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/fs-writeback.c?h=v6.15-rc3#n1984
>
> Doesn't really scale well to copy this for every caller of
> cond_resched(), though. An io specific helper implementation of
> cond_resched might help.
>
> Or if we don't want cond_resched to unplug (though I feel like you would
> normally want that), I think we could invalidate the ktime when
> scheduling to get the stats to read the current ktime after the process
> is scheduled back in.

Thanks. Makes sense to me. I'll try this out and report back.

> ---
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6978,6 +6978,9 @@ static void __sched notrace preempt_schedule_common(void)
>                  * between schedule and now.
>                  */
>         } while (need_resched());
> +
> +       if (current->flags & PF_BLOCK_TS)
> +               blk_plug_invalidate_ts(current);
>  }
>
>  #ifdef CONFIG_PREEMPTION
> --
