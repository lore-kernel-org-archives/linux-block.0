Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5715B126
	for <linux-block@vger.kernel.org>; Mon,  6 May 2024 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715037377; cv=none; b=X7ZfMIVcBVueePuG0sXRJKyGj2iOmEFj6vPu+IyQtfFWa0YWEHoLB6Dq+/VM6nkcazhl1t5M04CL2Sy6zVB/VuY3ACcFP8/2P5k3dzHOqQTFSogv3/DnKMSOUlrfp6sSnELL2BJlFXkOjmlViKRw1wwX6vP28+shkBD3dSaCaNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715037377; c=relaxed/simple;
	bh=1ddjZ9m1tzyYBd5WiuS216zq0g5W8YVZVCgPVf3SYtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bv3Njihi21eSUMwp8Q6LLwQJEZkx8Q9zspKo2vv6BQ+ZmEPGLB3a84UiyvIRjwa7eQVqai4Khr7x6jcmFJ1TuAgpGkHfgGY5OeDp68OZAtZkH5/U+qQlvZ2xniAxnWRPJMzxBkMn/WiiN2OVmv4lxlzj/Gqq8TCfSF+bJelwOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1YxaJkz8; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1YxaJkz8"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47f02dfe3adso564282137.3
        for <linux-block@vger.kernel.org>; Mon, 06 May 2024 16:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715037375; x=1715642175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWDZWYjkJPURzLw9syztHB0tJ6WcdS29tikCHBiAHac=;
        b=1YxaJkz8O7GUY0zJ6oLJs3/ya77qEan9Fq7Z1iaRz3lbsyDjZ2/opfx+7tZ1zqfWOy
         EG8HArNAyVOvBKkoFA5Zts2sXj1QgwQHuvYekqOHPiIFP+kXmTQmfJgmTbVTGgJ5NWLQ
         4AzTvCxM95PI9agtMnor2eLVactehO20Ob4PBHxScjb3dc3gyGQ0mh2HSh8aJIQnVUrz
         JYO8YeRIQv2ymUbZN6lGd9UXtmjPPxmIXr3PtBC0mPD4pbVBrzLCZkaHmb4zhBI/kLF1
         2jd/Q9H24zk2YmUsV9LwsYH3tqbXnvOxgIXK1Z5MnV8aDJnOnR9SNUB6uHe7lZT0T53X
         QcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715037375; x=1715642175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWDZWYjkJPURzLw9syztHB0tJ6WcdS29tikCHBiAHac=;
        b=sHKuEsu03X1ZDwYWW/dKy0A6xy3tNcdGI6zvwIyxyWEEZTVIRaY+/gDslo3x0skNef
         w7eS3Gndy+TJJYVu/HYdoqZjZqPLvlEukknZbf6SYogHZa4noHxSVqxzCra4wOhoYMJL
         TqwIXHKYrWJ8myeF2lfveGEEnNTflKYMI9ZRFAcTfBekrmQIiDcv2+djvnqPbhD4bVRo
         LVSJKfZUkV5NPneHIVr4ibf9LIxzcVeKvVxhXh9cQAi9jeJU72L/9W3Idt9K5QN291Yl
         66GznQ31yB02aS3wZpX2pFfKJwp765JX9kiHQhCteqk/22WsxXsHoDsW3OhVW2gVQhxK
         qwwg==
X-Gm-Message-State: AOJu0YzSgdjS4OBsjp6g3aMFzmgNQgJeLeeMb4uunubhxuOxJtlJF/69
	m4osLf5P03jhXWMPWtxPxKhnBfsAffwKQxiEVlxaGykro++s1qVCuC7SogtLC6MMi11H7sUoo6M
	RLzuGtS0oEAxZUQOdH+LXbMOnypUyPcbKnpz5
X-Google-Smtp-Source: AGHT+IHFGB9QV4Kb2tsiF9dC+7j50IbRzS/0Q+8vc+LKmoBTd7dx8+Wxwb4ZyuZzUzov+71cd2Ewd+S4Qevus2d5sRQ=
X-Received: by 2002:a67:f2ca:0:b0:47d:8561:99aa with SMTP id
 a10-20020a67f2ca000000b0047d856199aamr13797256vsn.4.1715037374718; Mon, 06
 May 2024 16:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506-b4-sio-block-ioctl-v1-1-da535cc020dc@google.com>
In-Reply-To: <20240506-b4-sio-block-ioctl-v1-1-da535cc020dc@google.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 6 May 2024 16:16:02 -0700
Message-ID: <CAFhGd8pzJesRvHdHxVfn5gWuwOLwtmtP6Gkuw57vBoQjLmTMiw@mail.gmail.com>
Subject: Re: [PATCH] block/ioctl: use overflow helper for blkpg_partition fields
To: Jens Axboe <axboe@kernel.dk>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:10=E2=80=AFPM Justin Stitt <justinstitt@google.com=
> wrote:
>
> Running syzkaller with the newly reintroduced signed integer overflow
> sanitizer shows this report:
>
> [   62.982337] ------------[ cut here ]------------
> [   62.985692] cgroup: Invalid name
> [   62.986211] UBSAN: signed-integer-overflow in ../block/ioctl.c:36:46
> [   62.989370] 9pnet_fd: p9_fd_create_tcp (7343): problem connecting sock=
et to 127.0.0.1
> [   62.992992] 9223372036854775807 + 4095 cannot be represented in type '=
long long'
> [   62.997827] 9pnet_fd: p9_fd_create_tcp (7345): problem connecting sock=
et to 127.0.0.1
> [   62.999369] random: crng reseeded on system resumption
> [   63.000634] GUP no longer grows the stack in syz-executor.2 (7353): 20=
002000-20003000 (20001000)
> [   63.000668] CPU: 0 PID: 7353 Comm: syz-executor.2 Not tainted 6.8.0-rc=
2-00035-gb3ef86b5a957 #1
> [   63.000677] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.16.3-debian-1.16.3-2 04/01/2014
> [   63.000682] Call Trace:
> [   63.000686]  <TASK>
> [   63.000731]  dump_stack_lvl+0x93/0xd0
> [   63.000919]  __get_user_pages+0x903/0xd30
> [   63.001030]  __gup_longterm_locked+0x153e/0x1ba0
> [   63.001041]  ? _raw_read_unlock_irqrestore+0x17/0x50
> [   63.001072]  ? try_get_folio+0x29c/0x2d0
> [   63.001083]  internal_get_user_pages_fast+0x1119/0x1530
> [   63.001109]  iov_iter_extract_pages+0x23b/0x580
> [   63.001206]  bio_iov_iter_get_pages+0x4de/0x1220
> [   63.001235]  iomap_dio_bio_iter+0x9b6/0x1410
> [   63.001297]  __iomap_dio_rw+0xab4/0x1810
> [   63.001316]  iomap_dio_rw+0x45/0xa0
> [   63.001328]  ext4_file_write_iter+0xdde/0x1390
> [   63.001372]  vfs_write+0x599/0xbd0
> [   63.001394]  ksys_write+0xc8/0x190
> [   63.001403]  do_syscall_64+0xd4/0x1b0
> [   63.001421]  ? arch_exit_to_user_mode_prepare+0x3a/0x60
> [   63.001479]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> [   63.001535] RIP: 0033:0x7f7fd3ebf539
> [   63.001551] Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 14 00 00 90 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> [   63.001562] RSP: 002b:00007f7fd32570c8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
> [   63.001584] RAX: ffffffffffffffda RBX: 00007f7fd3ff3f80 RCX: 00007f7fd=
3ebf539
> [   63.001590] RDX: 4db6d1e4f7e43360 RSI: 0000000020000000 RDI: 000000000=
0000004
> [   63.001595] RBP: 00007f7fd3f1e496 R08: 0000000000000000 R09: 000000000=
0000000
> [   63.001599] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [   63.001604] R13: 0000000000000006 R14: 00007f7fd3ff3f80 R15: 00007ffd4=
15ad2b8
> ...
> [   63.018142] ---[ end trace ]---
>

Please note that I had to reconstruct this entire UBSAN report with
some fancy regex as the actual report on my box had some IO flushing
issues when running syzkaller with multiple threads. Due to this, this
report may look weird but I tried my best to put things in
chronological order.
