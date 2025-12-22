Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D52878F4F
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766421834; cv=none; b=h4sWLvE9pyCpubYba5LPacCR+g00ObL2ok94SGrxR3DbQ+YozYR+RmPjX1Nfbe39e87RvBgxblFsrczx9MrEClj0vGGoFCtUBWP7eeI7pGeIEvzVcIirl8WMWswMVEbYr8iTmczrqEo/AH3MXbjxlFhd/KzOBnlIi0mtJOr7dd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766421834; c=relaxed/simple;
	bh=H7vVPf3cDoviXLYiV+2Wp9ZatIylrp+30s9joeDBIzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VvYk8pedqTFHT9KUCgL4x1LRd9dkz9B/4ZmppvbD6+McBGbWCSw5Vyk4oMJEEBwIAIwJlIx+4GW070L8hQmF7xyTULeNe1DDNOVMS/OTobSCSCIBzQIabWK8Cg9Go/XELaVIG0cxlhmsTU4YfA0pnECWWoiZam4OztX1jxZSyh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eKVteMBX; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eKVteMBX"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b8c7a4f214so191562b3a.2
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766421832; x=1767026632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMPCppz5Jgup4OAetB3jIDQJjA+L2I15Yy6MqELndug=;
        b=eKVteMBXZW+IDCS/m7I+KMB/Ig8aF1LyOs8LBzsShCSI+PegCgHuXTpeCaiSV4qAiG
         ORp95NlLWl8cOzXB1B1V/wW5UFiGepHOdx0cSilOncxWO4MvZQ/pga8HUeZ+ntNVzkvT
         jWYwWTX2R2ExSivFk8GAowuLew0EuO8yatCXQJY096zKiZchJbq2jhn5JoviTFi94Y8L
         W7ljHhVK1ObrFiNxmSTYW8fSpHm3jRImFBU7xlAP3d3x3Q6fPjpI6ChFx1yMpa68Nt7O
         mv97bt7UXFX1W98jPBq7zBwFrdz3Wz6E+yxaSzylmeKSo4t7Ek9uj8/U6PAO8kKOD0wa
         IPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766421832; x=1767026632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMPCppz5Jgup4OAetB3jIDQJjA+L2I15Yy6MqELndug=;
        b=E2BTbkJe+mHTx0t/nA4lGdnGaBbvqhk8W12ZYCYR6Q49dHVg8ZYMz7pIgHIp6bAr4w
         glAUjNkD3d1SnerMrSiZpItnigMIShv4LtAA9Dbcm/wCBLVfMyVMlCHK60eoKN/7YQ5I
         +1e1rQA2TFJrfrT1xiGDlWmBlsKNIhOiUQEx1yxc9lMQN8AZxOKWqII33X84oxBIePSk
         oajFf8+sB677WDGwnuKlziHWr+yQa79CAOhsfgoxVje15/A0rpWg+kU7a7+QzNWGOlsw
         pp1eGfQt2uDnSds8C+L1EPD2GD9op06kcIhNfYGtkAYHnki1leOVh5HXsGrtMmxAEZcj
         Edig==
X-Forwarded-Encrypted: i=1; AJvYcCVY+YdgpROYyNVTLzAiS0hsvJEPQn6hXokIzo2cQmkMwkCGDXdji/5MDJ+YPHymA50I5iwlXw4LLm7RQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz3QjglWUpyhcSWuaSUv8YxFkLRt8+uiNUhnZ7gVP6HwxsAp1z
	VHeppOoWv6hwcHpE/j1FGXqyLTaTdxmSqYf9UKmY0dwBLuytgVbg2YUyz4AbqlWxgH56u+Fi5eW
	31uBPcGNm+Gf+/VX6su/kSQtLXo0qJr1MfeZVoWTwFw==
X-Gm-Gg: AY/fxX6HyN5tyN3J0cXcrCSpkH33cGiiplGyqjLS90f1ZJCLFPnh9AUGIIIQS5toJK4
	+I/7KmSN2akhetPod6PGeZj5z3B4NmL3bkXa8qgFOZQwpqNbWo9ahcKppLYbsSVMG/cVdo7/7wG
	WxDMl+HbwGKjkTRmwNf9k0W1w/RePb4qPUt0se5DpBEL19Nmi3ZCmaKE8PYKI+yeIgXjWq5XnqJ
	eCJ2A6jr5MBwLNJvm3EIyg4us2TlMuc/IjQU5Sui7BbpVs/2Vs45a7RZW0uBcsfXWVBCdE=
X-Google-Smtp-Source: AGHT+IEsxKRwakIja0dzMyWp9W22QIzZiYfpyBw5VoLtUqGlP9YpqA/KD8o/PVYefYDBvqjeR1vV2q+hXZ8pCxwikm4=
X-Received: by 2002:a05:7022:3897:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-1217230569emr6386420c88.5.1766421832132; Mon, 22 Dec 2025
 08:43:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221164145.1703448-1-ming.lei@redhat.com> <20251221164145.1703448-2-ming.lei@redhat.com>
In-Reply-To: <20251221164145.1703448-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 22 Dec 2025 11:43:41 -0500
X-Gm-Features: AQt7F2qOOfRu-3_mapcm1qeyefwRL3qa22XnF_ZaFcCwVaSpG3wvvjB7qckbYHI
Message-ID: <CADUfDZrYj3b3dPDRaT25Be=h+QYKQ3X8QJ4VnU_ZVh8jM3AKCQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ublk: scan partition in async way
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Yoav Cohen <yoav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 21, 2025 at 11:42=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wro=
te:
>
> Implement async partition scan to avoid IO hang when reading partition
> tables. Similar to nvme_partition_scan_work(), partition scanning is
> deferred to a work queue to prevent deadlocks.
>
> When partition scan happens synchronously during add_disk(), IO errors
> can cause the partition scan to wait while holding ub->mutex, which
> can deadlock with other operations that need the mutex.
>
> Changes:
> - Add partition_scan_work to ublk_device structure
> - Implement ublk_partition_scan_work() to perform async scan
> - Always suppress sync partition scan during add_disk()
> - Schedule async work after add_disk() for trusted daemons
> - Add flush_work() in ublk_stop_dev() before grabbing ub->mutex
>
> Reported-by: Yoav Cohen <yoav@nvidia.com>
> Closes: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F=
0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver=
")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 49c208457198..21593826ad2d 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -237,6 +237,7 @@ struct ublk_device {
>         bool canceling;
>         pid_t   ublksrv_tgid;
>         struct delayed_work     exit_work;
> +       struct work_struct      partition_scan_work;
>
>         struct ublk_queue       *queues[];
>  };
> @@ -254,6 +255,20 @@ static inline struct request *__ublk_check_and_get_r=
eq(struct ublk_device *ub,
>                 u16 q_id, u16 tag, struct ublk_io *io, size_t offset);
>  static inline unsigned int ublk_req_build_flags(struct request *req);
>
> +static void ublk_partition_scan_work(struct work_struct *work)
> +{
> +       struct ublk_device *ub =3D
> +               container_of(work, struct ublk_device, partition_scan_wor=
k);
> +
> +       if (WARN_ON_ONCE(!test_and_clear_bit(GD_SUPPRESS_PART_SCAN,
> +                                            &ub->ub_disk->state)))
> +               return;
> +
> +       mutex_lock(&ub->ub_disk->open_mutex);
> +       bdev_disk_changed(ub->ub_disk, false);
> +       mutex_unlock(&ub->ub_disk->open_mutex);
> +}
> +
>  static inline struct ublksrv_io_desc *
>  ublk_get_iod(const struct ublk_queue *ubq, unsigned tag)
>  {
> @@ -2026,6 +2041,7 @@ static void ublk_stop_dev(struct ublk_device *ub)
>         mutex_lock(&ub->mutex);
>         ublk_stop_dev_unlocked(ub);
>         mutex_unlock(&ub->mutex);
> +       flush_work(&ub->partition_scan_work);
>         ublk_cancel_dev(ub);
>  }
>
> @@ -2954,9 +2970,14 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>
>         ublk_apply_params(ub);
>
> -       /* don't probe partitions if any daemon task is un-trusted */
> -       if (ub->unprivileged_daemons)
> -               set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> +       /*
> +        * Suppress partition scan to avoid potential IO hang.
> +        * If a path error occurs during partition scan, the IO may wait

What does a "path error" mean for ublk?

Other than that,
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +        * while holding ub->mutex, which can deadlock with other operati=
ons
> +        * that need the mutex. Defer partition scan to async work.
> +        * For unprivileged daemons, keep GD_SUPPRESS_PART_SCAN set perma=
nently.
> +        */
> +       set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>
>         ublk_get_device(ub);
>         ub->dev_info.state =3D UBLK_S_DEV_LIVE;
> @@ -2973,6 +2994,10 @@ static int ublk_ctrl_start_dev(struct ublk_device =
*ub,
>
>         set_bit(UB_STATE_USED, &ub->state);
>
> +       /* Schedule async partition scan for trusted daemons */
> +       if (!ub->unprivileged_daemons)
> +               schedule_work(&ub->partition_scan_work);
> +
>  out_put_cdev:
>         if (ret) {
>                 ublk_detach_disk(ub);
> @@ -3138,6 +3163,7 @@ static int ublk_ctrl_add_dev(const struct ublksrv_c=
trl_cmd *header)
>         mutex_init(&ub->mutex);
>         spin_lock_init(&ub->lock);
>         mutex_init(&ub->cancel_mutex);
> +       INIT_WORK(&ub->partition_scan_work, ublk_partition_scan_work);
>
>         ret =3D ublk_alloc_dev_number(ub, header->dev_id);
>         if (ret < 0)
> --
> 2.47.0
>
