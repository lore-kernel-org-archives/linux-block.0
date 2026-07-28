Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12DF4252A7
	for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785262936; cv=pass; b=VLQ+t8ae9GXNnbshWAJHvjXWxbXt1nI6BcgoF2R1AzfuWjGak0jBDuDBA3DtNlRkac5PNFz4KlcMB1wFcP6Xr0+sl7fKbjYTNWmpg7UJ+xCL9j5VYMuGbEr+CjoHnwa5uTKjXWH1Gv4tP+wogK/qDOAwhuGMmOpLzdhlASln9JM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785262936; c=relaxed/simple;
	bh=7cydfJ0sibwTzwV/UbG0vSIq4k7dqiMulmc+vsRY6u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjkwS3jC03b3inzlqJ2cpr0xRX2FHg9wTFcORs7ULH85//7Ut3ts9DinlpghkUr7dY9I38BVjK4beWQpCPWUFxMOp1WYq/nwPkjU28BGNfpdZtfr66fk2vMxI0mJ20q8ukU/vtYLpRw64nkbtBTK0i4KwULSuDcsakWgAUe7puI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=S4SAMe1d; arc=pass smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="S4SAMe1d"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4961446bee6so13376b6e.0
        for <linux-block@vger.kernel.org>; Tue, 28 Jul 2026 11:22:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785262932; cv=none;
        d=google.com; s=arc-20260327;
        b=eX2C9SoYJxuoSIGG5X1PsdTQQIpFxobB7pbWm7E21UOhBVVa4L5jt+UThbgovzfIL9
         NqZ2n2dpvIi9gBlyipQBzJnbiY7tIwYke/4D8cs+ERhdgvArCP8+yM1KEcEUvq8rW5T9
         qm+QvGez5dF+8jxM3aGyfrcDBg2VEja+ezZj6GktwXTkFod56bwgtE4jw9oI+s9Fd0SH
         AXtzWuNrClbwbFxbJQQzBKZa1WKBhJQ6QOOrzrcTKKdI1AQopyOaqGFAeahsCWkIHehZ
         WC0zKhF1UF15J73/SqreUZ+3xu3MbfoD/MCvQsSX8Lc0dqETZXhLpOIECCKKyUV26Z0g
         UIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YOI5qsUQsIoINSZDzx6Z+4b7W8/5EoxUJ9RJGL7PhBA=;
        fh=FPUz+SS7VFsY/zNx0t2kiNNGS5XuFRex9cKOyq6jeR0=;
        b=hoRHWGcENNYXS8Rk6103pNRiu0u3kRQ6PuTKWVg97+3A1lYdcJq1Rr/9F9qs7wwI8V
         dYxMmMHD0JrwsqB5y8IF5iqF7CBOoKsB1XD3k5Y90yTIN7FuEMm/uEErNjLnP8sR68NX
         /nSBETL5qlT1/bOVaYjf+if/zrtmmf5kz/yryOxDYeM4GFn7JdlPktbImvlL2eE4yr78
         l/EJp7NRQMO/HUc/btEqGyuyjQx9+hQoRGeK6tWREij2zKqr1e/PxpLxVRR9WhbNJxSc
         S/wJCZZIvPRMVUDMiHhrAwGzH/Zrla53TNy0Bdqe1RBXpCpMvxzVOxZFfVm05RR0+R/9
         ZtWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785262932; x=1785867732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YOI5qsUQsIoINSZDzx6Z+4b7W8/5EoxUJ9RJGL7PhBA=;
        b=S4SAMe1dTOdf592gQ8JfZmOMtyaGy8lfR/1IIB7dt1pNBRaRfK0Wsf7pN+XYkSgPCt
         xwhB8/HeGn9K80KHnFo7z29I8lG33dUUNEZCwqg3ZLj3R7b1CwxvQMaoSJyhbWrgK8gt
         apnFK05CIe+a1Ybhcv1BAy4J+8z2IaWTSK2KNm/mDNQKLfPd0yjiyNXP1Hy4CtoZ2bDI
         L7yQdJc5FMxIMZ0ilMcc3AQ0KCjlypPXr+YaAV4bqOgLUuWVHmI/76UNm5T6v1dmkHFC
         VFMY/tENF8DWiXthB0kIK5k2+NOjXq7QhZgSP/FwgiiBoW8y41zCXoIy1BuqgwOkmFpq
         9j7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785262932; x=1785867732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOI5qsUQsIoINSZDzx6Z+4b7W8/5EoxUJ9RJGL7PhBA=;
        b=qANkXeyDvIsg+6WjWfBFEkbZjvgWJh/w3IyUjO2MQFedmg8YlGe7UK7nmgoCoBWzVA
         rEIj6mtx30MEMcJiamvyveGQjRtzUP8H+iw6SR+3TQDjJPkdC/gafJ0CqHcgTAda4fUR
         zYaLr8HkzEO7zBxjmp8R/JgIYR2mNu6szhMMgcpA1fKJJQPVgHPRlTIjEsmybdud1vO6
         qa/w+Act6tpl2KiaKgVkZDj7gCxgRbgyLB7Zw/GIfx43AX6ryktMBYTKNxOXR+zS+U8/
         zClRqJhoNkztz5FhtFC0Q1exXr3H6s6N54pqTKTIttUn05zLX23b2QeyB5tQwrXJWcsN
         AR5g==
X-Forwarded-Encrypted: i=1; AHgh+RqRB18/gRVLH3uroIt0VH9GP/F11W/d11+vtsMARkCyPW0HGjal4WzEMi/iei2eP7vo742Q8fhAQllNmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3OUL4T39FlxLeK638e5TZFo/6g3bYfyIrWprf8PMWX+5EtbSk
	A/bOh2EPKDUDIrHw0aKq7kBmUohOBGt+eEvHiWVSGP0Cjjgb7dJjF67YveRHQeZ6MzRj3k17r5Q
	gEks9dec5/mvX19Rf92lBZ9kHYOVSwJBho1Zm3HHp8g==
X-Gm-Gg: AR+sD12m7PX+FGAC4rp15itq/f9+8jT1TpVvgX2slGdXYJqw+ffNCSCIu+nCNWP37r7
	01JUOL7I9i4lgBQIysHjooUSt6nLZly454F4JJsemYBsICe6gtbCCjD1GR+K6/XSeiwYXANjpQs
	sXQ94TNHP0CEY+BSjYqIoocqXunyEPieUUu4W/9QVVJWrUND968XqOa2ZCufI6xAaf+NIotUpD0
	8OXqIflGFhlUPJTVD/wpbK3eEUn4oEkyLLKqDb5X2Yj+q5J2VGBLcCO6fO7o4U=
X-Received: by 2002:a05:6870:898c:b0:455:9a0a:f403 with SMTP id
 586e51a60fabf-4586ce14424mr1403846fac.8.1785262931576; Tue, 28 Jul 2026
 11:22:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727162450.2921500-1-csander@purestorage.com> <CACVXFVOaA_k+TCmeyrjguW5StdDb=zQsTCXWMBQ7QiNX1wuDzA@mail.gmail.com>
In-Reply-To: <CACVXFVOaA_k+TCmeyrjguW5StdDb=zQsTCXWMBQ7QiNX1wuDzA@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 28 Jul 2026 11:22:00 -0700
X-Gm-Features: AUfX_myfrJKXBQP2SdXXmURfpWjqieiGynzvY1oktdCihrIe-TMkgRr_WSKhRGk
Message-ID: <CADUfDZr5-scDrSe6X3AVz3pX9iD8Cvri6AWj6zQWNqqqnL6jrQ@mail.gmail.com>
Subject: Re: [PATCH] ublk: remove WARN_ON_ONCE() in ublk_unmap_io()
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 7:47=E2=80=AFPM Ming Lei <tom.leiming@gmail.com> wr=
ote:
>
> On Mon, Jul 27, 2026 at 11:24=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > io->res is set from struct ublksrv_io_cmd's result field, which is
> > controlled by the ublk server process, without any validation. It's thu=
s
> > possible for userspace to trigger the io->res > rq_bytes warning.
> > ublk_copy_user_pages() already limits the copy length to the request
> > data length, so drop the warning.
> >
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  drivers/block/ublk_drv.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 4ca6ec738c93..4f30644756df 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -1492,12 +1492,10 @@ static unsigned int ublk_unmap_io(bool need_map=
,
> >
> >         if (ublk_need_unmap_req(req)) {
> >                 struct iov_iter iter;
> >                 const int dir =3D ITER_SOURCE;
> >
> > -               WARN_ON_ONCE(io->res > rq_bytes);
> > -
> >                 import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res=
, &iter);
> >                 return ublk_copy_user_pages(req, 0, &iter, dir);
> >         }
> >         return rq_bytes;
>
> The change may be fine, however access_ok() still can fail from import_ub=
uf(),
> so can we consolidate ublk_unmap_io() a bit?

Sorry, not quite sure what you mean by "consolidate". Are you saying
there should be a check of the import_ubuf() return value in
ublk_map_io() and ublk_unmap_io()?

Thanks,
Caleb
