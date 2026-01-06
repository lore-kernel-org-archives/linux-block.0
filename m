Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E17130ACE8
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727648; cv=none; b=qFOPPpxjc2TKyLPq4UES1I0wxxKdKqkhnw6ZZgSm9PBDTFe2WiSfTFDQRPXJ4C02YE2x57BDq1sErkGHvMKrOcIj+r44+Awe2MJD81jgen4ow5jhUgC36JLIJPPbhDTLkRIBGMi9+areCSs/FZuDIWa7nOFRIoWT9CWUeVwBLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727648; c=relaxed/simple;
	bh=DlqtCno0bjjs6+3s9znq2ClxfskrOMByX5sx0+iODtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iq8EUTJns3PYWB3Ka0F1ZaRlVeQd9UnUwg5NSWoHsa8QNhMbPT4m5rplyRXTatw+yQjcPcgMkn4O49XfaZ6gKVEKQ5Akl3VDL4X8QVhUop+YGigjF6g6mnZnS7PlSSz+txhf3DuQ07yOeCzuEcAXs/GmgP+SGvmpG25dSRsFguU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XQ0jEAhl; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XQ0jEAhl"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2a49022ae5dso24148eec.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 11:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767727642; x=1768332442; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/K0DwEMVRZ/ca0pGE0HOHLBrCZlB1IkzNWU7xLxEng=;
        b=XQ0jEAhlh+mRzcvKgS00sPcPI+7T/HYQ+iLSFY1Dc78HLQqTE6oImTDEQIXDpkzmYI
         y1n7RC7QeqKxft7YzioU6194ZsvfJbdTYy2rCadHKrSdGGjM4XlIWTqfwN9KZ8fFgAC7
         30D8NGLvo62QSFrqJ+eBUzopROyMcsqdbc9xgppYWRvErQEoqeT5dDl3yJ4HE+Lq57Nb
         zal07CguGrDWsRiwq8t6nM4GPVOQEiHLzp4hJetf2myBarEdDFTmUfbxUiUwd4sPRsi8
         kKc9dZpdHMvFLi35SQ/V9m0raTzukUBgIyKYKB8YeAUI0CHk/Cd7PcRrOCZ+YbMD3Cx5
         TdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767727642; x=1768332442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/K0DwEMVRZ/ca0pGE0HOHLBrCZlB1IkzNWU7xLxEng=;
        b=fNhk5qKNpCQcxIlNJdXl6gECTKPqaglPcd8Kpg+iE0rV+mhyXameTtWS/Qzd0KBazV
         Ap+ZOT6+k23uHcbuViOSRTwLGCeMWCrgzTWvIGRp/g5DhFL6Wu7ZFnnFf2l/d/3ib9oA
         BImlTiRxsrhpR/2tkOpY1SWwKpfstsV1rDChlN30zPjnDiCpNZtSaQLc3zoTnPZ62elW
         PzxxZp2U0u0g/5sfFxcPFaYqRVIskY3KgWkhFV7WaVIvIDD5Mvi+dsz2ZxVK01vy/T50
         bZScatfoUckT4TEWfCtYf6W+v2P0RNiFZf+uNFzLMdAZn2SLbIas15tJ8aVT0odHD0QM
         uGGw==
X-Forwarded-Encrypted: i=1; AJvYcCX3uoqZQUx2JJo3fOvTk7CPPsKGDtbb+4auoKri3QTLxBBRW/jpyO2gem1dP8jM2qJ9vBYBm0EZLAAJzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjcyBIGH4STvsMo8kZ/34/lAJ+CMVqToEeeMeih3Kcqu3fA73
	AP80UBDM9mWlwb/EJxwgM/NeXiuEOlaDmr/JSXDzyvUmS9PpsUgKoqZl0zdOgJ1qw/mGAi894p3
	jwNm2iazJJOSi7xjIEKFOSWtp3VnoW4PoVeMkJW8zlw==
X-Gm-Gg: AY/fxX7/FczvhAgG2LnwRbthLHtRMMzkvjjz8P3IiEDS+sdnN1Sz5q72WGzFjnfTM25
	SXMxHlZzs0a9SZ42lL9Q0kLcEJcuepDa0BQHtHoDXCkRoqy4X3326Ta+01aY43GrA8pOk8MPloB
	HqcMgMTlKZJUAgqTxDmPHLzFGJ2fiya0/atXMn3hqBw4CvzcgYhVodHjeM9GM47Dyt43eF3qkqj
	02v/uBg3FkL6ss/VA2vMSFVoKUSZlJLvkaAFtUYRYPN44iJrN/L1oTvcyOZk/j98EfIKNJMR8CE
	wq7AxZw=
X-Google-Smtp-Source: AGHT+IFHxI4pVQ6+2MEwKj2xlNKVbWonzBqGXhbVyNPwBUR+J1Nema68M5y35oksYmZfNwH6kn914eUDXU0fSuK7e0U=
X-Received: by 2002:a05:7022:4199:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-121f8aff7dcmr21143c88.2.1767727642171; Tue, 06 Jan 2026
 11:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106185831.18711-1-yoav@nvidia.com> <20260106185831.18711-3-yoav@nvidia.com>
In-Reply-To: <20260106185831.18711-3-yoav@nvidia.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 11:27:11 -0800
X-Gm-Features: AQt7F2qJygvJwuycfnpmqWMskqe-RlVqIiRNu4JHzoL2whHZYEq_LbQoKOgMLWc
Message-ID: <CADUfDZr9bdzsHMQj1u3_iSLHF8Nka7OxB6H3eEs8dO5zWLOxQA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
To: Yoav Cohen <yoav@nvidia.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	jholzman@nvidia.com, omril@nvidia.com, Yoav Cohen <yoav@example.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 10:59=E2=80=AFAM Yoav Cohen <yoav@nvidia.com> wrote:
>
> This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
> device if there are no active openers for the ublk block device.
> If the device is busy, the command returns -EBUSY instead of
> disrupting active clients. This allows safe, non-destructive stopping.
>
> Advertise UBLK_CMD_TRY_STOP_DEV support via UBLK_F_SAFE_STOP_DEV feature =
flag.
>
> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> ---
>  drivers/block/ublk_drv.c      | 42 ++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/ublk_cmd.h |  9 +++++++-
>  2 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2d5602ef05cc..9291eab4c31f 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -54,6 +54,7 @@
>  #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
>  #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
>  #define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> +#define UBLK_CMD_TRY_STOP_DEV  _IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
>
>  #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REGISTE=
R_IO_BUF)
>  #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_IO_B=
UF)
> @@ -73,7 +74,8 @@
>                 | UBLK_F_AUTO_BUF_REG \
>                 | UBLK_F_QUIESCE \
>                 | UBLK_F_PER_IO_DAEMON \
> -               | UBLK_F_BUF_REG_OFF_DAEMON)
> +               | UBLK_F_BUF_REG_OFF_DAEMON \
> +               | UBLK_F_SAFE_STOP_DEV)

Should also be added to the list of automatic feature flags in
ublk_ctrl_add_dev() (UBLK_F_CMD_IOCTL_ENCODE, ...,
UBLK_F_BUF_REG_OFF_DAEMON).

>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -239,6 +241,8 @@ struct ublk_device {
>         struct delayed_work     exit_work;
>         struct work_struct      partition_scan_work;
>
> +       bool                    block_open; /* protected by open_mutex */
> +
>         struct ublk_queue       *queues[];
>  };
>
> @@ -919,6 +923,9 @@ static int ublk_open(struct gendisk *disk, blk_mode_t=
 mode)
>                         return -EPERM;
>         }
>
> +       if (ub->block_open)
> +               return -EBUSY;
> +
>         return 0;
>  }
>
> @@ -3309,6 +3316,35 @@ static void ublk_ctrl_stop_dev(struct ublk_device =
*ub)
>         ublk_stop_dev(ub);
>  }
>
> +static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
> +{
> +       struct gendisk *disk;
> +       int ret =3D 0;
> +
> +       disk =3D ublk_get_disk(ub);
> +       if (!disk) {
> +               return -ENODEV;
> +       }
> +
> +       mutex_lock(&disk->open_mutex);
> +       if (disk_openers(disk) > 0) {
> +               ret =3D -EBUSY;
> +               goto unlock;
> +       }
> +       ub->block_open =3D true;
> +       /* release open_mutex as del_gendisk() will reacquire it */
> +       mutex_unlock(&disk->open_mutex);
> +
> +       ublk_ctrl_stop_dev(ub);
> +       goto out;
> +
> +unlock:
> +       mutex_unlock(&disk->open_mutex);
> +out:
> +       ublk_put_disk(disk);
> +       return ret;
> +}
> +
>  static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
>                 const struct ublksrv_ctrl_cmd *header)
>  {
> @@ -3704,6 +3740,7 @@ static int ublk_ctrl_uring_cmd_permission(struct ub=
lk_device *ub,
>         case UBLK_CMD_END_USER_RECOVERY:
>         case UBLK_CMD_UPDATE_SIZE:
>         case UBLK_CMD_QUIESCE_DEV:
> +       case UBLK_CMD_TRY_STOP_DEV:
>                 mask =3D MAY_READ | MAY_WRITE;
>                 break;
>         default:
> @@ -3817,6 +3854,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd =
*cmd,
>         case UBLK_CMD_QUIESCE_DEV:
>                 ret =3D ublk_ctrl_quiesce_dev(ub, header);
>                 break;
> +       case UBLK_CMD_TRY_STOP_DEV:
> +               ret =3D ublk_ctrl_try_stop_dev(ub);
> +               break;
>         default:
>                 ret =3D -EOPNOTSUPP;
>                 break;
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index ec77dabba45b..2b48c172542d 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -55,7 +55,8 @@
>         _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
>  #define UBLK_U_CMD_QUIESCE_DEV         \
>         _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> -
> +#define UBLK_U_CMD_TRY_STOP_DEV                \
> +       _IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
>  /*
>   * 64bits are enough now, and it should be easy to extend in case of
>   * running out of feature flags
> @@ -241,6 +242,12 @@
>   */
>  #define UBLK_F_UPDATE_SIZE              (1ULL << 10)
>
> +/*
> + * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
> + * allows stopping the device only if there are no openers.
> + */
> +#define UBLK_F_SAFE_STOP_DEV   (1ULL << 11)

This feature flag is already used for UBLK_F_AUTO_BUF_REG. Please use
bit 17 or higher, as bits up to 14 are already assigned and bits 15
and 16 are allocated by in-flight patch sets.

The feature flag should also be added to the list of known ublk
feature flags in cmd_dev_get_features() in
tools/testing/selftests/ublk/kublk.c.

Best,
Caleb

> +
>  /*
>   * request buffer is registered automatically to uring_cmd's io_uring
>   * context before delivering this io command to ublk server, meantime
> --
> 2.39.5 (Apple Git-154)
>
