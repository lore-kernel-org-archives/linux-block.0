Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D59421B9E2
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592950; cv=none; b=BhqoNn1E+h0YKV3HhmgzTr0OgpMibYKE7E70PQX90tOIgvNBigCAEyO3uQ02+J/Bl6Z/ZfyW6Wi7AVj5Qk2IlaoBkQAffDYi/kRcIhDGXTaFVbFyBohF2wGQNxUeIiwx0f9deCa7UulbdtHxn0mXT9Z3tKmILCiFMPM2UKJp+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592950; c=relaxed/simple;
	bh=D6iAu8L1VO7kA4h6FHt0EEgtjr72dxb9b/Pv8UYH5l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DN/fIO07PaXnWma8dvLo1+TUDtEkm4wOdgJhb1lwaUYQxFwe9MBmCl7AlxIA7mYBjzUxIVhNvKhKjAf5MPKyLgyWwRELNhEjZHghu2QZd7m+f9BYhiJ1NPMkE/AAFPX+A/VI3ciIGiiC5gKTYKGJRoCPAUCZqA9BCle8qhJy/Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Juig9s8n; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Juig9s8n"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b34abba1e9dso161686a12.3
        for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 08:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1752592948; x=1753197748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IESJUyDnVp+QVOw+cllX3D8uJpQcmQddZzYwpHDOf9c=;
        b=Juig9s8nb0v1po0pacHlf9CN0Y6TFmwn+XzqVRWjmEcW5Zol4yx7DUWR1KMrnSYmm/
         Jz0cA5dmw6O+spXaIbzf6BfLz2NV0uRhT1qbwfoN0LhWuCzuEE8FwnM5x9NX3SIH4xul
         t6ODQM5UCgkFh6gqOca9vO/tdieAX5kn4l5NLcZwGRysmxXX5oMDt6h1ZzCl1yTAZWxL
         S0ekWptEF7vHQAgVKnO1a7z/lML+6Op9VggRNWtLScwIeooNGICK+XUNPnpv3tWfBX5M
         lxxnlkeuF8PRuT7SFWgxDjrTZXCT4M96uyWxiIZFqf+wuqMnMIpvqJStcwfvGQNCGeRh
         SBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592948; x=1753197748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IESJUyDnVp+QVOw+cllX3D8uJpQcmQddZzYwpHDOf9c=;
        b=Cxd+xn8cxCd68g5zE+Cd4RCt7DZX7rdajlRyeH9IQ26k5xSAgVgj6Y1SEP4/gkVlS4
         KAvldsYPHVhyWi15d2s0z49ee1em4cQ12LHkn9NKXXgVMi0P1/F8Nvg1onqMdo+Ys+0y
         GDuqTDRu0nj35timsYbI8WK/1kgAkKrhxgVPzsrS3zWUStvc1nRG0GQqWr7QA/qtIq/5
         hgNNcDt2TJmRq+ptwl8zvE9hkL4t9Ss4Pt2PWmZMYKonGdzXHYNV7XpQ6AsdGf2alkHx
         5RcZZ7WvO7FS4PfavChG7VmuyX7poyDwJMsLDJ0mcC52I7szdHbxWDyJokqW86vuB31a
         Aoyg==
X-Forwarded-Encrypted: i=1; AJvYcCXJYYCgaHB5SS4cKwRAxYecLOHL7TCV7OdUVbcYIvm2CIYje/BfPAM7g24e00kAv2b7xQc/kNTImco81w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8i87NZNmXtS/ogEJ9MtLBFCzKiG0YePIgd6upGAuUHFZyK7MQ
	+/EqYjuHSF7LikjLhvIhGZyAWVRWza79R2jsIs4dlRORTEnZjMHON1Y8jfFxN2vEkftn/S3GwKm
	jjjbIApIQzB1ayG7uSONWALZKdskxrMD60tXWY3TbsQ==
X-Gm-Gg: ASbGncsiAmEeTayljNtZc/EWYaNth+x1CexPEzyuYlapWZNZ+mLLzld8rd1YGt96u3S
	i/YtbFxMcNGllCFnPowIWgAO8hxdiJlXbNnVXCKNC/XBx/1wQ50Vjacavz2Kk809g780tL3WHXB
	GhzZiR82m/sHi/nsMm+A6iz48zAww8k8HQ37mza9opqWLEI8PKc/tnyQccmSOGiOp5ZvmmVOv24
	4ckyuU3xdTytF3N
X-Google-Smtp-Source: AGHT+IEOBub69eMd2SCcCaBB4MeGXPvujR11IrTfvaPWzK+EBLRoWon26g+68F1BlZNe5Y7r7XReC8Cwszkaa2NAbJo=
X-Received: by 2002:a17:90a:da8d:b0:311:e8cc:4250 with SMTP id
 98e67ed59e1d1-31c94d270a0mr1277482a91.3.1752592948343; Tue, 15 Jul 2025
 08:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713143415.2857561-1-ming.lei@redhat.com> <20250713143415.2857561-5-ming.lei@redhat.com>
In-Reply-To: <20250713143415.2857561-5-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 15 Jul 2025 11:22:16 -0400
X-Gm-Features: Ac12FXwvl6uEo-s5cleUzAWQfpBfAApkUbowqDE5Qi3BPAaAi2SRJpOrzjOFcMQ
Message-ID: <CADUfDZoY_ezThviDK4nNWgBx8XePq06UhJO+M1em83o2ebMkjw@mail.gmail.com>
Subject: Re: [PATCH V3 04/17] ublk: let ublk_fill_io_cmd() cover more things
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2025 at 10:34=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Let ublk_fill_io_cmd() clear UBLK_IO_FLAG_OWNED_BY_SRV too.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> ---
>  drivers/block/ublk_drv.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 73c6c8d3b117..f251517baea3 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2014,6 +2014,8 @@ static inline void ublk_fill_io_cmd(struct ublk_io =
*io,
>  {
>         io->cmd =3D cmd;
>         io->flags |=3D UBLK_IO_FLAG_ACTIVE;
> +       /* now this cmd slot is owned by ublk driver */
> +       io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
>         io->addr =3D buf_addr;
>  }
>
> @@ -2229,9 +2231,6 @@ static int ublk_commit_and_fetch(const struct ublk_=
queue *ubq,
>         }
>
>         ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> -
> -       /* now this cmd slot is owned by ublk driver */
> -       io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
>         io->res =3D ub_cmd->result;
>
>         if (req_op(req) =3D=3D REQ_OP_ZONE_APPEND)
> @@ -2353,7 +2352,6 @@ static int __ublk_ch_uring_cmd(struct io_uring_cmd =
*cmd,
>                  */
>                 req =3D io->req;
>                 ublk_fill_io_cmd(io, cmd, ub_cmd->addr);
> -               io->flags &=3D ~UBLK_IO_FLAG_OWNED_BY_SRV;
>                 if (likely(ublk_get_data(ubq, io, req))) {
>                         __ublk_prep_compl_io_cmd(io, req);
>                         return UBLK_IO_RES_OK;
> --
> 2.47.0
>
