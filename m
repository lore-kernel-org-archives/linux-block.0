Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECC2749D2;
	Tue, 15 Apr 2025 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744696618; cv=none; b=tlg7ZGOBeYT4KblVUcJ32YHjPqHH7bZ76WAkNxKmDWgqHUgAQ7nO8mMMSoQe8w/j1p1mFQfwF5YT+6ZJ6WFMS9Tkz3nu4twJJjge3Q4oQVW40guZkV1j9dQlaLAC5BEJWBmZj8Vo+Venzmiah3HoXzid9fB+P571Uk2aCA/lqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744696618; c=relaxed/simple;
	bh=B+KREJM4mAb3R4rAMIV3uUfDJPy0U59jzlDGI/zlTnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RXKKpjmNmEJGGEdWsMQ3YpWHECLNhjSra+I6ZqmOAOAhyZ8jW1zQ2gujcGN6WJAwRQoVBUFDPPTAKSrKBezgewfBHtngmiPfu6UVxxVcbwt219uEAdH9XSCv6iVDjP2uLqW06Hj2YNjEEgqaVA2X+R1yYIz9GVQbt0O04S+3tb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivv8gz1U; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivv8gz1U"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-601fcbff303so2508305eaf.3;
        Mon, 14 Apr 2025 22:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744696615; x=1745301415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+Lq5aH54mbxFUn1f3Q1yft6LGpjwARyan/SZu5Jevk=;
        b=Ivv8gz1U++XrR4YK8gnYgLcP3EqGEUdJZ+ETQ1G489dNsl4t1dNefETvXR4TJwTZTT
         aRZ9L4OiY0UeCt86vtDXi1GqacE0NRoi1Icha61Zoe8qm12qhiVbExAVnklzPYvcI+yG
         EiqPB9W62YFgqcKNxpemPdx+6hQkoQtGIf8jyl/j6uMO6p/kGVpUp8rKGBmhg0n75nbV
         ne3w4+gCFlHIpF0tgoV/ej+i1N/sLGRgyoP4cNUeZUlsZvoRp6EooozYwpskn5YGKzTU
         Zy8k4XuEDjFzS5Pgohh+ksclQH5U+dQwUg/aWTDV/8PFYgwxDstIBOuNi6CrXBRrHC1h
         o3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744696615; x=1745301415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+Lq5aH54mbxFUn1f3Q1yft6LGpjwARyan/SZu5Jevk=;
        b=lSt4wg6fmm0oOiIeuVZLq0XEn6+9ztYFImBZgKTizrO9hsSzTliGiqmFfm1yQEfXNv
         M2DFJK/h9cZ8lqcXwSfYXt6tF4FR3rxR/i+y/ni9GhdNkRlyoAmHTkYX6plTrFkjwC5+
         1LJx7Cyzgjyx2SjF6VfqrQieHQxGqIwGA5eVYOyPACMpomF6FBY4xNdnJ4DWeSzsJCQy
         lqj9lEiFXc0XzGU0T0VaTO6nMtsVTZASMAKTA+T+04k28qFsIXJawOv44rPcw6jzvnSn
         qfyL0r4ph6DgbW2BLLmXyvD0F58EuUMOjnqFQTlVK/mKdf48FLzJhMRRmZ6SfGQWdR5H
         wfRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3IXhk0+6jp3f2ks6LZdTLNYfBettuBzbRmoIwvY8MRrayekg+QgE8kGMvgHOk8/ZQ23OibKyiWJrbLw==@vger.kernel.org, AJvYcCX+Uk0AThz8Gf6ukof4PWRdbYAiWVekRGS51562kHOC6jOvz0nQRYG9aGA29v921GG4LtV2e9aKaFoxgDa1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+3oSzXuFIphTfSdz+anFJZKfddvG7oqiQEq+bMRqnryZLVx35
	PYbXbYX6KqF+97kSxqI05ggywhPl5V05Ye6n88WZwMjuM+Zzp/AtmBjPydntqjMDE/zUCbp86Id
	pVD1k/kHg4+u2Q/+uzzuFghLDkaM=
X-Gm-Gg: ASbGnctrihUMmtEWNXzbUcYo1sUC5AKmG7Ra1IYEd1f7z3PhwEoTbJoSQHeufnEgZtk
	/G00JsXHV5ouS3f9ehG9GNhgx0yLVUp8Grr4y05WHQNhy8HZbR4Ehog9ov7lCPrSsOCBS/d/FBF
	vSpXR56765BDBLbUIKwLVpImDz44Ff6phZKQ==
X-Google-Smtp-Source: AGHT+IEmj2a8nxWV7QLjMqim/mpCeFuiCq/hoRyEihjWrREzvYE+1MMd1R2sq2i7W3FyrfQ5+1FNPpinKH+si8J5g8U=
X-Received: by 2002:a05:6871:a582:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-2d0d5ef2381mr9183774fac.26.1744696615464; Mon, 14 Apr 2025
 22:56:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415054436.512823-1-yunlong.xing@unisoc.com>
In-Reply-To: <20250415054436.512823-1-yunlong.xing@unisoc.com>
From: yunlong xing <yunlongxing23@gmail.com>
Date: Tue, 15 Apr 2025 13:56:44 +0800
X-Gm-Features: ATxdqUGVr2B6RvZrhcmEhVPU3cI0v3wMM4xNTKOHuXrtRP-NAetVPXlDwnSVpX4
Message-ID: <CA+3AYtRRgL2-vPNm=1XBKd_PFuRcB5fZh96VGsfTO2VaAvqv9w@mail.gmail.com>
Subject: Re: [PATCH V3] loop: aio inherit the ioprio of original request
To: Yunlong Xing <yunlong.xing@unisoc.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, bvanassche@acm.org, 
	hch@lst.de, niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org, 
	hao_hao.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yunlong Xing <yunlong.xing@unisoc.com> =E4=BA=8E2025=E5=B9=B44=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=8C 13:45=E5=86=99=E9=81=93=EF=BC=9A
>
> Set cmd->iocb.ki_ioprio to the ioprio of loop device's request.
> The purpose is to inherit the original request ioprio in the aio
> flow.
>
> Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Link: https://lore.kernel.org/r/20250414030159.501180-1-yunlong.xing@unis=
oc.com
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> V3:
> - fix Signed-off-by error in commit message
> ---
> V2:
> - Assign cmd->iocb.ki_ioprio in lo_rw_aio()
> ---
>  drivers/block/loop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 674527d770dc..dd7f33d47f4f 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -447,7 +447,7 @@ static int lo_rw_aio(struct loop_device *lo, struct l=
oop_cmd *cmd,
>         cmd->iocb.ki_filp =3D file;
>         cmd->iocb.ki_complete =3D lo_rw_aio_complete;
>         cmd->iocb.ki_flags =3D IOCB_DIRECT;
> -       cmd->iocb.ki_ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
> +       cmd->iocb.ki_ioprio =3D req_get_ioprio(rq);
>
>         if (rw =3D=3D ITER_SOURCE)
>                 ret =3D file->f_op->write_iter(&cmd->iocb, &iter);
> --
> 2.25.1
>

Hi Jens=EF=BC=8C

There is a mistake of Signed-off-by in commit message on previous version.
I noticed that you had commited it in block-6.15. Could you please help fix=
 it.

Best regards,
