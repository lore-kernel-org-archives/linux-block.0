Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A7C54E94
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 11:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjAZLyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAZLyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 06:54:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707512CFE5
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 03:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674734037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aWBzW99Th6YnywddwVf19AB0rAwD8aCbK+IZ2eg6LM8=;
        b=XvwY8bMNxXjhdwoXKAOR1+GJb/324we5xpLD964tUmMOqTs7/oDQ83+8PCsWSEr/04gI0S
        1M/md3hTcge/+3BIwdzxcBIfqP0pCOk9Mq8tMUIYL/0nHu0BJkTHdHxWrpW4fIhq5SakLX
        +6s5Ynmc2fbj5rYl4IHYWOU7AcBBSek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-YrlYyaEiOMORiCTfirMG4A-1; Thu, 26 Jan 2023 06:53:56 -0500
X-MC-Unique: YrlYyaEiOMORiCTfirMG4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF30387A9E0;
        Thu, 26 Jan 2023 11:53:55 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E500B140EBF5;
        Thu, 26 Jan 2023 11:53:54 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        "Harris, James R" <james.r.harris@intel.com>
Subject: [PATCH] block: ublk: move ublk_chr_class destroying after devices are removed
Date:   Thu, 26 Jan 2023 19:53:46 +0800
Message-Id: <20230126115346.263344-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The 'ublk_chr_class' is needed when deleting ublk char devices in
ublk_exit(), so move it after devices(idle) are removed.

Fixes the following warning reported by Harris, James R:

[  859.178950] sysfs group 'power' not found for kobject 'ublkc0'
[  859.178962] WARNING: CPU: 3 PID: 1109 at fs/sysfs/group.c:278 sysfs_remove_group+0x9c/0xb0

Reported-by: "Harris, James R" <james.r.harris@intel.com>
Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Link: https://lore.kernel.org/linux-block/Y9JlFmSgDl3+zy3N@T590/T/#t
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9f32553cb938..a725a236a38f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2238,13 +2238,12 @@ static void __exit ublk_exit(void)
 	struct ublk_device *ub;
 	int id;
 
-	class_destroy(ublk_chr_class);
-
-	misc_deregister(&ublk_misc);
-
 	idr_for_each_entry(&ublk_index_idr, ub, id)
 		ublk_remove(ub);
 
+	class_destroy(ublk_chr_class);
+	misc_deregister(&ublk_misc);
+
 	idr_destroy(&ublk_index_idr);
 	unregister_chrdev_region(ublk_chr_devt, UBLK_MINORS);
 }
-- 
2.31.1

