Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C11C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 17:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C14B2146E
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 17:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSebsSO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfIXRdp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:33:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53720 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbfIXRdp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 13:33:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so1090768wmd.3;
        Tue, 24 Sep 2019 10:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=HL3nBQDa4lmsZ40hrcqORRbh16WnQqTv5FW3aHhR0IM=;
        b=jSebsSO//kdiCOtQmaNr4EREjkjGfflpbUGnxEmkBi4lkxdim6C/43IlZ58rip/u0h
         Oo1b+tUEgIQzM8T2uK9dvvWGkfPnySb9e93dJGAwK4Nwh1ecqJ+mKk1mnPfThkCPaYid
         ZY47+fqvtIMRPmkXQnxerMFzEy6BJXM8DMvSvnQ3YhKoWPq1p42kQ/OD/3x7hDXc9Smt
         ZFHKzQFWxKagACWla3a6do7SKHWcOGWvGOhDISHgwag50Umyh+LOQHFU/PiP1iNEAOTo
         Uv6DcrHyGEMZi9VfAnPVxp12G/zcrbrBSwFpzIfA2WZcnxw4ZknlHY8U00hixhJx0g0g
         Uz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=HL3nBQDa4lmsZ40hrcqORRbh16WnQqTv5FW3aHhR0IM=;
        b=sWD4UikPjmzQ5bBhcgD/+Z2EzItzJsbW7T8Cp3+hUBH4UlaHOx6p/LiyrAYYvc29+A
         0K9SD96isuNY0eybGbb+uGkBgFYkfs4XeMFC7uw6kAGJorm2QGy9SaxMwveyFZHwGMoD
         KI/Q2ayk3YDDtW0h9AjwO84heV/fSQ515G02es934k3tyrT2tjd3Mm2DoleoYnuzXLu2
         ZqUpipus7tRV8mWr7lHovxWHjcdl9EkVl+2l6jPqWKj/aWccgIBpqRizYOVvs1kYkT1A
         I6P7J800wefWvCZjKLMSBtf64JKfljV2Zh2pBZ2CJsc7nl+xVvPFFMJ7qEs2xDm+5pWD
         abtg==
X-Gm-Message-State: APjAAAXDJEajlkXAswcztW1CtaRM4RKOdTV5YyaMiQ4K9G3qjsLweIIH
        VU7syEonBYOmG59sef/WJpTVmTCyMg9trA==
X-Google-Smtp-Source: APXvYqwo70g8wI1S6kU9LHEbJWGrwC1+/hN9zzEW5VvE7e+jUEmKE7DIHRTLqwH+24lKeDF/rTMcWg==
X-Received: by 2002:a7b:c5c2:: with SMTP id n2mr1343263wmk.20.1569346421133;
        Tue, 24 Sep 2019 10:33:41 -0700 (PDT)
Received: from [192.168.8.32] (lneuilly-656-1-59-14.w80-11.abo.wanadoo.fr. [80.11.63.14])
        by smtp.gmail.com with ESMTPSA id t8sm2115327wrx.76.2019.09.24.10.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 10:33:40 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
 <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>
 <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
 <a0a0cddf-c5ae-43b0-5445-0bd55e4b7c45@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <79fa9cc2-e0cc-922f-89d3-9ace59abb2e8@gmail.com>
Date:   Tue, 24 Sep 2019 20:33:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <a0a0cddf-c5ae-43b0-5445-0bd55e4b7c45@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KjsOFZNQZgDGRZ0oueXrNbphZGMqnJqQT"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KjsOFZNQZgDGRZ0oueXrNbphZGMqnJqQT
Content-Type: multipart/mixed; boundary="r65atvubWzdmf9a3jrU1ajgP3OUE5c9JO";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <79fa9cc2-e0cc-922f-89d3-9ace59abb2e8@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
References: <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
 <b999490f-6138-b685-5472-5cd1843b747d@kernel.dk>
 <ed37058b-ee96-7d44-1dc7-d2c48e2ac23f@kernel.dk>
 <20190924094942.GN2349@hirez.programming.kicks-ass.net>
 <6f935fb9-6ebd-1df1-0cd0-69e34a16fa7e@kernel.dk>
 <29e6e06e-351f-c19d-ed7c-51f30c9ca887@kernel.dk>
 <08193e07-6f05-a496-492d-06ed8ce3aea1@gmail.com>
 <da86ec56-5f14-536d-2d43-2cc9e118d2a7@kernel.dk>
 <6228b13d-5ef6-e83e-b5dc-7a157013d43f@gmail.com>
 <a0a0cddf-c5ae-43b0-5445-0bd55e4b7c45@kernel.dk>
In-Reply-To: <a0a0cddf-c5ae-43b0-5445-0bd55e4b7c45@kernel.dk>

--r65atvubWzdmf9a3jrU1ajgP3OUE5c9JO
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/09/2019 16:13, Jens Axboe wrote:
> On 9/24/19 5:23 AM, Pavel Begunkov wrote:
>>> Yep that should do it, and saves 8 bytes of stack as well.
>>>
>>> BTW, did you test my patch, this one or the previous? Just curious if=
 it
>>> worked for you.
>>>
>> Not yet, going to do that tonight
>=20
> Thanks! For reference, the final version is below. There was still a
> signal mishap in there, now it should all be correct afaict.
>=20
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 9b84232e5cc4..d2a86164d520 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2768,6 +2768,38 @@ static int io_ring_submit(struct io_ring_ctx *ct=
x, unsigned int to_submit,
>  	return submit;
>  }
> =20
> +struct io_wait_queue {
> +	struct wait_queue_entry wq;
> +	struct io_ring_ctx *ctx;
> +	unsigned to_wait;
> +	unsigned nr_timeouts;
> +};
> +
> +static inline bool io_should_wake(struct io_wait_queue *iowq)
> +{
> +	struct io_ring_ctx *ctx =3D iowq->ctx;
> +
> +	/*
> +	 * Wake up if we have enough events, or if a timeout occured since we=

> +	 * started waiting. For timeouts, we always want to return to userspa=
ce,
> +	 * regardless of event count.
> +	 */
> +	return io_cqring_events(ctx->rings) >=3D iowq->to_wait ||
> +			atomic_read(&ctx->cq_timeouts) !=3D iowq->nr_timeouts;
> +}
> +
> +static int io_wake_function(struct wait_queue_entry *curr, unsigned in=
t mode,
> +			    int wake_flags, void *key)
> +{
> +	struct io_wait_queue *iowq =3D container_of(curr, struct io_wait_queu=
e,
> +							wq);
> +
> +	if (!io_should_wake(iowq))
> +		return -1;

It would try to schedule only the first task in the wait list. Is that th=
e
semantic you want?
E.g. for waiters=3D[32,8] and nr_events =3D=3D 8, io_wake_function() retu=
rns
after @32, and won't wake up the second one.=20

> +
> +	return autoremove_wake_function(curr, mode, wake_flags, key);
> +}
> +
>  /*
>   * Wait until events become available, if we don't already have some. =
The
>   * application must reap them itself, as they reside on the shared cq =
ring.
> @@ -2775,8 +2807,16 @@ static int io_ring_submit(struct io_ring_ctx *ct=
x, unsigned int to_submit,
>  static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>  			  const sigset_t __user *sig, size_t sigsz)
>  {
> +	struct io_wait_queue iowq =3D {
> +		.wq =3D {
> +			.private	=3D current,
> +			.func		=3D io_wake_function,
> +			.entry		=3D LIST_HEAD_INIT(iowq.wq.entry),
> +		},
> +		.ctx		=3D ctx,
> +		.to_wait	=3D min_events,
> +	};
>  	struct io_rings *rings =3D ctx->rings;
> -	unsigned nr_timeouts;
>  	int ret;
> =20
>  	if (io_cqring_events(rings) >=3D min_events)
> @@ -2795,15 +2835,20 @@ static int io_cqring_wait(struct io_ring_ctx *c=
tx, int min_events,
>  			return ret;
>  	}
> =20
> -	nr_timeouts =3D atomic_read(&ctx->cq_timeouts);
> -	/*
> -	 * Return if we have enough events, or if a timeout occured since
> -	 * we started waiting. For timeouts, we always want to return to
> -	 * userspace.
> -	 */
> -	ret =3D wait_event_interruptible(ctx->wait,
> -				io_cqring_events(rings) >=3D min_events ||
> -				atomic_read(&ctx->cq_timeouts) !=3D nr_timeouts);
> +	iowq.nr_timeouts =3D atomic_read(&ctx->cq_timeouts);
> +	do {
> +		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
> +						TASK_INTERRUPTIBLE);
> +		if (io_should_wake(&iowq))
> +			break;
> +		schedule();
> +		if (signal_pending(current)) {
> +			ret =3D -ERESTARTSYS;
> +			break;
> +		}
> +	} while (1);
> +	finish_wait(&ctx->wait, &iowq.wq);
> +
>  	restore_saved_sigmask_unless(ret =3D=3D -ERESTARTSYS);
>  	if (ret =3D=3D -ERESTARTSYS)
>  		ret =3D -EINTR;
>=20

--=20
Yours sincerely,
Pavel Begunkov


--r65atvubWzdmf9a3jrU1ajgP3OUE5c9JO--

--KjsOFZNQZgDGRZ0oueXrNbphZGMqnJqQT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2KU2oACgkQWt5b1Glr
+6Um5A/+PKLpKzJ52j00idkAD3cdkJZzyTNZCBBXIDRN0BVSQV9duDe/R+fcHjWV
r6fX4XrH3z1znlCtneeoVil9Ob9VRPvLDSj3z1pW+p/U42qZPpPyijVshHotWYRT
d5HJxB3Eo73NngWpAPS1W2H2QRpAn9TXAQYhhZoo8yLYuUW7OPl3IiBARfEukZsW
CzeA01LiNcp+uSZGwRBNSnjm7Guv6H4tLZWgTUQCvOxdXAbN5FTXTdVMl5NrfnHh
Da3m8m92fvLjN92pv2UgYO/iP1c9h7SqM8CZ2HU9jRnKorJKr3gv1ArxtFVBuXXb
NKwCQvHWTRUr/2AfRfAPpKSrTH3/0/bgx+Y7p+EAIttUhbs6/1fjzVLfUzbSrWwm
y+9b09JyJua/iCC5KQe7h7uvLikEGwiMCRJyb+AlM8IZPeEtTIsmcEM9lDvhdUWE
al7a78RB25OJY3/Jc5IhjNRjZHQwHaXxlOPjb50ZPFmcfJu0HeBeDA+bVJt6YkvJ
A9UHuOL6OEspbdggnmTGPD3MAIWnKWYymOEbCT0IjOq/RL2HQaF2dSO3FJBAMz1I
0egeyuu0ZeFAUR8aDU1dwOZJNLZBYPyPl8PXf/drs74ssDcjOP8XAiyTiuwPWeNw
TsdtpgHVv6tJrb8UBWp2XSq55kkTMHRmvULfAgFptojE7S/GpFE=
=JR0g
-----END PGP SIGNATURE-----

--KjsOFZNQZgDGRZ0oueXrNbphZGMqnJqQT--
