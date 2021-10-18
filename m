Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77073C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 11:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5908860FD8
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 11:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhJRMAZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbhJRMAY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 08:00:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8567C06161C;
        Mon, 18 Oct 2021 04:58:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f11so10651164pfc.12;
        Mon, 18 Oct 2021 04:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=SuFOxZl4+HH69viYIp+PkDxoOY0BPw8gzbppwpli0cs=;
        b=XZYvJm/CBRdfr55abbtGKo3QQ2debO5VqEhs2PJuIV7rsBSecPpoJkVX4NKw0uZjWd
         NVKcH7XaTPS5AdUvJSTjLJNmj98awqHxENTZ/EYMaK1P3ltgCzEVswEM0zfdsXX9geSp
         P6FuKzDV4jaGfenNBzxMgaWD1m2+QGe57CTkrfFKJggq5UAeq5A4uYW3gc3iZ3b+OYe+
         MfQZesqbd1jhE1nJWZaSQgsOBBqywU5bOryj/b5OVdOgCW3/wZeL3Bfac/fS0gqtYhXk
         llz87F7jzY8NT2kxbIsh017J5OQ7nIKsgHZUog24Ns1paFhz2CHcmkRyOZ7Ym2b+zgfx
         QEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SuFOxZl4+HH69viYIp+PkDxoOY0BPw8gzbppwpli0cs=;
        b=HIvz4F3hTtDjmcbZs8XXrC0esab2Pa9vz63NpgYHTXcKJ7oaWspLZtOdbPT6IYqsHc
         ZyqmzadtyGeGdm/EufyTe1CgtKbTAlB+zPp7geGaJY+tQi5YAeDtXvNdxbXmYF37/rAl
         PUIX7Q/FwoI/PsQLWge1SYy/VULB+OwS3lBx00GIpZXsXFO13weGB8UIc7res9HLVe3X
         YmX7a0vsqj4SAZ8wCrPzsFe0DjUiLj5oEarFhnGCa3ZYFTEy3KGG2uO/jnrkzaHWRNpa
         f2XcmvPjclEb/xQebXThZ1Byhuh8toFI2rSiaNTsFq6IweqEELR20BYbQvIbTo/3UfNb
         Ah4g==
X-Gm-Message-State: AOAM530bMraNsC/bpzOINwnqocWP3/ibTH68PBfRCQbVDt3kx6244vCT
        owNkeeK6HGJmIbg6WulzKbwfMQGoEt6G+j6s
X-Google-Smtp-Source: ABdhPJztPygk/CipWYSHV7wHwvh/c8bpjiMTQ8DKltuYtItsgFJu1gfWNxkNbCcDzQo4uPUJhwa58w==
X-Received: by 2002:a63:6b03:: with SMTP id g3mr23216912pgc.123.1634558293387;
        Mon, 18 Oct 2021 04:58:13 -0700 (PDT)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id d60sm18910124pjk.49.2021.10.18.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 04:58:13 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     axboe@kernel.dk, hch@lst.de, willy@infradead.org,
        sunhao.th@gmail.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v3] block: fix incorrect references to disk objects
Date:   Mon, 18 Oct 2021 19:58:07 +0800
Message-Id: <20211018115807.21103-1-qiang.zhang1211@gmail.com>
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

Return directly after calling the put_device().

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 v1->v2:
 directly returning instead of assigning disk to NULL
 v2->v3:
 modify description information

 block/partitions/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 9dbddc355b40..ed5deef1d7e1 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -424,6 +424,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
 	device_del(pdev);
 out_put:
 	put_device(pdev);
+	return ERR_PTR(err);
 out_put_disk:
 	put_disk(disk);
 	return ERR_PTR(err);
-- 
2.17.1

