Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D31C4320D
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 07:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2012214DA
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 07:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJTZVSOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393733AbfIXHGT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 03:06:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46472 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393722AbfIXHGS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 03:06:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id o18so590383wrv.13;
        Tue, 24 Sep 2019 00:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=CAqNz62rnzTMNzotl4P9H07Js4miitT+DDcrWnY0cWc=;
        b=rJTZVSORuL57Mc4ZyKsKALo+9sBpF5Mzmz1GmI8MY7S94m5thAzv1oR6jZXGAOanWW
         h8xTk5T3fa1RLNLmlkxF+m7OzS4AR6iBx/8pKG5CjPe44PujdnCCtgvBWGc/Q+nZZvh2
         X9Y1kl/sb8C2z4hEtKYii1wOePEJSNXL1mrscw3nfbcgYxEdsA8wpmzDhpzJslFpRsgu
         cejA6qRJh+e66egiKHujniRopzlpXTMc5Q2s1xMiq9OFyO6EyZWuysmLowYojFKlg8Jc
         tpD6ebh1lkQ4PXPHL40VcqGJyaPBJmAwM613njXWn3Ixx9hafkSyJb8SQqJN0u0IYGI5
         ZrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=CAqNz62rnzTMNzotl4P9H07Js4miitT+DDcrWnY0cWc=;
        b=rSw1I/DEAUnv4ciRQHk/2wQ62CWLzZEuKXLgUS3gklIcVqRozLNnFtosbVxjg9Q/Em
         6+m91zezyVNEBTxN55FCdyHWM9AmFHM3W590sVjDMu6mktNkRIp1n6XfUrGmEeTuUpzd
         /cc6teoHx6QNFHTMQdzh+uuPCLy0VAuKdJfw9a11HtIbEKU9lOkWWnpbPoZJjPHuIeVu
         52az4J/mGxLQhmSJUak+cAMa0J+0Z6f+ZdGAXStEB+nOg7NT6agpI1MBMZ2WTON+TgL1
         zJLVqPGFo1P/5Lc8Zk0sp1P9HUrqdoQTG7RuiQwJ+MEGic+uMUB+VE6wMQsDo3YMRFx6
         +S4A==
X-Gm-Message-State: APjAAAXZ6q+UygKLlvYJzxudBJAuyee41/wFo1yegwgMfupyyc52piEu
        QSSusI9mdk849jmCZRiGQIXtBuetFq4Q9g==
X-Google-Smtp-Source: APXvYqz+WYxuVu5/TdOSON0xsXKT6yYyu4OrrsdmzfBSfxXiUgEYTOYW+8Vmrbkygnc6kecWwrmpQw==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr1062803wrx.91.1569308774442;
        Tue, 24 Sep 2019 00:06:14 -0700 (PDT)
Received: from [192.168.8.30] (lneuilly-656-1-59-14.w80-11.abo.wanadoo.fr. [80.11.63.14])
        by smtp.gmail.com with ESMTPSA id r20sm1845949wrg.61.2019.09.24.00.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 00:06:13 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
Date:   Tue, 24 Sep 2019 10:06:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FwcUuJqbd9xT7RzjZ64ZCX1utaCPzItat"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FwcUuJqbd9xT7RzjZ64ZCX1utaCPzItat
Content-Type: multipart/mixed; boundary="rVgAjVFYdFkb3QtGeWSQt1dDplbVOwwud";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
In-Reply-To: <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>

--rVgAjVFYdFkb3QtGeWSQt1dDplbVOwwud
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/09/2019 02:00, Jens Axboe wrote:
>> I think we can do the same thing, just wrapping the waitqueue in a
>> structure with a count in it, on the stack. Got some flight time
>> coming up later today, let me try and cook up a patch.
>=20
> Totally untested, and sent out 5 min before departure... But something
> like this.
Hmm, reminds me my first version. Basically that's the same thing but
with macroses inlined. I wanted to make it reusable and self-contained,
though.

If you don't think it could be useful in other places, sure, we could do
something like that. Is that so?

>=20
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index ca7570aca430..c2f9e1da26dd 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2768,6 +2768,37 @@ static int io_ring_submit(struct io_ring_ctx *ct=
x, unsigned int to_submit,
>  	return submit;
>  }
> =20
> +struct io_wait_queue {
> +	struct wait_queue_entry wq;
> +	struct io_ring_ctx *ctx;
> +	struct task_struct *task;
> +	unsigned to_wait;
> +	unsigned nr_timeouts;
> +};
> +
> +static inline bool io_should_wake(struct io_wait_queue *iowq)
> +{
> +	struct io_ring_ctx *ctx =3D iowq->ctx;
> +
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
> +	if (io_should_wake(iowq)) {
> +		list_del_init(&curr->entry);
> +		wake_up_process(iowq->task);
> +		return 1;
> +	}
> +
> +	return -1;
> +}
> +
>  /*
>   * Wait until events become available, if we don't already have some. =
The
>   * application must reap them itself, as they reside on the shared cq =
ring.
> @@ -2775,8 +2806,16 @@ static int io_ring_submit(struct io_ring_ctx *ct=
x, unsigned int to_submit,
>  static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
>  			  const sigset_t __user *sig, size_t sigsz)
>  {
> +	struct io_wait_queue iowq =3D {
> +		.wq =3D {
> +			.func	=3D io_wake_function,
> +			.entry	=3D LIST_HEAD_INIT(iowq.wq.entry),
> +		},
> +		.task		=3D current,
> +		.ctx		=3D ctx,
> +		.to_wait	=3D min_events,
> +	};
>  	struct io_rings *rings =3D ctx->rings;
> -	unsigned nr_timeouts;
>  	int ret;
> =20
>  	if (io_cqring_events(rings) >=3D min_events)
> @@ -2795,15 +2834,16 @@ static int io_cqring_wait(struct io_ring_ctx *c=
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
> +	prepare_to_wait_exclusive(&ctx->wait, &iowq.wq, TASK_INTERRUPTIBLE);
> +	do {
> +		if (io_should_wake(&iowq))
> +			break;
> +		schedule();
> +		set_current_state(TASK_INTERRUPTIBLE);
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


--rVgAjVFYdFkb3QtGeWSQt1dDplbVOwwud--

--FwcUuJqbd9xT7RzjZ64ZCX1utaCPzItat
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2JwFwACgkQWt5b1Glr
+6UJ7BAAsR6funLjt958HBmYxRNFaCHMpF6P5rDfadzdHyWmrF5hR/ZZcvAJ1qZL
IuOtogyKWm00hiTRzUtxpSNGHsQG+HpjtOVmbcwu7SSbpDME+Ig23VhSXI0zz/kk
mNycbDXACSzbimv5wdBseQ3WF3hjd4t6QHUHItSfDiMBHJMoL79oWxCN4xSOxyhU
e3t2Tt8HKFUrm0CKvzRJta1cWzaApakbyVka0nvD6XMZiouFmmjtKWQyyh2pyI84
NzdTWB/mJ3+CEqhAcggmJnxtdpItK153xI/+QbAB7PxcHxoe40pla/bvGrQjsg1y
tckYqHivWFeY4k7MfPV6I73tj2ue/tUiwCq0HbgsHp/YI+FmJsBX7sknswsp71E4
IheoUwhSee2C55RNrPO/ZS6Qc+tGQw+Q7Vr8LodT+TJ1DHt7jUv6ct3lYiR6xnqm
1QnnIhIwypWLq1HbXeHUhBzq8EzTNYpGal6THnwUH2hyRY567zWWZxPHiTa5tDNL
CRzWgj1WuBdINjm8kIu1DxHNd1wbCfrn9xxR7a1dJ6td/K59TiAOV9LdF2TX95+6
yz20qc74LGygYcRCEWG3p5/KXN559Wk3VFQ1rOjhENi6HLysDHNzOR7nwA5bXAYo
Nq/Z7D172crlkXHSuEE6yJ8lZ0f4Qs6veDa0djA6Guqgv2N/4i0=
=ZXN9
-----END PGP SIGNATURE-----

--FwcUuJqbd9xT7RzjZ64ZCX1utaCPzItat--
