Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC5FC433DF
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 01:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C5B2054F
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 01:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+7OJX/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgENBnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 21:43:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56971 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENBnQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 21:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589420595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zS0LU9unPFcZ24UkAd5rZAMx/qROGT2ogvBNae2cp1I=;
        b=G+7OJX/tg0LvBaKibXRaTv2LXqEE0e5B5/qNykCExJbTq2IWpl56OGkGLGmNcmIA7/RRH6
        xQNVk8H8PRhOBr+2X8JZKpXUK9Z23Pa/dGdSm97OpfmaxuKFoSDbHfskTbhw/L8ygM1o6f
        +mvP05DMTDCJAQwbmhlNKPCvUGT9Plg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-QBXc1giOOWiym3ahc9cqKg-1; Wed, 13 May 2020 21:43:13 -0400
X-MC-Unique: QBXc1giOOWiym3ahc9cqKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EADD460;
        Thu, 14 May 2020 01:43:12 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1FDD60C47;
        Thu, 14 May 2020 01:43:08 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH] block: fix build failure in case of !CONFIG_BLOCK
Date:   Thu, 14 May 2020 09:43:02 +0800
Message-Id: <20200514014302.2078182-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit e6249cdd46e4 ("block: add blk_io_schedule() for avoiding task hung
in sync dio") adds helper blk_io_schedule, however the required header
is added for CONFIG_BLOCK only.

Fixes the issue by moving the added '#include' out of CONFIG_BLOCK
because blk_io_schedule() doesn't need any CONFIG_BLOCK only stuff.

Fixes: e6249cdd46e4 ("block: add blk_io_schedule() for avoiding task hung in sync dio")
Reported-by: Satya Tangirala <satyat@google.com>
Tested-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blkdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5360696d85ff..bf99a723673b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -4,6 +4,7 @@
 
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/sysctl.h>
 
 #ifdef CONFIG_BLOCK
 
@@ -27,7 +28,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/sched/sysctl.h>
 
 struct module;
 struct scsi_ioctl_command;
-- 
2.25.2

