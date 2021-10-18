Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2389C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80CAD6101B
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 09:11:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhJRJNk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhJRJNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 05:13:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE6C06161C;
        Mon, 18 Oct 2021 02:11:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m21so15439850pgu.13;
        Mon, 18 Oct 2021 02:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Ewy/OKswLYPZAgNcZXQwvve5zSIn1eK4olZjK+6v5cE=;
        b=DrVPf6LaBZ2rOkH0DPMaGRbRtFfL8B0052hB2ZYe1ZIcJXeTl9ncExV9IOQTRVkx7K
         DxYQv1sN8p9ZTf3hcNGtVxmnrB+XAqGBGino9YvXL4wMkQTR2EIYY0XEnll8iuwmqtP1
         KzzqZeoDJsVjgYvIh2pHcE3YqKmaUSe6gEOtDdWyDE2QCDv5V3tVwRgXCzP1TeRqPEK4
         SmKk2ONaJh2UvO82sFAYjqQX3ScFLT1wUmyYeKVuyJjjTE+y5S05UMrk9KsTjj+uDRAa
         KcZouhu7ixR0FHjxD5+qw8rsrfWdK/d59UpztXGkkJmEfy7nZeanBH0sIOad/LH9ol8M
         hM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ewy/OKswLYPZAgNcZXQwvve5zSIn1eK4olZjK+6v5cE=;
        b=cIYT/5c9eJC/jkBkoiuwlntewdDaObv6pIDcxVuIljDNEbaXbB8uwnUU1Hh0sFQ+Tc
         o0LCldu0/c/2DauEQ4AXIb/UjisInLuYZYUPh1h8ky424OVoZR/rnTiQ3UV2bsrohJSR
         gxFI/WpV5uq47FZIeXiDMa087D6t8i8i3HrUqo6TayMOPAHtdoFOXI/DdntEmDzXq58t
         HUUP7rU9e1hhDR4fjJ670dO3NheV3NmjLddqwyjcBoazQ5o1tmvaBO8DDNmPAQ0i+q8T
         lEN/tDrNWjYteypoVfTONxUmvqHR8tmx6+r4KZFzszJ+GLBUzKCvkGa6q3z9SlAAPhld
         SBIQ==
X-Gm-Message-State: AOAM533IG/RC4S0e/hI8rAG+sw838I5oKaPxlNAjU/9z+K+ebxIoBlrG
        Iyi1Vb8WRUiJIPtw3aGbc6E=
X-Google-Smtp-Source: ABdhPJwspwvNNJxse0N4olrSeBZoCa5R9srL0m3FyRh5mIUP+AWhbt97viHoUfYL6Xp9xXnrrAFfNA==
X-Received: by 2002:a05:6a00:9a2:b0:44c:b979:afe3 with SMTP id u34-20020a056a0009a200b0044cb979afe3mr11666105pfg.61.1634548283020;
        Mon, 18 Oct 2021 02:11:23 -0700 (PDT)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id oc8sm12916951pjb.15.2021.10.18.02.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 02:11:22 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     axboe@kernel.dk, hch@lst.de, willy@infradead.org,
        sunhao.th@gmail.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH] block: fix incorrect references to disk objects
Date:   Mon, 18 Oct 2021 17:11:16 +0800
Message-Id: <20211018091116.16874-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When adding partitions to the disk, the reference count of the disk
object is increased. then alloc partition device and called
device_add(), if the device_add() return error, the reference
count of the disk object will be reduced twice, at put_device(pdev)
and put_disk(disk). this leads to the end of the object's life cycle
prematurely, and trigger following calltrace.

  __init_work+0x2d/0x50 kernel/workqueue.c:519
  synchronize_rcu_expedited+0x3af/0x650 kernel/rcu/tree_exp.h:847
  bdi_remove_from_list mm/backing-dev.c:938 [inline]
  bdi_unregister+0x17f/0x5c0 mm/backing-dev.c:946
  release_bdi+0xa1/0xc0 mm/backing-dev.c:968
  kref_put include/linux/kref.h:65 [inline]
  bdi_put+0x72/0xa0 mm/backing-dev.c:976
  bdev_free_inode+0x11e/0x220 block/bdev.c:408
  i_callback+0x3f/0x70 fs/inode.c:226
  rcu_do_batch kernel/rcu/tree.c:2508 [inline]
  rcu_core+0x76d/0x16c0 kernel/rcu/tree.c:2743
  __do_softirq+0x1d7/0x93b kernel/softirq.c:558
  invoke_softirq kernel/softirq.c:432 [inline]
  __irq_exit_rcu kernel/softirq.c:636 [inline]
  irq_exit_rcu+0xf2/0x130 kernel/softirq.c:648
  sysvec_apic_timer_interrupt+0x93/0xc0

making disk is NULL when calling put_disk().

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 block/partitions/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 3a4898433c43..4cb6803e7021 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -424,6 +424,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	device_del(pdev);
 out_put:
 	put_device(pdev);
+	disk = NULL;
 out_put_disk:
 	put_disk(disk);
 	return ERR_PTR(err);
-- 
2.17.1

