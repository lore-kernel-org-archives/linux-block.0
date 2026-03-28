Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968C73A5E99
	for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719647; cv=pass; b=lju9PtKVpg9YjX4yGYqc8g3/GedrWLOzTonjiiYEZdxhCCi+Uibw4HvHjrKsrFltVv2tqVFL6hKDHi8Koy/GdGOx2FHY8krj/HnhHDo4Qp7rceMWfxjXvueEnq9d3fGVuGNWZEKCb343evAgMvwJB/W4sUCE0rEYDsN2/cKhkTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719647; c=relaxed/simple;
	bh=pQMjEifqRPlt4rmrjnF9D0etr0Sd/rUTpUYxQpwoqpc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLENAPNfpUL/0SCqklpOaM+DVj7QBYLtCpezE20U0kdSoEqkDKFuMwRrTDDJkwT+BKtbWAb81rE5plmoB6atrkq57s5+OS9s2UjCJpN2C1SksFh9ISnf67p/BpyZUEx7TLxV79QqBQfQKrNYtli55j0fHmEqThYNYaMIA/aT3w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=E3aAr2eP; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="E3aAr2eP"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-66dfeb899f4so436762eaf.1
        for <linux-block@vger.kernel.org>; Sat, 28 Mar 2026 10:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774719642; cv=none;
        d=google.com; s=arc-20240605;
        b=E28ns1KnZ+Ayo9PVzjgGzjioHpjYvqz5EJe0vZf/62swAILeZEnpkyXzcMDT6tTvoE
         De+Gh91dx78YKQieotAJNjZoWb3ZiwuM461cWE/NbkXS7JfAqknIwwnq/MrNfvEYUvA4
         uFX7ST50LSJthwA0zlgXq200wKtyHlGGDdNjCUIPHKCo3AnAd/FCr1e/TR8Tajikv4uJ
         ei0mOJW7kmJwkmCjK+JKBz9jiXBlw2ehF+yr3vXCnIeD4xHOVU04VwUiLcAaMI6BnL6m
         z0lOuGsMo6OfZ6ZOUVALjAzeypiQHV5+jhy3jdBa1cZcwOEG8Xlg+QScOcM4brVZBi7C
         MsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I638lmGpxhMQgK17XeJxyr0MLE6uWS7TV8BxhN/H/zE=;
        fh=tlfhQZnFbX9ceszFVPegJK6YF+hWApfmRG5frVC/WsI=;
        b=jE4QFLXD5PqfTJcypD0oobskbK8+WUk4holg1a7Lq5v8Tf7eKLXKGzLD0ZsbMfoMj9
         LXY+3IBkzbIO5cn4oMkWRFFltLp05gPNS86Xc8dqir3YE66v6w93y7CBTCEbGDXRRRJO
         0E832x6wTvacMuKlCcoeV0Vp9ur3RCaOoDiAU8FR2T3XrFGEqjXfXnn7X2LarzCP+TU0
         bz4Mf3DcGCWKNI6YsPsHCNITpk+J9IxUMgp9acUIz1r9wzqcM3JqkFIvcjlp7s7HwqDZ
         NSJkdjVDlpHuYj/xh4MczYkN4tMuPvfNJIdLfr3QczwMFy+EgDvFoMCZ8OjN6Dc+ehcF
         v8Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774719642; x=1775324442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I638lmGpxhMQgK17XeJxyr0MLE6uWS7TV8BxhN/H/zE=;
        b=E3aAr2ePWzfpPSv9Q//X4G2lcU8vHABm4Vh+GoDmOunHiCfHalu0s6r75UyWeiWnlR
         5y/SMDhipdZr7ej9PV4icxSMxw0lzfp/kWB1IZizlyUiJuyH/sPrMDVaDkKk/Koo2hM5
         HS6zIOBBT1JDvYS/CjMpH/suDSHYXOFW/99EFNSVRnF5kY3hOeifcNWdFCoNkwZ5pis+
         L8SjMeDaYP5jUB/5QtfgTirZ3g1buJDgCUobOPOi+KrpGOPjs4bXWpsWORrGwczEAnsF
         LxltE478s+qlrSMFMFVX9v5t6nnGLMNdmzxU46EQTvV1BZ0rs65wxxtvLq6TSOvD7c4y
         nL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774719642; x=1775324442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I638lmGpxhMQgK17XeJxyr0MLE6uWS7TV8BxhN/H/zE=;
        b=hTCz8TZqBKPqBUyCDpSg3rFyjl3ZCcfs08nCE9dsXUUsJr1n4hMTg6av0toLYBRhxf
         AgTeQob4vLfeHgdnhEOHlhxGCZwaRZWZi0xP7q0hgk6mGF9TFmfa/uc8BgPilQLlKeCE
         ac6M9tR3WJ9ogbm9Wn9trZGdVy0n1wr0BWGX9gadBOlvCAFOZcF1kkcmVzSGBfRxUdZX
         W8yH+TrFRZIFIDFojsx00y77VOCURZ4jCMzUPKgEtMOIzCZ/nZ1C+PhRFxrKwFgVvITJ
         VEtH4t2lSdjDtEZY3nanYIhT5Wji9+wj7qGWw9HwADl2lM/tkqGBPQanA0ODbZWmeMDa
         0a0w==
X-Forwarded-Encrypted: i=1; AJvYcCXLvjZ93vajnP6mTb+BCuUestshOmqzYLAjHYBWEdFVM895fjFMi0yUC9pH2I/HlsxmYV3t6UdsHhsxNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEuVap96m2HxRFXjDVZKTS/xd6W39h5suJtWUvpyjkKn2IE3EP
	iMMFj/q/lq4ao9da+gKbQE4rlOgcTMbdFHr5IOI7HKCK2aZk23ZkpL/8Hbc/vzZOUASVupOWoVm
	t8Dr7jhhgM3Alr/2gAl/5ui17X+zvjZ5asoyA/fnBng==
X-Gm-Gg: ATEYQzxcuf3rKYtD3xDrdiI3EuWT+EIlGd6n7IxMC3P5yoGo2AycDONzoxY2vGBgdTm
	n5qZ77L0ap3o5rG9Bfr45smRdLKHntYntOAC1R+jRbbJdPjImw9wEv+wg7qqHrMz9s5VRMLbgDb
	UGfL9DK9XEoUuVm2PJ79NAvPo0ArIfVEaWJDoS9n6FgIL2ILG1P6oUhrvQSDrrgf4I7B5L5RJbp
	qg5sZ/AXKOR86BN5wGaRa6u+y6wjtOpuJCGZuCHL5ZYpXCMs1JZgF/Iia2QDxsh+YoY5KTEHozE
	uEcqKfnR
X-Received: by 2002:a05:6820:6102:b0:67e:15dd:f6af with SMTP id
 006d021491bc7-67e1843bbf5mr1697721eaf.0.1774719642225; Sat, 28 Mar 2026
 10:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328134258.3206825-1-ming.lei@redhat.com>
In-Reply-To: <20260328134258.3206825-1-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Sat, 28 Mar 2026 10:40:31 -0700
X-Gm-Features: AQROBzA47TmRlPcBbnSImjkfPcy0oMBpNvJQZSl16INVUOmnZkXjNDKbCSnWCgw
Message-ID: <CADUfDZo2pbwTsp_uJcTG+GYyBFmoU-5UPYu6dvAguRfgB_QWCA@mail.gmail.com>
Subject: Re: [PATCH] ublk: use unchecked copy helpers for bio page data
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 6:43=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Bio pages may originate from slab caches that lack SLAB_USERCOPY

What is SLAB_USERCOPY? The only references to it I can find are in
comments in commit aa981a665d587 ("lkdtm: add usercopy tests").

Best,
Caleb


> (e.g. jbd2 frozen metadata buffers allocated via jbd2_alloc()).
> When CONFIG_HARDENED_USERCOPY is enabled, copy_to_iter() calls
> check_copy_size() which rejects these slab pages, triggering a
> kernel BUG in usercopy_abort().
>
> This is a false positive: the data is ordinary block I/O content =E2=80=
=94
> the same data the loop/nbd driver writes to its backing file via
> vfs_iter_write().  The bvec length is always trusted, so the size
> check in check_copy_size() is not needed either.
>
> Switch to _copy_to_iter()/_copy_from_iter() which skip the
> check_copy_size() wrapper while the underlying copy_to_user()
> remains unchanged.
>
> Fixes: 2299ceec364e ("ublk: use copy_{to,from}_iter() for user copy")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 06ba8b441e5f..5f4a53216619 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1322,10 +1322,18 @@ static bool ublk_copy_user_bvec(const struct bio_=
vec *bv, unsigned *offset,
>
>         len =3D bv->bv_len - *offset;
>         bv_buf =3D kmap_local_page(bv->bv_page) + bv->bv_offset + *offset=
;
> +       /*
> +        * Bio pages may originate from slab caches without SLAB_USERCOPY
> +        * (e.g. jbd2 frozen metadata buffers).  This is the same data th=
at
> +        * the loop driver writes to its backing file =E2=80=94 no exposu=
re risk.
> +        * The bvec length is always trusted, so the size check in
> +        * check_copy_size() is not needed either.  Use the unchecked
> +        * helpers to avoid false positives on slab pages.
> +        */
>         if (dir =3D=3D ITER_DEST)
> -               copied =3D copy_to_iter(bv_buf, len, uiter);
> +               copied =3D _copy_to_iter(bv_buf, len, uiter);
>         else
> -               copied =3D copy_from_iter(bv_buf, len, uiter);
> +               copied =3D _copy_from_iter(bv_buf, len, uiter);
>
>         kunmap_local(bv_buf);
>
> --
> 2.53.0
>
