Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00725C76186
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 21:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F37B2084D
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 21:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaNNeho0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfGXV3o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 17:29:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35009 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfGXV3o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 17:29:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so42841735wmg.0;
        Wed, 24 Jul 2019 14:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=nkQQuYdgc0X5QDD9ENmNkgUO4pU0bBfV1L2f7qAhTY8=;
        b=JaNNeho0JdzCdDQ4ML1LnJufMt3OOWysTtwv4cGDjwRwXHGgo1/nkeldtO+mGyEwOz
         0w5/7h/cVByfP/lbaKl++9reXR/U6HezlmD2aDJ88p4S7++HAW3HkD+2wQAAk7QwdiJk
         sovzA/UnYCId31zyEwOifANFQJMmjITcjbWmO5byDhaMRD571UBIzx8XtQbPh/Tg4cED
         qgteA6FM+mtiWp1cSLOOR6NuRD8axT9oy1y6nL9H7O6wfwS0WX1xGBg+EvRy8mXSJIJJ
         63bgciJr+oEmyIa0rHF595j6eYTUU5n/WY1E5unvw24T4zDLZEBOBNui7mtoSTOYXOcJ
         dQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=nkQQuYdgc0X5QDD9ENmNkgUO4pU0bBfV1L2f7qAhTY8=;
        b=Hbzs2hKTJEIvC47IzoIT9lXVenK+5En7ljpzEnJcgdXco4P3zLVRMG8f3F+nzClCBS
         SNofO+GSoPzI6VB4mKucChdlERubx+aeevza7FJDrx7a8C6SBSE62thR9Bd7P+iDhJSj
         TQNbO4l3RpF78ZF3yWLbq0x456uqITjv0Czo6v9rTzW5vhnz4brY7ZqjWG2Jhva2XAw8
         NWPc4vqoPPJSjaqJAnswInNA7FYcC13Q5zgXMDJ0d1ZG7mQ0bAO/vPRe87FMcSMCgL/Q
         mnjutcL2hYpaGSzHxNUMmkuA4mDiYyu7262Zbm4mVtOXJUyoWlP9pJVqcyL9kUtKBcTQ
         qEOQ==
X-Gm-Message-State: APjAAAWeWg9NUdK5lQ/ekhUSam7hiRjV4DgZdHalQSxfGiFU5SRaJ3Ds
        RJDZsqss6Z6zfg3GSVzdWUmTJui6ZjU=
X-Google-Smtp-Source: APXvYqzyrBOtE/hNckRfxqw+FU35wuyFrYfx6juAIkbNSptFk+BR5DPL1P6bUZsjVmSznJf/WRLm6w==
X-Received: by 2002:a1c:f90f:: with SMTP id x15mr73780851wmh.69.1564003780403;
        Wed, 24 Jul 2019 14:29:40 -0700 (PDT)
Received: from [192.168.43.214] ([109.126.147.168])
        by smtp.gmail.com with ESMTPSA id 4sm110980397wro.78.2019.07.24.14.29.38
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 14:29:39 -0700 (PDT)
Subject: Re: [RFC][PATCH] io_uring: Incapsulate conditional mem accounting
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ba9abac35d74b11a0e338b478e472107064b738d.1562807210.git.asml.silence@gmail.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFmKBOQBEAC76ZFxLAKpDw0bKQ8CEiYJRGn8MHTUhURL02/7n1t0HkKQx2K1fCXClbps
 bdwSHrhOWdW61pmfMbDYbTj6ZvGRvhoLWfGkzujB2wjNcbNTXIoOzJEGISHaPf6E2IQx1ik9
 6uqVkK1OMb7qRvKH0i7HYP4WJzYbEWVyLiAxUj611mC9tgd73oqZ2pLYzGTqF2j6a/obaqha
 +hXuWTvpDQXqcOZJXIW43atprH03G1tQs7VwR21Q1eq6Yvy2ESLdc38EqCszBfQRMmKy+cfp
 W3U9Mb1w0L680pXrONcnlDBCN7/sghGeMHjGKfNANjPc+0hzz3rApPxpoE7HC1uRiwC4et83
 CKnncH1l7zgeBT9Oa3qEiBlaa1ZCBqrA4dY+z5fWJYjMpwI1SNp37RtF8fKXbKQg+JuUjAa9
 Y6oXeyEvDHMyJYMcinl6xCqCBAXPHnHmawkMMgjr3BBRzODmMr+CPVvnYe7BFYfoajzqzq+h
 EyXSl3aBf0IDPTqSUrhbmjj5OEOYgRW5p+mdYtY1cXeK8copmd+fd/eTkghok5li58AojCba
 jRjp7zVOLOjDlpxxiKhuFmpV4yWNh5JJaTbwCRSd04sCcDNlJj+TehTr+o1QiORzc2t+N5iJ
 NbILft19Izdn8U39T5oWiynqa1qCLgbuFtnYx1HlUq/HvAm+kwARAQABtDFQYXZlbCBCZWd1
 bmtvdiAoc2lsZW5jZSkgPGFzbWwuc2lsZW5jZUBnbWFpbC5jb20+iQJOBBMBCAA4FiEE+6Ju
 PTjTbx479o3OWt5b1Glr+6UFAlmKBOQCGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4AACgkQ
 Wt5b1Glr+6WxZA//QueaKHzgdnOikJ7NA/Vq8FmhRlwgtP0+E+w93kL+ZGLzS/cUCIjn2f4Q
 Mcutj2Neg0CcYPX3b2nJiKr5Vn0rjJ/suiaOa1h1KzyNTOmxnsqE5fmxOf6C6x+NKE18I5Jy
 xzLQoktbdDVA7JfB1itt6iWSNoOTVcvFyvfe5ggy6FSCcP+m1RlR58XxVLH+qlAvxxOeEr/e
 aQfUzrs7gqdSd9zQGEZo0jtuBiB7k98t9y0oC9Jz0PJdvaj1NZUgtXG9pEtww3LdeXP/TkFl
 HBSxVflzeoFaj4UAuy8+uve7ya/ECNCc8kk0VYaEjoVrzJcYdKP583iRhOLlZA6HEmn/+Gh9
 4orG67HNiJlbFiW3whxGizWsrtFNLsSP1YrEReYk9j1SoUHHzsu+ZtNfKuHIhK0sU07G1OPN
 2rDLlzUWR9Jc22INAkhVHOogOcc5ajMGhgWcBJMLCoi219HlX69LIDu3Y34uIg9QPZIC2jwr
 24W0kxmK6avJr7+n4o8m6sOJvhlumSp5TSNhRiKvAHB1I2JB8Q1yZCIPzx+w1ALxuoWiCdwV
 M/azguU42R17IuBzK0S3hPjXpEi2sK/k4pEPnHVUv9Cu09HCNnd6BRfFGjo8M9kZvw360gC1
 reeMdqGjwQ68o9x0R7NBRrtUOh48TDLXCANAg97wjPoy37dQE7e5Ag0EWYoE5AEQAMWS+aBV
 IJtCjwtfCOV98NamFpDEjBMrCAfLm7wZlmXy5I6o7nzzCxEw06P2rhzp1hIqkaab1kHySU7g
 dkpjmQ7Jjlrf6KdMP87mC/Hx4+zgVCkTQCKkIxNE76Ff3O9uTvkWCspSh9J0qPYyCaVta2D1
 Sq5HZ8WFcap71iVO1f2/FEHKJNz/YTSOS/W7dxJdXl2eoj3gYX2UZNfoaVv8OXKaWslZlgqN
 jSg9wsTv1K73AnQKt4fFhscN9YFxhtgD/SQuOldE5Ws4UlJoaFX/yCoJL3ky2kC0WFngzwRF
 Yo6u/KON/o28yyP+alYRMBrN0Dm60FuVSIFafSqXoJTIjSZ6olbEoT0u17Rag8BxnxryMrgR
 dkccq272MaSS0eOC9K2rtvxzddohRFPcy/8bkX+t2iukTDz75KSTKO+chce62Xxdg62dpkZX
 xK+HeDCZ7gRNZvAbDETr6XI63hPKi891GeZqvqQVYR8e+V2725w+H1iv3THiB1tx4L2bXZDI
 DtMKQ5D2RvCHNdPNcZeldEoJwKoA60yg6tuUquvsLvfCwtrmVI2rL2djYxRfGNmFMrUDN1Xq
 F3xozA91q3iZd9OYi9G+M/OA01husBdcIzj1hu0aL+MGg4Gqk6XwjoSxVd4YT41kTU7Kk+/I
 5/Nf+i88ULt6HanBYcY/+Daeo/XFABEBAAGJAjYEGAEIACAWIQT7om49ONNvHjv2jc5a3lvU
 aWv7pQUCWYoE5AIbDAAKCRBa3lvUaWv7pfmcEACKTRQ28b1y5ztKuLdLr79+T+LwZKHjX++P
 4wKjEOECCcB6KCv3hP+J2GCXDOPZvdg/ZYZafqP68Yy8AZqkfa4qPYHmIdpODtRzZSL48kM8
 LRzV8Rl7J3ItvzdBRxf4T/Zseu5U6ELiQdCUkPGsJcPIJkgPjO2ROG/ZtYa9DvnShNWPlp+R
 uPwPccEQPWO/NP4fJl2zwC6byjljZhW5kxYswGMLBwb5cDUZAisIukyAa8Xshdan6C2RZcNs
 rB3L7vsg/R8UCehxOH0C+NypG2GqjVejNZsc7bgV49EOVltS+GmGyY+moIzxsuLmT93rqyII
 5rSbbcTLe6KBYcs24XEoo49Zm9oDA3jYvNpeYD8rDcnNbuZh9kTgBwFN41JHOPv0W2FEEWqe
 JsCwQdcOQ56rtezdCJUYmRAt3BsfjN3Jn3N6rpodi4Dkdli8HylM5iq4ooeb5VkQ7UZxbCWt
 UVMKkOCdFhutRmYp0mbv2e87IK4erwNHQRkHUkzbsuym8RVpAZbLzLPIYK/J3RTErL6Z99N2
 m3J6pjwSJY/zNwuFPs9zGEnRO4g0BUbwGdbuvDzaq6/3OJLKohr5eLXNU3JkT+3HezydWm3W
 OPhauth7W0db74Qd49HXK0xe/aPrK+Cp+kU1HRactyNtF8jZQbhMCC8vMGukZtWaAwpjWiiH bA==
Message-ID: <a7f8939b-d7c8-7d10-f32c-319f009516b2@gmail.com>
Date:   Thu, 25 Jul 2019 00:29:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ba9abac35d74b11a0e338b478e472107064b738d.1562807210.git.asml.silence@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="DGktklrolnqzKXHsSgsti6HNrk3xKFtFm"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DGktklrolnqzKXHsSgsti6HNrk3xKFtFm
Content-Type: multipart/mixed; boundary="j4JmxJ24fveyJpooCCNqRbUm7uDe041YD";
 protected-headers="v1"
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <a7f8939b-d7c8-7d10-f32c-319f009516b2@gmail.com>
Subject: Re: [RFC][PATCH] io_uring: Incapsulate conditional mem accounting
References: <ba9abac35d74b11a0e338b478e472107064b738d.1562807210.git.asml.silence@gmail.com>
In-Reply-To: <ba9abac35d74b11a0e338b478e472107064b738d.1562807210.git.asml.silence@gmail.com>

--j4JmxJ24fveyJpooCCNqRbUm7uDe041YD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

ping

On 11/07/2019 04:07, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
>=20
> It's quite tedious and error-prone to manually check before each call
> to io_{,un}account_mem() whether we need memory accounting. Instead,
> the functions can work directly with struct io_ring_ctx and handle
> checks themselves. In any case, they're perfectly inlined.
>=20
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  fs/io_uring.c | 59 ++++++++++++++++++++++-----------------------------=

>  1 file changed, 25 insertions(+), 34 deletions(-)
>=20
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 3fd884b4e0be..f47f7abe19eb 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -2704,14 +2704,19 @@ static int io_sq_offload_start(struct io_ring_c=
tx *ctx,
>  	return ret;
>  }
> =20
> -static void io_unaccount_mem(struct user_struct *user, unsigned long n=
r_pages)
> +static void io_unaccount_mem(struct io_ring_ctx *ctx, unsigned long nr=
_pages)
>  {
> -	atomic_long_sub(nr_pages, &user->locked_vm);
> +	if (ctx->account_mem)
> +		atomic_long_sub(nr_pages, &ctx->user->locked_vm);
>  }
> =20
> -static int io_account_mem(struct user_struct *user, unsigned long nr_p=
ages)
> +static int io_account_mem(struct io_ring_ctx *ctx, unsigned long nr_pa=
ges)
>  {
>  	unsigned long page_limit, cur_pages, new_pages;
> +	struct user_struct *user =3D ctx->user;
> +
> +	if (!ctx->account_mem)
> +		return 0;
> =20
>  	/* Don't allow more pages than we can safely lock */
>  	page_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> @@ -2773,8 +2778,7 @@ static int io_sqe_buffer_unregister(struct io_rin=
g_ctx *ctx)
>  		for (j =3D 0; j < imu->nr_bvecs; j++)
>  			put_page(imu->bvec[j].bv_page);
> =20
> -		if (ctx->account_mem)
> -			io_unaccount_mem(ctx->user, imu->nr_bvecs);
> +		io_unaccount_mem(ctx, imu->nr_bvecs);
>  		kvfree(imu->bvec);
>  		imu->nr_bvecs =3D 0;
>  	}
> @@ -2857,11 +2861,9 @@ static int io_sqe_buffer_register(struct io_ring=
_ctx *ctx, void __user *arg,
>  		start =3D ubuf >> PAGE_SHIFT;
>  		nr_pages =3D end - start;
> =20
> -		if (ctx->account_mem) {
> -			ret =3D io_account_mem(ctx->user, nr_pages);
> -			if (ret)
> -				goto err;
> -		}
> +		ret =3D io_account_mem(ctx, nr_pages);
> +		if (ret)
> +			goto err;
> =20
>  		ret =3D 0;
>  		if (!pages || nr_pages > got_pages) {
> @@ -2874,8 +2876,7 @@ static int io_sqe_buffer_register(struct io_ring_=
ctx *ctx, void __user *arg,
>  					GFP_KERNEL);
>  			if (!pages || !vmas) {
>  				ret =3D -ENOMEM;
> -				if (ctx->account_mem)
> -					io_unaccount_mem(ctx->user, nr_pages);
> +				io_unaccount_mem(ctx, nr_pages);
>  				goto err;
>  			}
>  			got_pages =3D nr_pages;
> @@ -2885,8 +2886,7 @@ static int io_sqe_buffer_register(struct io_ring_=
ctx *ctx, void __user *arg,
>  						GFP_KERNEL);
>  		ret =3D -ENOMEM;
>  		if (!imu->bvec) {
> -			if (ctx->account_mem)
> -				io_unaccount_mem(ctx->user, nr_pages);
> +			io_unaccount_mem(ctx, nr_pages);
>  			goto err;
>  		}
> =20
> @@ -2919,8 +2919,7 @@ static int io_sqe_buffer_register(struct io_ring_=
ctx *ctx, void __user *arg,
>  				for (j =3D 0; j < pret; j++)
>  					put_page(pages[j]);
>  			}
> -			if (ctx->account_mem)
> -				io_unaccount_mem(ctx->user, nr_pages);
> +			io_unaccount_mem(ctx, nr_pages);
>  			kvfree(imu->bvec);
>  			goto err;
>  		}
> @@ -3009,9 +3008,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *=
ctx)
>  	io_mem_free(ctx->cq_ring);
> =20
>  	percpu_ref_exit(&ctx->refs);
> -	if (ctx->account_mem)
> -		io_unaccount_mem(ctx->user,
> -				ring_pages(ctx->sq_entries, ctx->cq_entries));
> +	io_unaccount_mem(ctx, ring_pages(ctx->sq_entries, ctx->cq_entries));
>  	free_uid(ctx->user);
>  	kfree(ctx);
>  }
> @@ -3253,7 +3250,6 @@ static int io_uring_create(unsigned entries, stru=
ct io_uring_params *p)
>  {
>  	struct user_struct *user =3D NULL;
>  	struct io_ring_ctx *ctx;
> -	bool account_mem;
>  	int ret;
> =20
>  	if (!entries || entries > IORING_MAX_ENTRIES)
> @@ -3269,29 +3265,24 @@ static int io_uring_create(unsigned entries, st=
ruct io_uring_params *p)
>  	p->cq_entries =3D 2 * p->sq_entries;
> =20
>  	user =3D get_uid(current_user());
> -	account_mem =3D !capable(CAP_IPC_LOCK);
> -
> -	if (account_mem) {
> -		ret =3D io_account_mem(user,
> -				ring_pages(p->sq_entries, p->cq_entries));
> -		if (ret) {
> -			free_uid(user);
> -			return ret;
> -		}
> -	}
> =20
>  	ctx =3D io_ring_ctx_alloc(p);
>  	if (!ctx) {
> -		if (account_mem)
> -			io_unaccount_mem(user, ring_pages(p->sq_entries,
> -								p->cq_entries));
>  		free_uid(user);
>  		return -ENOMEM;
>  	}
> +
>  	ctx->compat =3D in_compat_syscall();
> -	ctx->account_mem =3D account_mem;
> +	ctx->account_mem =3D !capable(CAP_IPC_LOCK);
>  	ctx->user =3D user;
> =20
> +	ret =3D io_account_mem(ctx, ring_pages(p->sq_entries, p->cq_entries))=
;
> +	if (ret) {
> +		free_uid(user);
> +		kfree(ctx);
> +		return ret;
> +	}
> +
>  	ret =3D io_allocate_scq_urings(ctx, p);
>  	if (ret)
>  		goto err;
>=20

--=20
Yours sincerely,
Pavel Begunkov


--j4JmxJ24fveyJpooCCNqRbUm7uDe041YD--

--DGktklrolnqzKXHsSgsti6HNrk3xKFtFm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+6JuPTjTbx479o3OWt5b1Glr+6UFAl04zcEACgkQWt5b1Glr
+6UFaxAAktZZWWVQzpkrIwga2JG2TT9sVAAlJjv6WFS9EDfwY19I7/FfhoTudsPM
p1tTpvtDY4yiGWrL5oVW3icpZMGWRnZ7wN3PUc1TqT59Fwhr0MtAQpAniQxG0MQ7
gfxubefqey03V5O6ywPt7MWESTuAwq6qSZvnq+vzblUDtSXybNfyWixJhi5dDb3U
Xk/3vKbrvONMcyCUEi2MYPaDeT4KoadYjDXF0Cz3SJsRFiGT3ekycjbN3SnAN7x/
Ac/TPE45RIdwlmf5ysA8jRS//n2BECVvV4oYCbeeJ2xXKNPGCJLHmwx+fhUxl2w0
+CNyWlGLkaI5NDrY46nFfDuZwvRkA7/06LJ1X7zoxwF9JUMd57eY44+0pFMZ7qmg
dV8TJGeT70zKfhlYBa4/9T1mNQMjxwrEg1Djf/YrxcOlmX7mVNd+dSf5XDaGylRC
N7+PppIsGMK0qz1kH2kbJIBAXkEriGRzL3z81zklievMvNJIC4fUVYX26sp5m2UH
kPQ19J1/p0kpCc8F24nmD0mX61YEi8oLBz9+3mF/Nash2SkRAfMKp8bBvglkrgM5
t8F5QXPpvj4Y++YUIFIgtGqQOvaHnsql4b4pUhbDMcZ/CQnriJQDHDdiIuA6pUMO
ntDOB1J1cxqWkuyn3u1NHNM/2MD2TCZjeBB+T1cfWmFdOjhYLgE=
=+q7w
-----END PGP SIGNATURE-----

--DGktklrolnqzKXHsSgsti6HNrk3xKFtFm--
