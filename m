Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E520C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5142920836
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 18:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sk4Bpn+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389356AbfBNSFA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:05:00 -0500
Received: from mail-lf1-f53.google.com ([209.85.167.53]:36041 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729935AbfBNSFA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 13:05:00 -0500
Received: by mail-lf1-f53.google.com with SMTP id q11so5233640lfd.3
        for <linux-block@vger.kernel.org>; Thu, 14 Feb 2019 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xDRd0qhG3tI9UXOIwFYphIgOhKBbabDtTbzGlD6CWcs=;
        b=sk4Bpn+pg//Ory8CnM2dJFLf1FuNivCaV/tHMJUY2s/4lsq+0aTMY92NPqGsUefLe+
         MEPQGnJwdo6fz4dIjcUXIHPvCpCGBZkR6xsRl753FvVRcYiRWNULWw6MLfZ9BUm7CypJ
         CzIUZMY7Dg+pnWRJbM3TCNANuj7btg/fGe+O6XhUJKg9XOqLYfS5asSFZslwy9nFRlsi
         vkTzGJ1ihEjMwt5eoaZys3NCkCASjhJD3eA9NjxNo25UgZnVjHxf+MPPyiRMyIZIiwMP
         8yW9xVTqSRgNz2RmvG1ruAzWQIVAHL5ScQ2IUBDV/aQZ7FGJc+vxgGXDND61IYiM3rz3
         XWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xDRd0qhG3tI9UXOIwFYphIgOhKBbabDtTbzGlD6CWcs=;
        b=tth1rZdbUbIJuoQ7r8A8+ErjNXxeu5w4N6n6sR11FymA9yLP+ICju4pSF92/vRJDhl
         fq7vGPHjRUwBP8Qy9GvhxlT5GwSJVz4GSgUtJnRWmogaHwcLhlVhGuUPrbbn3o87mQaI
         DxTpwb3Vec3DYmkf8QIb8+kwIsjZQLuc0/edYId1b5vk0BK/ecalYR74HplkZlmDwzzK
         44P93XJNXSpxHwaXiqxpetfbd/bEXTaG+vzdXMarFPjllG1cwZuPofImse9SzX+n7HwH
         WgQAT/+oYF+ESRDzAr4g0CNnOvN3CrSXxQo5KyYdvKWvN3ncqOgzKMrrXpuMk0wjv9Yy
         9i2Q==
X-Gm-Message-State: AHQUAuaL76J5vd6sAmO3pjn4Vj/JX7X3wD/TQXx2IuHQ5GhoNycQX/W/
        wmaXawYNgdAE+YPvIIzvYTTK0ty8YI4wQlpjy7Z+edJT
X-Google-Smtp-Source: AHgI3IYbzjlFIV4Cb5mui34bpbh8tFkaqCnkwIIdZifP1U9qhs80R1CbmwdwP2nSkhma0mf4gex2VTSVGAlCuegOkpw=
X-Received: by 2002:a19:ae0b:: with SMTP id f11mr3202615lfc.104.1550167497001;
 Thu, 14 Feb 2019 10:04:57 -0800 (PST)
MIME-Version: 1.0
From:   Evan Green <evgreen@google.com>
Date:   Thu, 14 Feb 2019 10:04:20 -0800
Message-ID: <CAE=gft4_WiL87FtZnVmZok+oXPjK=GUb5tDUPGQFijddrB0Pbg@mail.gmail.com>
Subject: KASAN warning in bt_for_each
To:     linux-block <linux-block@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Greetings, block experts!

I'm trying to track down a KASAN warning I'm seeing in our downstream
4.19 kernel, and I could use a little help. The warning looks like
this:

[  224.564894] BUG: KASAN: use-after-free in bt_for_each+0x1ac/0x28c
[  224.571195] Read of size 8 at addr ffffffc17c621340 by task fio/3851
[  224.577745]
[  224.579320] CPU: 2 PID: 3851 Comm: fio Tainted: G        W
4.19.16 #398
[  224.591905] Call trace:
[  224.594465]  dump_backtrace+0x0/0x2d8
[  224.598263]  show_stack+0x20/0x2c
[  224.601708]  __dump_stack+0x20/0x28
[  224.605329]  dump_stack+0xc8/0xec
[  224.608769]  print_address_description+0x74/0x240
[  224.613632]  kasan_report+0x258/0x274
[  224.617431]  __asan_report_load8_noabort+0x20/0x28
[  224.622384]  bt_for_each+0x1ac/0x28c
[  224.626090]  blk_mq_queue_tag_busy_iter+0x1d4/0x2f8
[  224.631127]  blk_mq_in_flight+0xa0/0x100
[  224.635193]  part_in_flight+0x54/0x19c
[  224.639079]  part_round_stats+0x138/0x1f0
[  224.643230]  blk_account_io_start+0x23c/0x54c
[  224.647742]  blk_mq_bio_to_request+0x24/0x2c
[  224.652165]  blk_mq_make_request+0x674/0xf90
[  224.656581]  generic_make_request+0x32c/0x7b4
[  224.661090]  submit_bio+0x230/0x464
[  224.664702]  __blkdev_direct_IO_simple+0x3d0/0x79c
[  224.669656]  blkdev_direct_IO+0x60/0x88
[  224.673629]  generic_file_read_iter+0x368/0xeb8
[  224.678308]  blkdev_read_iter+0xc0/0xd0
[  224.682281]  __vfs_read+0x1d8/0x2f0
[  224.685900]  vfs_read+0xd0/0x1bc
[  224.689249]  ksys_pread64+0x9c/0xec
[  224.692869]  __arm64_compat_sys_aarch32_pread64+0x60/0x68
[  224.698441]  el0_svc_common+0x120/0x1e0
[  224.702409]  el0_svc_compat_handler+0x64/0x80
[  224.706919]  el0_svc_compat+0x8/0x18
[  224.710615]
[  224.712177] The buggy address belongs to the page:
[  224.717128] page:ffffffbf05f18840 count:0 mapcount:0
mapping:0000000000000000 index:0x0
[  224.725377] flags: 0x4000000000000000()
[  224.729361] raw: 4000000000000000 0000000000000000 ffffffff00000301
0000000000000000
[  224.737340] raw: 0000000000000000 0000000000000000 00000000ffffffff
0000000000000000
[  224.745318] page dumped because: kasan: bad access detected
[  224.751070]
[  224.752629] Memory state around the buggy address:
[  224.757583]  ffffffc17c621200: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[  224.765035]  ffffffc17c621280: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[  224.772483] >ffffffc17c621300: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[  224.779921]                                            ^
[  224.785403]  ffffffc17c621380: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[  224.792853]  ffffffc17c621400: ff ff ff ff ff ff ff ff ff ff ff ff
ff ff ff ff
[  224.800299]

What was I doing when I saw this?
I was running blktests block/005 (switch schedulers while doing IO) on
a loop device backed by a block device. I don't hit this on every run
of block/005, but with this script I can usually hit it in less than a
minute:

d=`losetup --show -f /dev/sda5` # Replace sda5 with your favorite
unused partition.
cd /usr/blktests
echo "TEST_DEVS=$d" > config
while true; do
    ./check block/005
done

I got totally lost in the blk-mq stuff, but my best hunch is related
to this comment in bt_iter:
        /*
         * We can hit rq == NULL here, because the tagging functions
         * test and set the bit before assining ->rqs[].
         */
        if (rq && rq->q == hctx->queue)
                iter_data->fn(hctx, rq, iter_data->data, reserved);

I believe the KASAN warning is about touching rq->q. So my question
is: blk_mq_put_tag doesn't appear to clear out tags->rqs[tag] when
releasing the tag, so what's to prevent bt_iter from looking through a
stale rq, in between when someone has allocated that sbitmap tag (for
the second time), but not yet assigned their own rq in ->rqs[tag].
Maybe there's some synchronization further up the stack that I'm
missing?

I was hoping to prove this by nulling out tags->rqs[tag] in
blk_mq_put_tag, but apparently hctx->tags is sometimes not valid
anymore by that point? Horrible things happen when I do that.

So I moved sideways and tried a partial fix by clearing rqs[tag] right
away in blk_mq_get_tag. This of course doesn't close my suspected
window, but does make it a lot smaller, and indeed I saw my repro rate
drop to zero (at least letting it go for a few minutes).

Do you agree this might be an issue, and if so, is there a good place
I can null out tags->rqs[tag] before calling blk_mq_put_tag?
-Evan
