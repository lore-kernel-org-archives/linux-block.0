Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1433B776C
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819007; cv=pass; b=VoTIy0WGiMf466kXgCWlt2yjVFXtSNtGi1LkLPPTtJu9XSua9p/b/2LPJdDev7YT5SuoTTon65Mp72Kzh7eCmIy5CPgOS2apl9mBG9Tonf3WYJbf3zZY/+rMZA83kBoqD1XHjgMQcuftwvmTMTKgqPSc5U9N1p7pjJN3tcMUY8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819007; c=relaxed/simple;
	bh=MrbwzFNqjMIOLhoJfecFvvakYx1xgE9jvaem2D7B/aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsDbfEsGh3CyZViolPoKVq1O26n8jC1E6CCULrfak9CHzY7bK9bSLEmKwhTNz8V4Y8h/MEnuTrSkE+HuxBxFo2UI3Mm6E/w45Z4nLCO/b4u0Dp0ONkrlLWfxgUDsaaXN+8UscYWYT/Kh6VWdNWIF/fdBkb7nI+l9W+dhVMcjTDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FnADok/+; arc=pass smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FnADok/+"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e5f812619dso232551a34.1
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 11:10:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779819004; cv=none;
        d=google.com; s=arc-20240605;
        b=AlzHr6tLcEs0/5GID4f4O0hFMRV2u8X0HR1C6OA/FSWBU4MOHDYqWlaIMtLduMUWO8
         oGQa3xJ2OP67txDW6LF2KGyjIiPLT8+2WPhEx3UvP+AwPl8B/LTPvpDlU+uB6yGKmpas
         knAdWT3hmnwhRJdULpHFbmt3UyjcCqdkb0AHfcwx2+3eyi+xnJK93bXgDj7EwRbeZiYh
         iV979VIlcbV+7Aefm5ppw9I8JMWKFtPDu5GgEcRsBjxecksNk5cwLcebOLl2s3jZs4zf
         Pa8MLNOZaql8LCTmIBUe6JiRHb4WOpXjFeyEZ9YwVfiZ+215Tp11aG+GaQ9/UYAMPc90
         Q8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BHxc1zDO61V3Z4wRHfTslCCcmY1zg5MFafEGkaMrBHY=;
        fh=C7yAdiEYheUYFXjyxxrVkx39iaH2XL4I74VKQSV/e3w=;
        b=CHn4onJErZEhQLtuhehsGjoCwbaUz00L7T1PUKVuIfYC9JOUbQkofD6PjZ+CQFXMEW
         arZlqEi2xEu4FyVaqudfeq4QY4WGeCQo5kVYBX9x8AUK77azgDXyBE/3HSStV7zVKKbt
         SMRdXPB/UcSVaOmqU0WWqry5eg+kiQT7UdTP4xJfMi1QJ6Jh257HHMiPVj/NPGkuIR/8
         T7v/4uN4zsv3cHDxBTPrynvAopuLZtHD81pXQplHyhMVpdCX9TdNwTcOnJloLa+DCKqn
         vnXtlYpp/zxUId/8LakgwelTOE2T48nfc3KKJCj4+fHKU6T+iegg/el+Dmh4zcIptWH3
         bbOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1779819004; x=1780423804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BHxc1zDO61V3Z4wRHfTslCCcmY1zg5MFafEGkaMrBHY=;
        b=FnADok/+KA9RKNjrKtyqlTyBfJGhMZBZJEhzpN2S/QfTJ05ehAZL3hqreiO2sEBjCI
         9D+K2L/T5qJI9AM2oGqF2ieicTSEIvQ8HhDhDvrMNCGewL2zZqhZB6fJKIRJYEqPMeLf
         ErdqD6XoKhMtVsBK5jLaG+OuGh8N7W47gSSFyuzytukjxaO+euJ5QuUNAUtDXU4aYnaz
         sWbrK/b9vreiXPRSZ4OrVUcRlwxqZpTY4VRdS/P26mt+Bps6o2ojWbV8zFpOfmuVsMJ1
         IAf8i7h/VQJ+WRb2USHxbjCsWDPwefN8gm79ZZxaLbqVQlDao9C9w/L5adEk35bR9mOS
         CqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779819004; x=1780423804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BHxc1zDO61V3Z4wRHfTslCCcmY1zg5MFafEGkaMrBHY=;
        b=dwBdMSnU88iMXy70pB3ibHx+lnFQbW384nLZruv4U8NxYcEVMfjBeORNuizSEbxydV
         mbut4Hzz2bXe8zVHBbBg2VOVgeSJCN5PuPuPw8bPWKgFgG5juihM+3Cf2L0U5vQZn5CX
         qbRd9HGiMPkEu/4+JJB+fUXcAflTHh/rpbYLe8ALTizAmVctuVuQ4e57SEOWlUtXi4iD
         T6f4nClZk0CrzQvA8rH0CEQA+L5RI4VRsQo4yLJnNdIPcRnQepV8ax5CALhbfuSydfu2
         4IgSdbn137o2dXeZy+l3cJ51dei46MQ0nSnCMnMpI/3LGHGP5dZ54TAQCwOeH571RMAH
         tW6A==
X-Forwarded-Encrypted: i=1; AFNElJ9Bg+d8/2e0clJso8rFzU0pYD9A/U3hv5Bfau0rVtwOeWaana97WPvDtG01jK6aY5wZPd/s9YLq3cJTbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHFBhVRFfWgbAr0HECf8anJKu3/DgI7O1adGNFaHK6+gm5pqx
	3BAcRGwSl0k5b2PlUIpgRfP7DmYemI5Oxea1SJSovYtmF0FxlgVEwSADnZg37Kj7OA/H1GlGoXi
	UK7qITVoFh34v9PfUwy2unTJ+iFEtHEjOc8i/eGWyrQ==
X-Gm-Gg: Acq92OGsyLM9LT/gowDAd4LLPMHGC4LdAiUUx5FIxRe5VUqmadMZXE/sP6IUe2MQG6G
	i0TI8RD9edB4c+rpY84nbXt89Ilmz41gNMjhVmJvM5Kl35X04n2b6uF8VzDuw4LDvrBhPTmCJTg
	fB5v4lTMYqbn891mJdOiBEv9VWbOpNl4955+aVFSQM1dW+Yx8cGpIo6PuKxt0XbQCzM/rX4z/ig
	TYQ5aUTdDpUj/eDYLYcaNI5n5Yl0OGTtQUWYNTQDy5frzj1XcWA8qe2Uk49kD2ZqsM6TPTNY/pX
	TM3gYXI=
X-Received: by 2002:a05:6830:a8f:b0:7d9:b2dc:334a with SMTP id
 46e09a7af769-7e5fee9eb96mr7175624a34.3.1779819003631; Tue, 26 May 2026
 11:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526070042.1817997-1-hch@lst.de>
In-Reply-To: <20260526070042.1817997-1-hch@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 26 May 2026 11:09:51 -0700
X-Gm-Features: AVHnY4IRLcYnCjR9E40iQgZ2bqE9n7WhAapD9iHGH21LcobRM_qbr3tc7AD_k1U
Message-ID: <CADUfDZqWFWsLwuTwtXQg8zfYAumTqjVDsL3aH3cpKN599SUQww@mail.gmail.com>
Subject: Re: [PATCH] bvec: make the bvec_iter helpers inline functions
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 12:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> The macros are impossible to follow due to the lack of visual type
> information and all the braces.  Replace them with inline helpers to
> improve on that.  Because the calling conventions are a bit problematic
> with a lot of passing structures by value, all the helpers are marked
> as __always_inline so that they are force inlined.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  include/linux/bvec.h | 101 +++++++++++++++++++++++++++----------------
>  1 file changed, 64 insertions(+), 37 deletions(-)
>
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index d36dd476feda..f4c7ec282ac9 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -104,51 +104,78 @@ struct bvec_iter_all {
>         unsigned        done;
>  };
>
> -/*
> - * various member access, note that bio_data should of course not be use=
d
> - * on highmem page vectors
> - */
> -#define __bvec_iter_bvec(bvec, iter)   (&(bvec)[(iter).bi_idx])
> +static __always_inline const struct bio_vec *
> +__bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter ite=
r)
> +{
> +       return bvecs + iter.bi_idx;
> +}
>
>  /* multi-page (mp_bvec) helpers */
> -#define mp_bvec_iter_page(bvec, iter)                          \
> -       (__bvec_iter_bvec((bvec), (iter))->bv_page)
> +static __always_inline struct page *
> +mp_bvec_iter_page(const struct bio_vec *bvecs, const struct bvec_iter it=
er)
> +{
> +       return __bvec_iter_bvec(bvecs, iter)->bv_page;
> +}
>
> -#define mp_bvec_iter_len(bvec, iter)                           \
> -       min((iter).bi_size,                                     \
> -           __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_don=
e)
> +static __always_inline unsigned int
> +mp_bvec_iter_len(const struct bio_vec *bvecs, const struct bvec_iter ite=
r)
> +{
> +       return min(__bvec_iter_bvec(bvecs, iter)->bv_len - iter.bi_bvec_d=
one,
> +                       iter.bi_size);
> +}
>
> -#define mp_bvec_iter_offset(bvec, iter)                                \
> -       (__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_don=
e)
> +static __always_inline unsigned int
> +mp_bvec_iter_offset(const struct bio_vec *bvecs, const struct bvec_iter =
iter)
> +{
> +       return __bvec_iter_bvec(bvecs, iter)->bv_offset + iter.bi_bvec_do=
ne;
> +}
>
> -#define mp_bvec_iter_page_idx(bvec, iter)                      \
> -       (mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
> +static __always_inline unsigned int
> +mp_bvec_iter_page_idx(const struct bio_vec *bvecs, const struct bvec_ite=
r iter)
> +{
> +       return mp_bvec_iter_offset(bvecs, iter) / PAGE_SIZE;
> +}
>
> -#define mp_bvec_iter_bvec(bvec, iter)                          \
> -((struct bio_vec) {                                            \
> -       .bv_page        =3D mp_bvec_iter_page((bvec), (iter)),    \
> -       .bv_len         =3D mp_bvec_iter_len((bvec), (iter)),     \
> -       .bv_offset      =3D mp_bvec_iter_offset((bvec), (iter)),  \
> -})
> +static __always_inline struct bio_vec
> +mp_bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter it=
er)
> +{
> +       return (struct bio_vec) {
> +               .bv_page        =3D mp_bvec_iter_page(bvecs, iter),
> +               .bv_len         =3D mp_bvec_iter_len(bvecs, iter),
> +               .bv_offset      =3D mp_bvec_iter_offset(bvecs, iter),
> +       };
> +}
>
>  /* For building single-page bvec in flight */
> - #define bvec_iter_offset(bvec, iter)                          \
> -       (mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
> -
> -#define bvec_iter_len(bvec, iter)                              \
> -       min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),               \
> -             PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
> -
> -#define bvec_iter_page(bvec, iter)                             \
> -       (mp_bvec_iter_page((bvec), (iter)) +                    \
> -        mp_bvec_iter_page_idx((bvec), (iter)))
> -
> -#define bvec_iter_bvec(bvec, iter)                             \
> -((struct bio_vec) {                                            \
> -       .bv_page        =3D bvec_iter_page((bvec), (iter)),       \
> -       .bv_len         =3D bvec_iter_len((bvec), (iter)),        \
> -       .bv_offset      =3D bvec_iter_offset((bvec), (iter)),     \
> -})
> +static __always_inline unsigned int
> +bvec_iter_offset(const struct bio_vec *bvecs, const struct bvec_iter ite=
r)
> +{
> +       return mp_bvec_iter_offset(bvecs, iter) % PAGE_SIZE;
> +}
> +
> +static __always_inline unsigned int
> +bvec_iter_len(const struct bio_vec *bvecs, const struct bvec_iter iter)
> +{
> +       return min(mp_bvec_iter_len(bvecs, iter),
> +                       PAGE_SIZE - bvec_iter_offset(bvecs, iter));
> +}
> +
> +static __always_inline struct page *
> +bvec_iter_page(const struct bio_vec *bvecs, const struct bvec_iter iter)
> +{
> +       return mp_bvec_iter_page(bvecs, iter) +
> +               mp_bvec_iter_page_idx(bvecs, iter);
> +}
> +
> +static __always_inline struct bio_vec
> +bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
> +{
> +       return (struct bio_vec) {
> +               .bv_page        =3D bvec_iter_page(bvecs, iter),
> +               .bv_len         =3D bvec_iter_len(bvecs, iter),
> +               .bv_offset      =3D bvec_iter_offset(bvecs, iter),
> +       };
> +}
>
>  static inline bool bvec_iter_advance(const struct bio_vec *bv,
>                 struct bvec_iter *iter, unsigned bytes)
> --
> 2.53.0
>
>
