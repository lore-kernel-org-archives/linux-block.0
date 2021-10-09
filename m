Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E10C433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 07:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968C860F57
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 07:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbhJIHBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Oct 2021 03:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhJIHBz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Oct 2021 03:01:55 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC50C061570;
        Fri,  8 Oct 2021 23:59:58 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s75so5307291pgs.5;
        Fri, 08 Oct 2021 23:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=emkYxqV58YPcnV9wK+4W0hPkQJrufAB8SQaSjaWcy5A=;
        b=WqZKMgV11Xw4RG4qCsyL9ju4SHNDw3Y0p+eqNq+CtEFun6XseYSK1oSe95cgNNov8G
         +iyHPv0r6PmCdcMItx9+IeZc3rviPXopp5yVWkJF3DvT9KuAh5Ek8T382FB5nUqt+Afk
         lZMtPD4ujs+ZRWzAyIPqE33/v5SmWbU2RhSfS8QUrGWlaHJJ2HFBNHaWu8LO4disSYb3
         zhJjr1rvn6ro3J98PV5DKT7M2TIGiwVcU+PTQcLeDOfhleJLmYcbrBQbkIYZR/KeGvb2
         14AWPEkXzRzuLe26ov7pI/H1cCKGABvvnAGpQKAnhgmWtACxwy81nZ7X2vO4nMC8pnuF
         7Vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=emkYxqV58YPcnV9wK+4W0hPkQJrufAB8SQaSjaWcy5A=;
        b=ArZo+JINEiZ8OofY41RNKCR7jZSFyb41fYEZlN30RZ583MlAUeQD1ZClNZdlJksGDd
         krsoRUXgYMejFxDQfD5PCksk7ERAb8zDMSmKtSBt+oWt9StlRcK1vAvfhHqFRhnFO/LJ
         QaW/adxRLTKptCB/jj7ep2ct3SDdIQsRekOIUF9Wyfqo8K6QFueoWyBvfidPxTjFb44e
         47UL38b8Rgss4axvnH7tLXDId5N+rxru+9k4ZwbRJpJmFtTjEgSlhhZZFkxtGi4bguNm
         +J5iBSPvpcEe8XJ3VFqrqDitl+vCdoSymEFCxXVTzva4Gb6H9giMy4/MKmMYKruEsuXH
         raJw==
X-Gm-Message-State: AOAM531lCmjQQZNX0XqHhYzxDw1V+g50N1p738xH+epqUQjwjufLUHjb
        xGsd5L0FWDhbsG7T2XZp4HmdkudSwTxbNw==
X-Google-Smtp-Source: ABdhPJztwOXqNXOM0Zc8NmSCVPIUJraqhJkrm2fVuLW3P69MLO2hajyzqdiY1Hm+fpSEucSY3bP9ZA==
X-Received: by 2002:a63:f5b:: with SMTP id 27mr8197250pgp.302.1633762798198;
        Fri, 08 Oct 2021 23:59:58 -0700 (PDT)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id g3sm1389513pgj.66.2021.10.08.23.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 23:59:57 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     axboe@kernel.dk
Cc:     penguin-kernel@I-love.SAKURA.ne.jp, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] block: fix syzbot report UAF in bdev_free_inode()
Date:   Sat,  9 Oct 2021 14:59:51 +0800
Message-Id: <20211009065951.11567-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BUG: KASAN: use-after-free in bdev_free_inode+0x202/0x220
Read of size 8 at addr ffff88806e022148 by task systemd-udevd/8843
Call Trace:
 <IRQ>
 __dump_stack [inline]
 dump_stack_lvl+0xcd/0x134
 print_address_description.constprop.0.cold+0x6c/0x2d6
 __kasan_report [inline]
 kasan_report.cold+0x83/0xdf
 bdev_free_inode+0x202/0x220
 i_callback+0x3f/0x70
 rcu_do_batch [inline]
 rcu_core+0x7ab/0x1470
 __do_softirq+0x29b/0x9c2
 invoke_softirq [inline]
 __irq_exit_rcu+0x123/0x180
 irq_exit_rcu+0x5/0x20

Allocated by task 15227:
 kasan_save_stack+0x1b/0x40
 kasan_set_track [inline]
 set_alloc_info [inline]
 ____kasan_kmalloc [inline]
 ____kasan_kmalloc [inline]
 __kasan_kmalloc+0xa1/0xd0
 kasan_kmalloc [inline]
 kmem_cache_alloc_node_trace+0x20b/0x5d0
 kmalloc_node [inline]
 kzalloc_node [inline]
 __alloc_disk_node+0x77/0x580
 __blk_mq_alloc_disk+0xed/0x160
 loop_add+0x340/0x960
 loop_control_get_free [inline]
 loop_control_ioctl+0x227/0x4a0

 Freed by task 15227:
 kasan_save_stack+0x1b/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x20/0x30
 ____kasan_slab_free [inline]
 ____kasan_slab_free [inline]
 __kasan_slab_free+0xd1/0x110
 kasan_slab_free [inline]
 __cache_free [inline]
 kfree+0x10a/0x2c0
 __alloc_disk_node+0x474/0x580
 __blk_mq_alloc_disk+0xed/0x160
 loop_add+0x340/0x960
 loop_control_get_free [inline]
 loop_control_ioctl+0x227/0x4a0

The xa_insert() may be return error in __alloc_disk_node(), and the disk
object will be release, however there are two operations that will release
it, kfree(disk) and iput(disk->part0->bd_inode), the iput operations
will call call_rcu(), because the rcu callback executed is an asynchronous
actionthe, so when free disk object in rcu callback, the disk object haven
been released. solve it through a unified release action.

Reported-by: syzbot+8281086e8a6fbfbd952a@syzkaller.appspotmail.com
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 block/genhd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 5e8aa0ab66c2..924b75d9dfa6 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1269,11 +1269,13 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
 
 out_destroy_part_tbl:
 	xa_destroy(&disk->part_tbl);
-	iput(disk->part0->bd_inode);
 out_free_bdi:
 	bdi_put(disk->bdi);
 out_free_disk:
-	kfree(disk);
+	if (disk->part0)
+		iput(disk->part0->bd_inode);
+	else
+		kfree(disk);
 out_put_queue:
 	blk_put_queue(q);
 	return NULL;
-- 
2.17.1

