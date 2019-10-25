Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD117CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B5A21D71
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXiaoald"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394341AbfJYJg3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:36:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41238 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394278AbfJYJg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 05:36:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id p4so1497759wrm.8;
        Fri, 25 Oct 2019 02:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=bl2WOS2669jS0p4MM0ZtP9XkzD7cMvf/ibHDNKVuLWk=;
        b=IXiaoaldrF6iUk12g/Y3LCoVjCI4RxHAJPOklslTv7UtWVgPxy0aost/o83pfOPyFw
         nDUw2908sAD2OSWhlTK37/BTR4TVZIz8IOJeFuYxnSlSqgEMPmpaFhwgViSKXlvYJwHi
         DUq40a892m/o2cDB7ixVEd7i0FT03fjKb9VQdkgF7ey3T5kdkaXIHVPBbHeG8P3zeJFu
         rQSlrsvGzKKrxtArvk9pUiMUV8eJTnayrExznWNw8mSr6kTYYvbQc8a77CGWpZitgFtd
         A6+5SuwhSqKhHMwD5LP5kokvGmv6iHLNzJQR/F4Bew/nsN5rbmCLufRikbFnmOECma9U
         I2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=bl2WOS2669jS0p4MM0ZtP9XkzD7cMvf/ibHDNKVuLWk=;
        b=fHpzpfXnvL+ZcvtrC3WXwD6dJa27t5VkBOgyjSXZrLdJ63TaRrvmbwNCo9kDAq0jGQ
         f8soefgWlNKS6gA+oV4lLqzuqn3v9MPit1ownFzkFANwx7DNOrju6Lf7EviuJnzIc4k7
         9OENA7QhlXiebzttAhtUO2ssEGCFYNVG+BsyWJmwlRkMCifo1H0HhhPW2rZc40fP9+1G
         uEpApcop7q7jnDXs7I/VB2unIM0cGdx7xXjiGlIX42ub3xe4Mp5yY2dWAgLxvryajJ0A
         9603xrIU+O9ctrzIReTZVHqJ/wX+enSWyfsDFwELbh3L1Qj+nuEcAR0aT/6SBsH55AOp
         ioNQ==
X-Gm-Message-State: APjAAAV2RkfzEfOPaV0oAwxv8t1ZNxx8+Vf954I9UfI9HsHf0dRfOiMC
        5tuTna4BLmoEJdmBBkHmcQHjB1Ic
X-Google-Smtp-Source: APXvYqwUa0z/dIvO3qhLSYkp+dj9hOcmQP6zs05xxHjGoxbU0I2lzNTwfMZs/h/KIjZMlrg96lWJxw==
X-Received: by 2002:adf:9481:: with SMTP id 1mr1759151wrr.77.1571996184787;
        Fri, 25 Oct 2019 02:36:24 -0700 (PDT)
Received: from [192.168.43.159] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id d11sm1843285wrf.80.2019.10.25.02.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 02:36:23 -0700 (PDT)
Subject: Re: [PATCH 2/3] io_uring: Fix broken links with offloading
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1571991701.git.asml.silence@gmail.com>
 <bd0eaa7729e3b8b599a25167df0a4ee583da69cc.1571991701.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Message-ID: <dd88f5be-930b-53e5-c3b6-12927d6634b1@gmail.com>
Date:   Fri, 25 Oct 2019 12:36:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bd0eaa7729e3b8b599a25167df0a4ee583da69cc.1571991701.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mHWPEBz81cRimIQsEmEbITjOhg7CAv6pF"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mHWPEBz81cRimIQsEmEbITjOhg7CAv6pF
Content-Type: multipart/mixed; boundary="dAxsiZJdm05bU2fyu7JGJI1vDxCHPKQ6V";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <dd88f5be-930b-53e5-c3b6-12927d6634b1@gmail.com>
Subject: Re: [PATCH 2/3] io_uring: Fix broken links with offloading
References: <cover.1571991701.git.asml.silence@gmail.com>
 <bd0eaa7729e3b8b599a25167df0a4ee583da69cc.1571991701.git.asml.silence@gmail.com>
In-Reply-To: <bd0eaa7729e3b8b599a25167df0a4ee583da69cc.1571991701.git.asml.silence@gmail.com>

--dAxsiZJdm05bU2fyu7JGJI1vDxCHPKQ6V
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/10/2019 12:31, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
>=20
> io_sq_thread() processes sqes by 8 without considering links. As a
> result, links will be randomely subdivided.
>=20
> The easiest way to fix it is to call io_get_sqring() inside
> io_submit_sqes() as do io_ring_submit().
>=20
> Downsides:
> 1. This removes optimisation of not grabbing mm_struct for fixed files
> 2. It submitting all sqes in one go, without finer-grained sheduling
> with cq processing.
>=20
Is this logic with not-grabbing mm and fixed files critical?
I want to put it back later after some cleanup.=20

> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 62 +++++++++++++++++++++++++++------------------------=

>  1 file changed, 33 insertions(+), 29 deletions(-)
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 0e141d905a5b..949c82a40d16 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -735,6 +735,14 @@ static unsigned io_cqring_events(struct io_rings *=
rings)
>  	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
>  }
> =20
> +static inline unsigned int io_sqring_entries(struct io_ring_ctx *ctx)
> +{
> +	struct io_rings *rings =3D ctx->rings;
> +
> +	/* make sure SQ entry isn't read before tail */
> +	return smp_load_acquire(&rings->sq.tail) - ctx->cached_sq_head;
> +}
> +
>  /*
>   * Find and free completed poll iocbs
>   */
> @@ -2560,8 +2568,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx=
, struct sqe_submit *s)
>  	return false;
>  }
> =20
> -static int io_submit_sqes(struct io_ring_ctx *ctx, struct sqe_submit *=
sqes,
> -			  unsigned int nr, bool has_user, bool mm_fault)
> +static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
> +			  bool has_user, bool mm_fault)
>  {
>  	struct io_submit_state state, *statep =3D NULL;
>  	struct io_kiocb *link =3D NULL;
> @@ -2575,6 +2583,11 @@ static int io_submit_sqes(struct io_ring_ctx *ct=
x, struct sqe_submit *sqes,
>  	}
> =20
>  	for (i =3D 0; i < nr; i++) {
> +		struct sqe_submit s;
> +
> +		if (!io_get_sqring(ctx, &s))
> +			break;
> +
>  		/*
>  		 * If previous wasn't linked and we have a linked command,
>  		 * that's the end of the chain. Submit the previous link.
> @@ -2584,9 +2597,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx=
, struct sqe_submit *sqes,
>  			link =3D NULL;
>  			shadow_req =3D NULL;
>  		}
> -		prev_was_link =3D (sqes[i].sqe->flags & IOSQE_IO_LINK) !=3D 0;
> +		prev_was_link =3D (s.sqe->flags & IOSQE_IO_LINK) !=3D 0;
> =20
> -		if (link && (sqes[i].sqe->flags & IOSQE_IO_DRAIN)) {
> +		if (link && (s.sqe->flags & IOSQE_IO_DRAIN)) {
>  			if (!shadow_req) {
>  				shadow_req =3D io_get_req(ctx, NULL);
>  				if (unlikely(!shadow_req))
> @@ -2594,18 +2607,18 @@ static int io_submit_sqes(struct io_ring_ctx *c=
tx, struct sqe_submit *sqes,
>  				shadow_req->flags |=3D (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
>  				refcount_dec(&shadow_req->refs);
>  			}
> -			shadow_req->sequence =3D sqes[i].sequence;
> +			shadow_req->sequence =3D s.sequence;
>  		}
> =20
>  out:
>  		if (unlikely(mm_fault)) {
> -			io_cqring_add_event(ctx, sqes[i].sqe->user_data,
> +			io_cqring_add_event(ctx, s.sqe->user_data,
>  						-EFAULT);
>  		} else {
> -			sqes[i].has_user =3D has_user;
> -			sqes[i].needs_lock =3D true;
> -			sqes[i].needs_fixed_file =3D true;
> -			io_submit_sqe(ctx, &sqes[i], statep, &link);
> +			s.has_user =3D has_user;
> +			s.needs_lock =3D true;
> +			s.needs_fixed_file =3D true;
> +			io_submit_sqe(ctx, &s, statep, &link);
>  			submitted++;
>  		}
>  	}
> @@ -2620,7 +2633,6 @@ static int io_submit_sqes(struct io_ring_ctx *ctx=
, struct sqe_submit *sqes,
> =20
>  static int io_sq_thread(void *data)
>  {
> -	struct sqe_submit sqes[IO_IOPOLL_BATCH];
>  	struct io_ring_ctx *ctx =3D data;
>  	struct mm_struct *cur_mm =3D NULL;
>  	mm_segment_t old_fs;
> @@ -2635,8 +2647,8 @@ static int io_sq_thread(void *data)
> =20
>  	timeout =3D inflight =3D 0;
>  	while (!kthread_should_park()) {
> -		bool all_fixed, mm_fault =3D false;
> -		int i;
> +		bool mm_fault =3D false;
> +		unsigned int to_submit;
> =20
>  		if (inflight) {
>  			unsigned nr_events =3D 0;
> @@ -2656,7 +2668,8 @@ static int io_sq_thread(void *data)
>  				timeout =3D jiffies + ctx->sq_thread_idle;
>  		}
> =20
> -		if (!io_get_sqring(ctx, &sqes[0])) {
> +		to_submit =3D io_sqring_entries(ctx);
> +		if (!to_submit) {
>  			/*
>  			 * We're polling. If we're within the defined idle
>  			 * period, then let us spin without work before going
> @@ -2687,7 +2700,8 @@ static int io_sq_thread(void *data)
>  			/* make sure to read SQ tail after writing flags */
>  			smp_mb();
> =20
> -			if (!io_get_sqring(ctx, &sqes[0])) {
> +			to_submit =3D io_sqring_entries(ctx);
> +			if (!to_submit) {
>  				if (kthread_should_park()) {
>  					finish_wait(&ctx->sqo_wait, &wait);
>  					break;
> @@ -2705,19 +2719,8 @@ static int io_sq_thread(void *data)
>  			ctx->rings->sq_flags &=3D ~IORING_SQ_NEED_WAKEUP;
>  		}
> =20
> -		i =3D 0;
> -		all_fixed =3D true;
> -		do {
> -			if (all_fixed && io_sqe_needs_user(sqes[i].sqe))
> -				all_fixed =3D false;
> -
> -			i++;
> -			if (i =3D=3D ARRAY_SIZE(sqes))
> -				break;
> -		} while (io_get_sqring(ctx, &sqes[i]));
> -
>  		/* Unless all new commands are FIXED regions, grab mm */
> -		if (!all_fixed && !cur_mm) {
> +		if (!cur_mm) {
>  			mm_fault =3D !mmget_not_zero(ctx->sqo_mm);
>  			if (!mm_fault) {
>  				use_mm(ctx->sqo_mm);
> @@ -2725,8 +2728,9 @@ static int io_sq_thread(void *data)
>  			}
>  		}
> =20
> -		inflight +=3D io_submit_sqes(ctx, sqes, i, cur_mm !=3D NULL,
> -						mm_fault);
> +		to_submit =3D min(to_submit, ctx->sq_entries);
> +		inflight +=3D io_submit_sqes(ctx, to_submit, cur_mm !=3D NULL,
> +					   mm_fault);
> =20
>  		/* Commit SQ ring head once we've consumed all SQEs */
>  		io_commit_sqring(ctx);
>=20

--=20
Yours sincerely,
Pavel Begunkov


--dAxsiZJdm05bU2fyu7JGJI1vDxCHPKQ6V--

--mHWPEBz81cRimIQsEmEbITjOhg7CAv6pF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2ywhUACgkQWt5b1Glr
+6UXShAAsvlD9gTd60XZrIeaxjVekD4n8DwcS7+4pON7+sQLN3bz2sIuCS2igy7f
Z2JPtveb6DLZcOeNvO/D3VEI3CwMmlIxHfkS6uccWx9J+6kP2C2ogKljMrDC9Vsj
+Zr/afFnLxo/AULBdyLRnc7S1hJvHcH/E4YR0H1aiXRoBiRcdDnMr2kZiMgvuzmj
TneXnZdxe35P7RQ9SAPyiYd5qrvKMKxHrGSV4Xc6Lde3+WN+/VTER3Kabbx0MdfJ
zAYJsrN8xMtuDnx4rpFadKsD6RP7lTO1ThaGwa63/erZe/f0h5ZbAYm7kTmaXvTE
K0Qu7LgOSPZt6u8/O+73w2S437aI7QtKmOjkz9QA7CdelRQVwKuGB4GiJuGUWrSN
ewEQzVhb0TsM/ohkwvx7Z+s8penPRvfKPEohXa6td9HBnWFEG1/UJcVEiYbE4ExJ
lGLNV+uv79huUmik2u64fCoLE+Ls68H2z72tFLttey6HGaIH+bJ1aDcEoT2KzyY7
FsrbzefpWgU0sH0Jdqbi9wONq24BqWmHe0Q2K2tT/cpmxRcPjsBiuSakPuHV0yHL
28q5DI4+PLZPl1bZK7mBO7EuO7dxTECiLlQFGMndnpYiSKPKfFRyt6jd+rgQIiZK
kfg9yZ3xJc+2W0WRIVSmKTyWMN9UAT6RjtzH5yAjyrN8j283rWk=
=8ZaJ
-----END PGP SIGNATURE-----

--mHWPEBz81cRimIQsEmEbITjOhg7CAv6pF--
