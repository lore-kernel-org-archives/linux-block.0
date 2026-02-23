Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DBC2BE7BB
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862409; cv=pass; b=E00JY3ANJzodhRMd3H7LFLvCtIqQGCp4ArQYBvDtMMwS3Vo3QERxLD+XozxtRUpjTidi2f3AqHYj60zsUPA4cHCfPTLeSaFpQ0euzh80SpoJfsB6WUNKE+d2H+0Ffri2vrzNojkEVEUI36VsptrTv9Chhf2qUQvqVwZxO17z3n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862409; c=relaxed/simple;
	bh=HykTNcuKiAcsKETODVGw7I4p4N7pYvwiMmxacuq81Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLxbFeDebOSPJxgWeFM93LEKDTDSjADGof2OkRg8casQ6TaFZn7bkUEhdesBoWQb6FPcfDVgMcvo871XMK+LOpKUdH33uP7eMOhlUeG2wP74GDuYdq7lq8Va/wwC/TdrEyPMgzpnfWDGMs4Hks5Iw+B+cfnvifw8EOjQ6icJQ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=d2Vg84Ee; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="d2Vg84Ee"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b90ba3bae60so6154666b.2
        for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 08:00:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771862406; cv=none;
        d=google.com; s=arc-20240605;
        b=gTdxb7TX0IuAVZZfkkvgD+mYozvSV1FBlv1wGi67aaPkB3FqLYSNMNgWper/0Wateq
         VT4aM5M72BVeH85fjuj5epC1RdD9WWvyjLnyu46kdr3IVpuTXFyHNAl5XJUsxy+3wOp/
         N0Q4CnneUwRhC6qKVEyo/bMYLf6YGDYqQZUPsn+p1E8F5xECeAPL1R6wT27A9idOTK9i
         GectTb/DLzEW6Ovt2QyF3qInvyewJBRJW/VqXJ9KYXuvuPvWKHq9eqVAh2qs50BBmVo4
         3C9VbZaKdBKg7aoV0hSexcdHe0cHMpkYFpiNxfOjs8VCLUPAvL/11anjvujO7nNPIluG
         c7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GECeIAnRG+1DYzQpeso4UuY5rhuqMyULaoSHS1c9rjk=;
        fh=NEvYU9yC3qFadjezBzpvOGN/aEkZI9SvsGvsRkg7qLE=;
        b=OVFpN04yBths+Bxc8OlrLjh1qXV/oNuZiJeLDj1WoLAtLNhXvj+pgQPJ/8+rAsp0Bu
         ogWbvn9tglEjuJyYBCG8PPDDR1tE9MgBLdCLy5d7ytfSr902adtVDm+jtt3B3tgPhXLi
         0lGNtbZCv51u4GkvK22yiJ2ffFDXWIDzMe1mksLSenuLdSqwbYNkSj5ysa0UYmfPt9rC
         g/Z26I4ZQPFSFnDfIOgWk/tUSAdU2hXxTJ45OFXa8iA36vT8zR1gtIooOabWqOXyJgOt
         7mrQzSI0jyGojtKI8Fxc3wANoGFv8kxsv9CSGRIs6HZ6PfmcGnPl9Z3d1ErqCwP1Ybat
         Lr3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771862406; x=1772467206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GECeIAnRG+1DYzQpeso4UuY5rhuqMyULaoSHS1c9rjk=;
        b=d2Vg84EeF7Njp91MFPPMufhZ0V/kmhWOUZmdBgK/iLzq5csY1YhNyn8/3UBN+gxUH2
         OOWqlYnDq29j+sK2dv3utoC8ECa19VvuTpKbm1U2SgPP6LINDB/0XVPRfdm1Br2JsA9H
         g/DvZXB881L8b5LobOqIqWKLTwIQ2Rr1peYcHl4TsvjD+3aJ9nFVvYLjmSp1/WLbQpJw
         hW7fW3gkIxDPe0KN2bV17xRehci33U90fl56CGVPkjHJ9EEeNZgEyHjiBfVncisYYs1z
         uEm07vrCeh9TjtFN6Hb2YacMF1lozByhgwzao2vjzHr1hzIwtWrZTk9dOFRwe8UdZsQ7
         kKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862406; x=1772467206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GECeIAnRG+1DYzQpeso4UuY5rhuqMyULaoSHS1c9rjk=;
        b=rLB9fl7Xse3xB4kkD4tnGEvUGmHyHjaxfetSp602YQ2qMBsX4T3+Lxf8uxyl9c1Hpd
         79QcamQxREKqH1GlxwWSgninU1GNXWdoM3VBSNwsdlGVbbnyZHn65LT7dW86O++012S/
         OulhKpMUcqSvmS9MWB7QBArZggqjUzaJ0EsC/H99kP03+qMFbdlB05uIg3Zs1l/0EtOu
         Wur7ZfA4Z34pC5hLG+7gVU4wY6cMPT6Ob4dK2vZHfeheUlbNQ4kJXFPu8y0j5g/TDkJS
         bq74GlioHquxajj1G7vwkfv9nSwyQ0wkOk3YoX/Z5UU+P1ykHO6J3MbL83ZMDeD1U5p4
         zpIw==
X-Forwarded-Encrypted: i=1; AJvYcCXXMNklwfsf2mUYbhc7NE4Mu+wmZBtPGoKEk9P9sZswGQ13H6GZYNzsGRuHhOxvKORgxjX5dveBukSMIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVHwLjICE+FChxYQitrMEHYhwmrR7rTePIBJdkYPVfq1ljZhJ1
	dqcE/ULFtd3A3nr6eYoSHKduuFBTTlOXI3GhJORAoeU698ydte/yWwv6xy8RZIKAlB60ymNs2cJ
	QM1ioxvTqWYUla/d1qQY4UfxOdFLdCbBxspVvUQY5eg==
X-Gm-Gg: AZuq6aKzK79Kpq1wbCtwLze3E0fxDryFO4hI8FTXO3SAWUn51iUFBjWoYI/yVJPRvwm
	7tj7oEeALbawvayzyLOC+THr5c7pPrfNl1lsWQKItAacyhjyUORByKIi+YFhxMx8w9FB78PuWa/
	QT/33g91lAMx80fftVifiNJCVcjOJYb3VzTZfJYu3dgM4gXAESZiYaCYhgmen9UPs1GdvDFMyMC
	SADxSlkFU0BnNMElfKuAluX+8AFZczbXb29JSAwvfI8cvtSPdXQ/PdottybEM5/EuwQ/qU4M2HF
	J5zUos09
X-Received: by 2002:a17:906:9fc7:b0:b8e:7dcb:7f23 with SMTP id
 a640c23a62f3a-b90819894c5mr292261566b.2.1771862405564; Mon, 23 Feb 2026
 08:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223121515.3296983-1-alex@zazolabs.com> <20260223121515.3296983-2-alex@zazolabs.com>
In-Reply-To: <20260223121515.3296983-2-alex@zazolabs.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 23 Feb 2026 07:59:54 -0800
X-Gm-Features: AaiRm52mv0s4yYyx4erpIoUu5xL17crYd1kLm0qUcxlxIIBPp6ebT8GP2t6MsLY
Message-ID: <CADUfDZp-jX98mfERO0OUoMePfws5yRtvfmLfzD2tzfi+HDPyLQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] ublk: cleanup flag handling and fix UBLK_F_NO_AUTO_PART_SCAN
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:17=E2=80=AFAM Alexander Atanasov <alex@zazolabs.c=
om> wrote:
>
> Currently the code misuse GD_SUPPRESS_PART_SCAN flag
> as it tries to use it as a switch for the auto partition scan.
> To fully disable creation of partitions GENHD_FL_NO_PART must
> be used, switch code to use it instead GD_SUPPRESS_PART_SCAN.
>
> Using the new flags rules for partitions become:
>  - Unprivileged daemons - never scan partitions, they have
> GENHD_FL_NO_PART always set - they are devices without partitions.
>
>  - Trusted daemons - by default have partitions disabled.
> Partitions can be enabled via UBLK_F_PARTITIONS flag and
> automatic initial scan can be requested via UBLK_F_AUTO_PART_SCAN flag.
>
> Rework the code to work as described above:
> - remove checks in ublk_partition_scan_work and rely on
> the caller to schedule the work only if it has to be done.
> - set GENHD_FL_NO_PART on unprivileged devices
> - set GENHD_FL_NO_PART depending on UBLK_F_PARTITIONS on trusted
> devices.
>
> Fixes: 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  drivers/block/ublk_drv.c      | 34 +++++++++++++++++++---------------
>  include/uapi/linux/ublk_cmd.h |  7 +++++--
>  2 files changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3c918db4905c..d0c646eb9435 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -81,7 +81,8 @@
>                 | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRIT=
Y : 0) \
>                 | UBLK_F_SAFE_STOP_DEV \
>                 | UBLK_F_BATCH_IO \
> -               | UBLK_F_NO_AUTO_PART_SCAN)
> +               | UBLK_F_PARTITIONS \
> +               | UBLK_F_AUTO_PART_SCAN)
>
>  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
>                 | UBLK_F_USER_RECOVERY_REISSUE \
> @@ -2361,14 +2362,9 @@ static void ublk_partition_scan_work(struct work_s=
truct *work)
>         if (!disk)
>                 return;
>
> -       if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> -                                            &disk->state)))
> -               goto out;
> -
>         mutex_lock(&disk->open_mutex);
>         bdev_disk_changed(disk, false);
>         mutex_unlock(&disk->open_mutex);
> -out:
>         ublk_put_disk(disk);
>  }
>
> @@ -4409,9 +4405,13 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>          * wait while holding ub->mutex, which can deadlock with other
>          * operations that need the mutex. Defer partition scan to async
>          * work.
> -        * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set
> -        * permanently.
> +        * For unprivileged daemons, set GENHD_FL_NO_PART to
> +        * disable partitions.
>          */
> +       if (ub->unprivileged_daemons)
> +               disk->flags |=3D GENHD_FL_NO_PART;
> +
> +       /* Disable partition scans */
>         set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>
>         ublk_get_device(ub);
> @@ -4429,13 +4429,17 @@ static int ublk_ctrl_start_dev(struct ublk_device=
 *ub,
>
>         set_bit(UB_STATE_USED, &ub->state);
>
> -       /* Skip partition scan if disabled by user */
> -       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> -               clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> -       } else {
> -               /* Schedule async partition scan for trusted daemons */
> -               if (!ub->unprivileged_daemons)
> -                       schedule_work(&ub->partition_scan_work);
> +       if (!ub->unprivileged_daemons) {
> +               if (!(ub->dev_info.flags & UBLK_F_PARTITIONS)) {
> +                       /* disable partitions on trusted device */
> +                       disk->flags |=3D GENHD_FL_NO_PART;
> +               } else {
> +                       /* Enable partition scan on device */
> +                       clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> +                       /* Schedule auto partition scan if requested */
> +                       if (ub->dev_info.flags & UBLK_F_AUTO_PART_SCAN)
> +                               schedule_work(&ub->partition_scan_work);
> +               }
>         }
>
>  out_put_cdev:
> diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.=
h
> index a88876756805..467ecaa20ac1 100644
> --- a/include/uapi/linux/ublk_cmd.h
> +++ b/include/uapi/linux/ublk_cmd.h
> @@ -367,8 +367,11 @@
>   */
>  #define UBLK_F_SAFE_STOP_DEV   (1ULL << 17)
>
> -/* Disable automatic partition scanning when device is started */
> -#define UBLK_F_NO_AUTO_PART_SCAN (1ULL << 18)
> +/* Enable partitions on the device */
> +#define UBLK_F_PARTITIONS (1ULL << 18)

This is not backwards compatible. Existing ublk servers expect their
devices to support partitioning. If you want to introduce a feature
flag to control this, it needs to be opt-out rather than opt-in.
UBLK_F_AUTO_PART_SCAN probably also needs to remain as
UBLK_F_NO_AUTO_PART_SCAN.

Best,
Caleb

> +
> +/* Perform automatic partition scanning when device is started */
> +#define UBLK_F_AUTO_PART_SCAN (1ULL << 19)
>
>  /* device state */
>  #define UBLK_S_DEV_DEAD        0
> --
> 2.43.0
>
>
