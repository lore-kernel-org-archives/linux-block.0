Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3289B25392F
	for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646075; cv=none; b=q5fHDswpXdV0sGaP2Fp/hNiWkytcW4iQtF6Tv0k7PJyTBmVWJ3DSnHKUtk8qNJXN5wTD9Dkr7IJP6OyLrn7zQIiXTy/Ea8wyR0jLN5HKy6iTtgbP0lgUlKz1C5p4ger9QiC/AxIGnDxl8AvUdSZ8bjRpK7vhJdLhpKBsXdIIh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646075; c=relaxed/simple;
	bh=7sFT6Bfyyx47wJ0e7rj3fuTZw5+eRaE5Un8vZRCYs6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EpYFR5ftPoXx4HUtix2wLjKoNtrc4bIDxiAYCwY15tFurQOhZbdupFjshr2MxcCwrJo54RbEg26BYM8wmZmIL4mfsUnec9Gvkf1W/4YgV9jQM/T0652BqVzyGy7PMnqdGaqwrJW1yjYxT/dUbt/8tQhDxNMkPYKUBvKCLaBUwPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FuNNpXgJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FuNNpXgJ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-308218fed40so711157a91.0
        for <linux-block@vger.kernel.org>; Mon, 14 Apr 2025 08:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744646072; x=1745250872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/voBXv1jPBYNgh10o5cVLqacDgRHfBHPOVCmFKarT/Q=;
        b=FuNNpXgJ1AdVOe+PdIfSRlxnUUZ0Ts/wbR1geCQTek+mbpFYlBVpHW7wCdjh+dnruf
         3o0IY4DktKQe7jhJxPXYuj4cBLBOhOiiX7avgKtHRZRDxg2JOR5idnD3uRtcDs6LOLTq
         gyzoPUu9MvYXt9DL/W4N6PLwsrSVG0Zl1T0ExnQsDiF2jPdi3F5Btm1uiX/v4hkyT/7x
         j4k+NDHjWcHvQe3eo8EOK0Wowae5McDpEF20W8J6DbHLHODsx849IwdTZYJ1kh+7NyQ8
         i7LUay6GwSPAGRqSOEKg7zFDytc15462RD4c4GYvdgAOrlX5WGIHxxMFsg+OqlJCEuWt
         V5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744646072; x=1745250872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/voBXv1jPBYNgh10o5cVLqacDgRHfBHPOVCmFKarT/Q=;
        b=umwjuYBepoXeFO5OKNJWpqpl6OjirDRVffzHpi8pKS8HEorxvOLigrjyBEkAZ199KD
         gsuk5svYdf0ltmdTYCuRFBoDnjsD4Ubb7rwSN6ZKQAwTmtrdfk2JzEcnuG6De9q5hHN8
         qQLwO/PgqUcVSLH+G9limpbMvENsQyPy7EfwJUkPpVJNf27n5mXIO8B5343tDnNtis9V
         UxSGDuBKiuPHo0Dtm2wKWHqxv1t2wQ0pnhHJuop22lp3IY16gAvviOH0lCtAONMC4Rq1
         j1BHB8dmu/+KRiTGNN+AkiQRY22c969Vup7Evf7W9volg58RMKPvjFLUmD3jSgS77N9L
         8yPA==
X-Gm-Message-State: AOJu0YxSNR0coISzDv2A3t4hu8EIqNs+bHZFxuj0+RLG9f5cLaGMulLg
	bGP1SVJN0cR/CQzWdMjIBdcJmQmdmWHA0ck7ekpKf0OZbNrLdWVM51QB4WRFKvD8EBmGhrGy69P
	1PT6PDgFVnXLfIRhRYsrGAFo9SNn7i5+7O0jA8g==
X-Gm-Gg: ASbGncuasQemAeFlPEesHNnJJ2qOTVkLFUuBj9nfGGpAcxRbkJ+EyOFEEw8J40Baf2G
	fbnjYIJnfw3CVPSjaqcKVgWjEbeUM2w7y93yfPDtqGvOMxpWTZcO1yApM793EshbZX5hPhMh+wc
	Ev6Mh5WYJp+m7nSAWlOIZQ
X-Google-Smtp-Source: AGHT+IGyWUu8BPK6mkWBsaoPUflPkj62vHdswuSKCWvB1OYGkj3ObxvNABmsCVNNTIzXSQDl9c9MqJLMD6SGbxPt25w=
X-Received: by 2002:a17:90b:1651:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-308237e291fmr7274110a91.8.1744646072165; Mon, 14 Apr 2025
 08:54:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <36ba7ff3-ff0e-4db1-acb1-8e7a60a427cc@nvidia.com>
In-Reply-To: <36ba7ff3-ff0e-4db1-acb1-8e7a60a427cc@nvidia.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 14 Apr 2025 08:54:20 -0700
X-Gm-Features: ATxdqUH8tHGydr7RfzCpMdkenPlROHUWsyRaFkz6aXEyiBtvUv4Ws3gUshFcOkY
Message-ID: <CADUfDZpq8PMYC+q2cLN=vz+7ewW_yR3O_282xC7C0k9EZ-bMoQ@mail.gmail.com>
Subject: Re: [PATCH v3]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 4:45=E2=80=AFAM Jared Holzman <jholzman@nvidia.com>=
 wrote:
>
> Currently ublk only allows the size of the ublkb block device to be
> set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
>
> This does not provide support for extendable user-space block devices
> without having to stop and restart the underlying ublkb block device
> causing IO interruption.
>
> This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
> ublk block device to be resized on-the-fly.
>
> Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for
> this command.
>
> Signed-off-by: Omri Mann <omri@nvidia.com>
> ---
>   drivers/block/ublk_drv.c      | 19 ++++++++++++++++++-
>   include/uapi/linux/ublk_cmd.h |  7 +++++++
>   2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2fd05c1bd30b..2a8d8b864ef9 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -64,7 +64,8 @@
>                  | UBLK_F_CMD_IOCTL_ENCODE \
>                  | UBLK_F_USER_COPY \
>                  | UBLK_F_ZONED \
> -               | UBLK_F_USER_RECOVERY_FAIL_IO)
> +               | UBLK_F_USER_RECOVERY_FAIL_IO \
> +               | UBLK_F_UPDATE_SIZE)
>
>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                  | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -3052,6 +3053,17 @@ static int ublk_ctrl_get_features(struct
> io_uring_cmd *cmd)
>          return 0;
>   }
>
> +static void ublk_ctrl_set_size(struct ublk_device *ub, struct
> io_uring_cmd *cmd)
> +{
> +       const struct ublksrv_ctrl_cmd *header =3D io_uring_sqe_cmd(cmd->s=
qe);

Can you pass header instead of cmd to this function? See my recent
commit changing most of the other ublk_ctrl handlers:
https://git.kernel.dk/cgit/linux/commit/?h=3Dblock-6.15&id=3D843c6cec1af85f=
05971b7baf3704801895e77d76

> +       struct ublk_param_basic *p =3D &ub->params.basic;
> +       size_t new_size =3D (int)header->data[0];

Why cast from u64 to int and back to size_t?

> +
> +       mutex_lock(&ub->mutex);
> +       p->dev_sectors =3D new_size;
> +       set_capacity_and_notify(ub->ub_disk, p->dev_sectors);
> +       mutex_unlock(&ub->mutex);
> +}
>   /*
>    * All control commands are sent via /dev/ublk-control, so we have to
> check
>    * the destination device's permission
> @@ -3137,6 +3149,7 @@ static int ublk_ctrl_uring_cmd_permission(struct
> ublk_device *ub,
>          case UBLK_CMD_SET_PARAMS:
>          case UBLK_CMD_START_USER_RECOVERY:
>          case UBLK_CMD_END_USER_RECOVERY:
> +       case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
>                  mask =3D MAY_READ | MAY_WRITE;
>                  break;
>          default:
> @@ -3228,6 +3241,10 @@ static int ublk_ctrl_uring_cmd(struct
> io_uring_cmd *cmd,
>          case UBLK_CMD_END_USER_RECOVERY:
>                  ret =3D ublk_ctrl_end_recovery(ub, cmd);
>                  break;
> +       case _IOC_NR(UBLK_U_CMD_UPDATE_SIZE):
> +               ublk_ctrl_set_size(ub, cmd);
> +               ret =3D 0;
> +               break;
>          default:
>                  ret =3D -EOPNOTSUPP;
>                  break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index 583b86681c93..0e40e497c28f 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -51,6 +51,8 @@
>          _IOR('u', 0x13, struct ublksrv_ctrl_cmd)
>   #define UBLK_U_CMD_DEL_DEV_ASYNC       \
>          _IOR('u', 0x14, struct ublksrv_ctrl_cmd)
> +#define UBLK_U_CMD_UPDATE_SIZE         \
> +       _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
>
>   /*
>    * 64bits are enough now, and it should be easy to extend in case of
> @@ -211,6 +213,11 @@
>    */
>   #define UBLK_F_USER_RECOVERY_FAIL_IO (1ULL << 9)
>
> +/*
> + * Resisizing a block device is possible with UBLK_U_CMD_UPDATE_SIZE

"Resisizing" -> "Resizing"?

Best,
Caleb

> + */
> +#define UBLK_F_UPDATE_SIZE              (1ULL << 10)
> +
>   /* device state */
>   #define UBLK_S_DEV_DEAD        0
>   #define UBLK_S_DEV_LIVE        1
> --
> 2.43.0
>
>
