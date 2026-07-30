Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D233B05B8
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785426861; cv=pass; b=emE+ibJH4f3pJ/FTz++UXEx1KrRCLzFIwY/2ER5pq2xQlkhkyC5dekREhG5P35odEaJy4cDBxIB3QcTifks8X0VCwordrmXs9MjC5fnpi6BYlMmP4obPNp/f9nHcifm/Rlz2IqBQ8QAnNpoQOVfk+6c7uFSmEtq84L/qLiPg6qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785426861; c=relaxed/simple;
	bh=6YQb/t9FWRzsK5PiSTD/yTg61pWCZzsEJVx/UZG464k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CbdkCXFaWxwjvhHDfgW8Wfy9fPTSjptOmsgHoY8DwsaRCOxZitiYs8+QNq+ZiJMvJaMjIaJQaILeKWBpIpJHbnbPUgPcM6bzyI3DlWLxARzmMV9L756ERxdDkWSMMctCTdGnrcHWfkCH5fvn1WweK+WvTwaCiiAgM59QtWt+VFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=N++BKRqf; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="N++BKRqf"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-4498f3b4910so1644fac.3
        for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 08:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785426858; cv=none;
        d=google.com; s=arc-20260327;
        b=FQgklpM9z4EetlTVrNo3mXJoZxTjRX/tVlAFXcwjnGd8DVNa8ejMhzI59koIUgfpG7
         oQorEGAMm45mmORsMCtoJnwUrGgN79TogpHyCmRq5GB2i9M22Fb8gkVOmzl7Nm5gEcjb
         ixBvhwV2LdNYwCeYHAZb+bQNNtykWAnL/TrSae3dCVcjn9jy/ilJze74MJNWdiOo19sw
         cUw47HBL8F7mrKNLNeup5+V3zbnEZaWoyJm6o/W98x+0y/Msp4MopRa8hRd49ucklvjW
         FjLQMP9UuvExFqO3DR5w+xpUV+fDYHsrUubo2c20bhRIAG4V6ou1PByxUUGlNmQ7B/yx
         YW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MJXvN+LWAHsiq083jIe+UXU/QxcgIzpWEf1tVpeV7bY=;
        fh=GoOCIHGJj1BJj3r45QtaEfWFOi3j1aGGrKIIyiNW1Mw=;
        b=oVek6RjP+reKwcR5GQh9q2Yu7vE86H8E3ZaBxsKIGxBWfqHnLXzfItICz7Q22rg0h6
         nYZaf9JorGpSA/UJ9TI0WcHQ3cUj6KO7/FRL6SNUHbkGklc/wMxgK9Wyx0ubPSaW/Hvq
         mIZIqkzwQiqZ+sU2OAMSkgilMALTApG2xFgYHxX5wmAc41uTV7WDue4aK4+pUO3Szwp6
         TqP/XtyPIlmYgART2p0D/jZ85T0WL9G7LaLWPbKPp9z/9gyQjwa7TGevmAab3hrELvK1
         kK/DN+XfDcYQfAoeyKa/TfS23zufFYx1Tp1hA6W39AtS75WgfSGZUJJaRMawmQl82zQs
         Hy4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785426858; x=1786031658; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MJXvN+LWAHsiq083jIe+UXU/QxcgIzpWEf1tVpeV7bY=;
        b=N++BKRqfyX9zh/T9tliS+9DVL5khHbc4ABzjf4v/SDTtZEPMTCJRA7ljHmWSCdjyoA
         rn3Bba9+uTAqgNBxEdVQnxyU9MF/Dz8lgI4Yv2a+7cm0kNGN+Y3HfsNqX5crbZNTARgy
         Hxp5xyY3cGIVJY8xO3r09tSTzczilEceqBGa8XCysfac0iy5oTrb/BbdU1kFDDXRgNSK
         YMzyfpPQYJQSFjlz4LDF6JfayaF6ujdNfL2oX0Quvhaz+hSjqnuusX6Nuv3mGFVMFBh9
         grEIB8UDbEnQFis6oOfAdLZXGj+6j81VZ7QWTwEEX7qv/z+Br7jicyMnz7iv4AVMY8yf
         3f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785426858; x=1786031658;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJXvN+LWAHsiq083jIe+UXU/QxcgIzpWEf1tVpeV7bY=;
        b=tZg8cXX1SAjSEwAYXjlXkeRaGrVkA+C8DLSuV1BOF9sDM27mjFoRYu3imlrpozEc0e
         6qFThOzG7EJJHAnU6uq8oupy+VCKJYR9o1uy3SxRd4RKBBEWhPlwYa7vM2wBdiNGtLw/
         Y7G5ULdghAPAAGpFD8IT5ov5owDFKrKbfkPnJEDtDeJVBTwayplp9ZtAIE9oia3H0EDO
         12yOa+DtQT0uLjjzHKrHoHUjEND8O4O8pxKCZ2BjFG8RPrbruqu4pZE9PkQ8nZyJmfFr
         ZXi45or26YScJtPhAjcUiWHkG1iTvoRHIf3xPpFWYJ9tvE760sNl6AMT/NXFXj+ChqBs
         E/dg==
X-Gm-Message-State: AOJu0YwzQ7cVtUbOvEbegVxxgL4QDRtS4Tnz1N/oOCk6ZEKZsT+WGcsr
	hpImzwM/gxN6Bj682Xvm1GYPyWx5DMyGexBk759IpExnb9aekMNf1H0IOBpBixMpqZ3C8yIwNU2
	FpLtbH+xn+Z6j4rgSe9oiNLFRnv4pMzoqWWbVYZeJ6BjlIlKRnpnWSRMVOw==
X-Gm-Gg: AR+sD126/o28lGU5ivKTubbnfUlFhbkN1CSvpL9PXEzPRTETEJItYSn5aTEyRAmb7Kj
	OG76Lj0hnRE9P6zkis0tOkhu5gtt39WQjBm8jrcSaedh4qt2QDpm0M/+hLJClR7RcULI6WW6KS8
	CZZxj4m7eMK5g+nIgDdYvpTNREUQl0hyO92s19edVbk6OSf5cCqKQsDaFH6/365k0DoEoILDcU0
	EruuJ45Grri7M/aE4gAU4BCbdHvqfkik+3bUDId8M44SeZvULhpkAjmWeFAFWCkEED1Mi1T2Qj6
	Rv9bRJD7c20hPj6NoDp4MN7/mGFprZ8nMT6gcjlajiMZ
X-Received: by 2002:a05:6870:b3e3:b0:449:f4c7:c297 with SMTP id
 586e51a60fabf-458dd25dc57mr681323fac.3.1785426858138; Thu, 30 Jul 2026
 08:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729012951.3744582-1-csander@purestorage.com> <20260729012951.3744582-7-csander@purestorage.com>
In-Reply-To: <20260729012951.3744582-7-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 30 Jul 2026 08:54:07 -0700
X-Gm-Features: AUfX_mx5im4LLjA4CdYitOg9_b9OBl8hzUEJ1V48o4gpe3b67k5uOkEMPTU4z4E
Message-ID: <CADUfDZr2uZi775agBb5TszOrL3q6QH199bZNtqSUN9KzHBEjEw@mail.gmail.com>
Subject: Re: [PATCH 6/6] ublk: lift need_map check out of ublk_{,un}map_io()
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 6:30=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> ublk_map_io() and ublk_unmap_io() are no-ops for ublk devices that
> enable user copy or zero copy. However, the implementation is a bit
> convoluted, returning the full request data length and relying on the
> caller to check the return value against the request length.
> UBLK_F_SHMEM_ZC recently added branches to skip the ublk_{,un}map_io()
> call for I/Os using a shared-memory buffer. This is a more logical place
> for the need_map check, so move it there from ublk_{,un}map_io().
>
> Checking need_map early also avoids the expensive pointer-chasing for
> the ublk_iod_is_shmem_zc() check in __ublk_complete_rq() in the common
> case of a ublk device using user copy or zero copy.
>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 21 +++++++--------------
>  1 file changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 1da45e382253..d4443a43229e 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1464,19 +1464,15 @@ static inline bool ublk_need_unmap_req(const stru=
ct request *req)
>  {
>         return blk_rq_has_data(req) &&
>                (req_op(req) =3D=3D REQ_OP_READ || req_op(req) =3D=3D REQ_=
OP_DRV_IN);
>  }
>
> -static unsigned int ublk_map_io(const struct ublk_queue *ubq,
> -                               const struct request *req,
> +static unsigned int ublk_map_io(const struct request *req,
>                                 const struct ublk_io *io)
>  {
>         const unsigned int rq_bytes =3D blk_rq_bytes(req);
>
> -       if (!ublk_need_map_io(ubq))
> -               return rq_bytes;
> -
>         /*
>          * no zero copy, we delay copy WRITE request data into ublksrv
>          * context and the big benefit is that pinning pages in current
>          * context is pretty fast, see ublk_pin_user_pages
>          */
> @@ -1488,19 +1484,15 @@ static unsigned int ublk_map_io(const struct ublk=
_queue *ubq,
>                 return ublk_copy_user_pages(req, 0, &iter, dir);
>         }
>         return rq_bytes;
>  }
>
> -static unsigned int ublk_unmap_io(bool need_map,
> -               const struct request *req,
> +static unsigned int ublk_unmap_io(const struct request *req,
>                 const struct ublk_io *io)
>  {
>         const unsigned int rq_bytes =3D blk_rq_bytes(req);
>
> -       if (!need_map)
> -               return rq_bytes;
> -
>         if (ublk_need_unmap_req(req)) {
>                 struct iov_iter iter;
>                 const int dir =3D ITER_SOURCE;
>
>                 import_ubuf(dir, u64_to_user_ptr(io->buf.addr), io->res, =
&iter);
> @@ -1591,15 +1583,16 @@ static inline void __ublk_complete_rq(struct requ=
est *req, struct ublk_io *io,
>         if (req_op(req) !=3D REQ_OP_READ && req_op(req) !=3D REQ_OP_WRITE=
 &&
>             req_op(req) !=3D REQ_OP_DRV_IN)
>                 goto exit;
>
>         /* shmem zero copy: no data to unmap, pages already shared */
> -       if (ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))
> +       if (!need_map ||
> +           ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))

Realized the ublk_need_unmap_req() check in ublk_unmap_io() can also
be combined with the req_op(req) check above. Will update in v2.

Best,
Caleb

>                 goto exit;
>
>         /* for READ request, writing data in iod->addr to rq buffers */
> -       unmapped_bytes =3D ublk_unmap_io(need_map, req, io);
> +       unmapped_bytes =3D ublk_unmap_io(req, io);
>
>         /*
>          * Extremely impossible since we got data filled in just before
>          *
>          * Re-read simply for this unlikely case.
> @@ -1755,14 +1748,14 @@ static bool ublk_start_io(const struct ublk_queue=
 *ubq, struct request *req,
>                           struct ublk_io *io)
>  {
>         unsigned mapped_bytes;
>
>         /* shmem zero copy: skip data copy, pages already shared */
> -       if (ublk_iod_is_shmem_zc(ubq, req->tag))
> +       if (!ublk_need_map_io(ubq) || ublk_iod_is_shmem_zc(ubq, req->tag)=
)
>                 return true;
>
> -       mapped_bytes =3D ublk_map_io(ubq, req, io);
> +       mapped_bytes =3D ublk_map_io(req, io);
>
>         /* partially mapped, update io descriptor */
>         if (unlikely(mapped_bytes !=3D blk_rq_bytes(req))) {
>                 /*
>                  * Nothing mapped, retry until we succeed.
> --
> 2.54.0
>
