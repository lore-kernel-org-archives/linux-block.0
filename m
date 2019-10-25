Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADB3CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA5D21872
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTTirIWn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505693AbfJYQWO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:22:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37845 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504588AbfJYQWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:22:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so3015583wrv.4;
        Fri, 25 Oct 2019 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=6DKBsyh9rd4szCk7pHckqGu4/wV1h0ZRgzPXT5s9i04=;
        b=vTTirIWntOdHc9ARQukkY7j+0REIQ75LK2GTvlFXy/HbtvHfOD5coAGlf4PSURexny
         oYaYAz+lw0YPUezNFtkU1EOM9QFh/7JG0jK6gGh8np4b0ELc1T5X+uggCYHcssyexb/3
         nBfiITmIcr4yD4Oa6L+xBb5pL2xIG4GUyrhOTYW7icc1jGEKR+ErGRrRcHVpk9XkfP3P
         zfvIRCRbafu5t+O0iN8zjXloD42BxJQBpm/a8Kp1hv3ZtCp4xhqbzNAZtj6hUIOlZVEx
         k+8hZ7ObXPY5TnIzt2MQa9jcTxwQTy7CuOkYer9zyfp/Vk8aojmVTSw59G/Oxb1WSQpa
         PRjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:from:autocrypt:subject:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=6DKBsyh9rd4szCk7pHckqGu4/wV1h0ZRgzPXT5s9i04=;
        b=DPIEzARJHl0R6zIjVl0udzGoJP+Cv5rnc4QQMAkzzuyznhx4+1WBpniBkYJ//cg2uR
         aEGio3A1mKVFKT7Le90lkxCsDZL2Ausrq/DL+cnVG0wt8eh9b24luepNjDvaPLKNEt4W
         Hrepko8A5vxeCNPGHt07Rhu0C8lLZMbyoS0pFoGGwrLKyZhVa5CRvYjGshioYvI8FA8k
         wlshKrWtmTZE39fw5mX2WXW6dCCNq6gqzvXwWpYDebh8gxD6JIMFjgpDx+MUbcl0sjnw
         qX4e3Rgd8uCAQgrARbUxiuD5TYtADNTNon2ICCvezeHDdKJhlXPV+2w33reGT4WAK91t
         HCsg==
X-Gm-Message-State: APjAAAU+iTaJCgak+AXrLZpQUZ67nf9zGNuV8Y+eNmxTch7SVI4cry6V
        jZmteIdOi6dztF8qkeLpCb3o+eNN
X-Google-Smtp-Source: APXvYqxRz8zzjI9/+FFus3XHgA9PvhPBNj4SZ0eQXtxLHYwVTKnHYi4esAS8xxkybgN8g0tJUTHWBg==
X-Received: by 2002:adf:e5cf:: with SMTP id a15mr4029419wrn.143.1572020529884;
        Fri, 25 Oct 2019 09:22:09 -0700 (PDT)
Received: from [192.168.43.159] ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id a11sm3155396wmh.40.2019.10.25.09.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:22:09 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [BUG] io_uring: defer logic based on shared data
Message-ID: <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
Date:   Fri, 25 Oct 2019 19:21:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NoC8xj7Uw8eyBPdqTqrq7u7fElAPP7pFw"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NoC8xj7Uw8eyBPdqTqrq7u7fElAPP7pFw
Content-Type: multipart/mixed; boundary="z8mmP2Vpy7y45yY1OVFAnMpYGiQTDX9Aa";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <b44b0488-ba66-0187-2d9b-6949ceb613fb@gmail.com>
Subject: Re: [BUG] io_uring: defer logic based on shared data
References: <5badf1c0-9a7d-0950-2943-ff8db33e0929@gmail.com>
 <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>
In-Reply-To: <bfb58429-6abe-06f0-3fd8-14a0040cecf0@kernel.dk>

--z8mmP2Vpy7y45yY1OVFAnMpYGiQTDX9Aa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/10/2019 19:03, Jens Axboe wrote:
> On 10/25/19 3:55 AM, Pavel Begunkov wrote:
>> I found 2 problems with __io_sequence_defer().
>>
>> 1. it uses @sq_dropped, but doesn't consider @cq_overflow
>> 2. @sq_dropped and @cq_overflow are write-shared with userspace, so
>> it can be maliciously changed.
>>
>> see sent liburing test (test/defer *_hung()), which left an unkillable=

>> process for me
>=20
> OK, how about the below. I'll split this in two, as it's really two
> separate fixes.
cached_sq_dropped is good, but I was concerned about cached_cq_overflow.
io_cqring_fill_event() can be called in async, so shouldn't we do some
synchronisation then?

>=20
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 5d10984381cf..5d9d960c1c17 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -191,6 +191,7 @@ struct io_ring_ctx {
>  		unsigned		sq_entries;
>  		unsigned		sq_mask;
>  		unsigned		sq_thread_idle;
> +		unsigned		cached_sq_dropped;
>  		struct io_uring_sqe	*sq_sqes;
> =20
>  		struct list_head	defer_list;
> @@ -208,6 +209,7 @@ struct io_ring_ctx {
> =20
>  	struct {
>  		unsigned		cached_cq_tail;
> +		unsigned		cached_cq_overflow;
>  		unsigned		cq_entries;
>  		unsigned		cq_mask;
>  		struct wait_queue_head	cq_wait;
> @@ -419,7 +421,8 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct=
 io_uring_params *p)
>  static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
>  				       struct io_kiocb *req)
>  {
> -	return req->sequence !=3D ctx->cached_cq_tail + ctx->rings->sq_droppe=
d;
> +	return req->sequence !=3D ctx->cached_cq_tail + ctx->cached_sq_droppe=
d
> +					+ ctx->cached_cq_overflow;
>  }
> =20
>  static inline bool io_sequence_defer(struct io_ring_ctx *ctx,
> @@ -590,9 +593,8 @@ static void io_cqring_fill_event(struct io_ring_ctx=
 *ctx, u64 ki_user_data,
>  		WRITE_ONCE(cqe->res, res);
>  		WRITE_ONCE(cqe->flags, 0);
>  	} else {
> -		unsigned overflow =3D READ_ONCE(ctx->rings->cq_overflow);
> -
> -		WRITE_ONCE(ctx->rings->cq_overflow, overflow + 1);
> +		ctx->cached_cq_overflow++;
> +		WRITE_ONCE(ctx->rings->cq_overflow, ctx->cached_cq_overflow);
>  	}
>  }
> =20
> @@ -2601,7 +2603,8 @@ static bool io_get_sqring(struct io_ring_ctx *ctx=
, struct sqe_submit *s)
> =20
>  	/* drop invalid entries */
>  	ctx->cached_sq_head++;
> -	rings->sq_dropped++;
> +	ctx->cached_sq_dropped++;
> +	WRITE_ONCE(rings->sq_dropped, ctx->cached_sq_dropped);
>  	return false;
>  }
> =20
> @@ -2685,6 +2688,7 @@ static int io_sq_thread(void *data)
> =20
>  	timeout =3D inflight =3D 0;
>  	while (!kthread_should_park()) {
> +		unsigned prev_cq, cur_cq;
>  		bool mm_fault =3D false;
>  		unsigned int to_submit;
> =20
> @@ -2767,8 +2771,12 @@ static int io_sq_thread(void *data)
>  		}
> =20
>  		to_submit =3D min(to_submit, ctx->sq_entries);
> +		prev_cq =3D ctx->cached_cq_tail + ctx->cached_cq_overflow;
>  		inflight +=3D io_submit_sqes(ctx, to_submit, cur_mm !=3D NULL,
>  					   mm_fault);
> +		cur_cq =3D ctx->cached_cq_tail + ctx->cached_cq_overflow;
> +		if ((ctx->flags & IORING_SETUP_IOPOLL) && (prev_cq !=3D cur_cq))
> +			inflight -=3D cur_cq - prev_cq;
> =20
>  		/* Commit SQ ring head once we've consumed all SQEs */
>  		io_commit_sqring(ctx);
>=20

--=20
Yours sincerely,
Pavel Begunkov


--z8mmP2Vpy7y45yY1OVFAnMpYGiQTDX9Aa--

--NoC8xj7Uw8eyBPdqTqrq7u7fElAPP7pFw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl2zIRQACgkQWt5b1Glr
+6UMnA/+LIcb3IDLD9JOlRI/2et04+7kGFLTQPIIRRu26dvUsXHTM956kkCUYBRq
TaxWd0SwPjYdrKuL5HnV2U3n59gxz3NzcBG/SqGaNICtc2DgZhIowkyOZCoiuyq1
IRp5T69XJu7S55LiPP0swbewps6LN4580ZAStksf27zZQP4ntfffWVrjEKhXMo3A
QS/GCjxIoQzjnhxgWrx2QgVcLBkEtVFGUG3F9fOL0kC5Zm/mvryyJ28oLtDx+FvI
GOiXQCWNb13d60sWLXCdsd1v4cLnoiEeQm+jWa0Lq0+fMzfxhK8QsCjQoYP/D0/N
mddMAydPuSyVwxq7+0Il96luXp/aKyt1S14WEtGR0SxM7J9MgtCO7+7wf8jc7m9R
ftoJa11ZhkbCkGjxj4ONI4IzhN/SLqu/b8+L6DfLoNQ519afJVJxtLVWbZw8f7hA
K0Zfua2oASQmZI9uG1yEpxH3S2f46W5BMWyhH17JRiZyvyYDjx2qGldNUB1/IdgW
eHSfcOlp2iBzHd7O1vLXKQK0LE7WRrfOS2Wp8t1ALx36bxx3D7lRme/uqqOMAy49
d0sdhE+4gtWu8/Ry1fAz6MUhCiDQAQyJX9edCyZaqEjNjVno83r21npZdCda9uK9
Z1CiChee0bFGUgH6d0ftOgW/3/r+pNw9SsLQe8qITYuuwkpw5UE=
=aOit
-----END PGP SIGNATURE-----

--NoC8xj7Uw8eyBPdqTqrq7u7fElAPP7pFw--
