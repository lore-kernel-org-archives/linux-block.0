Return-Path: <SRS0=zNjm=ZH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594D3C432C3
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3BB20718
	for <linux-block@archiver.kernel.org>; Fri, 15 Nov 2019 10:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sueVgHED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfKOKQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Nov 2019 05:16:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39065 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfKOKQh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Nov 2019 05:16:37 -0500
Received: by mail-wr1-f65.google.com with SMTP id l7so10334005wrp.6
        for <linux-block@vger.kernel.org>; Fri, 15 Nov 2019 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=UN/KKW49IR1fjweJi4DwDBTp0myHxSUme7tkQjd1asw=;
        b=sueVgHEDR5E7HoEFlt3W2GQVHgE8JF1am7lSR4Lb0yWnblNbWNEysUubJVZohLCYQh
         Z0XiAakChpuo5Iu3SNf6AIZiZb6C0Ibcm4zcQzsLWmZI0Arf24BWUWIOybXqDP4jt7BG
         tS2rHKBclp6/UYIVlg8k2rpg3Zg1xikzweWEutb4ZBnnzgBOD5C3zwL71l9nTUH9NZoy
         hZwYQKqOTmwHuCVM2ZC+P6+09srw2tHokSFBcPX3SQcftk/8eGFvM2t1mPh+N3q3Zc1r
         yg30J2I3pjkVZejebWW0abYW0eMCXwafspliJw3mX49P8EbnF8qj3X2ax3BG2qXeH9pD
         OUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=UN/KKW49IR1fjweJi4DwDBTp0myHxSUme7tkQjd1asw=;
        b=sRlwpo9TT9E8ULg7qv7a7X7IkvGRLu1Bbp07ufY3SoHL60IusID3q7NJWd5GNicS/L
         jFgYFshMUV6kQLwCKGmAFORJ0T8tkDrGvckdDwmODKH/RFAFQ/6Z5uOhjMAIVno4l6r8
         30Oj19EIen1chgDm1cxuJi/rB/ChLFUmqGXzDEhfObO7PrcPz8Pl8oOx/KUv1wVWG/kJ
         RQ6xPCFGRU57508qK7t9U2Vf0WNn67wFVqTfkhyIFRe6y14XtPw0TJK23RMt6MSXAUsT
         +bZGnuimUa/tNU54ODguTW7DGuTl3cnADVABL6cM+9Afbf3ROBOHPz2l7X/HGM4VyPc8
         1DGw==
X-Gm-Message-State: APjAAAWZHuWuifveSp4Y1iZCnqZr8HPowy8zrBs8vcDQLItjshsE/1R9
        czbp10S6IcyY7dTDoQlFd8CtCHEsn99wNluIf2c8iw==
X-Google-Smtp-Source: APXvYqzsH0eRzv0KNVDR/piRe0sbxJV4KaBlzEahU8bed2kGsDm/vh3pGu2+Vcf1pYYtSJ74IBy8eJk2hSVjrlrdZBY=
X-Received: by 2002:adf:e911:: with SMTP id f17mr11223558wrm.300.1573812994685;
 Fri, 15 Nov 2019 02:16:34 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Nov 2019 11:16:23 +0100
Message-ID: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
Subject: null_handle_cmd() doesn't initialize data when reading
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

I'm debugging an issue in nullb driver reported by KMSAN at QEMU startup.
There are numerous reports like the one below when checking nullb for
different partition types.
Basically, read_dev_sector() allocates a cache page which is then
wrapped into a bio and passed to the device driver, but never
initialized.

I've tracked the problem down to a call to null_handle_cmd(cmd,
/*sector*/0, /*nr_sectors*/8, /*op*/0).
Turns out all the if-branches in this function are skipped, so neither
of null_handle_throttled(), null_handle_flush(),
null_handle_badblocks(), null_handle_memory_backed(),
null_handle_zoned() is executed, and we proceed directly to
nullb_complete_cmd().

As a result, the pages read from the nullb device are never
initialized, at least at boot time.
How can we fix this?

This bug may also have something to do with
https://groups.google.com/d/topic/syzkaller-bugs/d0fmiL9Vi9k/discussion.

KMSAN report follows:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
 BUG: KMSAN: uninit-value in[<      none      >]
adfspart_check_ICS+0xd08/0x1040 block/partitions/acorn.c:365
 Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:77
 [<      none      >] dump_stack+0x196/0x1f0 lib/dump_stack.c:113
 [<      none      >] kmsan_report+0x127/0x220 mm/kmsan/kmsan_report.c:108
 [<      none      >] __msan_warning+0x73/0xe0 mm/kmsan/kmsan_instr.c:245
 [<      none      >] adfspart_check_ICS+0xd08/0x1040
block/partitions/acorn.c:365
 [<      none      >] check_partition+0x58c/0xc20 block/partitions/check.c:=
167
 [<      none      >] rescan_partitions+0x39b/0x1ff0
block/partition-generic.c:531
 [<      none      >] __blkdev_get+0x14f1/0x2440 fs/block_dev.c:1600
 [<      none      >] blkdev_get+0x237/0x6a0 fs/block_dev.c:1708
 [<     inline     >] register_disk block/genhd.c:655
 [<      none      >] __device_add_disk+0x1612/0x20f0 block/genhd.c:745
 [<      none      >] device_add_disk+0x90/0xa0 block/genhd.c:763
 [<     inline     >] add_disk ./include/linux/genhd.h:429
 [<     inline     >] null_gendisk_register drivers/block/null_blk_main.c:1=
547
 [<      none      >] null_add_dev+0x34c7/0x3b30
drivers/block/null_blk_main.c:1718
...
 Uninit was created at:
 [<      none      >] kmsan_save_stack_with_flags+0x3f/0x90 mm/kmsan/kmsan.=
c:151
 [<     inline     >] kmsan_internal_alloc_meta_for_pages
mm/kmsan/kmsan_shadow.c:362
 [<      none      >] kmsan_alloc_page+0x14e/0x360 mm/kmsan/kmsan_shadow.c:=
391
 [<      none      >] __alloc_pages_nodemask+0x594e/0x6050 mm/page_alloc.c:=
4796
 [<     inline     >] __alloc_pages ./include/linux/gfp.h:475
 [<     inline     >] alloc_page_interleave mm/mempolicy.c:2058
 [<      none      >] alloc_pages_current+0x2e7/0x990 mm/mempolicy.c:2186
 [<     inline     >] alloc_pages ./include/linux/gfp.h:511
 [<      none      >] __page_cache_alloc+0x95/0x310 mm/filemap.c:981
 [<      none      >] do_read_cache_page+0x4d5/0x1520 mm/filemap.c:2788
 [<      none      >] read_cache_page+0xf3/0x110 mm/filemap.c:2896
 [<     inline     >] read_mapping_page ./include/linux/pagemap.h:396
 [<      none      >] read_dev_sector+0xd6/0x390 block/partition-generic.c:=
668
 [<     inline     >] read_part_sector block/partitions/check.h:38
 [<      none      >] adfspart_check_ICS+0x117/0x1040
block/partitions/acorn.c:361
 [<      none      >] check_partition+0x58c/0xc20 block/partitions/check.c:=
167
 [<      none      >] rescan_partitions+0x39b/0x1ff0
block/partition-generic.c:531
 [<      none      >] __blkdev_get+0x14f1/0x2440 fs/block_dev.c:1600
 [<      none      >] blkdev_get+0x237/0x6a0 fs/block_dev.c:1708
 [<     inline     >] register_disk block/genhd.c:655
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks,
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
