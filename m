Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA8CC00144
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 06:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiG2GEk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 02:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiG2GEj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 02:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B41819006
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 23:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659074677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9IhAbq2OZvyBjB2CO9TdBT4poez9LYI5ZVOI4Np8XII=;
        b=XIOEWl8K+ztoY3THGnshyWEWkdKzLomRyjpiGuovdy9hQWPl8kHZf0wt8YaYvhifQCJ92B
        +NZN2m5U74kotgcKXvVZ3lqzrXuFQLROBd4LZkfJPw/BHe1yJRe+yCgG8wRYW5h2907vvr
        xLaYKWZpKcPQRQE9x7hq8P253KtCuiY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-75MQJ35pMg-VQ9QBvsgi-w-1; Fri, 29 Jul 2022 02:04:28 -0400
X-MC-Unique: 75MQJ35pMg-VQ9QBvsgi-w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB8FC3C0E228;
        Fri, 29 Jul 2022 06:04:27 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D931440C1288;
        Fri, 29 Jul 2022 06:04:25 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com
Subject: [PATCH blktests] block/002: remove debugfs check while blktests is running
Date:   Fri, 29 Jul 2022 14:04:11 +0800
Message-Id: <20220729060411.162529-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Seem commit: 99d055b4fd4b ("block: remove per-disk debugfs files in blk_unregister_queue")

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/block/002 | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tests/block/002 b/tests/block/002
index 9b183e7..15b47a6 100755
--- a/tests/block/002
+++ b/tests/block/002
@@ -25,9 +25,6 @@ test() {
 	blktrace -D "$TMP_DIR" "/dev/${SCSI_DEBUG_DEVICES[0]}" >"$FULL" 2>&1 &
 	sleep 0.5
 	echo 1 > "/sys/block/${SCSI_DEBUG_DEVICES[0]}/device/delete"
-	if [[ ! -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
-		echo "debugfs directory deleted with blktrace active"
-	fi
 	{ kill $!; wait; } >/dev/null 2>/dev/null
 	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; then
 		echo "debugfs directory leaked"
-- 
2.34.1

