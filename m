Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236D92EB845
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 20:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200643; cv=pass; b=BMAFmeDPmzWdVXxr2P4+Aq4hVZ3OfrgOhJc9OveCHE25c4w0SxDdwwZZqKHVGVTxSfYNQ1zUP4zUdrTdG91CCkopT8DNitrzn+a1GgVfBsWVrYfvJfUtaaj7uZuN7FJhXqNkotsPmKNYAMQlYxH3IQP5o7PAmMtg5/3CkpdKwhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200643; c=relaxed/simple;
	bh=rzjH/fYqtOB9oaq5k2QvvZfdzZ4k2F2caz0sp0huBsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ab3q0CCMKqV51EOrHrN7PeAXARqRac41YtBQUc0Wb/EVXRUpSpmKslU8nlOJH6Vh1O8ps30zAYcnrW6nLOpVx3R656QDZfRf4SOvxb0Z3bGbh9wrJeGbUiKEho9vxSujyX2sndzHog7l7qtdOX3qrCRrQkG44BIRnxekqAewNcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HoE1sK5S; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HoE1sK5S"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b7063004daso132309eec.0
        for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 12:37:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769200641; cv=none;
        d=google.com; s=arc-20240605;
        b=CPop2Ibblp3wps44iY+1iMF/VD3CrirmndgTr3l3b7h6dYrXS1IKd+jbD1j6cB3Dx4
         L3Xjs2GvV5tLnPNbIVRLHSq1MNqT4HBu08Qbf5lyV4zKfUyu6wk8iDHt+m+zuA/1FzJv
         EkdszpI2zdmcxxuErKOOl0H1l2JwjdAGgd63etLe2TdTf4TuN7L/SSSIafjRCAPqYKYp
         i05dJS/1CUW7Xj84UoWUrfWl64b+6NpSBh5tV3OycPj1ZXCtE1cmx/l0dsxgvDIDMwLy
         Vigrp7MDNFxZZ9Z8avwLEv5Oc7OwqHL0/+jnKv2L0Xl2yDAU/SagxTvBKlgukjnHAN2X
         CcwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3QpWOcLCTk9n5n+Z0IjSt9mzkzVDhbqmwv5wnQRjgVY=;
        fh=WWiG8LxD/TBx8wN0/WprCa1UQwFgLq/YhqiLZOUoKqY=;
        b=QJOZ9+ONy6AuKmQGrovyeezqPSzGRJ9ERCdwYa/SvHb3spFx3Nfv31Zpr6MF1hATty
         sEj+BFh7PNak2T2JMBYDpWjiu5pwhrgbRJrGInzF+29xQK93nLWHrFu0Bmp1i/A2UMV0
         COvT0/ZwDsEOtlRndn1417VqRLWRRxXABFZRUiufVtr3WwYELBEj4YUN7T9RJ7nk6eHc
         PoU6WnULH2dsB4iNuI3fLvBYlpGpD5kwMIj1eJSK23MPZvg8PKeAu9PBYLf3E6KnisR7
         CcIgWJVgXrYaKulb6yfypju/6m/R+ME1+3uR+Kj6YZpKwBm2k+aM7+iqg04Cbm9PHfs/
         UF/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769200641; x=1769805441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QpWOcLCTk9n5n+Z0IjSt9mzkzVDhbqmwv5wnQRjgVY=;
        b=HoE1sK5SBOH5C2MsxH86k3gDNkLPI3wQnBzT3WPTTk1aDq3rQS4TSoPyXk+XBk/gus
         x76s867VXj0vq1ryrl1i/bm0I6oFwH/G2PZ2JLEewtVApoN83/eH4/16q5wzNfQe48HO
         vQ4EuoIwI8cBCmGnmTvJJZ/jqz1DejrfIq2lbTsA9sHiAsoK6BR3g6sQP9Suc5xQWom4
         WqdE0UYNsevz2arv5/01ByNMQj8okmIHW4UP+vvLcBOO+obSsoDkLhVZpKyhGjsrP8Se
         /C3hUxnEAP1hSFgiAMazmyAJf6Bn1c/hO6Cg04p2wr3QjU6dlskBbcYAK8v7VVYoAADG
         89dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200641; x=1769805441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3QpWOcLCTk9n5n+Z0IjSt9mzkzVDhbqmwv5wnQRjgVY=;
        b=BemdHiTChVvwGBU4W6R66bqeI/b9aEoGpREtG7QxvKQ9WJ2T8jVq4u8JvmUHfeeWwM
         1zcM93tK7jBDIo/urd8sAeVCJiENUUUb5IJ/3CrA8Fv9QyoI1MXlwvm/mlavTgFfE/bW
         kU8CHrlAsSVrQCn9d+stbvH2p3KrWPNmsFmkEUBXu3NeeXvzOY05M9Vcd40ClLgGAF7J
         cP9TPJauvzIMxUiAJeHIn3pufSS/pj7VPCV3hJq1xuQdpwh/i7a3xekOvJbNYMzZh2g1
         3sqQa+eVdXC5ex0WoXQDyNHEqrUwNmEkkIH0vw9V3laKmTqhrhqOGmwLtQRfBMC0aEi0
         t8kg==
X-Forwarded-Encrypted: i=1; AJvYcCXqsvbSc7wh/AQ8rtMO7vtpGFBwAu1BhgtECNTLxrKmBvwG7kkCK3cQOBcCQBfOTQhTzxbML/UajMRthw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYaQUnDq6xkE3U0b0y1EPl3aP3m+q5DSzQFuSzn+nbK6lxOh/
	sQZReri8+iNIJe2jbBjOyTTyx18lU+rhozPy+MHvhK7UauKoKJhKsKTRjtV0CJjEuyfOdqgNRbI
	NG3A66ZNJ2XL/2Q34QzDTgRoY2kNMlGLy7d5YdC/MGw==
X-Gm-Gg: AZuq6aJXA/6sC40OE+QYssMdIdOmYPocGupKaz8DSc7x4Jwz/Bb//J15BLAtfzt72H6
	MBtJQ2+uzgyKP7LeyVye+j+PMBCCrSoaSbSAKrplvZBr6Pa8bPcPdY7qTasR+vHGGyjuMHoVKcW
	4QtkkKYhWH/0bk0i7w9S8QKOe48eqy44NL2jcCd4Wb7WIZ2XqsM4KINtAQ5DWC3L4bDIyQ7lRLP
	0m6ZJURxXj0nBGWd4x9KHWEhlPrDgFUY8V+b9TTMzd+b8qzAcVHWsML0L8t2u/Ou163C2DH
X-Received: by 2002:a05:693c:2b11:b0:2b7:20bb:8c23 with SMTP id
 5a478bee46e88-2b74e8e186emr154289eec.8.1769200640544; Fri, 23 Jan 2026
 12:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123135205.2202474-1-ming.lei@redhat.com> <20260123135205.2202474-3-ming.lei@redhat.com>
In-Reply-To: <20260123135205.2202474-3-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 23 Jan 2026 12:37:07 -0800
X-Gm-Features: AZwV_QhLhyD5FHst38Eqs1Q1feL5WEfLXVP0kKLCpZ_p0emD6ccoY3o59rgqbXU
Message-ID: <CADUfDZog7YhUz0RXfyR=guO3-aKo_FnSF6cSVY1uVv0=m-xB1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] ublk: document IO reference counting design
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2026 at 5:53=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add comprehensive documentation for ublk's split reference counting
> model (io->ref + io->task_registered_buffers) above ublk_init_req_ref()
> given this model isn't very straightforward.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 64 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 7981decd1cee..91218b78e711 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -985,6 +985,70 @@ static inline bool ublk_dev_need_req_ref(const struc=
t ublk_device *ub)
>                ublk_dev_support_auto_buf_reg(ub);
>  }
>
> +/*
> + * ublk IO Reference Counting Design
> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> + *
> + * For user-copy and zero-copy modes, ublk uses a split reference model =
with
> + * two counters that together track IO lifetime:
> + *
> + *   - io->ref: refcount for off-task buffer registrations and user-copy=
 ops
> + *   - io->task_registered_buffers: count of buffers registered on the I=
O task
> + *
> + * Key Invariant:
> + * --------------
> + * The sum (io->ref + io->task_registered_buffers) must equal UBLK_REFCO=
UNT_INIT

This is only true when UBLK_IO_FLAG_OWNED_BY_SRV is set. If the
ublk_io isn't currently dispatched to the ublk server, ref and
task_registered_buffers would both be 0.

> + * when no active references exist. This invariant is checked by
> + * ublk_check_and_reset_active_ref() during daemon exit to determine if =
all
> + * references have been released.
> + *
> + * Why Split Counters:
> + * -------------------
> + * Buffers registered on the IO daemon task can use the lightweight
> + * task_registered_buffers counter (simple increment/decrement) instead =
of
> + * atomic refcount operations. The ublk_io_release() callback checks if
> + * current =3D=3D io->task to decide which counter to update.

However, this optimization can only be used before the I/O is
completed, since task_registered_buffers is collapsed into the atomic
ref at that point. All subsequent buffer unregistrations need to use
the atomic ref since they may be releasing the last reference.

> + *
> + * Reference Lifecycle:
> + * --------------------
> + * 1. ublk_init_req_ref(): Sets io->ref =3D UBLK_REFCOUNT_INIT at IO dis=
patch
> + *
> + * 2. During IO processing:
> + *    - On-task buffer reg: task_registered_buffers++ (no ref change)
> + *    - Off-task buffer reg: ref++ via ublk_get_req_ref()
> + *    - Buffer unregister callback (ublk_io_release):
> + *      * If on-task: task_registered_buffers--
> + *      * If off-task: ref-- via ublk_put_req_ref()
> + *
> + * 3. ublk_sub_req_ref() at IO completion:
> + *    - Computes: sub_refs =3D UBLK_REFCOUNT_INIT - task_registered_buff=
ers
> + *    - Subtracts sub_refs from ref
> + *    - This accounts for the initial UBLK_REFCOUNT_INIT minus any on-ta=
sk
> + *      buffers that were already counted in task_registered_buffers

I would note that task_registered_buffers is also zeroed during
ublk_sub_req_ref(). Effectively, it's transferring/collapsing
task_registered_buffers into the atomic ref.

> + *
> + * Example (zero-copy, register on-task, unregister off-task):
> + *   - Dispatch: ref =3D UBLK_REFCOUNT_INIT, task_registered_buffers =3D=
 0
> + *   - Register buffer on-task: task_registered_buffers =3D 1
> + *   - Unregister off-task: ref-- (UBLK_REFCOUNT_INIT - 1), task_registe=
red_buffers stays 1
> + *   - Completion via ublk_sub_req_ref():
> + *     sub_refs =3D UBLK_REFCOUNT_INIT - 1, ref =3D (UBLK_REFCOUNT_INIT =
- 1) - (UBLK_REFCOUNT_INIT - 1) =3D 0
> + *
> + * Example (auto buffer registration):
> + *   Auto buffer registration sets task_registered_buffers =3D 1 at disp=
atch.
> + *
> + *   - Dispatch: ref =3D UBLK_REFCOUNT_INIT, task_registered_buffers =3D=
 1
> + *   - Buffer unregister: task_registered_buffers-- (becomes 0)
> + *   - Completion via ublk_sub_req_ref(): sub_refs =3D UBLK_REFCOUNT_INI=
T - 0, ref becomes 0

I think the order here was actually reversed in commit b749965edda8
"ublk: remove ublk_commit_and_fetch()". ublk_need_complete_req() will
call ublk_sub_req_ref(), and io_buffer_unregister_bvec() is called
*afterwards*, which results in a call to ublk_io_release(). So the
buffer unregister will end up performing an atomic decrement of ref.

> + *   - Daemon exit check: sum =3D ref + task_registered_buffers =3D UBLK=
_REFCOUNT_INIT

Both ref  and task_registered_buffers are 0 at this point, no?

Best,
Caleb

> + *   - Sum equals UBLK_REFCOUNT_INIT, so no active reference exists
> + *
> + * Batch IO Special Case:
> + * ----------------------
> + * In batch IO mode, io->task is NULL. This means ublk_io_release() alwa=
ys
> + * takes the off-task path (ublk_put_req_ref), decrementing io->ref. The
> + * task_registered_buffers counter still tracks registered buffers for t=
he
> + * invariant check, even though the callback doesn't decrement it.
> + */
>  static inline void ublk_init_req_ref(const struct ublk_queue *ubq,
>                 struct ublk_io *io)
>  {
> --
> 2.47.0
>
