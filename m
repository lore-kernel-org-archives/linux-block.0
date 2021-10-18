Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ECBC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE15C6101B
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 10:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhJRKgj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJRKgj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 06:36:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA0EC06161C;
        Mon, 18 Oct 2021 03:34:28 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d9so7184340pfl.6;
        Mon, 18 Oct 2021 03:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=vLQG/+g2rc3n5AuI3xXz6ksQ52G8r7tXmP6Q5CEcgiw=;
        b=HLswWWW6B+2ynEGgOfkT0acpnqrMyj0oamcKteuldzzs0J3HjL/wT7rwDjqdrK52e0
         zqTfF4dVJAYDU/4ITJrnojxEyyWihO4+yY7D11btwYEgb+DoDegMVhaUgcWrnZqjbxCq
         sKt1aWWLfjRFjL4/Vc5/Badlme5DfDcSZadZ7C3D5Ul1XlHpAi3KfwuvoxNgKFYx8JUk
         H0sxSIwx+n9dxuGmxXFVGocynysIW+8NqNqUni76BogZXDU+ZHtE51m3NPNXCisp7kM4
         hEVUJEAZ1v3zfCdKyvkK5e722FNju2ohrGkWjaeQMy9I4+PbZKtlqNhkEplR9hybR23J
         1igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vLQG/+g2rc3n5AuI3xXz6ksQ52G8r7tXmP6Q5CEcgiw=;
        b=Kp13S993ynLwTu4uGld/95cXz42DX69HewA9faQNDtrP29cqsz6J50OzXdARib89Cq
         QYmD8ZbzeBcFxtn5ArHzpF2OsPPo7qVlQ4TLnJo6AzAXhlBBPclagtZgpQxOfAsegvB5
         RMomgGaRJzbLYYP6k6kJM0gegfOyLhsjl3I+M8mgm8zbwApMVMB0ozrYVGD8lpyQprvp
         LoBo+ZGhC8FO2M6Os94U8yGbcmVcPvdmfKdjBgZYzIgOIaJSbVsMN8rETxXrcQ7Xsd+r
         jj9a//NBPL4Kim2GWee2Be7gWuFtLiyASB+ujI98lDmhZqGPss8xkImdKCI5ihNHUkJ2
         2XGw==
X-Gm-Message-State: AOAM531gO6R85hPX7fGsnhvLwzTm9GuwGyVXE5S5L1FVbhKljZf1adLB
        fgAO6ZsVyuogjOcw8c5tWvs=
X-Google-Smtp-Source: ABdhPJyvP2qYsPvVHCK0I7vIFhwjt162USP6z7Unh/ve00dwza8v6p9WmNVysrkEwmfWelWCx6BWmw==
X-Received: by 2002:a05:6a00:1488:b0:44d:25b2:f80b with SMTP id v8-20020a056a00148800b0044d25b2f80bmr27802215pfu.20.1634553267884;
        Mon, 18 Oct 2021 03:34:27 -0700 (PDT)
Received: from BJ-zhangqiang.qcraft.lan ([137.59.101.13])
        by smtp.gmail.com with ESMTPSA id z24sm13229044pfr.141.2021.10.18.03.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:34:27 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     axboe@kernel.dk, hch@lst.de, willy@infradead.org,
        sunhao.th@gmail.com, hch@infradead.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH v2] block: fix incorrect references to disk objects
Date:   Mon, 18 Oct 2021 18:34:22 +0800
Message-Id: <20211018103422.2043-1-qiang.zhang1211@gmail.com>
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
 v1->v2:
 directly returning instead of assigning disk to NULL 

 block/partitions/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 3a4898433c43..b9e9af84f518 100644
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

