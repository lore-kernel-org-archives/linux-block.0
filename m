Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD051FCF5B
	for <linux-block@vger.kernel.org>; Wed,  8 Jan 2025 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736346627; cv=none; b=ZwskEP1wSd54UzCFh2WDyq3CQuEleE6YwSpRfPVJl2OSL2yJfr5Mc3EsRI4WtK6O5PZkpLX5wrigtfz8YdbQK67ESk5ArPEmHcEUtU394otR/qDSrbxX06rYJcrAnsqkury2I3hhbjPjlncsyGMqNdsFat+g1S/rnG/FdWuD1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736346627; c=relaxed/simple;
	bh=hXxdGM1/ZZBySuqs0woYavYjyNMj+V+ENb4AZAxt8xw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lbI7k6nKeJCDr4AzFpnmySvSD1PxmvL5o/UaUDWs2v0r8H+su6pQ/AYCK+Jjk+Ai7+2eij7383Km+we6NMvP8+tTWFb7TPBBs9wUGe0ekv34uQ2qObVyCUmpjrCe4bfGn4bs9uMD7goysLGuxI+JpOcrK7TQcKK8nC9FuRoFGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=l4xn5geR; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="l4xn5geR"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a9cb667783so126923835ab.1
        for <linux-block@vger.kernel.org>; Wed, 08 Jan 2025 06:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736346624; x=1736951424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DuVh8yvTcgPWHjlIoS+IJBGxlHJC9yCWBv/cQMDWTMs=;
        b=l4xn5geR5rSgeYxJRFB65mxhzaETBkonYn6+mlDpcOv0dybNXCQweXdq3ZsSI2mTmG
         jkJgjpdxAEbonipKNEuvVxx/oRE4fzTfE/0aYpRSfKJYB0YwSBW+wGdfj9amiznVAuJ9
         UQ+nWX7DDAv4SehyZjYPO46S+B71zL6eKKMpn4PLB8Guzv6RuVRavy7IoPZAcgQhBHXJ
         fBXJRKxcT5EgaY/03y+PD4Xfn5wjFKYISyLnFWhXlTmmyisDxgLz0uq9auy3ml2SU7mK
         2EMEq+BOpyOknYV9gQ4caRzUO7OjBlYCVJQRpquDQilZqwUil38JtLQJ2ClUQ4c7tgOV
         76Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736346624; x=1736951424;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DuVh8yvTcgPWHjlIoS+IJBGxlHJC9yCWBv/cQMDWTMs=;
        b=LSnuIlVhhFy8+0l0rLQ6r06DVwZ8X/IMwtvp+/JLdVm9CagJ6JRVUOTzmyXs4EvnQX
         xitQUzCMIv37EszimKZklWi8ExFYz7MetTuDJhWiRfpbm91C6+AG6c51Ef+OiOFV+kmK
         z/F5ATiEUt8+HuucuXwnz6ZfvyJ9bexoMKBphAap0sUZVQl1ryC1jizC0cpnJ4VcGlS5
         ntP6hLtVjPw1xLq4ioyLIMYV7Ta+S8bzi6zVBDKm0pUqTfkc4rpg//wukW3UlSs11/a7
         Uirn3jOPmGIoDw/IOU4DBoHOGI86pXt+N5fGlvYARPE4XjKxsUrX9ifaGeJttC3u61bf
         sptQ==
X-Gm-Message-State: AOJu0YxdekMrQmOjyslo/wGhPhAmlhDvru54LbMUFXsfmc3q8yQh8fHK
	pB0pLlEZlSsFaOsvz5fc5R1fbQRHTwkWuTa3uYKiRwob6QS6YRgM5G2I8VOVl7A=
X-Gm-Gg: ASbGncuhuXV/zGw1x3+F0qFzs02D2SeqAUBz4LIQqerQKxLqF9gLDd2uZRBvHNrAhDt
	JLG1r8NJWOZdbu1m7njuz3aEdY/eCyc4edUwTow02pp0dIoQLsSws2JD/tk20FRvu4yCZqoXreZ
	Td255KpaWQl86HPW5Kr5HRCjStP7sMWMdahtaIXdNh+oECuhxEaHMJSVTpfyzx8z6Rnomci+R0B
	xiF9xvkJ7OWpexrYkJDfoNNLseg753Mh5O3yZNNlyx0Ke8=
X-Google-Smtp-Source: AGHT+IEILOGftdUa2gw3p76dHAOiz0IU4GolIFxvk/mdMt1nBUxede1jLEdZho67wkyulPLiuu8dNg==
X-Received: by 2002:a05:6e02:156d:b0:3a7:e3e3:bd57 with SMTP id e9e14a558f8ab-3ce3a8beb89mr24027085ab.15.1736346623663;
        Wed, 08 Jan 2025 06:30:23 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c1de6e0sm10602714173.127.2025.01.08.06.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 06:30:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: jack@suse.cz, yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20250108084148.1549973-1-yukuai1@huaweicloud.com>
References: <20250108084148.1549973-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH] block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()
Message-Id: <173634662244.346437.17736271332101517970.b4-ty@kernel.dk>
Date: Wed, 08 Jan 2025 07:30:22 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Wed, 08 Jan 2025 16:41:48 +0800, Yu Kuai wrote:
> Our syzkaller report a following UAF for v6.6:
> 
> BUG: KASAN: slab-use-after-free in bfq_init_rq+0x175d/0x17a0 block/bfq-iosched.c:6958
> Read of size 8 at addr ffff8881b57147d8 by task fsstress/232726
> 
> CPU: 2 PID: 232726 Comm: fsstress Not tainted 6.6.0-g3629d1885222 #39
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x91/0xf0 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x66/0x300 mm/kasan/report.c:364
>  print_report+0x3e/0x70 mm/kasan/report.c:475
>  kasan_report+0xb8/0xf0 mm/kasan/report.c:588
>  hlist_add_head include/linux/list.h:1023 [inline]
>  bfq_init_rq+0x175d/0x17a0 block/bfq-iosched.c:6958
>  bfq_insert_request.isra.0+0xe8/0xa20 block/bfq-iosched.c:6271
>  bfq_insert_requests+0x27f/0x390 block/bfq-iosched.c:6323
>  blk_mq_insert_request+0x290/0x8f0 block/blk-mq.c:2660
>  blk_mq_submit_bio+0x1021/0x15e0 block/blk-mq.c:3143
>  __submit_bio+0xa0/0x6b0 block/blk-core.c:639
>  __submit_bio_noacct_mq block/blk-core.c:718 [inline]
>  submit_bio_noacct_nocheck+0x5b7/0x810 block/blk-core.c:747
>  submit_bio_noacct+0xca0/0x1990 block/blk-core.c:847
>  __ext4_read_bh fs/ext4/super.c:205 [inline]
>  ext4_read_bh+0x15e/0x2e0 fs/ext4/super.c:230
>  __read_extent_tree_block+0x304/0x6f0 fs/ext4/extents.c:567
>  ext4_find_extent+0x479/0xd20 fs/ext4/extents.c:947
>  ext4_ext_map_blocks+0x1a3/0x2680 fs/ext4/extents.c:4182
>  ext4_map_blocks+0x929/0x15a0 fs/ext4/inode.c:660
>  ext4_iomap_begin_report+0x298/0x480 fs/ext4/inode.c:3569
>  iomap_iter+0x3dd/0x1010 fs/iomap/iter.c:91
>  iomap_fiemap+0x1f4/0x360 fs/iomap/fiemap.c:80
>  ext4_fiemap+0x181/0x210 fs/ext4/extents.c:5051
>  ioctl_fiemap.isra.0+0x1b4/0x290 fs/ioctl.c:220
>  do_vfs_ioctl+0x31c/0x11a0 fs/ioctl.c:811
>  __do_sys_ioctl fs/ioctl.c:869 [inline]
>  __se_sys_ioctl+0xae/0x190 fs/ioctl.c:857
>  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
>  do_syscall_64+0x70/0x120 arch/x86/entry/common.c:81
>  entry_SYSCALL_64_after_hwframe+0x78/0xe2
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix waker_bfqq UAF after bfq_split_bfqq()
      commit: eb92f7314625807ad569c218039ec90e9e14c784

Best regards,
-- 
Jens Axboe



