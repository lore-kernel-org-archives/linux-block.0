Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A64C98
	for <linux-block@vger.kernel.org>; Thu, 25 Apr 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714010061; cv=none; b=MVCu8zBu70szwz94FcmYO+NHABtc5DgQKcPQ+Awpc6xH5JHcnNegyuX6lbK2CFB7J457cs/kcbDyTJ8loqJExQjfI03DnhBqOk+DlGxNZpNBkZF5oOHdryLzlP6tptzgpYb7TXTqMmSBx5AcLvZpgGrvpaGk9J2colCpMiDdGRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714010061; c=relaxed/simple;
	bh=YiJQQm3WLB1WWnCg6KHdif+jeioO6Q4aOnhRdwHr1rg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gVh9XWERdF2vpw5JqP3EdELhYUWJ6IExMq1pxRXJBPb97ZoGSyL88DgBRv3lVQOOeWhCAQS43Ep+nuF9gaO10flyjjfScv3O39qCXDVqKMHY+W97+SnOrVfVs8OVFYO/hj7xeYZQ2cUtjKLMqoWO05d1R9Q9mIPcxEW6dh6Zs/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e202B2Bl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e202B2Bl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714010058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KAGedGByEbushDO5nbCtOFuWCCxLdgMCo2UW6xpFwzQ=;
	b=e202B2BluSzRxiyk8FEE5csZZyeAVhavvfnNri/ReDUYg3EOGQnw90fNqHj43niUn73OdL
	GmXUgBhJOf5EKNE1/kMyjXTCFQi5gYZ1FWE2rjuHOFBNwHTGGlTbRAS+fXxFtoVvwENEsT
	4RglK/nva1/AimnLULrKa5mcAcU34r0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-9a8V4pcUPeOrygjwA7WxEg-1; Wed, 24 Apr 2024 21:54:17 -0400
X-MC-Unique: 9a8V4pcUPeOrygjwA7WxEg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a556121c01aso22227266b.2
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2024 18:54:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714010055; x=1714614855;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAGedGByEbushDO5nbCtOFuWCCxLdgMCo2UW6xpFwzQ=;
        b=T6N5vQSJTso5y+Yk/WyZhqQsX9BLcH3XH1u4FLcjbSZVxsO/MZyyrCZlP0/b4EWGwe
         p7FUn0l/UDjC3yyRm/e7uccmw0oCqAbLD8pKaWNhMgOnKs2MwdHpGjuE/emw1oaRMLMT
         /sjS0YEeCa8Zg3S5ryF0eVpSLxBY9RAhd8okEp9YfNEb95GRP+NGhFFHplV0CnGm+oZu
         ulGZGT4+hobz5wI7LZncq29Qcudgzg9xB1WLR9/JhPw/9laHViCmWTrqFQBwTbURgvps
         8jS+yp77XwPLd+Ls2Ce18EI9PgtHdb/R3EvGtNa4/303wlCWiB6uaw9x0DeD2tIlCNjm
         yCrA==
X-Forwarded-Encrypted: i=1; AJvYcCVdV/GTEscsY+dvsqXjFcQi/WW1kgtQRyRPgB2EWDeV1afoKffsCrN/fy9cB6Hxng44Lv2O8+wilGQRUzFubC6rLegaz/qP7Gk/sU4=
X-Gm-Message-State: AOJu0YwbxPrL9eN9neTybCRJZ01NSsCfSsADCELkNybJPUJ17ZXgOlYp
	rc498ZVRX9eILgeLEmxgG40vnIrU5XgOpPFwu93lzjdxy37eE4qdmhBfk2rzolH60AmDVsgH5DJ
	N6jSKu7BnN2Ng0tf3Iyo4ysELAzMBCA+t6swtxNU6WhFjhCpfHH5U+/MoEix/XMXxqXTTHQd7xR
	zEQFu+moWOFRsytNc/xknUgcJ95bumaBXM4OrWbCkCmDeVuWm8
X-Received: by 2002:a17:907:7213:b0:a55:6507:6a35 with SMTP id dr19-20020a170907721300b00a5565076a35mr3563362ejc.49.1714010055622;
        Wed, 24 Apr 2024 18:54:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvtiFU55qbSX2FKMazqad263K0VBdlwL6kks2UTCh+/lFxWJoXQR/hyUU7/RxZEe6ZiXXaR1YiYMm29WfWUcQ=
X-Received: by 2002:a17:907:7213:b0:a55:6507:6a35 with SMTP id
 dr19-20020a170907721300b00a5565076a35mr3563345ejc.49.1714010055287; Wed, 24
 Apr 2024 18:54:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Guangwu Zhang <guazhang@redhat.com>
Date: Thu, 25 Apr 2024 09:54:04 +0800
Message-ID: <CAGS2=YobBtv0JnQJSYcu9x57y_VqS7-4NemWjsFdaPcpLLVm1Q@mail.gmail.com>
Subject: [bug report] Format FS failed with ublk device
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,
the format FS command will hung up  with ublk device.

# ublk --version
ublksrv 1.1-7-gf01c509

kerne: 6.9.0-rc4.kasan


nvme0n1                     259:1    0   1.5T  0 disk
=E2=94=94=E2=94=80nvme0n1p1                 259:2    0     5G  0 part
# ublk add -t loop -f /dev/nvme0n1p1
dev id 0: nr_hw_queues 1 queue_depth 128 block size 4096 dev_capacity 10485=
760
max rq size 524288 daemon pid 3227 flags 0x42 state LIVE
ublkc: 245:0 ublkb: 259:3 owner: 0:0
queue 0: tid 3228 affinity(0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
18 19 20 21 22 23 24 25 26 27 28 29 30 31 )
target {"backing_file":"/dev/nvme0n1p1","dev_size":5368709120,"direct_io":1=
,"name":"loop","type":1}

# mkfs.xfs -f /dev/ublkb0    << can not finish,  pid 3239
meta-data=3D/dev/ublkb0            isize=3D512    agcount=3D4, agsize=3D327=
680 blks
         =3D                       sectsz=3D4096  attr=3D2, projid32bit=3D1
         =3D                       crc=3D1        finobt=3D1, sparse=3D1, r=
mapbt=3D0
         =3D                       reflink=3D1    bigtime=3D1 inobtcount=3D=
1 nrext64=3D0
data     =3D                       bsize=3D4096   blocks=3D1310720, imaxpct=
=3D25
         =3D                       sunit=3D0      swidth=3D0 blks
naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=3D1
log      =3Dinternal log           bsize=3D4096   blocks=3D16384, version=
=3D2
         =3D                       sectsz=3D4096  sunit=3D1 blks, lazy-coun=
t=3D1
realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=3D0

# cat /proc/3239/stack
[<0>] rq_qos_wait+0x12a/0x1f0
[<0>] wbt_wait+0x11a/0x240
[<0>] __rq_qos_throttle+0x49/0x90
[<0>] blk_mq_submit_bio+0x58c/0x19d0
[<0>] submit_bio_noacct_nocheck+0x40d/0x780
[<0>] blk_next_bio+0x41/0x50
[<0>] __blkdev_issue_zero_pages+0x1ba/0x370
[<0>] blkdev_issue_zeroout+0x1a7/0x390
[<0>] blkdev_fallocate+0x264/0x3d0
[<0>] vfs_fallocate+0x2b0/0xad0
[<0>] __x64_sys_fallocate+0xb4/0x100
[<0>] do_syscall_64+0x7b/0x160
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  862.171377] INFO: task mkfs.xfs:3239 blocked for more than 122 seconds.
[  862.178073]       Not tainted 6.9.0-rc4.kasan+ #1
[  862.182820] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  862.190721] task:mkfs.xfs        state:D stack:0     pid:3239
tgid:3239  ppid:1801   flags:0x00004002
[  862.190733] Call Trace:
[  862.190737]  <TASK>
[  862.190742]  __schedule+0x65f/0x15a0
[  862.190759]  ? blk_mq_flush_plug_list.part.0+0xd7/0x4a0
[  862.190774]  ? __pfx___schedule+0x10/0x10
[  862.190779]  ? __blk_flush_plug+0x286/0x4a0
[  862.190790]  ? __pfx___blk_flush_plug+0x10/0x10
[  862.190795]  ? kmem_cache_alloc+0x145/0x390
[  862.190803]  ? __pfx_rq_wait_inc_below+0x10/0x10
[  862.190812]  ? __pfx_wbt_inflight_cb+0x10/0x10
[  862.190820]  schedule+0x70/0x1b0
[  862.190826]  io_schedule+0xc0/0x130
[  862.190832]  rq_qos_wait+0x12a/0x1f0
[  862.190840]  ? __pfx_rq_qos_wait+0x10/0x10
[  862.190845]  ? __pfx_rq_qos_wake_function+0x10/0x10
[  862.190850]  ? __pfx_wbt_inflight_cb+0x10/0x10
[  862.190856]  ? submit_bio_noacct_nocheck+0x78/0x780
[  862.190862]  wbt_wait+0x11a/0x240
[  862.190868]  ? __pfx_wbt_wait+0x10/0x10
[  862.190874]  __rq_qos_throttle+0x49/0x90
[  862.190880]  blk_mq_submit_bio+0x58c/0x19d0
[  862.190888]  ? __pfx_blk_mq_submit_bio+0x10/0x10
[  862.190893]  ? bio_associate_blkg_from_css+0x246/0xad0
[  862.190901]  ? blk_cgroup_bio_start+0x281/0x3e0
[  862.190908]  submit_bio_noacct_nocheck+0x40d/0x780
[  862.190912]  ? bio_alloc_bioset+0x43c/0x770
[  862.190923]  ? __pfx_submit_bio_noacct_nocheck+0x10/0x10
[  862.190929]  ? submit_bio_noacct+0x210/0x1780
[  862.190935]  blk_next_bio+0x41/0x50
[  862.190939]  __blkdev_issue_zero_pages+0x1ba/0x370
[  862.190948]  ? __pfx_vfs_write+0x10/0x10
[  862.190957]  blkdev_issue_zeroout+0x1a7/0x390
[  862.190964]  ? __pfx_blkdev_issue_zeroout+0x10/0x10
[  862.190974]  blkdev_fallocate+0x264/0x3d0
[  862.190981]  vfs_fallocate+0x2b0/0xad0
[  862.190989]  __x64_sys_fallocate+0xb4/0x100
[  862.190994]  do_syscall_64+0x7b/0x160
[  862.191005]  ? __vm_munmap+0x139/0x230
[  862.191012]  ? __pfx___vm_munmap+0x10/0x10
[  862.191016]  ? fpregs_restore_userregs+0xe3/0x1f0
[  862.191029]  ? syscall_exit_work+0xff/0x130
[  862.191037]  ? syscall_exit_to_user_mode+0x78/0x200
[  862.191045]  ? do_syscall_64+0x87/0x160
[  862.191050]  ? do_user_addr_fault+0x477/0xad0
[  862.191061]  ? exc_page_fault+0x59/0xc0
[  862.191067]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  862.191077] RIP: 0033:0x7f2c9e3025da
[  862.191083] RSP: 002b:00007ffd2f328b38 EFLAGS: 00000246 ORIG_RAX:
000000000000011d
[  862.191089] RAX: ffffffffffffffda RBX: 00000000a0009000 RCX: 00007f2c9e3=
025da
[  862.191094] RDX: 00000000a0009000 RSI: 0000000000000010 RDI: 00000000000=
00004
[  862.191097] RBP: 0000000000020000 R08: 0000000000000000 R09: 00000000000=
00000
[  862.191100] R10: 0000000004000000 R11: 0000000000000246 R12: 00005629d6f=
66870
[  862.191104] R13: 00007ffd2f329260 R14: 0000000000000004 R15: 00000000000=
00002
[  862.191111]  </TASK

