Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCCF13A25F;
	Tue,  9 Jul 2024 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528760; cv=none; b=iCdJLWM74o1h8Xd8huOZfuv/2Jry/TtxIR7GKd/iCGE8bBOtX6W/GQyjJahMIjIctpe2qDSaDl/llihg8eGvhVOlxV7QFoOx4l+usq8+qOB/YHmfQ2+wKBCFyY3bVN5AYNSRyCJRujMX0L/1Ax/1gzpJURd00mwHMVovKw9B9Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528760; c=relaxed/simple;
	bh=uc8f3I9FjT4ddzKf5AdW/NsGUiFiP6hsnUEvrfc7Kuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpC2LrRE5cVxYr7GZYqGwDnHgMDidYezlhU04BtiZeMiC5ZCT1V3LLgnisHQ82tMiraEps7TgSlRzhKJbdVpjMdHaBfknFhv4312ba+SGmzk2SxZyrETybQZrqAxfxFYFsX3mrcVaFrgIyTvPTW1CZbhxTt9syWI/90SfRWPoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64b3655297aso49349837b3.1;
        Tue, 09 Jul 2024 05:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720528756; x=1721133556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ENGgw6ue9S7M03KBHk+pRSFUONWY6uW3wiK1b5+M7g=;
        b=F8lakUVK/kyJHw+Uj8BzFNgQLqEKA6K/t8YQdxNaNUjgTl5ptkMIA3yeW9kZl8Lqa7
         ADOp2fa74xZs+WTkSY7sFtqhY863lJi/AKUYhZOSp3wDFBROZW596EyFzVcnoSIVPlk7
         yU7scG6c8/amLkRFu3TNY1iMdQAjwbqhIdh9aGVFr58W+/r6rvaBO1KRdm9Y0q2doalc
         qviQYi4Rj9691ql9j9AmfIyxPK2ifoUkydeK40IHflTF6EimSZT3E5FZ/Kic+LN93ddt
         3KhR4wmcMSBsa238rh/YlI1DbWaJirptloW8TcZ8BbSPilsEkP+Is/GqDwglN/agM0z7
         LTsg==
X-Forwarded-Encrypted: i=1; AJvYcCUhEISElO/dIRLiHNoanVoPPhMU5t2wAlQjuc69nO+QfgZlUhNiazEKsLc4I7CSXtgLYkL28x/DYUySykfXiKvhaq/u/Sk//r9C/KDp9Bk00cabvrrHSm2wQL+iQbE/48e9kUD5356SklQ=
X-Gm-Message-State: AOJu0Yw6/rtaMBsXt8jIye/nFoLEzyCpBW9RR4NC7kTh4xe9Ap1VasYm
	r6fiR/y6agY5ZvtyvCviysE8S95jPePxyPRZh627NUCvuPhH9nSqVT62F5lu
X-Google-Smtp-Source: AGHT+IGOqsEaK+2y45ypFvHz4TTp8bcBZzle58Y0shZtw1GwNhmzeCDfT1cyj5rgRfL+WDXf0Je9nQ==
X-Received: by 2002:a05:690c:7484:b0:627:e43f:7dd4 with SMTP id 00721157ae682-658f0fb3102mr32165237b3.45.1720528755799;
        Tue, 09 Jul 2024 05:39:15 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e5310f3asm3223167b3.69.2024.07.09.05.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 05:39:15 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-65465878c1fso40646837b3.2;
        Tue, 09 Jul 2024 05:39:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOaryIGf9tnrdkzSkLaCz0hL64DAyHP5jdC8G9t/Ef+GD3svO23sxXyh2B/u+ky7u9h4edYCTpzss1NnVtI7K84HQIsU7GEOtnzZN8IWeHpdfEkgwM9VA/Y3ChUGNKv++CNZloqADC8oo=
X-Received: by 2002:a0d:c686:0:b0:64b:7859:a92f with SMTP id
 00721157ae682-658ee790bf9mr26399557b3.5.1720528755101; Tue, 09 Jul 2024
 05:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706075228.2350978-1-hch@lst.de> <20240706075228.2350978-3-hch@lst.de>
In-Reply-To: <20240706075228.2350978-3-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 9 Jul 2024 14:39:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV95g78=2GmLP95Kn3_0DL5zVuv2KCDYVsk8D2gNnu7SQ@mail.gmail.com>
Message-ID: <CAMuHMdV95g78=2GmLP95Kn3_0DL5zVuv2KCDYVsk8D2gNnu7SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org, 
	linux-block@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Sat, Jul 6, 2024 at 9:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
> Work on a single address to simplify the logic, and prepare the callers
> from using better helpers.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch, which is now commit 09595e0c9d654743 ("block:
pass a phys_addr_t to get_max_segment_size") in block/for-next

This is causing the following crash on landisk when starting
a Debian userspace:

Run /sbin/init as init process
process '/sbin/init' started with executable stack
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at block/blk-merge.c:607 __blk_rq_map_sg+0x74/0x240
Modules linked in:

CPU: 0 PID: 1 Comm: init Not tainted 6.10.0-rc3-landisk-00178-g09595e0c9d65=
 #228
PC is at __blk_rq_map_sg+0x74/0x240
PR is at __blk_rq_map_sg+0x1ee/0x240
PC  : 8c1d58f8 SP  : 8c825bec SR  : 40008100 TEA : 295ce8b0
R0  : 00000002 R1  : 00000002 R2  : fffffffe R3  : 8c1fc2a0
R4  : 8c825c0c R5  : 8c825c00 R6  : 00000000 R7  : 00000001
R8  : 8cb2c040 R9  : 8c825c50 R10 : 00000000 R11 : 00000003
R12 : 00000000 R13 : 8cb2c158 R14 : 00000000
MACH: 0000565d MACL: 00000000 GBR : 00000000 PR  : 8c1d5a72

Call trace:
 [<8c26a1c8>] scsi_alloc_sgtables+0xb8/0x1ac
 [<8c2736aa>] sd_init_command+0x2a2/0x70a
 [<8c03a910>] irqd_irq_disabled.isra.0+0x0/0xc
 [<8c26b296>] scsi_queue_rq+0x512/0x634
 [<8c1db0d0>] blk_mq_dispatch_rq_list+0x1c8/0x358
 [<8c1dac28>] blk_mq_get_driver_tag+0x0/0x14
 [<8c20ef8e>] sbitmap_get+0x5a/0x78
 [<8c1dab01>] blk_mq_dequeue_from_ctx+0xd/0x64
 [<8c1deaf6>] __blk_mq_sched_dispatch_requests+0x24a/0x38c
 [<8c1dec9a>] blk_mq_sched_dispatch_requests+0x22/0x50
 [<8c1d86fa>] blk_rq_is_passthrough.isra.0+0x0/0xc
 [<8c1dec78>] blk_mq_sched_dispatch_requests+0x0/0x50
 [<8c1de8ac>] __blk_mq_sched_dispatch_requests+0x0/0x38c
 [<8c1da158>] blk_mq_run_hw_queue+0xc8/0xf8
 [<8c1db3d4>] blk_mq_flush_plug_list+0x174/0x28c
 [<8c1d86fa>] blk_rq_is_passthrough.isra.0+0x0/0xc
 [<8c1d1e32>] __blk_flush_plug+0x3e/0xd8
 [<8c0025d8>] arch_local_irq_restore+0x0/0x24
 [<8c071838>] arch_local_irq_save+0x0/0x24
 [<8c071a0c>] readahead_folio+0x0/0x60
 [<8c1d1ee4>] blk_finish_plug+0x18/0x30
 [<8c0025d8>] arch_local_irq_restore+0x0/0x24
 [<8c071838>] arch_local_irq_save+0x0/0x24
 [<8c071a0c>] readahead_folio+0x0/0x60
 [<8c071ada>] read_pages+0x4c/0x106
 [<8c071c26>] page_cache_ra_unbounded+0x92/0x14c
 [<8c06c37c>] filemap_fault+0x2c8/0x43c
 [<8c087d30>] __do_fault+0x1c/0x6c
 [<8c08b0cc>] handle_mm_fault+0x588/0x780
 [<8c00cb14>] do_page_fault+0x10c/0x1a0
 [<8c006108>] ret_from_exception+0x0/0xc
 [<8c006108>] ret_from_exception+0x0/0xc
 [<8c006108>] ret_from_exception+0x0/0xc

---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
kernel BUG at drivers/scsi/scsi_lib.c:1160!
Kernel BUG: 003e [#1]
Modules linked in:

CPU: 0 PID: 1 Comm: init Tainted: G        W
6.10.0-rc3-landisk-00178-g09595e0c9d65 #228
PC is at scsi_alloc_sgtables+0x144/0x1ac
PR is at scsi_alloc_sgtables+0xb8/0x1ac
PC  : 8c26a254 SP  : 8c825c50 SR  : 40008100 TEA : 295ce8b0
R0  : 00000003 R1  : 00000002 R2  : 8cb2c180 R3  : 000000bc
R4  : 8c825c0c R5  : 8c825c00 R6  : 00000000 R7  : 00000000
R8  : 8cb2c09c R9  : 8cb4cafc R10 : 8c51b12c R11 : 8cb2c118
R12 : 8cb2c000 R13 : 00000000 R14 : 00000003
MACH: 0000565d MACL: 00000000 GBR : 00000000 PR  : 8c26a1c8

Call trace:
 [<8c2736aa>] sd_init_command+0x2a2/0x70a
 [<8c03a910>] irqd_irq_disabled.isra.0+0x0/0xc
 [<8c26b296>] scsi_queue_rq+0x512/0x634
 [<8c1db0d0>] blk_mq_dispatch_rq_list+0x1c8/0x358
 [<8c1dac28>] blk_mq_get_driver_tag+0x0/0x14
 [<8c20ef8e>] sbitmap_get+0x5a/0x78
 [<8c1dab01>] blk_mq_dequeue_from_ctx+0xd/0x64
 [<8c1deaf6>] __blk_mq_sched_dispatch_requests+0x24a/0x38c
 [<8c1dec9a>] blk_mq_sched_dispatch_requests+0x22/0x50
 [<8c1d86fa>] blk_rq_is_passthrough.isra.0+0x0/0xc
 [<8c1dec78>] blk_mq_sched_dispatch_requests+0x0/0x50
 [<8c1de8ac>] __blk_mq_sched_dispatch_requests+0x0/0x38c
 [<8c1da158>] blk_mq_run_hw_queue+0xc8/0xf8
 [<8c1db3d4>] blk_mq_flush_plug_list+0x174/0x28c
 [<8c1d86fa>] blk_rq_is_passthrough.isra.0+0x0/0xc
 [<8c1d1e32>] __blk_flush_plug+0x3e/0xd8
 [<8c0025d8>] arch_local_irq_restore+0x0/0x24
 [<8c071838>] arch_local_irq_save+0x0/0x24
 [<8c071a0c>] readahead_folio+0x0/0x60
 [<8c1d1ee4>] blk_finish_plug+0x18/0x30
 [<8c0025d8>] arch_local_irq_restore+0x0/0x24
 [<8c071838>] arch_local_irq_save+0x0/0x24
 [<8c071a0c>] readahead_folio+0x0/0x60
 [<8c071ada>] read_pages+0x4c/0x106
 [<8c071c26>] page_cache_ra_unbounded+0x92/0x14c
 [<8c06c37c>] filemap_fault+0x2c8/0x43c
 [<8c087d30>] __do_fault+0x1c/0x6c
 [<8c08b0cc>] handle_mm_fault+0x588/0x780
 [<8c00cb14>] do_page_fault+0x10c/0x1a0
 [<8c006108>] ret_from_exception+0x0/0xc
 [<8c006108>] ret_from_exception+0x0/0xc
 [<8c006108>] ret_from_exception+0x0/0xc

Process: init (pid: 1, stack limit =3D (ptrval))
Stack: (0x8c825c50 to 0x8c826000)
5c40:                                     8cb2c180 c4b8bd37 8c2736aa 8cb2c0=
00
5c60: 00000001 00000000 8c93e800 00000088 0008d350 8cb2c09c 8cb25200 8c03a9=
10
5c80: 8c807840 8cb4c800 8cb28600 00000088 00080700 00000000 00000020 8c26b2=
96
5ca0: 8cb2c118 8cb2c11c 8cb4c800 8c93e800 8cb2c000 8cb4c800 8cb2c09c 8cb2c1=
3c
5cc0: 8c93e800 00000003 8cb28014 8cb4cafc 8cb29000 8c825d20 8cb4c8fc 8c1db0=
d0
5ce0: 00000000 8c1dac28 8cb2c034 8cb25100 8cb2c000 8cb25100 8c825d5c 000000=
00
5d00: 8c20ef8e 8c825d20 00000000 00000000 ffffffff 00000000 00000000 8cb290=
00
5d20: 8cb2c000 8c1dab01 c4b8bd37 8c1deaf6 00000000 00000002 8cb28c00 000000=
00
5d40: 00000001 8c825d5c 8cb25100 00000000 fffede60 8c825d54 8c825d54 8c825d=
5c
5d60: 8c825d5c 8cb2c000 8cb29000 c4b8bd37 8c1dec9a 00000000 8c1d86fa 8cb251=
40
5d80: 8c1dec78 00000000 8c1de8ac 8cb25100 8c1da158 8cb25100 8c93e8a0 8c1db3=
d4
5da0: 8c1d86fa 8cb25140 8cb2c034 8cb25100 8c825dd0 8c825e2c 00000000 8ff766=
6c
5dc0: 00000000 8c825dcc 8cb25100 00000000 8c825dd0 8c825dd0 c4b8bd37 8c1d1e=
32
5de0: 8c0025d8 8c071838 8c071a0c 00000000 8c51b12c 8c825e44 8c825e2c 000000=
01
5e00: 8c825e10 c4b8bd37 8c1d1ee4 8c0025d8 8c071838 8c071a0c 8c51b12c 00112c=
ca
5e20: 00000000 8c825eac 8c071ada 00000000 00000000 ce7eb754 00000002 000000=
01
5e40: 00110100 8c825e44 8c825e44 c4b8bd37 8c071c26 00000011 8c825eac 8cb95c=
ec
5e60: 0000002a 00112cca 8cb95ce0 8ff8cb20 0000003a 00000011 00402100 000000=
08
5e80: 8c06c37c 0000003a 8cb95ce0 8cb95ce0 8ca56280 8c825f18 8ca56280 8ca562=
c0
5ea0: 00000000 8ca56280 8cb95c0c 8ca56280 8cb95ce0 8ca562c0 0000003b 000000=
00
5ec0: 00000000 00000000 00000000 c4b8bd37 8c087d30 01000000 00000000 00000d=
73
5ee0: 295ce8b0 8cbc81f8 8c825f18 8cbc81f8 8c08b0cc 00000001 8ff8c900 8cbc81=
f8
5f00: ffffffff 8c931784 295ce000 00000255 8c825fa4 00000040 8cbc81f8 00100c=
ca
5f20: 0000003a 295ce000 295ce8b0 00000a55 8cc06294 8cc06294 00000000 8ff8c9=
00
5f40: 00000000 00000000 8c9317ac 00000000 c4b8bd37 8c00cb14 01000000 8c825f=
e4
5f60: 295ce8b0 00000255 00000001 8c825fa4 00000001 00000812 0000003a 8c9317=
80
5f80: 00000001 8c006108 7bb436b4 295d8de4 29581000 295ce8b0 8c006108 8c0061=
08
5fa0: 00000001 00000007 00000000 0000f686 000000ea 295ce8b0 00000000 000000=
00
5fc0: 295ce8b0 295cf000 7bb43668 29581a58 295ce8b0 29581000 295d8de4 7bb436=
b4
5fe0: 7bb43650 2956c3d8 2955cd1a 00008000 00000000 0000002c 00000030 ffffff=
ff
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/exit.c:823 do_exit+0x68/0x704
Modules linked in:

CPU: 0 PID: 1 Comm: init Tainted: G      D W
6.10.0-rc3-landisk-00178-g09595e0c9d65 #228
PC is at do_exit+0x68/0x704
PR is at do_exit+0x5c/0x704
PC  : 8c011a2c SP  : 8c825b5c SR  : 40008100 TEA : 295ce8b0
R0  : 00000040 R1  : 8c825e2c R2  : 40008100 R3  : 00000000
R4  : 00000000 R5  : ffd0b128 R6  : 00000000 R7  : 00000001
R8  : 8c822000 R9  : 8c010da4 R10 : 8c8222fc R11 : 8c010d94
R12 : 0000000b R13 : 8c3b4d70 R14 : 00000003
MACH: 00000244 MACL: 0000afa8 GBR : 00000000 PR  : 8c011a20

Call trace:
 [<8c035e60>] vprintk_emit+0xc0/0x13c
 [<8c3b4d70>] _printk+0x0/0x48
 [<8c0121a2>] make_task_dead+0xda/0x130
 [<8c3b4d70>] _printk+0x0/0x48
 [<8c003ede>] die+0xde/0x14c
 [<8c1fce6c>] bust_spinlocks+0x0/0x38
 [<8c0025d8>] arch_local_irq_restore+0x0/0x24
 [<8c0040f8>] bug_trap_handler+0x8c/0xc8
 [<8c26a254>] scsi_alloc_sgtables+0x144/0x1ac
 [<8c0061be>] debug_trap+0xe/0x18
 [<8c00406c>] bug_trap_handler+0x0/0xc8
 [<8c26a254>] scsi_alloc_sgtables+0x144/0x1ac
 [<8c26a1c8>] scsi_alloc_sgtables+0xb8/0x1ac
 [<8c2736aa>] sd_init_command+0x2a2/0x70a
 [<8c03a910>] irqd_irq_disabled.isra.0+0x0/0xc
 [<8c26b296>] scsi_queue_rq+0x512/0x634
 [<8c1db0d0>] blk_mq_dispatch_rq_list+0x1c8/0x358
 [<8c1dac28>] blk_mq_get_driver_tag+0x0/0x14
 [<8c20ef8e>] sbitmap_get+0x5a/0x78
 [<8c1dab01>] blk_mq_dequeue_from_ctx+0xd/0x64
 [<8c1deaf6>] __blk_mq_sched_dispatch_requests+0x24a/0x38c
 [<8c1dec9a>] blk_mq_sched_dispatch_requests+0x22/0x50
 [<8c1d86fa>] blk_rq_is_passthrough.isra.0+0x0/0xc
 [<8c1dec78>] blk_mq_sched_dispatch_requests+0x0/0x50
 [<8c1de8ac>] __blk_mq_sched_dispatch_requests+0x0/0x38c
 [<8c1da158>] blk_mq_run_hw_queue+0xc8/0xf8
 [<8c1db3d4>] blk_mq_flush_plug_list+0x174/0x28c
 [<8c1d86fa>] blk_rq_is_passthrough.isra.0+0x0/0xc
 [<8c1d1e32>] __blk_flush_plug+0x3e/0xd8
 [<8c0025d8>] arch_local_irq_restore+0x0/0x24
 [<8c071838>] arch_local_irq_save+0x0/0x24
 [<8c071a0c>] readahead_folio+0x0/0x60
 [<8c1d1ee4>] blk_finish_plug+0x18/0x30
 [<8c0025d8>] arch_local_irq_restore+0x0/0x24
 [<8c071838>] arch_local_irq_save+0x0/0x24
 [<8c071a0c>] readahead_folio+0x0/0x60
 [<8c071ada>] read_pages+0x4c/0x106
 [<8c071c26>] page_cache_ra_unbounded+0x92/0x14c
 [<8c06c37c>] filemap_fault+0x2c8/0x43c
 [<8c087d30>] __do_fault+0x1c/0x6c
 [<8c08b0cc>] handle_mm_fault+0x588/0x780
 [<8c00cb14>] do_page_fault+0x10c/0x1a0
 [<8c006108>] ret_from_exception+0x0/0xc
 [<8c006108>] ret_from_exception+0x0/0xc
 [<8c006108>] ret_from_exception+0x0/0xc

---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b
Rebooting in 10 seconds..

Other people seem to have run into similar issues
https://lore.kernel.org/all/58a667c3-e884-4fa0-9855-3a73a1880260@nvidia.com=
/

> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -209,23 +209,22 @@ static inline unsigned get_max_io_size(struct bio *=
bio,
>  /**
>   * get_max_segment_size() - maximum number of bytes to add as a single s=
egment
>   * @lim: Request queue limits.
> - * @start_page: See below.
> - * @offset: Offset from @start_page where to add a segment.
> + * @paddr: address of the range to add
> + * @max_len: maximum length available to add at @paddr
>   *
> - * Returns the maximum number of bytes that can be added as a single seg=
ment.
> + * Returns the maximum number of bytes of the range starting at @paddr t=
hat can
> + * be added to a single segment.
>   */
>  static inline unsigned get_max_segment_size(const struct queue_limits *l=
im,
> -               struct page *start_page, unsigned long offset)
> +               phys_addr_t paddr, unsigned int len)
>  {
> -       unsigned long mask =3D lim->seg_boundary_mask;
> -
> -       offset =3D mask & (page_to_phys(start_page) + offset);
> -
>         /*
>          * Prevent an overflow if mask =3D ULONG_MAX and offset =3D 0 by =
adding 1
>          * after having calculated the minimum.
>          */
> -       return min(mask - offset, (unsigned long)lim->max_segment_size - =
1) + 1;
> +       return min_t(unsigned long, len,
> +               min(lim->seg_boundary_mask - (lim->seg_boundary_mask & pa=
ddr),
> +                   (unsigned long)lim->max_segment_size - 1) + 1);
>  }
>
>  /**
> @@ -258,9 +257,7 @@ static bool bvec_split_segs(const struct queue_limits=
 *lim,
>         unsigned seg_size =3D 0;
>
>         while (len && *nsegs < max_segs) {
> -               seg_size =3D get_max_segment_size(lim, bv->bv_page,
> -                                               bv->bv_offset + total_len=
);
> -               seg_size =3D min(seg_size, len);
> +               seg_size =3D get_max_segment_size(lim, bvec_phys(bv) + to=
tal_len, len);
>
>                 (*nsegs)++;
>                 total_len +=3D seg_size;
> @@ -494,8 +491,8 @@ static unsigned blk_bvec_map_sg(struct request_queue =
*q,
>
>         while (nbytes > 0) {
>                 unsigned offset =3D bvec->bv_offset + total;
> -               unsigned len =3D min(get_max_segment_size(&q->limits,
> -                                  bvec->bv_page, offset), nbytes);
> +               unsigned len =3D get_max_segment_size(&q->limits, bvec_ph=
ys(bvec),
> +                       nbytes);
>                 struct page *page =3D bvec->bv_page;
>
>                 /*

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
