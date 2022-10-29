Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB033C38A02
	for <linux-block@archiver.kernel.org>; Sat, 29 Oct 2022 01:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJ2BFz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 21:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJ2BFy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 21:05:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C198C38A16
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 18:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667005499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lv2gcG0mi6BhhQX1GFxjBRiCscYfuQR/lUfg9fXxC6c=;
        b=W8wO+Rk9yZwiKBKisBw9jbmGgh0u6A5hVwdVRwx7kNMKkIYvkyEJ3z2tWtLJPc7TEK+yzy
        UQjbSIivvlt4kwnoNL+rHZA3UhIyeYHDbITiFMaERPsBGYY6Vg8Ob1UJLwHnkZzZ6unOPY
        LL676S2D3nI1SIcCJyyOBfdaI75xhlo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-93-iEWuiGOvPm-EQE_SG1836g-1; Fri, 28 Oct 2022 21:04:55 -0400
X-MC-Unique: iEWuiGOvPm-EQE_SG1836g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FC9C101A528;
        Sat, 29 Oct 2022 01:04:55 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DF6C40C206B;
        Sat, 29 Oct 2022 01:04:53 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] ublk_drv: comment on ublk_driver entry of Kconfig
Date:   Sat, 29 Oct 2022 09:04:30 +0800
Message-Id: <20221029010432.598367-3-ming.lei@redhat.com>
In-Reply-To: <20221029010432.598367-1-ming.lei@redhat.com>
References: <20221029010432.598367-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add help info for choosing to build ublk_drv as module or builtin.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index db1b4b202646..a41145d52de9 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -408,6 +408,12 @@ config BLK_DEV_UBLK
 	  definition isn't finalized yet, and might change according to future
 	  requirement, so mark is as experimental now.
 
+	  Say Y if you want to get better performance because task_work_add()
+	  can be used in IO path for replacing io_uring cmd, which will become
+	  shared between IO tasks and ubq daemon, meantime task_work_add() can
+	  can handle batch more effectively, but task_work_add() isn't exported
+	  for module, so ublk has to be built to kernel.
+
 source "drivers/block/rnbd/Kconfig"
 
 endif # BLK_DEV
-- 
2.31.1

