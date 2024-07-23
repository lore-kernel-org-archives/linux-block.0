Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2E32F5E
	for <linux-block@vger.kernel.org>; Tue, 23 Jul 2024 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721698417; cv=none; b=JJoZD2mQ9UZrsdUGOaXVXty6XTAQjsRENtJVVbgkAz2523i8gxF1jCnIaO8BibMF3B3T3/RCJbRiKnCRoTpJeho8JKIgPc5+XU/a8xMzEf0HO5OptSACM0axlhKhmkxuVfens7gKKhffi4lIqpSo10pXSbh0QyWAW1vNjTdd+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721698417; c=relaxed/simple;
	bh=iR5/Ko0O48z1kXSjGR3c8tnJbfBcmoXdFMaxFeSgim0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2cLdkx3V+jQvWFESXVOgyu4wVgosjB2oVDh2WzWoS6u72a3FSj3FIJ6n2NGPkmSKxLM32+5L99HMv+iFLbA4pLmhzeEVbw1X9FknM284N+UQirBqZ05MfKEhMTQUvLgDvZwKiT0DI2VBhTxUcE+Ls85/c1BViaSDhpR7C8PD/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YMTblas0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YMTblas0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721698414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyTO09t2j6PJnV6GXy5HbssjwomZxDpFfV/46yXQB4w=;
	b=YMTblas0x25g6wBYYrUFn0OEKkH2lZTqd9QJza9QG+1qjX/8RMnH0TqbYsi3wlDZgxWtNp
	2E0E8iwOuXiqPpUrNglBshlh7+zBJW1mYdC9QBnCvKwisPMRK7A2h+BCIfdGX1LH+RBXXa
	ueHhpuIO9SeHhK/YSdrkfhxxQOPuOKI=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-YRRpvAZNOuW6l6Nd-Vetrw-1; Mon, 22 Jul 2024 21:33:32 -0400
X-MC-Unique: YRRpvAZNOuW6l6Nd-Vetrw-1
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-49298970b4aso106778137.0
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 18:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721698412; x=1722303212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyTO09t2j6PJnV6GXy5HbssjwomZxDpFfV/46yXQB4w=;
        b=fgT6AIaroIMTOqv63+UXFHxPxLQPQL7pI1Fkl2K+c4ZQKFx3F5YLr4+NKWJq6ucxNi
         Iq4o0q6coXpmiU1F6CRIktl/S3eFaUDaorlXIv+YtxDU6XrScMF+nYhrntw6c0MAxqmi
         TfdDlfeeaFGWkm8ty2iml0dk3ARbkaE45H55eU33Q/NdG8b9PJTOkCpwaOeia0w293HV
         kylySah5Tqj1rxc9WRKXRxCgPT5LbHhcC/nlUYeefE6naWlG5VguOpweWHFut9tpna7y
         8uoVmQ26ZK+aPfLFLl8LBmDsOCtmXmldBDi7pGqBAwDhXESwTeJw4LlesDjDriurVJmL
         p4rw==
X-Forwarded-Encrypted: i=1; AJvYcCWK9NQ3ZPsCpnVQmHEbGuyVB/udIwjVpwJMSSUA8EQeaZP4omevT1JOMoYKu6t52fonNso0fOAK6WcKJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxcgX5CspdrZp59cLWk3as078hjHPb5AbN5J8+4MuLh9R30osS
	W4SkVrDfVJ+qmm82ugavwsOl2LjRAP0XGAqZkzvwsxuVFCNamglnNY9iptvbYhoZMM2E/IIvT6l
	dmdjNnO9m7/+oOx3uentb1Vnnz3/TZJQo3+ck6+7Ps2pX3AJ9wCAQ68LvNy1wsjozz0/YAz3fIU
	AwSiMPyoiHv0FP39wzj8l3LqbKsAbIAdi2BkY=
X-Received: by 2002:a05:6102:26c5:b0:48d:b0a3:fe25 with SMTP id ada2fe7eead31-49283deb38emr4674610137.1.1721698412331;
        Mon, 22 Jul 2024 18:33:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpJ7mOQ5NJSO0Xet0Ie67tI97YCdUbMKgYtIoMWSKaBdm0SzDHQoCTtuhhgjR2rZHnL7PcjTQOIBTcn5bEsXg=
X-Received: by 2002:a05:6102:26c5:b0:48d:b0a3:fe25 with SMTP id
 ada2fe7eead31-49283deb38emr4674598137.1.1721698411904; Mon, 22 Jul 2024
 18:33:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722091633.13128-1-yang.yang@vivo.com>
In-Reply-To: <20240722091633.13128-1-yang.yang@vivo.com>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 23 Jul 2024 09:33:21 +0800
Message-ID: <CAFj5m9LKfOFs2XC4dDmatuwRMaNxx0=QM-_9noeOj5VMQg++3w@mail.gmail.com>
Subject: Re: [PATCH v2] block: fix deadlock between sd_remove & sd_release
To: Yang Yang <yang.yang@vivo.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 5:17=E2=80=AFPM Yang Yang <yang.yang@vivo.com> wrot=
e:
>
> Our test report the following hung task:
>
> [ 2538.459400] INFO: task "kworker/0:0":7 blocked for more than 188 secon=
ds.
> [ 2538.459427] Call trace:
> [ 2538.459430]  __switch_to+0x174/0x338
> [ 2538.459436]  __schedule+0x628/0x9c4
> [ 2538.459442]  schedule+0x7c/0xe8
> [ 2538.459447]  schedule_preempt_disabled+0x24/0x40
> [ 2538.459453]  __mutex_lock+0x3ec/0xf04
> [ 2538.459456]  __mutex_lock_slowpath+0x14/0x24
> [ 2538.459459]  mutex_lock+0x30/0xd8
> [ 2538.459462]  del_gendisk+0xdc/0x350
> [ 2538.459466]  sd_remove+0x30/0x60
> [ 2538.459470]  device_release_driver_internal+0x1c4/0x2c4
> [ 2538.459474]  device_release_driver+0x18/0x28
> [ 2538.459478]  bus_remove_device+0x15c/0x174
> [ 2538.459483]  device_del+0x1d0/0x358
> [ 2538.459488]  __scsi_remove_device+0xa8/0x198
> [ 2538.459493]  scsi_forget_host+0x50/0x70
> [ 2538.459497]  scsi_remove_host+0x80/0x180
> [ 2538.459502]  usb_stor_disconnect+0x68/0xf4
> [ 2538.459506]  usb_unbind_interface+0xd4/0x280
> [ 2538.459510]  device_release_driver_internal+0x1c4/0x2c4
> [ 2538.459514]  device_release_driver+0x18/0x28
> [ 2538.459518]  bus_remove_device+0x15c/0x174
> [ 2538.459523]  device_del+0x1d0/0x358
> [ 2538.459528]  usb_disable_device+0x84/0x194
> [ 2538.459532]  usb_disconnect+0xec/0x300
> [ 2538.459537]  hub_event+0xb80/0x1870
> [ 2538.459541]  process_scheduled_works+0x248/0x4dc
> [ 2538.459545]  worker_thread+0x244/0x334
> [ 2538.459549]  kthread+0x114/0x1bc
>
> [ 2538.461001] INFO: task "fsck.":15415 blocked for more than 188 seconds=
.
> [ 2538.461014] Call trace:
> [ 2538.461016]  __switch_to+0x174/0x338
> [ 2538.461021]  __schedule+0x628/0x9c4
> [ 2538.461025]  schedule+0x7c/0xe8
> [ 2538.461030]  blk_queue_enter+0xc4/0x160
> [ 2538.461034]  blk_mq_alloc_request+0x120/0x1d4
> [ 2538.461037]  scsi_execute_cmd+0x7c/0x23c
> [ 2538.461040]  ioctl_internal_command+0x5c/0x164
> [ 2538.461046]  scsi_set_medium_removal+0x5c/0xb0
> [ 2538.461051]  sd_release+0x50/0x94
> [ 2538.461054]  blkdev_put+0x190/0x28c
> [ 2538.461058]  blkdev_release+0x28/0x40
> [ 2538.461063]  __fput+0xf8/0x2a8
> [ 2538.461066]  __fput_sync+0x28/0x5c
> [ 2538.461070]  __arm64_sys_close+0x84/0xe8
> [ 2538.461073]  invoke_syscall+0x58/0x114
> [ 2538.461078]  el0_svc_common+0xac/0xe0
> [ 2538.461082]  do_el0_svc+0x1c/0x28
> [ 2538.461087]  el0_svc+0x38/0x68
> [ 2538.461090]  el0t_64_sync_handler+0x68/0xbc
> [ 2538.461093]  el0t_64_sync+0x1a8/0x1ac
>
>   T1:                           T2:
>   sd_remove
>   del_gendisk
>   __blk_mark_disk_dead
>   blk_freeze_queue_start
>   ++q->mq_freeze_depth
>                                 bdev_release
>                                 mutex_lock(&disk->open_mutex)
>                                 sd_release
>                                 scsi_execute_cmd
>                                 blk_queue_enter
>                                 wait_event(!q->mq_freeze_depth)
>   mutex_lock(&disk->open_mutex)
>
> SCSI does not set GD_OWNS_QUEUE, so QUEUE_FLAG_DYING is not set in
> this scenario. This is a classic ABBA deadlock. To fix the deadlock,

del_gendisk() shouldn't fail scsi_execute_cmd(), so QUEUE_FLAG_DYING
can't be set.

> make sure we don't try to acquire disk->open_mutex after freezing
> the queue.
>
> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>
> ---
> Changes from v1:
>   - Modify commit message by suggestion
> ---
>  block/genhd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/genhd.c b/block/genhd.c
> index 8f1f3c6b4d67..c5fca3e893a0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -663,12 +663,12 @@ void del_gendisk(struct gendisk *disk)
>          */
>         if (!test_bit(GD_DEAD, &disk->state))
>                 blk_report_disk_dead(disk, false);
> -       __blk_mark_disk_dead(disk);
>
>         /*
>          * Drop all partitions now that the disk is marked dead.
>          */
>         mutex_lock(&disk->open_mutex);
> +       __blk_mark_disk_dead(disk);
>         xa_for_each_start(&disk->part_tbl, idx, part, 1)
>                 drop_partition(part);
>         mutex_unlock(&disk->open_mutex);

This fix looks fine, and the added lock dependency is safe since
mq_freeze_lock is block layer internal lock, so:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,

