Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AD2C004D4
	for <linux-block@archiver.kernel.org>; Wed, 18 Jan 2023 04:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjAREYs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 23:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjAREYq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 23:24:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AACB54B10
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 20:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674015829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O3rVi0Tm+UIuHqPCOZjdFFLlALLFBT90ih2Ct60lx9o=;
        b=bYxm+REYvj8Zn8qnaGmIXFunSdQbaZiLOZkHLAb9FB8QP00rQZffWv0wgN2LckP7QqLgCS
        VzZTwRFJkEoIwKT6Jr8wD3UkpXz96BWwCSHmqCZYaosxLD7DsvCkSmdJvi58iAZ8CVw97d
        1dSAx0RFXnk8vQ8CWFMtPGVh1NZ/qIA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-340-xLJi23cLNY-lNv74hSoVrA-1; Tue, 17 Jan 2023 23:23:46 -0500
X-MC-Unique: xLJi23cLNY-lNv74hSoVrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1CEA585A588;
        Wed, 18 Jan 2023 04:23:46 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 161FF40C2064;
        Wed, 18 Jan 2023 04:23:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: ublk: fix doc build warning
Date:   Wed, 18 Jan 2023 12:23:18 +0800
Message-Id: <20230118042318.127900-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following warning:

Documentation/block/ublk.rst:157: WARNING: Enumerated list ends without a blank line; unexpected unindent.
Documentation/block/ublk.rst:171: WARNING: Enumerated list ends without a blank line; unexpected unindent.

Fixes: 56f5160bc1b8 ("ublk_drv: add mechanism for supporting unprivileged ublk device")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 Documentation/block/ublk.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/block/ublk.rst b/Documentation/block/ublk.rst
index 2916fcf3ab44..1713b2890abb 100644
--- a/Documentation/block/ublk.rst
+++ b/Documentation/block/ublk.rst
@@ -154,7 +154,9 @@ managing and controlling ublk devices with help of several control commands:
   How to deal with userspace/kernel compatibility:
 
   1) if kernel is capable of handling ``UBLK_F_UNPRIVILEGED_DEV``
+
     If ublk server supports ``UBLK_F_UNPRIVILEGED_DEV``:
+
     ublk server should send ``UBLK_CMD_GET_DEV_INFO2``, given anytime
     unprivileged application needs to query devices the current user owns,
     when the application has no idea if ``UBLK_F_UNPRIVILEGED_DEV`` is set
@@ -162,16 +164,20 @@ managing and controlling ublk devices with help of several control commands:
     retrieve it via ``UBLK_CMD_GET_DEV_INFO2``
 
     If ublk server doesn't support ``UBLK_F_UNPRIVILEGED_DEV``:
+
     ``UBLK_CMD_GET_DEV_INFO`` is always sent to kernel, and the feature of
     UBLK_F_UNPRIVILEGED_DEV isn't available for user
 
   2) if kernel isn't capable of handling ``UBLK_F_UNPRIVILEGED_DEV``
+
     If ublk server supports ``UBLK_F_UNPRIVILEGED_DEV``:
+
     ``UBLK_CMD_GET_DEV_INFO2`` is tried first, and will be failed, then
     ``UBLK_CMD_GET_DEV_INFO`` needs to be retried given
     ``UBLK_F_UNPRIVILEGED_DEV`` can't be set
 
     If ublk server doesn't support ``UBLK_F_UNPRIVILEGED_DEV``:
+
     ``UBLK_CMD_GET_DEV_INFO`` is always sent to kernel, and the feature of
     ``UBLK_F_UNPRIVILEGED_DEV`` isn't available for user
 
-- 
2.31.1

