Return-Path: <SRS0=56XS=XT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B4C432C1
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 09:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD9214D9
	for <linux-block@archiver.kernel.org>; Tue, 24 Sep 2019 09:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlXwiZKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504163AbfIXJWA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Sep 2019 05:22:00 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54282 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504078AbfIXJWA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Sep 2019 05:22:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id p7so1333113wmp.4;
        Tue, 24 Sep 2019 02:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=4Svmg2pNEqL0dYuavoZKpfwgMfpM01EW1kt+QBDceJE=;
        b=MlXwiZKQikdeBvxmrJfV8Gai1mjWMgnJiETI5J2JOUbsvW9sDWu+myjEMZ81O16U7d
         lzkZ+wOBuGJbQmu7tDADq4B7UEjTTY4XMXkbKJjtSgaGCMUhhbKtRyirF+6YGQ/uCmPt
         cMPs6TU0noXVCTtbEAayYuuiYEmAPAdCFZOTJI/x4XOVIerm69OUcqqiG1CVRig76Dyr
         U7+n4j6fNgQr6JGYEV1eot42yopdkULYe9jhLUOnpuWFw36a6B9H1IfrdgDbnegQu61Z
         SMOZCLNvEhNBQMjhRmaX4zoiep76KNTmEN1jbthbi+DvkdxxBhuWS35eOIM9mxK2z7RX
         3zcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=4Svmg2pNEqL0dYuavoZKpfwgMfpM01EW1kt+QBDceJE=;
        b=ZRXgl7RuGl3zk2FDRix1ltXT1L2+5i7lK+1Ux5lfc2KzNHxp13uC9wsEQKaOvIitV/
         M4jhXXOsBU88giLwJAWcJqlCZ/Dp4Mx2kXD//3eDc0E9sJM4VIFdJ73i/z/HUP54uhNO
         q1v3cGxFM4Izo7bB6BSCezkjHeUv1d9Cgs+tURF12m21PEXUGJG3/IGmW55uBWmTyZw2
         qdD6MFXpZ1hE4qYOq7ZYXiechDeRz6u25lZJszrwVswutpTjPlB4pmOV4j6NU2pSMllS
         p7Ph7XxVpUHeHF7jpY4oVtfj7Pk+lf3SoC7ZYcFEI2GuUNnekcJ+Q2ecVuV396NGL8i5
         7OWw==
X-Gm-Message-State: APjAAAWCln5lc7W1iGoF1U17/Z46epVOcRNjXrxKXsfr1+DC9kZfojKb
        2jm7xgDfnSgxQ1JI/3z7jLVC3P/2FkUNKg==
X-Google-Smtp-Source: APXvYqwASUkYuwhefE6C0dpz46PSCzveOWWztKrDI0h0mZHrKx8qLHc+PMoDXpwYAq4ylZth+IfQbw==
X-Received: by 2002:a05:600c:291c:: with SMTP id i28mr1751140wmd.98.1569316916487;
        Tue, 24 Sep 2019 02:21:56 -0700 (PDT)
Received: from [192.168.1.75] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id z189sm1974398wmc.25.2019.09.24.02.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 02:21:55 -0700 (PDT)
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
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
Message-ID: <38ea2681-dbf0-457a-dcc0-406d10e2572b@gmail.com>
Date:   Tue, 24 Sep 2019 12:21:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lpznCLlSs4WrAqwlvXfl5dExYmPCsu9vv"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lpznCLlSs4WrAqwlvXfl5dExYmPCsu9vv
Content-Type: multipart/mixed; boundary="AYFSNnwktxvoAOmfPIeRB9q8WipSBL4dg";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <38ea2681-dbf0-457a-dcc0-406d10e2572b@gmail.com>
Subject: Re: [PATCH v2 0/2] Optimise io_uring completion waiting
References: <cover.1569139018.git.asml.silence@gmail.com>
 <a4996ae7-ac0a-447b-49b2-7e96275aad29@kernel.dk>
 <20190923083549.GA42487@gmail.com>
 <c15b2d54-c722-8fb4-266f-b589c1a21aa5@gmail.com>
 <df612e90-8999-0085-d2d6-4418e044e429@gmail.com>
 <731b2087-7786-5374-68ff-8cba42f0cd68@kernel.dk>
 <759b9b48-1de3-1d43-3e39-9c530bfffaa0@kernel.dk>
 <43244626-9cfd-0c0b-e7a1-878363712ef3@gmail.com>
 <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>
In-Reply-To: <f2608e3d-bb4e-9984-79e8-a2ab4f855c7f@kernel.dk>

--AYFSNnwktxvoAOmfPIeRB9q8WipSBL4dg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 24/09/2019 11:02, Jens Axboe wrote:
> On 9/24/19 1:06 AM, Pavel Begunkov wrote:
>> On 24/09/2019 02:00, Jens Axboe wrote:
>>>> I think we can do the same thing, just wrapping the waitqueue in a
>>>> structure with a count in it, on the stack. Got some flight time
>>>> coming up later today, let me try and cook up a patch.
>>>
>>> Totally untested, and sent out 5 min before departure... But somethin=
g
>>> like this.
>> Hmm, reminds me my first version. Basically that's the same thing but
>> with macroses inlined. I wanted to make it reusable and self-contained=
,
>> though.
>>
>> If you don't think it could be useful in other places, sure, we could =
do
>> something like that. Is that so?
>=20
> I totally agree it could be useful in other places. Maybe formalized an=
d
> used with wake_up_nr() instead of adding a new primitive? Haven't looke=
d
> into that, I may be talking nonsense.

@nr there is about number of tasks to wake up. AFAIK doesn't solve the
problem.


>=20
> In any case, I did get a chance to test it and it works for me. Here's
> the "finished" version, slightly cleaned up and with a comment added
> for good measure.
>=20
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index ca7570aca430..14fae454cf75 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2768,6 +2768,42 @@ static int io_ring_submit(struct io_ring_ctx *ct=
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
> @@ -2775,8 +2811,16 @@ static int io_ring_submit(struct io_ring_ctx *ct=
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
> @@ -2795,15 +2839,16 @@ static int io_cqring_wait(struct io_ring_ctx *c=
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


--AYFSNnwktxvoAOmfPIeRB9q8WipSBL4dg--

--lpznCLlSs4WrAqwlvXfl5dExYmPCsu9vv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2J4DIACgkQWt5b1Glr
+6WNLA//bv2aKPQXnFAUJhFNN41r3jG8nJEkr6M+DTwBdH7wd7VL9PgxgSZwQRQq
JW9rkpnOj5omgn8k7GYP+KoUNRa1cLani69YXfWVmC6ZSe3RL/+9yqyY/fbMZzHD
4Yx7chOSSV+up7wX6Vs4jw/bfz5rqnXscY7ZMLj5nopex3N2kmwfgWaetyIW8K4x
11ijC13G2fGxpkMnGbKLDFxjnp6O25J6jWbUqIEkr0qQeXRjGqdwgguFrzT03ixm
Z1UAfJV5oBUIkL1GImZsqh+ShffLyuW6W9YnCa4bxdR+7m/OJIbr7K5OEvBdT7dh
6xWKEMl9My/p5PWZ145k8tNLyHYoYlXqmQyzn2DWGqkTdegY6UeEJxkhJKpT2OgU
FS3LpXFS7SJk/dMY3SSu7IjWXuLNRGQqTWejh7K8v2xbjoSk1d752tkzxkfIshhs
yaLuTg+XX6w9/sn/559+t7zj2tIYSI1Xtp55SuPIWFiBo40NTHEc7n471AG21Dyl
rwhyArFclYcBf99in4D4vzyDGuSczI3opTS3v+TfqNx196A1M7E3xnN8KoLlKKOe
+3gg9lwVqiOMtOdQchVpv0UHE9pjfspoQSoN43NIqTGLmR9UD2Ybn3zqKugRT4lU
5dIGjcD/uh7xzDLCyvyPvw+0Iiu2QltWTR+Bs8EkBix18xhFIKw=
=2EOm
-----END PGP SIGNATURE-----

--lpznCLlSs4WrAqwlvXfl5dExYmPCsu9vv--
