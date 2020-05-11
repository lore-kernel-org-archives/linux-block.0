Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50905C47255
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 13:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2083120735
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 13:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcKHwY+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgEKNJq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 09:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729213AbgEKNJq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 09:09:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D684CC061A0C
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 06:09:45 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j5so10899447wrq.2
        for <linux-block@vger.kernel.org>; Mon, 11 May 2020 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hg9VBdFb6S7MHzSj9WtiYFDHpCKpSdvYFo2xgAcog7U=;
        b=HcKHwY+GL6iA4YdFdwx46dvzNoelU37EwlkF//FCkY1mn4xY6NTVTRGr5IScAk3reL
         zcvcaxjduTo7ntB3q6BetCMl8aUs8862aXr5p4p7DC67Nk5TJo7WNm1JKhFfpVDb5gJu
         iLbeHuRDR7+fh/T1JEcm+O7gSM/R63SfoXzJy6+q6MbZ6NzdbgpG/wJrhqTkR9QpP/yO
         bwhapAlVQ4slPjReKWzXZ4lYaYMyYp5nsOa+tyZUrZTDKuCADrXM+jgvltlh5QExstt2
         8lFdr720unj/Y4bzU70r6plDUbl0oFwQwysx1XUq0oNl5TfgwR1QYfRrZfolCObTcwlx
         56bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hg9VBdFb6S7MHzSj9WtiYFDHpCKpSdvYFo2xgAcog7U=;
        b=Si5n6+uPwo7gWc4J5gdhZS7caXCkJ4zACP/RL8b2AG1AuwJmtCCzOaIHhKNHBNTkih
         3QlysARpgvQcpS1NFOv+Z7ksG+15OJuNpSiN525hJPcz/lS6ygPDICrcHr2ijxxYKvaZ
         uXG2SQNrPMTAQp1KdZVLlhatPCXNwfLtdCIGySiIs/qO3MsDFbg1FzExONx6NHSesMdm
         Oji8q/B5TH+7lwpeLNPNwidkUzCH6iRGiSFRDHcWo2pMm1d41SwuKdloRMI9I/m/pbmc
         PxQRrsAi2YNJJFc3sUsVC0gskZuDS6e3dJveVjgfrnMefMUxEEpu3n94vp+roJfX6T3y
         yKQQ==
X-Gm-Message-State: AGi0PuaWyuXYlO//VNCSSf22A0xdi4CPV4bNMg/W1+lMf11qLlbRzO5Z
        lhRDZ2b+PuDuhM8kRHVK0PZbhfOS9R1zhSIIuV7H5g==
X-Google-Smtp-Source: APiQypKUjdIuSRRGo5GlUNPCBsqiQWrTvnYSoIYvDcTqd75sCc079r6YtAqCBH3EwDL9ZIQV3qB0ET8UbWpume6xp4Q=
X-Received: by 2002:adf:c7c3:: with SMTP id y3mr18773735wrg.196.1589202584319;
 Mon, 11 May 2020 06:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
 <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk> <CAG_fn=XXsjDsA0_MoTF3XfjSuLCc+6wRaOCY_ZDt661P_rSmOg@mail.gmail.com>
 <BYAPR04MB57495B31CEA65B2B5D76203C864A0@BYAPR04MB5749.namprd04.prod.outlook.com>
 <CAG_fn=WVHpRQ19MK12pxiizTEvUFLiV7LJgF_LrX_G2SYd=ivQ@mail.gmail.com>
 <277579c9-9e33-89ea-bfcd-bc14a543726c@acm.org> <CAG_fn=WQXuTuGmC8oQ25f6DYJ4CiMSz7_S7Nkp+z6L1QL7Zokw@mail.gmail.com>
 <BY5PR04MB69001D14C2318410930ABC03E7A10@BY5PR04MB6900.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB69001D14C2318410930ABC03E7A10@BY5PR04MB6900.namprd04.prod.outlook.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 May 2020 15:09:33 +0200
Message-ID: <CAG_fn=WdBm+P4tQUpyN50XhXF=OhLcGK1=XdDWYYacK4OSqBcg@mail.gmail.com>
Subject: Re: null_handle_cmd() doesn't initialize data when reading
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>
> Can you describe again the problem you are seeing please ? I can't find the
> first email of this thread and forgot what the problem is.
>

Yes, sorry.

The original message was:
>> I'm debugging an issue in nullb driver reported by KMSAN at QEMU startup.
>> There are numerous reports like the one below when checking nullb for
>> different partition types.
>> Basically, read_dev_sector() allocates a cache page which is then
>> wrapped into a bio and passed to the device driver, but never
>> initialized.

>> I've tracked the problem down to a call to null_handle_cmd(cmd,
>> /*sector*/0, /*nr_sectors*/8, /*op*/0).
>> Turns out all the if-branches in this function are skipped, so neither
>> of null_handle_throttled(), null_handle_flush(),
>> null_handle_badblocks(), null_handle_memory_backed(),
>> null_handle_zoned() is executed, and we proceed directly to
>> nullb_complete_cmd().

>> As a result, the pages read from the nullb device are never
>> initialized, at least at boot time.
>> How can we fix this?

Today null_handle_cmd() looks different, but the problem is still manifesting.
KMSAN reports look as follows:

=====================================================
BUG: KMSAN: uninit-value in adfspart_check_ICS+0xb8e/0xde0
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.7.0-rc4+ #4177
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 adfspart_check_ICS+0xb8e/0xde0 block/partitions/acorn.c:364
 check_partition block/partitions/core.c:140
 blk_add_partitions+0x86a/0x2560 block/partitions/core.c:571
 bdev_disk_changed+0x5c2/0xa30 fs/block_dev.c:1543
 __blkdev_get+0x1195/0x2280 fs/block_dev.c:1646
 blkdev_get+0x219/0x6b0 fs/block_dev.c:1748
 register_disk block/genhd.c:763
 __device_add_disk+0x15b5/0x20a0 block/genhd.c:853
 device_add_disk+0x90/0xa0 block/genhd.c:871
 add_disk ./include/linux/genhd.h:294
 null_gendisk_register drivers/block/null_blk_main.c:1628
 null_add_dev+0x2eaa/0x35d0 drivers/block/null_blk_main.c:1803
 null_init+0x6c5/0xd8d drivers/block/null_blk_main.c:1888
 do_one_initcall+0x4c9/0x930 init/main.c:1160
...
Uninit was created at:
 kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:144
 kmsan_internal_alloc_meta_for_pages mm/kmsan/kmsan_shadow.c:280
 kmsan_alloc_page+0xb9/0x180 mm/kmsan/kmsan_shadow.c:304
 __alloc_pages_nodemask+0xc0e/0x5dd0 mm/page_alloc.c:4848
 __alloc_pages ./include/linux/gfp.h:504
 alloc_page_interleave mm/mempolicy.c:2161
 alloc_pages_current+0x2e7/0x990 mm/mempolicy.c:2293
 alloc_pages ./include/linux/gfp.h:540
 __page_cache_alloc+0x95/0x310 mm/filemap.c:959
 do_read_cache_page+0x293/0x1510 mm/filemap.c:2752
 read_cache_page+0xf3/0x110 mm/filemap.c:2867
 read_mapping_page ./include/linux/pagemap.h:397
 read_part_sector+0x156/0x560 block/partitions/core.c:643
 adfspart_check_ICS+0xa0/0xde0 block/partitions/acorn.c:360
 check_partition block/partitions/core.c:140
 blk_add_partitions+0x86a/0x2560 block/partitions/core.c:571
 bdev_disk_changed+0x5c2/0xa30 fs/block_dev.c:1543
 __blkdev_get+0x1195/0x2280 fs/block_dev.c:1646
 blkdev_get+0x219/0x6b0 fs/block_dev.c:1748
 register_disk block/genhd.c:763
 __device_add_disk+0x15b5/0x20a0 block/genhd.c:853
 device_add_disk+0x90/0xa0 block/genhd.c:871
 add_disk ./include/linux/genhd.h:294
 null_gendisk_register drivers/block/null_blk_main.c:1628
 null_add_dev+0x2eaa/0x35d0 drivers/block/null_blk_main.c:1803
 null_init+0x6c5/0xd8d drivers/block/null_blk_main.c:1888
 do_one_initcall+0x4c9/0x930 init/main.c:1160
=====================================================
