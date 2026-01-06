Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28170342C9A
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 19:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767728937; cv=none; b=diM6YJwJzn8Kqbw+apMMjxF1bsAuHoBG2Uy+zBt/5RjG2Xws/MTbRSoOprpknivLGI3RwsOcdea3SixLb1b6y+fCky18y59dlD6Dd8LjT1vg+53NS5/KaBSX0Hk2Szv493ZvdXSZ9p78FhGIGSF0Hank4rTww6IHYbIMdFNrKDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767728937; c=relaxed/simple;
	bh=2Yjt8U1jmBIMKEj6M4Q2oLpf2I8t6Zgc0Yqo5olcCh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jje1lrqCvHne6zEjNkxNxilM6FZBs+4vT+XV4JxVN6BUht3AdTrWFhhp+S0+BG5YX8UQVpXF8eUx07Udk61AcdGp98HSWFuIyb/PZKS1K95413co8kRP8bxT3Wbj/ykCqmkiBzPEawgDE7MH943M1lPVBrDnFgoXaTDcTQal27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Q9pd6qQ2; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Q9pd6qQ2"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-11bba84006dso71702c88.2
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767728934; x=1768333734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZpVi5TIDx1hg/lePodnjApaWASmkc/Ad/LDk3KapkU=;
        b=Q9pd6qQ2wW4+y2CET+uLSd6CiMqdVOyhFLg02mMAQnoDt9il0Qggel9pFweP6NUKSr
         paObhu50s6A9sInAIlrAZhGgjCGozNQlNQ+DA93WK/9xvSgP2ciVWHCx3xps/M7yHWzj
         BkusGhmcRQqSPqfGFPdKpUkK9zA6Bfd7KTaNgHov458JFEM6vikjs/hyGk9Q76yF96E2
         aYoKYa/GSWCHOJkSMQBQDk1EV1/kXAwXXiqiUjvq8Rt5Izu/zD7cxGL57s2C2PE7oE5C
         bixCLAeldg1j3NfMaZAc/CY97JVQ08lcNQat08MkhrwQdZdd2KbLd8VS1CaK86OamB9d
         R8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767728934; x=1768333734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OZpVi5TIDx1hg/lePodnjApaWASmkc/Ad/LDk3KapkU=;
        b=jeArBsY+MYgyG3LbPY2Ecg7plscat9mqoIuzdTAanGqAwnZkLYWuxYyhHpnj7zq9Rm
         6fHIuUQ1VbLguTXbSuWTWpDBGDEaiMgfPVUyYwJ/PKFjs/VBPMnK3qcTlnsqcZGosPti
         tyVo6JJ0TSCOBxDx8wUBuKWzBrASHjPu9l0S5214ya4f70EENexc4vpaE5H/PiOkhJ2W
         yVU1Gvui9YrlDf17z8Q0JkCxa9lFqR6H5JlaGPgkR8deWIU/eCASLvsr5nUJHH+I4mTN
         cQNvizItoa6P8+oH9lydWwdMX4YHKlsrQC10XMMYPEreVrPAYqaJeytOcaB45+jvVGTb
         mmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7/ldvn6vGm9/+04NeSuo5UZ1Yx3YAKfWYWbIK2AC5izV3k/3FMVpRqwlk3zgvcWQ5vmXdVPO6HXgMrg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2qhfTH9Ydp+88UdWgvO9JdREVeamHyYBgDYazYH354Fn+p2x
	Vg0zpAfWEKftGoIbKDrccoAHBIAmXL79MSu8pMwHFvId7Gb4XKBw4c8Dq4HfZaF06cedkkPVYQ8
	KEsNgjCpRw9V0dsep7Rf1ZGdtUXuMvGRp3Oe0xcu+1A==
X-Gm-Gg: AY/fxX5LZcuWt1HWU3cEAnnu9DNX01MHH9iBQZzpvNyhT6cl58NkqDVhatwI5NkmvoS
	bK5t4lxs2dUWFGDw3J7NKpkyvCiG/WuvxUO+fIYoSq4meH7uAGF1l7t/m6yOsKyJK6M+TDBAzGP
	YNG0jZIYEOuZYTnUqCAdItbUfLDwC84ExmYSiS8gZvqL4P3JhJVQ4N8N4Denx0pV3/gpbs25aA6
	XdHjHvy4VVKzdWNLCfIvxzapTRpqwAm0TfsCFrNPNa7EXycKb3nvNlW3ZsftrrGwt1m7VEy
X-Google-Smtp-Source: AGHT+IE2PNbz1ewsurDKE9n2C67mLPnmFPmpIU8QTmXZdsoPUDFL49W7Jr9krGqLCTYPnvdwb8fSWgNu8haL1fqp4JA=
X-Received: by 2002:a05:7022:6293:b0:11b:1c6d:98ed with SMTP id
 a92af1059eb24-121f8abea5cmr54920c88.2.1767728934088; Tue, 06 Jan 2026
 11:48:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106185831.18711-1-yoav@nvidia.com> <20260106185831.18711-3-yoav@nvidia.com>
 <CADUfDZr9bdzsHMQj1u3_iSLHF8Nka7OxB6H3eEs8dO5zWLOxQA@mail.gmail.com> <c45de2c7-7d88-4b52-a3e9-a9f5863864d7@nvidia.com>
In-Reply-To: <c45de2c7-7d88-4b52-a3e9-a9f5863864d7@nvidia.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 6 Jan 2026 11:48:42 -0800
X-Gm-Features: AQt7F2qbV02jq8AcVb2x8Tp-52HdovtoN9Uz-zSPCzFoHW7tqNw7BDr8o9TbECs
Message-ID: <CADUfDZpfOt6A8T+sPDLuOtJhuDyd11CBL9J+tnoz44s1FgNvfg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ublk: add UBLK_CMD_TRY_STOP_DEV command
To: Yoav Cohen <yoav@nvidia.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jared Holzman <jholzman@nvidia.com>, 
	Omri Levi <omril@nvidia.com>, Yoav Cohen <yoav@example.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 11:40=E2=80=AFAM Yoav Cohen <yoav@nvidia.com> wrote:
>
> On 06/01/2026 21:27, Caleb Sander Mateos wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Tue, Jan 6, 2026 at 10:59=E2=80=AFAM Yoav Cohen <yoav@nvidia.com> wr=
ote:
> >>
> >> This command is similar to UBLK_CMD_STOP_DEV, but it only stops the
> >> device if there are no active openers for the ublk block device.
> >> If the device is busy, the command returns -EBUSY instead of
> >> disrupting active clients. This allows safe, non-destructive stopping.
> >>
> >> Advertise UBLK_CMD_TRY_STOP_DEV support via UBLK_F_SAFE_STOP_DEV featu=
re flag.
> >>
> >> Signed-off-by: Yoav Cohen <yoav@nvidia.com>
> >> ---
> >>   drivers/block/ublk_drv.c      | 42 +++++++++++++++++++++++++++++++++=
+-
> >>   include/uapi/linux/ublk_cmd.h |  9 +++++++-
> >>   2 files changed, 49 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >> index 2d5602ef05cc..9291eab4c31f 100644
> >> --- a/drivers/block/ublk_drv.c
> >> +++ b/drivers/block/ublk_drv.c
> >> @@ -54,6 +54,7 @@
> >>   #define UBLK_CMD_DEL_DEV_ASYNC _IOC_NR(UBLK_U_CMD_DEL_DEV_ASYNC)
> >>   #define UBLK_CMD_UPDATE_SIZE   _IOC_NR(UBLK_U_CMD_UPDATE_SIZE)
> >>   #define UBLK_CMD_QUIESCE_DEV   _IOC_NR(UBLK_U_CMD_QUIESCE_DEV)
> >> +#define UBLK_CMD_TRY_STOP_DEV  _IOC_NR(UBLK_U_CMD_TRY_STOP_DEV)
> >>
> >>   #define UBLK_IO_REGISTER_IO_BUF                _IOC_NR(UBLK_U_IO_REG=
ISTER_IO_BUF)
> >>   #define UBLK_IO_UNREGISTER_IO_BUF      _IOC_NR(UBLK_U_IO_UNREGISTER_=
IO_BUF)
> >> @@ -73,7 +74,8 @@
> >>                  | UBLK_F_AUTO_BUF_REG \
> >>                  | UBLK_F_QUIESCE \
> >>                  | UBLK_F_PER_IO_DAEMON \
> >> -               | UBLK_F_BUF_REG_OFF_DAEMON)
> >> +               | UBLK_F_BUF_REG_OFF_DAEMON \
> >> +               | UBLK_F_SAFE_STOP_DEV)
> >
> > Should also be added to the list of automatic feature flags in
> > ublk_ctrl_add_dev() (UBLK_F_CMD_IOCTL_ENCODE, ...,
> > UBLK_F_BUF_REG_OFF_DAEMON).
> >
> >>
> >>   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >>                  | UBLK_F_USER_RECOVERY_REISSUE \
> >> @@ -239,6 +241,8 @@ struct ublk_device {
> >>          struct delayed_work     exit_work;
> >>          struct work_struct      partition_scan_work;
> >>
> >> +       bool                    block_open; /* protected by open_mutex=
 */
> >> +
> >>          struct ublk_queue       *queues[];
> >>   };
> >>
> >> @@ -919,6 +923,9 @@ static int ublk_open(struct gendisk *disk, blk_mod=
e_t mode)
> >>                          return -EPERM;
> >>          }
> >>
> >> +       if (ub->block_open)
> >> +               return -EBUSY;
> >> +
> >>          return 0;
> >>   }
> >>
> >> @@ -3309,6 +3316,35 @@ static void ublk_ctrl_stop_dev(struct ublk_devi=
ce *ub)
> >>          ublk_stop_dev(ub);
> >>   }
> >>
> >> +static int ublk_ctrl_try_stop_dev(struct ublk_device *ub)
> >> +{
> >> +       struct gendisk *disk;
> >> +       int ret =3D 0;
> >> +
> >> +       disk =3D ublk_get_disk(ub);
> >> +       if (!disk) {
> >> +               return -ENODEV;
> >> +       }
> >> +
> >> +       mutex_lock(&disk->open_mutex);
> >> +       if (disk_openers(disk) > 0) {
> >> +               ret =3D -EBUSY;
> >> +               goto unlock;
> >> +       }
> >> +       ub->block_open =3D true;
> >> +       /* release open_mutex as del_gendisk() will reacquire it */
> >> +       mutex_unlock(&disk->open_mutex);
> >> +
> >> +       ublk_ctrl_stop_dev(ub);
> >> +       goto out;
> >> +
> >> +unlock:
> >> +       mutex_unlock(&disk->open_mutex);
> >> +out:
> >> +       ublk_put_disk(disk);
> >> +       return ret;
> >> +}
> >> +
> >>   static int ublk_ctrl_get_dev_info(struct ublk_device *ub,
> >>                  const struct ublksrv_ctrl_cmd *header)
> >>   {
> >> @@ -3704,6 +3740,7 @@ static int ublk_ctrl_uring_cmd_permission(struct=
 ublk_device *ub,
> >>          case UBLK_CMD_END_USER_RECOVERY:
> >>          case UBLK_CMD_UPDATE_SIZE:
> >>          case UBLK_CMD_QUIESCE_DEV:
> >> +       case UBLK_CMD_TRY_STOP_DEV:
> >>                  mask =3D MAY_READ | MAY_WRITE;
> >>                  break;
> >>          default:
> >> @@ -3817,6 +3854,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_c=
md *cmd,
> >>          case UBLK_CMD_QUIESCE_DEV:
> >>                  ret =3D ublk_ctrl_quiesce_dev(ub, header);
> >>                  break;
> >> +       case UBLK_CMD_TRY_STOP_DEV:
> >> +               ret =3D ublk_ctrl_try_stop_dev(ub);
> >> +               break;
> >>          default:
> >>                  ret =3D -EOPNOTSUPP;
> >>                  break;
> >> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_c=
md.h
> >> index ec77dabba45b..2b48c172542d 100644
> >> --- a/include/uapi/linux/ublk_cmd.h
> >> +++ b/include/uapi/linux/ublk_cmd.h
> >> @@ -55,7 +55,8 @@
> >>          _IOWR('u', 0x15, struct ublksrv_ctrl_cmd)
> >>   #define UBLK_U_CMD_QUIESCE_DEV         \
> >>          _IOWR('u', 0x16, struct ublksrv_ctrl_cmd)
> >> -
> >> +#define UBLK_U_CMD_TRY_STOP_DEV                \
> >> +       _IOWR('u', 0x17, struct ublksrv_ctrl_cmd)
> >>   /*
> >>    * 64bits are enough now, and it should be easy to extend in case of
> >>    * running out of feature flags
> >> @@ -241,6 +242,12 @@
> >>    */
> >>   #define UBLK_F_UPDATE_SIZE              (1ULL << 10)
> >>
> >> +/*
> >> + * The device supports the UBLK_CMD_TRY_STOP_DEV command, which
> >> + * allows stopping the device only if there are no openers.
> >> + */
> >> +#define UBLK_F_SAFE_STOP_DEV   (1ULL << 11)
> >
> > This feature flag is already used for UBLK_F_AUTO_BUF_REG. Please use
> > bit 17 or higher, as bits up to 14 are already assigned and bits 15
> > and 16 are allocated by in-flight patch sets.
> >
> > The feature flag should also be added to the list of known ublk
> > feature flags in cmd_dev_get_features() in
> > tools/testing/selftests/ublk/kublk.c.
> >
> > Best,
> > Caleb
> >
> >> +
> >>   /*
> >>    * request buffer is registered automatically to uring_cmd's io_urin=
g
> >>    * context before delivering this io command to ublk server, meantim=
e
> >> --
> >> 2.39.5 (Apple Git-154)
> >>
> Thank you for the comments, on which branch should I rebased my changes o=
n?

I would use block-6.19. It looks like it has 1 additional ublk commit
on top of for-7.0/block. Feature flag bits 15 and 16 are used by the
following patch series, but they can be rebased on yours once it
lands:
UBLK_F_BATCH_IO:
https://lore.kernel.org/linux-block/20251202121917.1412280-11-ming.lei@redh=
at.com/T/#u
UBLK_F_NO_AUTO_PART_SCAN:
https://lore.kernel.org/linux-block/20251220095322.1527664-2-ming.lei@redha=
t.com/T/#u
UBLK_F_INTEGRITY:
https://lore.kernel.org/linux-block/20260106005752.3784925-4-csander@purest=
orage.com/T/#u

Best,
Caleb
