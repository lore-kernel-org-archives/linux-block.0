Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0117B4EB
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714486648; cv=none; b=umxqcACaO9Kz3106MB3Xw66USbed5L+jqB7aU1TNJBoA5uOdmKMREtpHldTA5Kef1argjm2n4f6izLcbVTFO3hauhOcsET0X9xNUvORBBjTegmuadn/pdi+51W3Hv2kxw+0pqnSvxko21e/Wu0zYPKm58cUv8eXNhCH5c2EqY/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714486648; c=relaxed/simple;
	bh=Dg0MzuwtDgAzKEsKKVAdH3LZuB2yz/x6en0sZ50jecU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMm/YT/Z98YTemk++Z0quGngaTEObESyBuRDixOmKA++EAOSRM7Sjur89hYUlH3xAd5oxlvfVh/c///mj51qcRuPTyOK1F/gEgl0a2enwQg5vMoRyt1vbMDpl43QTSY44zoNLbMENnN0WFO5GrKHkpL28WEWBl3GLGzr9WbOmNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SyzfFrwp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SyzfFrwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714486644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tkKnyVhNvrBQagq6/KTRiauumw2/czr0ivE7Xi1IcsE=;
	b=SyzfFrwpt2XqmaOyGW6iSYdTUP33q1LMDwZLw1mhJeHCyBl3VcpBzqme9/6GJfUHSDjggF
	RgeUUhRwrMwoT6DKbjgRyqxx2RFGUSWdY+9HxIMsKDvJZX3CZI1Igv/fprxEUp15nxx6eO
	TIXi5bJpLN9CIiZbS6t2vYcqDE0lgH8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-5HaL5jXDM7WCTfMvXmLnAg-1; Tue, 30 Apr 2024 10:17:23 -0400
X-MC-Unique: 5HaL5jXDM7WCTfMvXmLnAg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2b2c438d031so301425a91.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 07:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714486641; x=1715091441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkKnyVhNvrBQagq6/KTRiauumw2/czr0ivE7Xi1IcsE=;
        b=QVdP13DpSON34jHPsJxAWUB3fCrxpEnwMO/BKi5NsmesGE00UlDa8XAi9LP97lK/Ig
         /qKjnmgy2IEGGYL6P3kLEBlb1Y7WP+jMRIbevF5LZG2GGxVbECDayh2OZl1ZU8Cy7/5f
         BPWlFok5D64uWvBR1iAC/c2wJnB5WjffH85omLe/cLD8M4UKqn3jKRa3NsI0AfbZT89I
         DlNVy3XINsRXN9AtIObyfADwg5Ejw7FikcKMJ4m2juqxyjDZYc9v0dtLiRZ4pAQs8v19
         LP88v+Ch0D6h2kbOcG74KpKDvrYVDABwSTK65YLZxiPOHhEOghA1SYvSC9XSV12JiXcN
         C8Gw==
X-Forwarded-Encrypted: i=1; AJvYcCUza7e/eiOJdFrbZHFFBxUJJUVmoQoiW+hZOyc5eO+eMjkdebKey46R7wt7kBmZ5jS0D9VMuB+KgJ739bLewDtUzD0uLsC3acH5IZo=
X-Gm-Message-State: AOJu0YyMkYA9EKAO5UiJ8h77rdK8EB5zVESdOBqQrgE98RS6xh1YbcMw
	3dmO4FtBdWkeGhD4tZSILd1Hxqjz844zCV/bwzB5zP1V3ZVyW0JUM8KqJEzBxmtaO7elIBpsiON
	Qqn3hD3mfHazKVArhpIZn5/xmpbluAn7fyqyV9KigoAhY2tROxU3LIJYqVJLiIQnrs3i9UnEKI5
	MfebeeTx5JbX06fiKGxVgfDBAU+mIJMgRfjczFnwifVM/Uqg==
X-Received: by 2002:a17:90b:4a8f:b0:2a5:f19:978d with SMTP id lp15-20020a17090b4a8f00b002a50f19978dmr3044538pjb.37.1714486641252;
        Tue, 30 Apr 2024 07:17:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFreilTEzi4jgoqCEUd0HqgILrV3AJHsBQAzL8L7ttDETqE55m26zZsV9Yha1p5qKharZxB4ed3HxzY3t7T4gU=
X-Received: by 2002:a17:90b:4a8f:b0:2a5:f19:978d with SMTP id
 lp15-20020a17090b4a8f00b002a50f19978dmr3044508pjb.37.1714486640799; Tue, 30
 Apr 2024 07:17:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs8X31NnOWGVLniT5OWBRtEphxw-AcYrPaygG_uYaoeENQ@mail.gmail.com>
 <dcc6150c-d632-4b14-9b0d-1b3b45fb5c24@wdc.com> <aded9da3-347a-4268-8190-6f39692ea8ee@nvidia.com>
 <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
In-Reply-To: <25fd1c08-fe6a-48dc-874e-464b2b0e12e5@wdc.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 30 Apr 2024 22:17:06 +0800
Message-ID: <CAHj4cs-h7Fi+G_aQiv-q4+ea4uki8Yiw6AHpWdZvaazg11Gd9Q@mail.gmail.com>
Subject: Re: [bug report] RIP: 0010:blk_flush_complete_seq+0x450/0x1060
 observed during blktests nvme/tcp nvme/012
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 2:17=E2=80=AFPM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 30.04.24 00:18, Chaitanya Kulkarni wrote:
> > On 4/29/24 07:35, Johannes Thumshirn wrote:
> >> On 23.04.24 15:18, Yi Zhang wrote:
> >>> Hi
> >>> I found this issue on the latest linux-block/for-next by blktests
> >>> nvme/tcp nvme/012, please help check it and let me know if you need
> >>> any info/testing for it, thanks.
> >>>
> >>> [ 1873.394323] run blktests nvme/012 at 2024-04-23 04:13:47
> >>> [ 1873.761900] loop0: detected capacity change from 0 to 2097152
> >>> [ 1873.846926] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> >>> [ 1873.987806] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> >>> [ 1874.208883] nvmet: creating nvm controller 1 for subsystem
> >>> blktests-subsystem-1 for NQN
> >>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> >>> [ 1874.243423] nvme nvme0: creating 48 I/O queues.
> >>> [ 1874.362383] nvme nvme0: mapped 48/0/0 default/read/poll queues.
> >>> [ 1874.517677] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> >>> 127.0.0.1:4420, hostnqn:
> >>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> >
> > [...]
> >
> >>>
> >>> [  326.827260] run blktests nvme/012 at 2024-04-29 16:28:31
> >>> [  327.475957] loop0: detected capacity change from 0 to 2097152
> >>> [  327.538987] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> >>>
> >>> [  327.603405] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> >>>
> >>>
> >>> [  327.872343] nvmet: creating nvm controller 1 for subsystem
> >>> blktests-subsystem-1 for NQN
> >>> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
> >>>
> >>> [  327.877120] nvme nvme0: Please enable CONFIG_NVME_MULTIPATH for fu=
ll
> >>> support of multi-port devices.
> >
> > seems like you don't have multipath enabled that is one difference
> > I can see in above log posted by Yi, and your log.
>
>
> Yup, but even with multipath enabled I can't get the bug to trigger :(

It's not one 100% reproduced issue, I tried on my another server and
it cannot be reproduced.

>
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns)
>
> [  279.642826] run blktests nvme/012 at 2024-04-29 18:52:26
>
> [  280.296493] loop0: detected capacity change from 0 to 2097152
> [  280.360139] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>
>
> [  280.426171] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  280.712262] nvmet: creating nvm controller 1 for subsystem
> blktests-subsystem-1 for NQN
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
>
> [  280.718259] nvme nvme0: creating 4 I/O queues.
>
>
> [  280.722258] nvme nvme0: mapped 4/0/0 default/read/poll queues.
>
>
> [  280.726088] nvme nvme0: new ctrl: NQN "blktests-subsystem-1", addr
> 127.0.0.1:4420, hostnqn:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> [  281.343044] XFS (nvme0n1): Mounting V5 Filesystem
> 513881ee-db18-48c7-a2b0-3e4e3e41f38c
>
> [  281.381925] XFS (nvme0n1): Ending clean mount
>
>
> [  281.390154] xfs filesystem being mounted at /mnt/blktests supports
> timestamps until 2038-01-19 (0x7fffffff)
> [  309.958309] perf: interrupt took too long (2593 > 2500), lowering
> kernel.perf_event_max_sample_rate to 77000
>
> [  377.847337] perf: interrupt took too long (3278 > 3241), lowering
> kernel.perf_event_max_sample_rate to 61000
>
> [  471.964099] XFS (nvme0n1): Unmounting Filesystem
> 513881ee-db18-48c7-a2b0-3e4e3e41f38c
>
> nvme/012 (run mkfs and data verification fio job on NVMeOF block
> device-backed ns) [passed]
>
>      runtime    ...  192.747s
>
>
>
> Can you see if you can reproduce it on your side?
>
> Thanks,
>         Johannes



--=20
Best Regards,
  Yi Zhang

