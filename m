Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792775193;
	b=A9YrVf4+aA/CB+lbBEpd5N1ZfJfy/jKRQ+w+otYwjCylb0N1MMqRBU0+RYthUwsBDXAA
	 qvV3IDTmrmepvhPDbqMbxwoe8ISczKyzgFsfVne/dmh1GOgvj55lQe2HIqPkLdwpOIt3u
	 y2GVn39JsOtVcmKFUzJqTACRMTEQ78L1aPF2wXELirvAQbNnsuK5RbzFGQXrObBhZwOOS
	 ypDidkA3WMRnKzlH3Zjkq/9gm1/EcmwEt68CRN7wkpwXPin2gF0KNWp0cWzyHIE3nBZ83
	 B6U+wQfsGPtW2ySQV6lznPer3b2QIguJx+MMQPsSFFNXPm9qCXXL0iw8r8qGI0RMKVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7W9Fg/Y8TWqaQYuAul5Bgmvw4O5gOdeksViXJu/tFEM=;
	b=DuOG5mL00iHwAkzl48emk+UtACalv2rzTRSnJW7mpymyQUt/CKY6jQ96B+3A451Hl2XC
	 zuVjRKNwNtap6nTvNuTlz+F4Y33WPTaDj+ujS88Ar5U+60TIYlCvBWhG/VGb5Nu1DuguB
	 YHV4gX58qqkSQoTJxr+MdCVjeoWnaUt32PVgN2Svhbnef3QCGlZgNciDSvqpOvdQ9q+Qk
	 iXI3WtGnXMQ3UhELYVYRET3MNlcaiRzuXfKewu1LSFJeuA6v9HKm6LLM6KLQCDDwYWDmA
	 /21aWiVcoP5+hQAzsJziKn+5FG38GTecg3W0RUDWxNmWOyukWZaq0KqqL42oe2T4EAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qOKHx9iV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012C606A320
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 17:06:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6012C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qOKHx9iV
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5337c7b9937so6091cf.0
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 10:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792775191; cv=none;
        d=google.com; s=arc-20260327;
        b=Mv4miqBv0vq+czu7xaWLN93t5o6GDRIwI06vNhCwovnmwmc8GUzB+CJjm5tiSJZON2
         2jKvx0HQ2y7yW/HcNoJu9+1xMTA3e2szPFea/IHkaMffo528ZyfcC+f1jC3Dso7nP0Nr
         TpTRm1wtxrnIYHFtH8s/bi/+YmLw1eoSQvVYoX0pakdi12pjfxYySacACBbYQy2/FaOL
         oP5FBlPVI4Aj4ws0VxP4axGvYlvYeo7TIT/UAN5xI0HSnlQw4hslsvkcqdnml+DrZ3zP
         0Jjx7DLBYFo1+iuC7q8tVTyS/l9fGedz1Jx44dsa22pNZWA7szgDX7LBz+rGsxkfRqgV
         6HMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7W9Fg/Y8TWqaQYuAul5Bgmvw4O5gOdeksViXJu/tFEM=;
        fh=4Eg/WuSF+JV5gBB9oR8xkkFwl0l+PBiYo18Lx/SFkHs=;
        b=Bl3TSOPH0KpUX89eiD4ihvvAdNdO/F7ZFYvO9NZKgN/h03NdKycNpBHdeF2KDTjRE5
         1w7WmGlvI6ii3JQVj5sAX4/LLntf1PqOuI6IF4cTrH/f817ECM5oVFxDtB8EQ5jQZDYf
         2t1Y8t+wuQYhGwbJm3MWoUcDZ2UPYQM5fqFQfT3au06h1W5K63bMfoKKh1ujr0cw1cGQ
         BXvfnrINEqnbgreKxG5v9LGcCvmvNhQ1JRINSX/GcaHMemTqnyyz4PxhWDr16Se6RTgK
         otSlsKeq3fArz7m1jw7ZCS/T10vS02pyT7ba99VidPORTe83epaTLQjVTSQAo7OW7XXm
         QBsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792775191; x=1793379991; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7W9Fg/Y8TWqaQYuAul5Bgmvw4O5gOdeksViXJu/tFEM=;
        b=qOKHx9iVHLN3caelBrYVLKaRyjHfVHuouzTInE00Z5n93a+Pr3Jr9ayV5AH+4A0LmZ
         TbOf1czfdfp/NZcd8CUVpupVeMyGjxP08lJ+Zo3wGDugwv4Ayq0SvIdRCv6NWR3cyTJL
         llia/B3i4udywlcD1o+OcjL4n4rEIqs3sSpptoKxe+nWVvLCZGf361Rk7Fr9Vv94xHqv
         UUrtILLa029oC7RxdlRq/hotGbdy6WyOJSwHTOMPAZqciGV1sypdPAjr7peKz9Mo9xWx
         vy7ECZuX4Dtjwep3/I6jzAJg3BWDRAVYS8V4tvO1ojrCF36Q9+62DVi44y997YNFb96r
         B7Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792775191; x=1793379991;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7W9Fg/Y8TWqaQYuAul5Bgmvw4O5gOdeksViXJu/tFEM=;
        b=KyLIVblE/dw2ehuOIKcR+JTi4WiGTYkfo+C5oamdS+avOSziGUf7GXT9zQ0dF6uBiR
         zzjZVHmfwg6TsmtR5GxAk7EdGnYkWQP7P67+gqr60guE0H65WqlBk4sF8kMiorSlWMTq
         xBIOCkEEStJ6UCh4OFKF5lONI8HNklg2QvZ5o4/ZKcghZ5sKOepj7OsIkISFvftn7Sxv
         qYbKwMr9M4wFYhOnVh8RX6rY0Frd/sK8lZ11hTQP87qrSry8sjy23/XsT+/QPQLFUpBm
         NThh6P9JWZiUMEpdARY9WixdKQ1Se70PjNNrXV4rzQ/jY6XJq6ni8gi3AJ5LUt8iDY3N
         a+rw==
X-Forwarded-Encrypted: i=1; AKwUvBxk3nSU1aTiKJnYyosIezUusjnZFttYuNJgOH/KAtseAmgJPGnvOtCIRaXqySzbo/VGAsPM6tnOHGHbnA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIR39K/iZoVcpW25FqUxqLO0gRcHzeLgj6PvyUsYliacsIIsk14
	4yqvK8W9j3T+RzA8ul65OOqtAnv3EYgAz/eez8+X8AWxoDqNdyGdsqDNJ5iLyJk2MC2mOA556OT
	ID3MZWH124juYDO1hjiNruBAD2qfD/WB1BoHq4uUvZCsoFbALcbSaGJzY
X-Gm-Gg: AYBFou2fGvfMrUgMISkcIvtFPw49EAodpjlHAcaNuBOGhQQPZeNuCJ6W+7PSTGKbzWo
	2O9bMQ34pt9uGceVWraQ4P1DETd/JD2sZY+nWXp4Y7dlfWiPsentIIpSuMe0UKKAtLGSpFvr1UM
	Xw6b0gVhnVRwNUOsFNZgqnU4f06eHm0lO7qGwdtDj8mo4YU/h7tmVtil5Yyf3ah5lecYn4SwfBL
	jRNKcCFDMRQ1ncJDF9KbeyoF37giEPCioIb3KW/M+nlGawmduS47J3D08C2CxmU9BnzuwQ2ce+j
	WdbAfgcVY7eHlc08G+qS2UOBA4CRhN5pbpWD3FXgrEpC9Vzk03CDkxLVKoWXKK1it9cFRzWLeST
	YeNQcGHhSODYBrlEoZZzLPChRTqfdTb7P3ENqVF22vlyXrcP+0ciXfIyX+agvS09mBCYdGhnypG
	AP36Q+WmAqGWWV9NGTMHdsMyrOXBsnlQpsD7eHp0VAQIsXxWSoFEK8
X-Received: by 2002:a05:622a:2303:b0:532:9220:a9ae with SMTP id
 d75a77b69052e-536c281537amr19657921cf.6.1792775184544; Fri, 23 Oct 2026
 10:06:24 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021024236.1787884-1-senozhatsky@chromium.org> <20261021024236.1787884-10-senozhatsky@chromium.org>
In-Reply-To: <20261021024236.1787884-10-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Fri, 23 Oct 2026 13:05:47 -0400
X-Gm-Features: AclHuK9aMIpm2VNtMp0HeDAF-ArORfHFJxKzdJsO6LgPxAnViYSqmcSilR02eGY
Message-ID: <CADyq12xeONu-+YRP79KaH4XCsSrNK5DdoKw6T5YSEyW7Acxh7w@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] zram: split zcomp into separate R/W streams
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Bo Zhang <zhangbo0325@gmail.com>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 10:43=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Split struct zcomp_strm into separate compression (Write zcomp_cstrm)
> and decompression (Read zcomp_dstrm) streams, and split zcomp_ops
> context creation/destruction into create_cctx/destroy_cctx and
> optional create_dctx/destroy_dctx callbacks.
>
> This decouples Read (decompression) and Write (compression) paths so
> they no longer contend on the same per-CPU stream mutex (Writer vs
> Reader priority inversion).  Currently, a (low priority) Writer that
> holds the stream mutex can be preempted by a (higher priority) Reader
> on the same CPU, which then blocks on that mutex until the Writer gets
> to run again and releases it, which can take a long time when there
> are other runnable tasks on that CPU.  The good news is that Read and
> Write contexts are completely independent - compression uses its own
> scratch buffer that decompression never touches, and decompression
> uses its own local buffer (for spanning zsmalloc objects) that
> compression never touches, so the Read/Write context split doesn't
> noticeably increase memory usage.  In addition many S/W backends have
> stateless decompression contexts.
>
> A quick synthetic fio test for Writer vs Reader inversion on 24 CPUs
> (preempt=3Dfull, zstd, 48 low priority (nice 19) writers, 24 normal
> priority (nice 0) CPU hogs and 24 high priority (nice -19) readers):
>
>   Metric           Base               Patched
>   ----------------------------------------------------------
>   Read IOPS        207k               1,150k        (+5.6x)
>   Read clat avg    101.50 us          7.76 us       (-13.1x)
>   Read clat stdev  5,615.90 us        30.78 us      (-182x)
>   Read clat p99.99 258,998 us         111.10 us     (-2331x)
>   Read clat max    1,342,600 us       11,217 us     (-120x)

These results are awesome and thanks for exploring other options. I
agree this sounds like a great path forward.

>
> Suggested-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/backend_842.c     |   4 +-
>  drivers/block/zram/backend_deflate.c |  96 ++++++++++-------
>  drivers/block/zram/backend_lz4.c     |   7 +-
>  drivers/block/zram/backend_lz4hc.c   |   4 +-
>  drivers/block/zram/backend_lzo.c     |   4 +-
>  drivers/block/zram/backend_lzorle.c  |   4 +-
>  drivers/block/zram/backend_zstd.c    | 119 +++++++++++++---------
>  drivers/block/zram/zcomp.c           | 147 +++++++++++++++++++++------
>  drivers/block/zram/zcomp.h           |  28 +++--
>  drivers/block/zram/zram_drv.c        |  38 +++----
>  10 files changed, 298 insertions(+), 153 deletions(-)
>
> diff --git a/drivers/block/zram/backend_842.c b/drivers/block/zram/backen=
d_842.c
> index 56ffda201727..f911cd1ca72e 100644
> --- a/drivers/block/zram/backend_842.c
> +++ b/drivers/block/zram/backend_842.c
> @@ -63,8 +63,8 @@ static int decompress_842(struct zcomp_params *params, =
struct zcomp_ctx *ctx,
>  const struct zcomp_ops backend_842 =3D {
>         .compress       =3D compress_842,
>         .decompress     =3D decompress_842,
> -       .create_ctx     =3D create_842,
> -       .destroy_ctx    =3D destroy_842,
> +       .create_cctx    =3D create_842,
> +       .destroy_cctx   =3D destroy_842,
>         .setup_params   =3D setup_params_842,
>         .release_params =3D release_params_842,
>         .name           =3D "842",
> diff --git a/drivers/block/zram/backend_deflate.c b/drivers/block/zram/ba=
ckend_deflate.c
> index 20685aca9bdc..5ffdaf80d8cf 100644
> --- a/drivers/block/zram/backend_deflate.c
> +++ b/drivers/block/zram/backend_deflate.c
> @@ -13,11 +13,6 @@
>  #define DEFLATE_DEF_WINBITS            (-11)
>  #define DEFLATE_DEF_MEMLEVEL           MAX_MEM_LEVEL
>
> -struct deflate_ctx {
> -       struct z_stream_s cctx;
> -       struct z_stream_s dctx;
> -};
> -
>  static void deflate_release_params(struct zcomp_params *params)
>  {
>  }
> @@ -51,70 +46,98 @@ static int deflate_setup_params(struct zcomp_params *=
params)
>         return 0;
>  }
>
> -static void deflate_destroy(struct zcomp_ctx *ctx)
> +static void deflate_destroy_cctx(struct zcomp_ctx *ctx)
>  {
> -       struct deflate_ctx *zctx =3D ctx->context;
> +       struct z_stream_s *cctx =3D ctx->context;
>
> -       if (!zctx)
> +       if (!cctx)
>                 return;
>
> -       if (zctx->cctx.workspace) {
> -               zlib_deflateEnd(&zctx->cctx);
> -               vfree(zctx->cctx.workspace);
> -       }
> -       if (zctx->dctx.workspace) {
> -               zlib_inflateEnd(&zctx->dctx);
> -               vfree(zctx->dctx.workspace);
> +       if (cctx->workspace) {
> +               zlib_deflateEnd(cctx);
> +               vfree(cctx->workspace);
>         }
> -       kfree(zctx);
> +       kfree(cctx);
>  }
>
> -static int deflate_create(struct zcomp_params *params, struct zcomp_ctx =
*ctx)
> +static int deflate_create_cctx(struct zcomp_params *params,
> +                              struct zcomp_ctx *ctx)
>  {
> -       struct deflate_ctx *zctx;
> +       struct z_stream_s *cctx;
>         size_t sz;
>         int ret;
>
> -       zctx =3D kzalloc_obj(*zctx);
> -       if (!zctx)
> +       cctx =3D kzalloc_obj(*cctx);
> +       if (!cctx)
>                 return -ENOMEM;
>
> -       ctx->context =3D zctx;
> +       ctx->context =3D cctx;
>         sz =3D zlib_deflate_workspacesize(params->deflate.winbits, MAX_ME=
M_LEVEL);
> -       zctx->cctx.workspace =3D vzalloc(sz);
> -       if (!zctx->cctx.workspace)
> +       cctx->workspace =3D vzalloc(sz);
> +       if (!cctx->workspace)
>                 goto error;
>
> -       ret =3D zlib_deflateInit2(&zctx->cctx, params->level, Z_DEFLATED,
> +       ret =3D zlib_deflateInit2(cctx, params->level, Z_DEFLATED,
>                                 params->deflate.winbits, DEFLATE_DEF_MEML=
EVEL,
>                                 Z_DEFAULT_STRATEGY);
>         if (ret !=3D Z_OK)
>                 goto error;
>
> +       return 0;
> +
> +error:
> +       deflate_destroy_cctx(ctx);
> +       return -EINVAL;
> +}
> +
> +static void deflate_destroy_dctx(struct zcomp_ctx *ctx)
> +{
> +       struct z_stream_s *dctx =3D ctx->context;
> +
> +       if (!dctx)
> +               return;
> +
> +       if (dctx->workspace) {
> +               zlib_inflateEnd(dctx);
> +               vfree(dctx->workspace);
> +       }
> +       kfree(dctx);
> +}
> +
> +static int deflate_create_dctx(struct zcomp_params *params,
> +                              struct zcomp_ctx *ctx)
> +{
> +       struct z_stream_s *dctx;
> +       size_t sz;
> +       int ret;
> +
> +       dctx =3D kzalloc_obj(*dctx);
> +       if (!dctx)
> +               return -ENOMEM;
> +
> +       ctx->context =3D dctx;
>         sz =3D zlib_inflate_workspacesize();
> -       zctx->dctx.workspace =3D vzalloc(sz);
> -       if (!zctx->dctx.workspace)
> +       dctx->workspace =3D vzalloc(sz);
> +       if (!dctx->workspace)
>                 goto error;
>
> -       ret =3D zlib_inflateInit2(&zctx->dctx, params->deflate.winbits);
> +       ret =3D zlib_inflateInit2(dctx, params->deflate.winbits);
>         if (ret !=3D Z_OK)
>                 goto error;
>
>         return 0;
>
>  error:
> -       deflate_destroy(ctx);
> +       deflate_destroy_dctx(ctx);
>         return -EINVAL;
>  }
>
>  static int deflate_compress(struct zcomp_params *params, struct zcomp_ct=
x *ctx,
>                             struct zcomp_req *req)
>  {
> -       struct deflate_ctx *zctx =3D ctx->context;
> -       struct z_stream_s *deflate;
> +       struct z_stream_s *deflate =3D ctx->context;
>         int ret;
>
> -       deflate =3D &zctx->cctx;
>         ret =3D zlib_deflateReset(deflate);
>         if (ret !=3D Z_OK)
>                 return -EINVAL;
> @@ -136,12 +159,9 @@ static int deflate_decompress(struct zcomp_params *p=
arams,
>                               struct zcomp_ctx *ctx,
>                               struct zcomp_req *req)
>  {
> -       struct deflate_ctx *zctx =3D ctx->context;
> -       struct z_stream_s *inflate;
> +       struct z_stream_s *inflate =3D ctx->context;
>         int ret;
>
> -       inflate =3D &zctx->dctx;
> -
>         ret =3D zlib_inflateReset(inflate);
>         if (ret !=3D Z_OK)
>                 return -EINVAL;
> @@ -161,8 +181,10 @@ static int deflate_decompress(struct zcomp_params *p=
arams,
>  const struct zcomp_ops backend_deflate =3D {
>         .compress       =3D deflate_compress,
>         .decompress     =3D deflate_decompress,
> -       .create_ctx     =3D deflate_create,
> -       .destroy_ctx    =3D deflate_destroy,
> +       .create_cctx    =3D deflate_create_cctx,
> +       .destroy_cctx   =3D deflate_destroy_cctx,
> +       .create_dctx    =3D deflate_create_dctx,
> +       .destroy_dctx   =3D deflate_destroy_dctx,
>         .setup_params   =3D deflate_setup_params,
>         .release_params =3D deflate_release_params,
>         .name           =3D "deflate",
> diff --git a/drivers/block/zram/backend_lz4.c b/drivers/block/zram/backen=
d_lz4.c
> index 5f2e27805d75..9767482a2fea 100644
> --- a/drivers/block/zram/backend_lz4.c
> +++ b/drivers/block/zram/backend_lz4.c
> @@ -38,8 +38,7 @@ static int lz4_setup_params(struct zcomp_params *params=
)
>         if (!dict_stream)
>                 return -ENOMEM;
>
> -       ret =3D LZ4_loadDict(dict_stream,
> -                          params->dict, params->dict_sz);
> +       ret =3D LZ4_loadDict(dict_stream, params->dict, params->dict_sz);
>         if (ret !=3D params->dict_sz) {
>                 vfree(dict_stream);
>                 return -EINVAL;
> @@ -102,8 +101,8 @@ static int lz4_decompress(struct zcomp_params *params=
, struct zcomp_ctx *ctx,
>  const struct zcomp_ops backend_lz4 =3D {
>         .compress       =3D lz4_compress,
>         .decompress     =3D lz4_decompress,
> -       .create_ctx     =3D lz4_create,
> -       .destroy_ctx    =3D lz4_destroy,
> +       .create_cctx    =3D lz4_create,
> +       .destroy_cctx   =3D lz4_destroy,
>         .setup_params   =3D lz4_setup_params,
>         .release_params =3D lz4_release_params,
>         .name           =3D "lz4",
> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/back=
end_lz4hc.c
> index b62736b26622..2d1364a29b27 100644
> --- a/drivers/block/zram/backend_lz4hc.c
> +++ b/drivers/block/zram/backend_lz4hc.c
> @@ -107,8 +107,8 @@ static int lz4hc_decompress(struct zcomp_params *para=
ms, struct zcomp_ctx *ctx,
>  const struct zcomp_ops backend_lz4hc =3D {
>         .compress       =3D lz4hc_compress,
>         .decompress     =3D lz4hc_decompress,
> -       .create_ctx     =3D lz4hc_create,
> -       .destroy_ctx    =3D lz4hc_destroy,
> +       .create_cctx    =3D lz4hc_create,
> +       .destroy_cctx   =3D lz4hc_destroy,
>         .setup_params   =3D lz4hc_setup_params,
>         .release_params =3D lz4hc_release_params,
>         .name           =3D "lz4hc",
> diff --git a/drivers/block/zram/backend_lzo.c b/drivers/block/zram/backen=
d_lzo.c
> index 78538479c511..e703560d9ecd 100644
> --- a/drivers/block/zram/backend_lzo.c
> +++ b/drivers/block/zram/backend_lzo.c
> @@ -61,8 +61,8 @@ static int lzo_decompress(struct zcomp_params *params, =
struct zcomp_ctx *ctx,
>  const struct zcomp_ops backend_lzo =3D {
>         .compress       =3D lzo_compress,
>         .decompress     =3D lzo_decompress,
> -       .create_ctx     =3D lzo_create,
> -       .destroy_ctx    =3D lzo_destroy,
> +       .create_cctx    =3D lzo_create,
> +       .destroy_cctx   =3D lzo_destroy,
>         .setup_params   =3D lzo_setup_params,
>         .release_params =3D lzo_release_params,
>         .name           =3D "lzo",
> diff --git a/drivers/block/zram/backend_lzorle.c b/drivers/block/zram/bac=
kend_lzorle.c
> index 011787f1430b..e95026e99202 100644
> --- a/drivers/block/zram/backend_lzorle.c
> +++ b/drivers/block/zram/backend_lzorle.c
> @@ -61,8 +61,8 @@ static int lzorle_decompress(struct zcomp_params *param=
s, struct zcomp_ctx *ctx,
>  const struct zcomp_ops backend_lzorle =3D {
>         .compress       =3D lzorle_compress,
>         .decompress     =3D lzorle_decompress,
> -       .create_ctx     =3D lzorle_create,
> -       .destroy_ctx    =3D lzorle_destroy,
> +       .create_cctx    =3D lzorle_create,
> +       .destroy_cctx   =3D lzorle_destroy,
>         .setup_params   =3D lzorle_setup_params,
>         .release_params =3D lzorle_release_params,
>         .name           =3D "lzo-rle",
> diff --git a/drivers/block/zram/backend_zstd.c b/drivers/block/zram/backe=
nd_zstd.c
> index 7a8b5ff186f2..d55615f34300 100644
> --- a/drivers/block/zram/backend_zstd.c
> +++ b/drivers/block/zram/backend_zstd.c
> @@ -10,10 +10,8 @@
>  #include "backend_zstd.h"
>
>  struct zstd_ctx {
> -       zstd_cctx *cctx;
> -       zstd_dctx *dctx;
> -       void *cctx_mem;
> -       void *dctx_mem;
> +       void *ctx;
> +       void *mem;
>  };
>
>  struct zstd_params {
> @@ -105,7 +103,7 @@ static int zstd_setup_params(struct zcomp_params *par=
ams)
>         return -EINVAL;
>  }
>
> -static void zstd_destroy(struct zcomp_ctx *ctx)
> +static void zstd_destroy_cctx(struct zcomp_ctx *ctx)
>  {
>         struct zstd_ctx *zctx =3D ctx->context;
>
> @@ -113,30 +111,23 @@ static void zstd_destroy(struct zcomp_ctx *ctx)
>                 return;
>
>         /*
> -        * If ->cctx_mem and ->dctx_mem were allocated then we didn't use
> -        * C/D dictionary and ->cctx / ->dctx were "embedded" into these
> -        * buffers.
> +        * If ->mem was allocated then we didn't use C/D dictionary and
> +        * ->ctx was "embedded" into this buffer.
>          *
> -        * If otherwise then we need to explicitly release ->cctx / ->dct=
x.
> +        * If otherwise then we need to explicitly release ->ctx.
>          */
> -       if (zctx->cctx_mem)
> -               vfree(zctx->cctx_mem);
> +       if (zctx->mem)
> +               vfree(zctx->mem);
>         else
> -               zstd_free_cctx(zctx->cctx);
> -
> -       if (zctx->dctx_mem)
> -               vfree(zctx->dctx_mem);
> -       else
> -               zstd_free_dctx(zctx->dctx);
> +               zstd_free_cctx(zctx->ctx);
>
>         kfree(zctx);
>  }
>
> -static int zstd_create(struct zcomp_params *params, struct zcomp_ctx *ct=
x)
> +static int zstd_create_cctx(struct zcomp_params *params, struct zcomp_ct=
x *ctx)
>  {
> +       struct zstd_params *zp =3D params->drv_data;
>         struct zstd_ctx *zctx;
> -       zstd_parameters prm;
> -       size_t sz;
>
>         zctx =3D kzalloc_obj(*zctx);
>         if (!zctx)
> @@ -144,40 +135,74 @@ static int zstd_create(struct zcomp_params *params,=
 struct zcomp_ctx *ctx)
>
>         ctx->context =3D zctx;
>         if (params->dict_sz =3D=3D 0) {
> -               prm =3D zstd_get_params(params->level, PAGE_SIZE);
> -               sz =3D zstd_cctx_workspace_bound(&prm.cParams);
> -               zctx->cctx_mem =3D vzalloc(sz);
> -               if (!zctx->cctx_mem)
> -                       goto error;
> -
> -               zctx->cctx =3D zstd_init_cctx(zctx->cctx_mem, sz);
> -               if (!zctx->cctx)
> -                       goto error;
> +               zstd_parameters prm =3D zp->cprm;
> +               size_t sz =3D zstd_cctx_workspace_bound(&prm.cParams);
>
> -               sz =3D zstd_dctx_workspace_bound();
> -               zctx->dctx_mem =3D vzalloc(sz);
> -               if (!zctx->dctx_mem)
> +               zctx->mem =3D vzalloc(sz);
> +               if (!zctx->mem)
>                         goto error;
>
> -               zctx->dctx =3D zstd_init_dctx(zctx->dctx_mem, sz);
> -               if (!zctx->dctx)
> +               zctx->ctx =3D zstd_init_cctx(zctx->mem, sz);
> +               if (!zctx->ctx)
>                         goto error;
>         } else {
> -               struct zstd_params *zp =3D params->drv_data;
> +               zctx->ctx =3D zstd_create_cctx_advanced(zp->custom_mem);
> +               if (!zctx->ctx)
> +                       goto error;
> +       }
> +
> +       return 0;
> +
> +error:
> +       zstd_destroy_cctx(ctx);
> +       return -EINVAL;
> +}
> +
> +static void zstd_destroy_dctx(struct zcomp_ctx *ctx)
> +{
> +       struct zstd_ctx *zctx =3D ctx->context;
> +
> +       if (!zctx)
> +               return;
> +
> +       if (zctx->mem)
> +               vfree(zctx->mem);
> +       else
> +               zstd_free_dctx(zctx->ctx);
> +
> +       kfree(zctx);
> +}
> +
> +static int zstd_create_dctx(struct zcomp_params *params, struct zcomp_ct=
x *ctx)
> +{
> +       struct zstd_params *zp =3D params->drv_data;
> +       struct zstd_ctx *zctx;
>
> -               zctx->cctx =3D zstd_create_cctx_advanced(zp->custom_mem);
> -               if (!zctx->cctx)
> +       zctx =3D kzalloc_obj(*zctx);
> +       if (!zctx)
> +               return -ENOMEM;
> +
> +       ctx->context =3D zctx;
> +       if (params->dict_sz =3D=3D 0) {
> +               size_t sz =3D zstd_dctx_workspace_bound();
> +
> +               zctx->mem =3D vzalloc(sz);
> +               if (!zctx->mem)
>                         goto error;
>
> -               zctx->dctx =3D zstd_create_dctx_advanced(zp->custom_mem);
> -               if (!zctx->dctx)
> +               zctx->ctx =3D zstd_init_dctx(zctx->mem, sz);
> +               if (!zctx->ctx)
> +                       goto error;
> +       } else {
> +               zctx->ctx =3D zstd_create_dctx_advanced(zp->custom_mem);
> +               if (!zctx->ctx)
>                         goto error;
>         }
>
>         return 0;
>
>  error:
> -       zstd_destroy(ctx);
> +       zstd_destroy_dctx(ctx);
>         return -EINVAL;
>  }
>
> @@ -189,10 +214,10 @@ static int zstd_compress(struct zcomp_params *param=
s, struct zcomp_ctx *ctx,
>         size_t ret;
>
>         if (params->dict_sz =3D=3D 0)
> -               ret =3D zstd_compress_cctx(zctx->cctx, req->dst, req->dst=
_len,
> +               ret =3D zstd_compress_cctx(zctx->ctx, req->dst, req->dst_=
len,
>                                          req->src, req->src_len, &zp->cpr=
m);
>         else
> -               ret =3D zstd_compress_using_cdict(zctx->cctx, req->dst,
> +               ret =3D zstd_compress_using_cdict(zctx->ctx, req->dst,
>                                                 req->dst_len, req->src,
>                                                 req->src_len,
>                                                 zp->cdict);
> @@ -210,10 +235,10 @@ static int zstd_decompress(struct zcomp_params *par=
ams, struct zcomp_ctx *ctx,
>         size_t ret;
>
>         if (params->dict_sz =3D=3D 0)
> -               ret =3D zstd_decompress_dctx(zctx->dctx, req->dst, req->d=
st_len,
> +               ret =3D zstd_decompress_dctx(zctx->ctx, req->dst, req->ds=
t_len,
>                                            req->src, req->src_len);
>         else
> -               ret =3D zstd_decompress_using_ddict(zctx->dctx, req->dst,
> +               ret =3D zstd_decompress_using_ddict(zctx->ctx, req->dst,
>                                                   req->dst_len, req->src,
>                                                   req->src_len, zp->ddict=
);
>         if (zstd_is_error(ret))
> @@ -224,8 +249,10 @@ static int zstd_decompress(struct zcomp_params *para=
ms, struct zcomp_ctx *ctx,
>  const struct zcomp_ops backend_zstd =3D {
>         .compress       =3D zstd_compress,
>         .decompress     =3D zstd_decompress,
> -       .create_ctx     =3D zstd_create,
> -       .destroy_ctx    =3D zstd_destroy,
> +       .create_cctx    =3D zstd_create_cctx,
> +       .destroy_cctx   =3D zstd_destroy_cctx,
> +       .create_dctx    =3D zstd_create_dctx,
> +       .destroy_dctx   =3D zstd_destroy_dctx,
>         .setup_params   =3D zstd_setup_params,
>         .release_params =3D zstd_release_params,
>         .name           =3D "zstd",
> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index 028e2f0f587e..1c9f6d5c8cd1 100644
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -45,30 +45,65 @@ static const struct zcomp_ops *backends[] =3D {
>         NULL
>  };
>
> -static void zcomp_strm_free(struct zcomp *comp, struct zcomp_strm *zstrm=
)
> +static void zcomp_cstrm_free(struct zcomp *comp, struct zcomp_cstrm *zst=
rm)
>  {
> -       comp->ops->destroy_ctx(&zstrm->ctx);
> -       vfree(zstrm->local_copy);
> +       if (comp->ops->destroy_cctx)
> +               comp->ops->destroy_cctx(&zstrm->ctx);
>         vfree(zstrm->buffer);
>         zstrm->buffer =3D NULL;
> +       zstrm->ctx.context =3D NULL;
>  }
>
> -static int zcomp_strm_init(struct zcomp *comp, struct zcomp_strm *zstrm)
> +static int zcomp_cstrm_init(struct zcomp *comp, struct zcomp_cstrm *zstr=
m)
>  {
>         int ret;
>
> -       ret =3D comp->ops->create_ctx(comp->params, &zstrm->ctx);
> -       if (ret)
> -               return ret;
> +       if (comp->ops->create_cctx) {
> +               ret =3D comp->ops->create_cctx(comp->params, &zstrm->ctx)=
;
> +               if (ret) {
> +                       /* backend has released partially created context=
 */
> +                       zstrm->ctx.context =3D NULL;
> +                       return ret;
> +               }
> +       }
>
> -       zstrm->local_copy =3D vzalloc(PAGE_SIZE);
>         /*
>          * allocate 2 pages. 1 for compressed data, plus 1 extra for the
>          * case when compressed size is larger than the original one
>          */
>         zstrm->buffer =3D vzalloc(2 * PAGE_SIZE);
> -       if (!zstrm->buffer || !zstrm->local_copy) {
> -               zcomp_strm_free(comp, zstrm);
> +       if (!zstrm->buffer) {
> +               zcomp_cstrm_free(comp, zstrm);
> +               return -ENOMEM;
> +       }
> +       return 0;
> +}
> +
> +static void zcomp_dstrm_free(struct zcomp *comp, struct zcomp_dstrm *zst=
rm)
> +{
> +       if (comp->ops->destroy_dctx)
> +               comp->ops->destroy_dctx(&zstrm->ctx);
> +       vfree(zstrm->local_copy);
> +       zstrm->local_copy =3D NULL;
> +       zstrm->ctx.context =3D NULL;
> +}
> +
> +static int zcomp_dstrm_init(struct zcomp *comp, struct zcomp_dstrm *zstr=
m)
> +{
> +       int ret;
> +
> +       if (comp->ops->create_dctx) {
> +               ret =3D comp->ops->create_dctx(comp->params, &zstrm->ctx)=
;
> +               if (ret) {
> +                       /* backend has released partially created context=
 */
> +                       zstrm->ctx.context =3D NULL;
> +                       return ret;
> +               }
> +       }
> +
> +       zstrm->local_copy =3D vzalloc(PAGE_SIZE);
> +       if (!zstrm->local_copy) {
> +               zcomp_dstrm_free(comp, zstrm);
>                 return -ENOMEM;
>         }
>         return 0;
> @@ -114,10 +149,10 @@ ssize_t zcomp_available_show(const char *comp, char=
 *buf, ssize_t at)
>         return at;
>  }
>
> -struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
> +struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp)
>  {
>         for (;;) {
> -               struct zcomp_strm *zstrm =3D raw_cpu_ptr(comp->stream);
> +               struct zcomp_cstrm *zstrm =3D raw_cpu_ptr(comp->cstream);
>
>                 /*
>                  * Inspired by zswap
> @@ -136,12 +171,29 @@ struct zcomp_strm *zcomp_stream_get(struct zcomp *c=
omp)
>         }
>  }
>
> -void zcomp_stream_put(struct zcomp_strm *zstrm)
> +void zcomp_cstrm_put(struct zcomp_cstrm *zstrm)
> +{
> +       mutex_unlock(&zstrm->lock);
> +}
> +
> +struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp)
> +{
> +       for (;;) {
> +               struct zcomp_dstrm *zstrm =3D raw_cpu_ptr(comp->dstream);
> +
> +               mutex_lock(&zstrm->lock);
> +               if (likely(zstrm->local_copy))
> +                       return zstrm;
> +               mutex_unlock(&zstrm->lock);
> +       }
> +}
> +
> +void zcomp_dstrm_put(struct zcomp_dstrm *zstrm)
>  {
>         mutex_unlock(&zstrm->lock);
>  }
>
> -int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
> +int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
>                    const void *src, unsigned int *dst_len)
>  {
>         struct zcomp_req req =3D {
> @@ -159,7 +211,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_s=
trm *zstrm,
>         return ret;
>  }
>
> -int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
> +int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
>                      struct scatterlist *sg, unsigned int src_len, void *=
dst)
>  {
>         struct zcomp_req req =3D {
> @@ -191,23 +243,44 @@ int zcomp_decompress(struct zcomp *comp, struct zco=
mp_strm *zstrm,
>  int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
>  {
>         struct zcomp *comp =3D hlist_entry(node, struct zcomp, node);
> -       struct zcomp_strm *zstrm =3D per_cpu_ptr(comp->stream, cpu);
> +       struct zcomp_cstrm *cstrm;
> +       struct zcomp_dstrm *dstrm;
>         int ret;
>
> -       ret =3D zcomp_strm_init(comp, zstrm);
> -       if (ret)
> +       cstrm =3D per_cpu_ptr(comp->cstream, cpu);
> +       ret =3D zcomp_cstrm_init(comp, cstrm);
> +       if (ret) {
>                 pr_err("Can't allocate a compression stream\n");
> -       return ret;
> +               return ret;
> +       }
> +
> +       dstrm =3D per_cpu_ptr(comp->dstream, cpu);
> +       ret =3D zcomp_dstrm_init(comp, dstrm);
> +       if (ret) {
> +               pr_err("Can't allocate a decompression stream\n");
> +               zcomp_cstrm_free(comp, cstrm);
> +               return ret;
> +       }
> +
> +       return 0;
>  }
>
>  int zcomp_cpu_dead(unsigned int cpu, struct hlist_node *node)
>  {
>         struct zcomp *comp =3D hlist_entry(node, struct zcomp, node);
> -       struct zcomp_strm *zstrm =3D per_cpu_ptr(comp->stream, cpu);
> +       struct zcomp_cstrm *cstrm;
> +       struct zcomp_dstrm *dstrm;
> +
> +       cstrm =3D per_cpu_ptr(comp->cstream, cpu);
> +       mutex_lock(&cstrm->lock);
> +       zcomp_cstrm_free(comp, cstrm);
> +       mutex_unlock(&cstrm->lock);
> +
> +       dstrm =3D per_cpu_ptr(comp->dstream, cpu);
> +       mutex_lock(&dstrm->lock);
> +       zcomp_dstrm_free(comp, dstrm);
> +       mutex_unlock(&dstrm->lock);
>
> -       mutex_lock(&zstrm->lock);
> -       zcomp_strm_free(comp, zstrm);
> -       mutex_unlock(&zstrm->lock);
>         return 0;
>  }
>
> @@ -215,17 +288,27 @@ static int zcomp_init(struct zcomp *comp, struct zc=
omp_params *params)
>  {
>         int ret, cpu;
>
> -       comp->stream =3D alloc_percpu(struct zcomp_strm);
> -       if (!comp->stream)
> -               return -ENOMEM;
> -
>         comp->params =3D params;
>         ret =3D comp->ops->setup_params(comp->params);
>         if (ret)
>                 goto cleanup;
>
> -       for_each_possible_cpu(cpu)
> -               mutex_init(&per_cpu_ptr(comp->stream, cpu)->lock);
> +       comp->cstream =3D alloc_percpu(struct zcomp_cstrm);
> +       if (!comp->cstream) {
> +               ret =3D -ENOMEM;
> +               goto cleanup;
> +       }
> +
> +       comp->dstream =3D alloc_percpu(struct zcomp_dstrm);
> +       if (!comp->dstream) {
> +               ret =3D -ENOMEM;
> +               goto cleanup;
> +       }
> +
> +       for_each_possible_cpu(cpu) {
> +               mutex_init(&per_cpu_ptr(comp->cstream, cpu)->lock);
> +               mutex_init(&per_cpu_ptr(comp->dstream, cpu)->lock);
> +       }
>
>         ret =3D cpuhp_state_add_instance(CPUHP_ZCOMP_PREPARE, &comp->node=
);
>         if (ret < 0)
> @@ -235,7 +318,8 @@ static int zcomp_init(struct zcomp *comp, struct zcom=
p_params *params)
>
>  cleanup:
>         comp->ops->release_params(comp->params);
> -       free_percpu(comp->stream);
> +       free_percpu(comp->dstream);
> +       free_percpu(comp->cstream);
>         return ret;
>  }
>
> @@ -243,7 +327,8 @@ void zcomp_destroy(struct zcomp *comp)
>  {
>         cpuhp_state_remove_instance(CPUHP_ZCOMP_PREPARE, &comp->node);
>         comp->ops->release_params(comp->params);
> -       free_percpu(comp->stream);
> +       free_percpu(comp->dstream);
> +       free_percpu(comp->cstream);
>         kfree(comp);
>  }
>
> diff --git a/drivers/block/zram/zcomp.h b/drivers/block/zram/zcomp.h
> index f38fd31f9e4e..22be50dc51ba 100644
> --- a/drivers/block/zram/zcomp.h
> +++ b/drivers/block/zram/zcomp.h
> @@ -39,10 +39,15 @@ struct zcomp_ctx {
>         void *context;
>  };
>
> -struct zcomp_strm {
> +struct zcomp_cstrm {
>         struct mutex lock;
>         /* compression buffer */
>         void *buffer;
> +       struct zcomp_ctx ctx;
> +};
> +
> +struct zcomp_dstrm {
> +       struct mutex lock;
>         /* local copy of handle memory */
>         void *local_copy;
>         struct zcomp_ctx ctx;
> @@ -62,8 +67,11 @@ struct zcomp_ops {
>         int (*decompress)(struct zcomp_params *params, struct zcomp_ctx *=
ctx,
>                           struct zcomp_req *req);
>
> -       int (*create_ctx)(struct zcomp_params *params, struct zcomp_ctx *=
ctx);
> -       void (*destroy_ctx)(struct zcomp_ctx *ctx);
> +       int (*create_cctx)(struct zcomp_params *params, struct zcomp_ctx =
*ctx);
> +       void (*destroy_cctx)(struct zcomp_ctx *ctx);
> +
> +       int (*create_dctx)(struct zcomp_params *params, struct zcomp_ctx =
*ctx);
> +       void (*destroy_dctx)(struct zcomp_ctx *ctx);
>
>         int (*setup_params)(struct zcomp_params *params);
>         void (*release_params)(struct zcomp_params *params);
> @@ -73,7 +81,8 @@ struct zcomp_ops {
>
>  /* dynamic per-device compression frontend */
>  struct zcomp {
> -       struct zcomp_strm __percpu *stream;
> +       struct zcomp_cstrm __percpu *cstream;
> +       struct zcomp_dstrm __percpu *dstream;
>         const struct zcomp_ops *ops;
>         struct zcomp_params *params;
>         struct hlist_node node;
> @@ -87,12 +96,15 @@ const char *zcomp_lookup_backend_name(const char *com=
p);
>  struct zcomp *zcomp_create(const char *alg, struct zcomp_params *params)=
;
>  void zcomp_destroy(struct zcomp *comp);
>
> -struct zcomp_strm *zcomp_stream_get(struct zcomp *comp);
> -void zcomp_stream_put(struct zcomp_strm *zstrm);
> +struct zcomp_cstrm *zcomp_cstrm_get(struct zcomp *comp);
> +void zcomp_cstrm_put(struct zcomp_cstrm *zstrm);
> +
> +struct zcomp_dstrm *zcomp_dstrm_get(struct zcomp *comp);
> +void zcomp_dstrm_put(struct zcomp_dstrm *zstrm);
>
> -int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
> +int zcomp_compress(struct zcomp *comp, struct zcomp_cstrm *zstrm,
>                    const void *src, unsigned int *dst_len);
> -int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
> +int zcomp_decompress(struct zcomp *comp, struct zcomp_dstrm *zstrm,
>                      struct scatterlist *sg, unsigned int src_len, void *=
dst);
>
>  #endif /* _ZCOMP_H_ */
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.=
c
> index 0e1aa0da11aa..def5266679b0 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1348,7 +1348,7 @@ static ssize_t writeback_store(struct device *dev,
>  static int decompress_bdev_page(struct zram *zram, struct page *page,
>                                 unsigned long index)
>  {
> -       struct zcomp_strm *zstrm;
> +       struct zcomp_dstrm *zstrm;
>         struct scatterlist sg[1];
>         unsigned int size;
>         int ret, prio;
> @@ -1373,7 +1373,7 @@ static int decompress_bdev_page(struct zram *zram, =
struct page *page,
>         sg_init_table(sg, 1);
>         sg_set_page(sg, page, size, 0);
>
> -       zstrm =3D zcomp_stream_get(zram->comps[prio]);
> +       zstrm =3D zcomp_dstrm_get(zram->comps[prio]);
>         ret =3D zcomp_decompress(zram->comps[prio], zstrm, sg, size,
>                                zstrm->local_copy);
>         if (!ret) {
> @@ -1382,7 +1382,7 @@ static int decompress_bdev_page(struct zram *zram, =
struct page *page,
>                 copy_page(dst, zstrm->local_copy);
>                 kunmap_local(dst);
>         }
> -       zcomp_stream_put(zstrm);
> +       zcomp_dstrm_put(zstrm);
>         slot_unlock(zram, index);
>
>         return ret;
> @@ -2115,7 +2115,7 @@ static int read_incompressible_page(struct zram *zr=
am, struct page *page,
>  static int read_compressed_page(struct zram *zram, struct page *page,
>                                 unsigned long index)
>  {
> -       struct zcomp_strm *zstrm;
> +       struct zcomp_dstrm *zstrm;
>         struct scatterlist sg[2];
>         unsigned long handle;
>         unsigned int size;
> @@ -2126,13 +2126,13 @@ static int read_compressed_page(struct zram *zram=
, struct page *page,
>         size =3D get_slot_size(zram, index);
>         prio =3D get_slot_comp_priority(zram, index);
>
> -       zstrm =3D zcomp_stream_get(zram->comps[prio]);
> +       zstrm =3D zcomp_dstrm_get(zram->comps[prio]);
>         zs_obj_read_sg_begin(zram->mem_pool, handle, sg, size);
>         dst =3D kmap_local_page(page);
>         ret =3D zcomp_decompress(zram->comps[prio], zstrm, sg, size, dst)=
;
>         kunmap_local(dst);
>         zs_obj_read_sg_end(zram->mem_pool, handle);
> -       zcomp_stream_put(zstrm);
> +       zcomp_dstrm_put(zstrm);
>
>         return ret;
>  }
> @@ -2300,7 +2300,7 @@ static int zram_write_page(struct zram *zram, struc=
t page *page,
>         unsigned long handle;
>         unsigned int comp_len;
>         void *mem;
> -       struct zcomp_strm *zstrm;
> +       struct zcomp_cstrm *zstrm;
>         unsigned long element;
>         bool same_filled;
>
> @@ -2310,20 +2310,20 @@ static int zram_write_page(struct zram *zram, str=
uct page *page,
>         if (same_filled)
>                 return write_same_filled_page(zram, element, index);
>
> -       zstrm =3D zcomp_stream_get(zram->comps[ZRAM_PRIMARY_COMP]);
> +       zstrm =3D zcomp_cstrm_get(zram->comps[ZRAM_PRIMARY_COMP]);
>         mem =3D kmap_local_page(page);
>         ret =3D zcomp_compress(zram->comps[ZRAM_PRIMARY_COMP], zstrm,
>                              mem, &comp_len);
>         kunmap_local(mem);
>
>         if (unlikely(ret)) {
> -               zcomp_stream_put(zstrm);
> +               zcomp_cstrm_put(zstrm);
>                 pr_err("Compression failed! err=3D%d\n", ret);
>                 return ret;
>         }
>
>         if (comp_len >=3D huge_class_size) {
> -               zcomp_stream_put(zstrm);
> +               zcomp_cstrm_put(zstrm);
>                 return write_incompressible_page(zram, page, index);
>         }
>
> @@ -2331,18 +2331,18 @@ static int zram_write_page(struct zram *zram, str=
uct page *page,
>                            GFP_NOIO | __GFP_NOWARN |
>                            __GFP_HIGHMEM | __GFP_MOVABLE, page_to_nid(pag=
e));
>         if (IS_ERR_VALUE(handle)) {
> -               zcomp_stream_put(zstrm);
> +               zcomp_cstrm_put(zstrm);
>                 return PTR_ERR((void *)handle);
>         }
>
>         if (!zram_can_store_page(zram)) {
> -               zcomp_stream_put(zstrm);
> +               zcomp_cstrm_put(zstrm);
>                 zs_free(zram->mem_pool, handle);
>                 return -ENOMEM;
>         }
>
>         zs_obj_write(zram->mem_pool, handle, zstrm->buffer, comp_len);
> -       zcomp_stream_put(zstrm);
> +       zcomp_cstrm_put(zstrm);
>
>         slot_lock(zram, index);
>         slot_free(zram, index);
> @@ -2451,7 +2451,7 @@ static int recompress_slot(struct zram *zram, unsig=
ned long index,
>                            struct page *page, u64 *num_recomp_pages,
>                            u32 threshold, u32 prio)
>  {
> -       struct zcomp_strm *zstrm =3D NULL;
> +       struct zcomp_cstrm *zstrm =3D NULL;
>         unsigned long handle_old;
>         unsigned long handle_new;
>         unsigned int comp_len_old;
> @@ -2483,7 +2483,7 @@ static int recompress_slot(struct zram *zram, unsig=
ned long index,
>          */
>         clear_slot_flag(zram, index, ZRAM_IDLE);
>
> -       zstrm =3D zcomp_stream_get(zram->comps[prio]);
> +       zstrm =3D zcomp_cstrm_get(zram->comps[prio]);
>         src =3D kmap_local_page(page);
>         ret =3D zcomp_compress(zram->comps[prio], zstrm, src, &comp_len_n=
ew);
>         kunmap_local(src);
> @@ -2498,7 +2498,7 @@ static int recompress_slot(struct zram *zram, unsig=
ned long index,
>                 *num_recomp_pages -=3D 1;
>
>         if (ret) {
> -               zcomp_stream_put(zstrm);
> +               zcomp_cstrm_put(zstrm);
>                 return ret;
>         }
>
> @@ -2507,7 +2507,7 @@ static int recompress_slot(struct zram *zram, unsig=
ned long index,
>
>         if (class_index_new >=3D class_index_old ||
>             (threshold && comp_len_new >=3D threshold)) {
> -               zcomp_stream_put(zstrm);
> +               zcomp_cstrm_put(zstrm);
>
>                 /*
>                  * Secondary algorithms failed to re-compress the page
> @@ -2536,12 +2536,12 @@ static int recompress_slot(struct zram *zram, uns=
igned long index,
>                                __GFP_HIGHMEM | __GFP_MOVABLE,
>                                page_to_nid(page));
>         if (IS_ERR_VALUE(handle_new)) {
> -               zcomp_stream_put(zstrm);
> +               zcomp_cstrm_put(zstrm);
>                 return PTR_ERR((void *)handle_new);
>         }
>
>         zs_obj_write(zram->mem_pool, handle_new, zstrm->buffer, comp_len_=
new);
> -       zcomp_stream_put(zstrm);
> +       zcomp_cstrm_put(zstrm);
>
>         slot_free(zram, index);
>         set_slot_handle(zram, index, handle_new);
> --
> 2.56.0.212.g129ede20d9-goog
>
