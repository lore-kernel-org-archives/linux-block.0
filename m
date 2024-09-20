Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35317838C
	for <linux-block@vger.kernel.org>; Fri, 20 Sep 2024 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726842030; cv=none; b=ty7KI06kl4d3F1Rv0Ru62wg92BrI7YslXRELZh5oCyu+htOYluyZ9ka7FB1ZTqEd2akDtQvrDOGocW8p8pMO4RJPQVB9QNGnOW0X1q7oV3cgVoq3fx2TtNzh9+yVJYybo8sZlyhjj+E0FcG5uMU7K5VJ9Og3OgYknAhe3QOJlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726842030; c=relaxed/simple;
	bh=VuAAW+C9+09hTVErW/kMvUUITjpu2YXDEAAT/D/9+80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g9ZNbp61kZ5UA7lyGeqFcgzGTb8OX8NVhHAB6e6+lSLohmJbJvR+cqGedd3vr57kjpCO0hlYAZggX6X9rq9JxrAlg36kZPrIFbx0Ojxg/wG6axMM3Bs3ehL39dy7m68pmr9NS+QkEm5JQWKRYLZpOvGYcz0Mxo55sDaYRq8oM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2IfqjQ5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2IfqjQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726842027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fCalEBABFVFsMMhs8TPEqo8Ap8uiBjRPjKqEGdMLqnE=;
	b=g2IfqjQ5Gj+tc8RgRqVVvFiSYqTcdW8Utbz7u7OXiU4ah6LJoZ6A+38jMu92nusZLG36Lk
	chLoT97pkYhYYNByX704S1a76loAVte+/sDTxUPP9FCFM4FVkPd6BTG6upETZ1x9GwtMQw
	Td/xZt0ifw0RIR0+Nke/t2WOYbgdiQE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-wxKwX2dSMjaUM_AqgQXZxA-1; Fri, 20 Sep 2024 10:20:26 -0400
X-MC-Unique: wxKwX2dSMjaUM_AqgQXZxA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8b3af9e61so2245985a91.2
        for <linux-block@vger.kernel.org>; Fri, 20 Sep 2024 07:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726842024; x=1727446824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCalEBABFVFsMMhs8TPEqo8Ap8uiBjRPjKqEGdMLqnE=;
        b=mXoNw6Qq6SElo111IyqmUthZAQROfm9LsZt2KeBECKPHPu+6LZIoh9JncJ4ARQCNUK
         lV6mKDOwTB3pqnUoSw7uQFYUpW0k1f+IJbnTSm+iNpqPYyrZt4lXuI7tmFR6R9JdJIu8
         SgGBFx9j6Ok+BLyzYWkYJm+AxxCfumgEWUa6rwZejY1mrefj5B1InoEolcRmI+MxoRCV
         UntEWawMUQgwc0DdzNEwm0PwK05DxyHjWqmo53SUULKONRJ3p4sxwbWJJ59alfkPLg7w
         Hro/7M7DX3GDtgt+Ufl/bUNwJT2RfpijP9Pa5UmM4eUDfhvqG4nnUnu1ympKTcq5ACtm
         nkzw==
X-Gm-Message-State: AOJu0YyqNHVuolELurwAtlzU3Q7OuATaKnq/xESIeWSEu/S6yv0HLV8B
	3yTPfhMpGXrrBpgR/Da969UCwNJ3JuVYNG+karuiflayuFHLRB2P+ty56/MIaW+t9RKskZD+bgR
	3ov4ocg0UBEQOvCmfdjnFfCfP5i8/tHqGcMhjJPuVJcDcyRe1zG4uMEyqeCLaYOelkNDDw1GYlA
	bpSU3VAdQV9JM7FB+jqNumhRezIa0Hhwg5Hrqwj7Trkm7xpg==
X-Received: by 2002:a17:90a:62c7:b0:2da:9490:900c with SMTP id 98e67ed59e1d1-2dd80c7ecbcmr3202657a91.21.1726842024033;
        Fri, 20 Sep 2024 07:20:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyCh2QJpZ4RfCR4/0c8rkzSouxSf5uv4vyNtzdlJMeQxeDouDT2kEKJZpDylsJEwPmGG+nC5N7oytgOPvdg2Q=
X-Received: by 2002:a17:90a:62c7:b0:2da:9490:900c with SMTP id
 98e67ed59e1d1-2dd80c7ecbcmr3202632a91.21.1726842023707; Fri, 20 Sep 2024
 07:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
In-Reply-To: <CAHj4cs90xV1t2NbV6P3_z1oYwD0BcvMhC5V2mGgekRq8iae=NA@mail.gmail.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Fri, 20 Sep 2024 22:20:11 +0800
Message-ID: <CAHj4cs8YGgmemMZDXmt7yHa+Xq3EiEvRWOJGEQTDjqGB2rAogw@mail.gmail.com>
Subject: Re: [bug report][regression][bisected] most of blktests nvme/tcp
 failed with the last linux code
To: linux-block <linux-block@vger.kernel.org>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Hannes
I did bisect and it seems was introduced with the below commit:

commit 1e48b34c9bc79aa36700fccbfdf87e61e4431d2b
Author: Hannes Reinecke <hare@suse.de>
Date:   Mon Jul 22 14:02:22 2024 +0200

    nvme: split off TLS sysfs attributes into a separate group


On Thu, Sep 19, 2024 at 12:09=E2=80=AFAM Yi Zhang <yi.zhang@redhat.com> wro=
te:
>
> Hello
>
> CKI reported most of the blktests nvme/tcp tests failed on the linux
> tree[1], here is the reproducer and dmesg log, the issue cannot be
> reproduced with 6.11.0, seems
> it was introduced with the latest block code merge, please help check
> it and let me know if you need any info/testing about it, thanks.
>
>
> [1]
> https://datawarehouse.cki-project.org/kcidb/tests/14394423
>
> [2]
> # nvme_trtype=3Dtcp ./check nvme/003
> nvme/003 (tr=3Dtcp) (test if we're sending keep-alives to a discovery
> controller) [failed]
>     runtime  11.280s  ...  11.188s
>     --- tests/nvme/003.out 2024-09-18 11:30:11.243366401 -0400
>     +++ /root/blktests/results/nodev_tr_tcp/nvme/003.out.bad
> 2024-09-18 11:52:32.977112834 -0400
>     @@ -1,3 +1,3 @@
>      Running nvme/003
>     -disconnected 1 controller(s)
>     +disconnected 0 controller(s)
>      Test complete
> # dmesg
> [  447.213539] run blktests nvme/003 at 2024-09-18 11:52:21
> [  447.229285] loop0: detected capacity change from 0 to 2097152
> [  447.233104] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  447.242398] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [  447.251089] sysfs: cannot create duplicate filename
> '/devices/virtual/nvme-fabrics/ctl/nvme0/reset_controller'
> [  447.251810] CPU: 2 UID: 0 PID: 5241 Comm: nvme Kdump: loaded Not
> tainted 6.12.0-0.rc0.adfc3ded5c33.2.test.el10.aarch64 #1
> [  447.252540] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/=
2015
> [  447.253006] Call trace:
> [  447.253171]  dump_backtrace+0xd8/0x130
> [  447.253432]  show_stack+0x20/0x38
> [  447.253657]  dump_stack_lvl+0x80/0xa8
> [  447.253925]  dump_stack+0x18/0x30
> [  447.254152]  sysfs_warn_dup+0x6c/0x90
> [  447.254406]  sysfs_add_file_mode_ns+0x12c/0x138
> [  447.254713]  create_files+0xa8/0x1f8
> [  447.254973]  internal_create_group+0x18c/0x358
> [  447.255274]  internal_create_groups+0x58/0xe0
> [  447.255558]  sysfs_create_groups+0x20/0x40
> [  447.255826]  device_add_attrs+0x19c/0x218
> [  447.256093]  device_add+0x310/0x6d0
> [  447.256327]  cdev_device_add+0x58/0xc0
> [  447.256579]  nvme_add_ctrl+0x78/0xd0 [nvme_core]
> [  447.256895]  nvme_tcp_create_ctrl+0x3c/0x178 [nvme_tcp]
> [  447.257248]  nvmf_create_ctrl+0x150/0x288 [nvme_fabrics]
> [  447.257614]  nvmf_dev_write+0x98/0xf8 [nvme_fabrics]
> [  447.257948]  vfs_write+0xdc/0x380
> [  447.258174]  ksys_write+0x7c/0x120
> [  447.258408]  __arm64_sys_write+0x24/0x40
> [  447.258673]  invoke_syscall.constprop.0+0x74/0xd0
> [  447.258994]  do_el0_svc+0xb0/0xe8
> [  447.259225]  el0_svc+0x44/0x1a0
> [  447.259449]  el0t_64_sync_handler+0x120/0x130
> [  447.259745]  el0t_64_sync+0x1a4/0x1a8
>
> --
> Best Regards,
>   Yi Zhang



--=20
Best Regards,
  Yi Zhang

