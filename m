Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FB23191D0
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192050; cv=pass; b=a7Yg3YR2PIpFaP+N0XIdi0JAd4LyTtxGKMeCHNVdm8N8U1HdcnloXLmlNB62CI4lhxQOqOmTLgD3eVTsR+mbirYkAPKT3FoVHAfrH3c+pzCb51KLPtJYfzvzspTyJ99H/d8G2hPo8GGhJZJ6dpg/4FOMk38PzHXIDXMaveh/v2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192050; c=relaxed/simple;
	bh=Vcjw23Z7V74nESKjyETVB+4i3FsrvEdVkIzgHF+j//Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDj4MxC9HzLJD+75GRgBd6yT4rp2Zprw5AtwKBUktV6uNlaM+1jQ6BPXq3Gu+h8PpY74tGP6sFbqtvtdeeblI7XiUBkLguPWldMMjC2Pbs68qzYU28AXQJWrrIVqcF90Iv97VXk4+u1wVOpwzAPa33xKqaCnEv5KRZaaNQPcgOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=buGNi6iQ; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="buGNi6iQ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbbe75715dso376177a34.1
        for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 11:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776192047; cv=none;
        d=google.com; s=arc-20240605;
        b=WXue3AnGyc8omR04FROjRRkBzTlhoFW7mDloxn4ewLJzRQEB2kH95xTh8mqpuVZTfp
         Dxqq+Eqp84aQSXxCXW/fjjv5UiNuen6ZJ4fv/181+OhRaerbVHGLF9eOfp49EMo+DopW
         m+y/9Z7vO7h9GlA1LPW19l0oJrpt6rJ/VO/YyxigNwrTJwegNOlBfBwUD9yqPB/TBkBd
         UB90nj8pYGRnUhqC75QZzmuSJZxqgR6J/nmjjhv9KzTMTo/VrnXIaA00NsEnKVwZezcS
         jLHmoeuUG4jKKDWIJQGjmnSTI8/lJ7y1TL7+22nW+rSnFaclVROSD5JrRjK0E2K4SvsG
         +Vug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rP/4MPEUmWx9OpXaulOc3Zk9q1qkszY88LqHXhg7+jE=;
        fh=9BsCpgVrDBKX3gvyFR9uWzU9CdProW5v6UqKxOCJDqY=;
        b=B4+CEP+Gip2eg7bx44G+6hhKxFJN1sX//VqMFwTfVHeDFdbVnrzirXG7xwULRcP8Lq
         pSWZmrxNxoudBiJSLD2Dr4Cwg4O/0uaMCsuvQSZ6SyU+sbUpxxRUNjhF+iKKUF20SDZg
         Yu+0kEVWs4ojpmRib14BOjJWYX3Hv5ExuooLKlE+fBgv1hYMSvcX2j2AJuVA9L6gO4Vt
         rs/9MX2DMaUMVjxOlkbNhHg3f2ozRObRZ+DNrTDAk/zaXY8yv72yBuAUKpBbQzkLvEd3
         3AtMQx8C+W23wIg690VZ5LH6BcZAuDiKj3pO5dGbEjTZhAT9ixW12mqtraSn+hS7nkOk
         NHyg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776192047; x=1776796847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rP/4MPEUmWx9OpXaulOc3Zk9q1qkszY88LqHXhg7+jE=;
        b=buGNi6iQ4VCDunEiorjqSfHza4jxFT3JF+nmOITHGv9358qZgVfKSMg11nNLNGSL22
         b5DRJ6drL+mSUmwFcjGxwQLQ69wRgwfbWSZIEErbUU+iuMC/C8zjXZTUFi51yuOx9Mnd
         o52SfIX9ltC8gkjq6qHycIeax2FdV2pZXhhrRJVZIhLcPzj4zogXCG56Eh1DlqWmQXfx
         t9QBAd3A5KhnIMZVWhdqf3RL0uF9UUCsYjxEPp9lfQZh9OlbOQRXYkFZh8LsUQ1PnFDu
         mkVvssmml0ZMFrVVIF1B4hTIlQKUHA+99MY6IW2efXjvuGRyfvpnFsal6R+orDls2o4U
         OipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776192047; x=1776796847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rP/4MPEUmWx9OpXaulOc3Zk9q1qkszY88LqHXhg7+jE=;
        b=FJgiDYdMdia4nfhIbfZLV00N6BddJ3OZSs7lgQ1L6vSGViMR2AoEGvzmGS4+9EchvH
         4EV/F16aJ9Q1BcZCxO0SV3r2XZmi/drI+qfLEfyvTDKCeoiAfaTX9p2fdqOFzFNqKYOp
         0coz3vXrh2jx54Edo4lH8g4DrmSzz3F2e2kkdvhaEGNNHNrsXnXYuT+u6DaKrnjNPwfP
         nGqpE544xeXkEDvs56p5hjY6GGBOGHZyBkW0Pejd2JrwSm6oa5NnOvEuHhx5cxr32Ula
         01MrWOew/vO/uYGZuf1FRq3J8QVXt61HOt3fBpZ8ilsF8MLtmQobD9ZAZhvj/epd+cG+
         cowA==
X-Forwarded-Encrypted: i=1; AFNElJ/EwWt1QOuvw6d2wa06g3sIEtJei31EwK+2yWKJ3N+5WaMd6EcYE9jg29dc+u+shobUcj5/ofqRi/+N7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSL+GvHA8v1CV7W7zWm2vSsO5IKs/lUnSnU+PTgeFNVb45lOT
	3DlR7gxx1eySH5Rd/OikgfoDIv1+1ZST6DlXReu7Y65clCm0LsYBQEZ5jrIGgjqDu407CO5UVaV
	xdbziKKucpC4Et3qEdQ01dfF7gC3nzML75YCmagNssg==
X-Gm-Gg: AeBDieuNvisdaZfE+KFoW9Io6H+/4SdRnqMxjdJQnUXhCO3lcT0usLzgEwy4boyG0YS
	VD8RTc07JAFOeG3mufsF2rHnp7iFouho8Ec7DmUpH/7CuscrHin5ZIenDIORCghCUK2XLIQ0f8x
	70SorQceFNWVNSeylCOOOBsUydyGP2a2c2p7QHSJ7Rf93dkq0D2G1VLciHZ1a7+qXoyOQT1CHZN
	TrTKes9iS0FXg/0nLhMjJvdh7ojkydNFRGIwAwCRNuRKk6m2tWJUg1+UXx6ukRyHzRs3Xsg3tEZ
	BJyhTeQnSKEeonPl9Z4=
X-Received: by 2002:a05:6830:43a2:b0:7db:dc9e:f17e with SMTP id
 46e09a7af769-7dc27f9fa9fmr8323460a34.5.1776192047408; Tue, 14 Apr 2026
 11:40:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409133020.3780098-1-tom.leiming@gmail.com> <20260409133020.3780098-2-tom.leiming@gmail.com>
In-Reply-To: <20260409133020.3780098-2-tom.leiming@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 14 Apr 2026 11:40:36 -0700
X-Gm-Features: AQROBzA3X5qi0Ke7IcbgSfWlSnNVJ9izV-e9kp4Va8BADZ21yf7DT00cE1vwtAs
Message-ID: <CADUfDZr39RaLObyXg9sijCOpLF4K2+TZH3ygGiCVxO8aAqwTkw@mail.gmail.com>
Subject: Re: [PATCH 1/7] ublk: widen ublk_shmem_buf_reg.len to __u64 for 4GB
 buffer support
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 9, 2026 at 6:30=E2=80=AFAM Ming Lei <tom.leiming@gmail.com> wro=
te:
>
> The __u32 len field cannot represent a 4GB buffer (0x100000000
> overflows to 0). Change it to __u64 so buffers up to 4GB can be
> registered. Add a reserved field for alignment and validate it
> is zero.
>
> The kernel enforces a default max of 4GB (UBLK_SHMEM_BUF_SIZE_MAX)
> which may be increased in future.
>
> Signed-off-by: Ming Lei <tom.leiming@gmail.com>
> ---
>  drivers/block/ublk_drv.c      | 9 ++++++++-
>  include/uapi/linux/ublk_cmd.h | 3 ++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2e475bdc54dd..ada9a2e32ea9 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -63,6 +63,9 @@
>  #define UBLK_CMD_REG_BUF       _IOC_NR(UBLK_U_CMD_REG_BUF)
>  #define UBLK_CMD_UNREG_BUF     _IOC_NR(UBLK_U_CMD_UNREG_BUF)
>
> +/* Default max shmem buffer size: 4GB (may be increased in future) */
> +#define UBLK_SHMEM_BUF_SIZE_MAX        (1ULL << 32)
> +
>  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGISTE=
R_IO_BUF)
>  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO_B=
UF)
>
> @@ -5351,11 +5354,15 @@ static int ublk_ctrl_reg_buf(struct ublk_device *=
ub,
>         if (buf_reg.flags & ~UBLK_SHMEM_BUF_READ_ONLY)
>                 return -EINVAL;
>
> +       if (buf_reg.reserved)
> +               return -EINVAL;
> +
>         addr =3D buf_reg.addr;
>         size =3D buf_reg.len;
>         nr_pages =3D size >> PAGE_SHIFT;
>
> -       if (!size || !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
> +       if (!size || size > UBLK_SHMEM_BUF_SIZE_MAX ||

Should be >=3D? Otherwise, LGTM.

Best,
Caleb

> +           !PAGE_ALIGNED(size) || !PAGE_ALIGNED(addr))
>                 return -EINVAL;
>
>         disk =3D ublk_get_disk(ub);
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index ecd258847d3d..66d93efccd51 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -89,8 +89,9 @@
>  /* Parameter buffer for UBLK_U_CMD_REG_BUF, pointed to by ctrl_cmd.addr =
*/
>  struct ublk_shmem_buf_reg {
>         __u64   addr;   /* userspace virtual address of shared memory */
> -       __u32   len;    /* buffer size in bytes (page-aligned, max 4GB) *=
/
> +       __u64   len;    /* buffer size in bytes, page-aligned, default ma=
x 4GB */
>         __u32   flags;
> +       __u32   reserved;
>  };
>
>  /* Pin pages without FOLL_WRITE; usable with write-sealed memfd */
> --
> 2.53.0
>
