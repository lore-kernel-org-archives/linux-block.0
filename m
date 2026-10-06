Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3381835CBD7
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791267815; cv=pass; b=F95c6W28IYYH5LBQUkxC9xdyM6zLp/CeAtxLXMamGrt7CSgWhkVUp543Zuh+YaAL7l07hiGqsbts5vuUOqihzMtSKNVfjoMGVKsWcL0/fMzRgQFU8nk0y/3fL5HB1l9mvmLLIzpFqjIrLbCBD84OliyBD8cGtfKvYpV/gW/y+10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791267815; c=relaxed/simple;
	bh=6yj3IjznaS3BQd8hYYaLqUQxrXsV+yww0L4Bwh7JzCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHtCPDTr72rDtoD13GSSUeT+4hMaq13Tiuqqlwbwv7m4VpApqT7wqYTI5u92WfuUzTEwKa37RwWjUkrBq7K1C5fNzLNqmIndwOvRYB+JdoPI2DFJG8UBnDukpdj4lF/yN5L8NNCrAv2ne0jzCtG9rZI2TLaS2TViAFD2uO4geQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfnT+qAm; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfnT+qAm"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5351f9dbfe0so85591cf.1
        for <linux-block@vger.kernel.org>; Mon, 05 Oct 2026 23:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791267813; cv=none;
        d=google.com; s=arc-20260327;
        b=RARDJnHO5YLX2RXnc9w/+acLB4keJJC93qYiWJU5WI3v3lqeMRKAHgF1/f8Bf/WN5P
         4iiIhG0BE+a69AgFJHy9qBJFZO1T0+7Z1iTKGatmkam0fcv6oevW8cYLf3NgE87yuaXo
         Deqj4x46x10rqDMzCogRImxyOWm+g4WlYwrKHOnDmNoLuN+5t1qt/p9HOp0V8w3Asojr
         Ag14vOSXd12G2vWET5kHRojnP6uRi2N8AIAEOoqHjHvzeTjb1QFJJ1lS3og+nZilp7Zf
         vuPkedG5YqTGugVusAK6lnFtYccYCxLHtQ81qtqbsL7PFNnPAlNpxhdky2jvPq1w/bsG
         ajjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d6+kRSXQFgdihasqR6LMoeFY3+MY7JRLIu/SoS6ybio=;
        fh=gzCH2H8xwt8GX30G6amWZXzCTJmeDOaEPl8tDjg8r3Y=;
        b=p3zFTw6ppgVtOamfERf07ZeyUkOj4Wpchl9Ip8A12kpkzhY2bRyLG7p01WixpATlvx
         1DmkNIcHHcv3G/DCd3+n6ym3MyMR2FL15Lvz9y2i6ksDEKf0HKKsrLuMH6OMlWxJrXWT
         8iNGyIz9KI+2UruuRs8LazdUPzw5PdvwcmN7bKItD12nxcpMhUtALWMYa2/0FEHOd0NQ
         +gVEABadozhWCLnG9WRtSseyrBkgqR8YkQBDO2uUQfKZAE/aLw9uRTukKBY4sxnO+x1U
         pcyuxLpRrKWLvN+0f05tg9NWwW8QiGFoZTFoYJODZsF7fCtQn4wKHQmhDouVJkl6WeU+
         O/2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791267813; x=1791872613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d6+kRSXQFgdihasqR6LMoeFY3+MY7JRLIu/SoS6ybio=;
        b=TfnT+qAmh9967qN/rO0yT1C+UdYnQS0y7h7zh5T3zxO7iea0M/W1vaZAtrH0YCMJXd
         i+Qa+af9IGq4wxdLEbtLkn+SOYfdNcz2V9UK57mZnjOsBtY52i0hhCjjNy5R1McQEhC5
         25BVktMyRQnsEzrAUD4GqoS1NZX5MQt6RM4w4ZABSPhiouAgsS+OWbg9fZ1dfWUQkQYV
         7RPd4ifcDhCKtUUFCxoRQQBpNMd/st9I5o9xcvgoPc8WfaGe8i5ueutir9y33C77NLf5
         vVKaN9ft2JjftP8Tw1+6Z8demgypQBGCmVdLHsgfWlP9F67GQCtFqq/JPOeuasa4DOLM
         sOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791267813; x=1791872613;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d6+kRSXQFgdihasqR6LMoeFY3+MY7JRLIu/SoS6ybio=;
        b=IGd6NU4Py7dXk5caHoHNb1w/gZRvz5D38+zLERiml4ktupYrzHUJO+2dABLG49V7Dc
         /mB9NJVQMWJeSucultVTDuhgDDuZ2J9jHpXrR7NJi8QVY/iTXzUG5C3mrwhQxWTNBiJm
         +JNqAV3znab9Xjgv/RlB7MTL2Kur5+EnNEGAiwd5OLf1IoX6L6pNbJWA62drXCMCsd27
         sM+B+rYh/qKtqfJNStTmeQumJFHqswzaP1tbBQuemqg8gic9IkUyzrcXNdxjcFKfVysL
         vXRu3phFOFlYAp4j4ujSU1nAjD0i00vhjkUifF6VPlJghEFhKBYoUAWXmNzePi88ctDI
         tgxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwdfwyiaK667iKpSU+Qz7bw5M0DaetcVViepQOrhs+FixgqR9IHKM8qu3b2d5KJvHNVcoz45miinTPjpA==@vger.kernel.org
X-Gm-Message-State: AFuF++mWmVKb26+NQmWLJKzfTk2IKxlRnUQ7Yql9kpi8JACaOT20fXSF
	bAZKTtUZZTdTAsqHBph6mv0NB00JR7e76a63xfTKmjZMIVD4pMAL2snCtGFwy3oSJOQfO8bnbWx
	XS6AA5FhYbf89fRsWHQLHQ4oAAZ2IqINAhUxcS98g
X-Gm-Gg: AYBFou3uD218H4NHmRetSL0vTNH1qWmvQm19ECkwUbbACFEzUc2jDhHcMWJUxM3CJP0
	8E5lm3kKOKzuzlAw6ldOOOjgPsH1VpQHEi1cKjb/gDkHXH8deU+Zi5yCP6/8PbAUXInpG/K52vK
	JuapnyGGhHhYv1h/MQtTrdJr9XePlm0jvAG2Xunbb1Kv3akIlL0wr7BehCBRJdAlS80FhmGnNkX
	4LjQE1UUW2uPPkVpOij+oKS1THVHMBN68QsIx1qtlZiJn63YBScdZRjXqPqV1wQ50x0zzpQTuB/
	UKu33mib38ENTJIzmkYj4KHTayEYRMMJLC4G/zGIRsGyinw9A6RXUVLbF4xBeM4wh0skQsgzLIV
	6mVe+XnrRz0lTWKeQAnpbJG8cPcfso86w76eBOqExUFFbw9/+JqSG+fkNv5fXoF/caoipB349DE
	NwhSws6jOXInzQeaAav9wkADjrn+A=
X-Received: by 2002:a05:622a:244c:b0:533:9746:9a86 with SMTP id
 d75a77b69052e-535406abef8mr12178981cf.5.1791267811940; Mon, 05 Oct 2026
 23:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005122036.718976-1-senozhatsky@chromium.org> <20261005122036.718976-7-senozhatsky@chromium.org>
In-Reply-To: <20261005122036.718976-7-senozhatsky@chromium.org>
From: Brian Geffon <bgeffon@google.com>
Date: Tue, 6 Oct 2026 15:22:54 +0900
X-Gm-Features: AclHuK8LYHoepKR1DX5jKzVYXr3tve8RqbZuZnlBMtj7jR1SkDVBcQxir3QS8S0
Message-ID: <CADyq12wEtNYBi=gDaWxMGOaaxTPYj2DKg25YE4owBOxFuSbCpQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] zram: lz4hc: use LZ4_decompress_safe_usingDict()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Richard Chang <richardycc@google.com>, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 9:21=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> Use LZ4_decompress_safe_usingDict() in lz4hc_decompress() to avoid
> needing a per-CPU LZ4_streamDecode_t structure.  Drop struct lz4hc_ctx
> as well and store the compression workspace directly in ctx->context,
> matching backend_lz4.
>
> Using vmalloc(LZ4HC_MEM_COMPRESS) instead of kzalloc() for cstrm when a
> dictionary is configured also avoids power-of-2 page rounding (~256 KB
> rounded up to 512 KB), saving ~252 KB per CPU.
>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  drivers/block/zram/backend_lz4hc.c | 70 +++++-------------------------
>  1 file changed, 11 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/back=
end_lz4hc.c
> index f3656c27af21..b62736b26622 100644
> --- a/drivers/block/zram/backend_lz4hc.c
> +++ b/drivers/block/zram/backend_lz4hc.c
> @@ -4,18 +4,10 @@
>
>  #include <linux/kernel.h>
>  #include <linux/lz4.h>
> -#include <linux/slab.h>
>  #include <linux/vmalloc.h>
>
>  #include "backend_lz4hc.h"
>
> -struct lz4hc_ctx {
> -       void *mem;
> -
> -       LZ4_streamDecode_t *dstrm;
> -       LZ4_streamHC_t *cstrm;
> -};
> -
>  static void lz4hc_release_params(struct zcomp_params *params)
>  {
>         LZ4_streamHC_t *dict_stream =3D params->drv_data;
> @@ -65,61 +57,32 @@ static int lz4hc_setup_params(struct zcomp_params *pa=
rams)
>
>  static void lz4hc_destroy(struct zcomp_ctx *ctx)
>  {
> -       struct lz4hc_ctx *zctx =3D ctx->context;
> -
> -       if (!zctx)
> -               return;
> -
> -       kfree(zctx->dstrm);
> -       kfree(zctx->cstrm);
> -       vfree(zctx->mem);
> -       kfree(zctx);
> +       vfree(ctx->context);
>  }
>
>  static int lz4hc_create(struct zcomp_params *params, struct zcomp_ctx *c=
tx)
>  {
> -       struct lz4hc_ctx *zctx;
> +       BUILD_BUG_ON(sizeof(LZ4_streamHC_t) !=3D LZ4HC_MEM_COMPRESS);
>
> -       zctx =3D kzalloc_obj(*zctx);
> -       if (!zctx)
> +       ctx->context =3D vmalloc(LZ4HC_MEM_COMPRESS);
> +       if (!ctx->context)
>                 return -ENOMEM;
> -
> -       ctx->context =3D zctx;
> -       if (params->dict_sz =3D=3D 0) {
> -               zctx->mem =3D vmalloc(LZ4HC_MEM_COMPRESS);
> -               if (!zctx->mem)
> -                       goto error;
> -       } else {
> -               zctx->dstrm =3D kzalloc_obj(*zctx->dstrm);
> -               if (!zctx->dstrm)
> -                       goto error;
> -
> -               zctx->cstrm =3D kzalloc_obj(*zctx->cstrm);
> -               if (!zctx->cstrm)
> -                       goto error;
> -       }
> -
>         return 0;
> -
> -error:
> -       lz4hc_destroy(ctx);
> -       return -EINVAL;
>  }
>
>  static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx =
*ctx,
>                           struct zcomp_req *req)
>  {
> -       struct lz4hc_ctx *zctx =3D ctx->context;
>         int ret;
>
> -       if (!zctx->cstrm) {
> +       if (!params->drv_data) {
>                 ret =3D LZ4_compress_HC(req->src, req->dst, req->src_len,
>                                       req->dst_len, params->level,
> -                                     zctx->mem);
> +                                     ctx->context);
>         } else {
>                 /* Cstrm needs to be reset */
> -               memcpy(zctx->cstrm, params->drv_data, sizeof(*zctx->cstrm=
));
> -               ret =3D LZ4_compress_HC_continue(zctx->cstrm, req->src, r=
eq->dst,
> +               memcpy(ctx->context, params->drv_data, sizeof(LZ4_streamH=
C_t));
> +               ret =3D LZ4_compress_HC_continue(ctx->context, req->src, =
req->dst,
>                                                req->src_len, req->dst_len=
);
>         }
>         if (!ret)
> @@ -131,22 +94,11 @@ static int lz4hc_compress(struct zcomp_params *param=
s, struct zcomp_ctx *ctx,
>  static int lz4hc_decompress(struct zcomp_params *params, struct zcomp_ct=
x *ctx,
>                             struct zcomp_req *req)
>  {
> -       struct lz4hc_ctx *zctx =3D ctx->context;
>         int ret;
>
> -       if (!zctx->dstrm) {
> -               ret =3D LZ4_decompress_safe(req->src, req->dst, req->src_=
len,
> -                                         req->dst_len);
> -       } else {
> -               /* Dstrm needs to be reset */
> -               ret =3D LZ4_setStreamDecode(zctx->dstrm, params->dict,
> -                                         params->dict_sz);
> -               if (!ret)
> -                       return -EINVAL;
> -               ret =3D LZ4_decompress_safe_continue(zctx->dstrm, req->sr=
c,
> -                                                  req->dst, req->src_len=
,
> -                                                  req->dst_len);
> -       }
> +       ret =3D LZ4_decompress_safe_usingDict(req->src, req->dst, req->sr=
c_len,
> +                                           req->dst_len, params->dict,
> +                                           params->dict_sz);
>         if (ret < 0)
>                 return -EINVAL;
>         return 0;
> --
> 2.56.0.rc1.315.gc6ed9934b7-goog
>
