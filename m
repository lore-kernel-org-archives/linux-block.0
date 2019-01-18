Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835E4C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 05:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302F620652
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 05:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="IUZi+1bH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfARFTs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:19:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37980 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfARFTs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 00:19:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id a1so7430006qkc.5
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 21:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=JyYgM1QiMPY8dwKNrc03BII+UUTuyQXyiSPCs7m+qzQ=;
        b=IUZi+1bHK9O9pyovbYJF86Ok2owEU8XoZ/MYzfRqcIKF5p+OAjKHITEJEVEJPmBt/n
         7uS+ZrrJJK5K1cl9qTi/YQTjY4a4p5tZ2GLdBJ+GmK4LrjOU08jZIjsw+jg5SaMcCyAz
         m92cfxIXWu+8e5vqLMvxwNAA1bXzHUmtD1NhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JyYgM1QiMPY8dwKNrc03BII+UUTuyQXyiSPCs7m+qzQ=;
        b=DifHWWRBrwXyL5rmJ/ilWQOpbiNvhFXr4vyEryWfCpdko4D9k06vVSMygUj/VQaLk2
         AdXbAOb4OF3jMNDWHDpBtzLLIiEhhC2mp6bIoU3OWw/PPK+8S5QNT2GJH04bVEl/QJlK
         nyKyhS9WxbGFHOLEg2ycFUktjaY6wD3nbLLT7n0SkAqQGaXbcGCxTWKA3KkghHTvCQI4
         a62s5l6zXQJD/JDYPP/Xb6FcMBcOmhRqbT4Dc2SCSGefJ+LrG95jfbVa9Pg9qruRUdIL
         +UBteM1nAni0dFUX3XJauUHInd6d0yuCGsUxMpyfeKtT4adL6uvVD+zon1CCxCA6A8N8
         xEvg==
X-Gm-Message-State: AJcUukfoZkyznaM4d9x788qPZ2a0pO8OzRO1PCD2gOHfVeKl9zUQ6+9K
        NfdQlTTc5C5zhVPe7lISj1y6+Q==
X-Google-Smtp-Source: ALg8bN7YtlUHNvV4DKD05rJYtv/Lj2w1MLwhlhjvHl/6CbbA6dcpPXbKvUNLYhUQ/MwsimJaCxPLsw==
X-Received: by 2002:a37:1fc6:: with SMTP id n67mr13886492qkh.180.1547788786960;
        Thu, 17 Jan 2019 21:19:46 -0800 (PST)
Received: from localhost.localdomain ([2001:67c:1562:8007::aac:4356])
        by smtp.gmail.com with ESMTPSA id w34sm62571103qtj.27.2019.01.17.21.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 21:19:46 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     colyli@suse.de, "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        linux-bcache@vger.kernel.org,
        Mauricio Oliveira <mauricio.oliveira@canonical.com>
Cc:     Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH] bcache: never writeback a discard operation
Date:   Fri, 18 Jan 2019 16:18:25 +1100
Message-Id: <20190118051825.18196-1-dja@axtens.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some users see panics like the following when performing fstrim on a bcached volume:

[  529.803060] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[  530.183928] #PF error: [normal kernel read fault]
[  530.412392] PGD 8000001f42163067 P4D 8000001f42163067 PUD 1f42168067 PMD 0
[  530.750887] Oops: 0000 [#1] SMP PTI
[  530.920869] CPU: 10 PID: 4167 Comm: fstrim Kdump: loaded Not tainted 5.0.0-rc1+ #3
[  531.290204] Hardware name: HP ProLiant DL360 Gen9/ProLiant DL360 Gen9, BIOS P89 12/27/2015
[  531.693137] RIP: 0010:blk_queue_split+0x148/0x620
[  531.922205] Code: 60 38 89 55 a0 45 31 db 45 31 f6 45 31 c9 31 ff 89 4d 98 85 db 0f 84 7f 04 00 00 44 8b 6d 98 4c 89 ee 48 c1 e6 04 49 03 70 78 <8b> 46 08 44 8b 56 0c 48
8b 16 44 29 e0 39 d8 48 89 55 a8 0f 47 c3
[  532.838634] RSP: 0018:ffffb9b708df39b0 EFLAGS: 00010246
[  533.093571] RAX: 00000000ffffffff RBX: 0000000000046000 RCX: 0000000000000000
[  533.441865] RDX: 0000000000000200 RSI: 0000000000000000 RDI: 0000000000000000
[  533.789922] RBP: ffffb9b708df3a48 R08: ffff940d3b3fdd20 R09: 0000000000000000
[  534.137512] R10: ffffb9b708df3958 R11: 0000000000000000 R12: 0000000000000000
[  534.485329] R13: 0000000000000000 R14: 0000000000000000 R15: ffff940d39212020
[  534.833319] FS:  00007efec26e3840(0000) GS:ffff940d1f480000(0000) knlGS:0000000000000000
[  535.224098] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  535.504318] CR2: 0000000000000008 CR3: 0000001f4e256004 CR4: 00000000001606e0
[  535.851759] Call Trace:
[  535.970308]  ? mempool_alloc_slab+0x15/0x20
[  536.174152]  ? bch_data_insert+0x42/0xd0 [bcache]
[  536.403399]  blk_mq_make_request+0x97/0x4f0
[  536.607036]  generic_make_request+0x1e2/0x410
[  536.819164]  submit_bio+0x73/0x150
[  536.980168]  ? submit_bio+0x73/0x150
[  537.149731]  ? bio_associate_blkg_from_css+0x3b/0x60
[  537.391595]  ? _cond_resched+0x1a/0x50
[  537.573774]  submit_bio_wait+0x59/0x90
[  537.756105]  blkdev_issue_discard+0x80/0xd0
[  537.959590]  ext4_trim_fs+0x4a9/0x9e0
[  538.137636]  ? ext4_trim_fs+0x4a9/0x9e0
[  538.324087]  ext4_ioctl+0xea4/0x1530
[  538.497712]  ? _copy_to_user+0x2a/0x40
[  538.679632]  do_vfs_ioctl+0xa6/0x600
[  538.853127]  ? __do_sys_newfstat+0x44/0x70
[  539.051951]  ksys_ioctl+0x6d/0x80
[  539.212785]  __x64_sys_ioctl+0x1a/0x20
[  539.394918]  do_syscall_64+0x5a/0x110
[  539.568674]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

We have observed it where both:
1) LVM/devmapper is involved (bcache backing device is LVM volume) and
2) writeback cache is involved (bcache cache_mode is writeback)

On one machine, we can reliably reproduce it with:

 # echo writeback > /sys/block/bcache0/bcache/cache_mode # not sure if this is required
 # mount /dev/bcache0 /test
 # for i in {0..10}; do file="$(mktemp /test/zero.XXX)"; dd if=/dev/zero of="$file" bs=1M count=256; sync; rm $file; done; fstrim -v /test

Observing this with tracepoints on, we see the following writes:

fstrim-18019 [022] .... 91107.302026: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4260112 + 196352 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302050: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4456464 + 262144 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302075: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 4718608 + 81920 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302094: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5324816 + 180224 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302121: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5505040 + 262144 hit 0 bypass 1
fstrim-18019 [022] .... 91107.302145: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 5767184 + 81920 hit 0 bypass 1
fstrim-18019 [022] .... 91107.308777: bcache_write: 73f95583-561c-408f-a93a-4cbd2498f5c8 inode 0  DS 6373392 + 180224 hit 1 bypass 0
<crash>

Note the final one has different hit/bypass flags.

This is because in should_writeback(), we were hitting a case where
the partial stripe condition was returning true and so
should_writeback() was returning true early.

If that hadn't been the case, it would have hit the would_skip test, and
as would_skip == s->iop.bypass == true, should_writeback() would have
returned false.

Looking at the git history from 72c270612bd3 ("bcache: Write out full
stripes"), it looks like the idea was to optimise for raid5/6:

       * If a stripe is already dirty, force writes to that stripe to
	 writeback mode - to help build up full stripes of dirty data

To fix this issue, make sure that should_writeback() on a discard op
never returns true.

More details of debugging: https://www.spinics.net/lists/linux-bcache/msg06996.html

Previous reports:
 - https://bugzilla.kernel.org/show_bug.cgi?id=201051
 - https://bugzilla.kernel.org/show_bug.cgi?id=196103
 - https://www.spinics.net/lists/linux-bcache/msg06885.html

Cc: Kent Overstreet <koverstreet@google.com>
Cc: stable@vger.kernel.org
Fixes: 72c270612bd3 ("bcache: Write out full stripes")
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/md/bcache/writeback.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index 6a743d3bb338..4e4c6810dc3c 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -71,6 +71,9 @@ static inline bool should_writeback(struct cached_dev *dc, struct bio *bio,
 	    in_use > bch_cutoff_writeback_sync)
 		return false;
 
+	if (bio_op(bio) == REQ_OP_DISCARD)
+		return false;
+
 	if (dc->partial_stripes_expensive &&
 	    bcache_dev_stripe_dirty(dc, bio->bi_iter.bi_sector,
 				    bio_sectors(bio)))
-- 
2.17.1

