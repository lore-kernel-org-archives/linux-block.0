Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFF5C04A68
	for <linux-block@archiver.kernel.org>; Sat, 30 Jul 2022 07:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiG3H6p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Jul 2022 03:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG3H6o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Jul 2022 03:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FC7B12746
        for <linux-block@vger.kernel.org>; Sat, 30 Jul 2022 00:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659167922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eNh7WAaQtf2DeRktyS9OyMciIVF8g/7ZlI3xGnzyu7U=;
        b=dUm6b3+Gxx6SemTm3bMtpiZczXB1F9+Tdp3JBvWT8MAJ4bDIe7NnwOMWH7VNZMiSYHzUqn
        S0p1yU3xtJ45KRsPFurDYalCaiRHPpyl1IQMR0MIaawqRDfL9WpO+xzOnjEzu49b18FehM
        b75pPnY8QtllgouvWlgTc9N4G+k2bhc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-fHAKEG5XOiW8iuHywgMabg-1; Sat, 30 Jul 2022 03:58:40 -0400
X-MC-Unique: fHAKEG5XOiW8iuHywgMabg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85F921019C8E;
        Sat, 30 Jul 2022 07:58:40 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73A3290A04;
        Sat, 30 Jul 2022 07:58:38 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     linux-block@vger.kernel.org, hch@lst.de, ming.lei@redhat.com
Subject: [PATCH v2 blktests] block/002: remove debugfs check while blktests is running
Date:   Sat, 30 Jul 2022 15:58:28 +0800
Message-Id: <20220730075828.218063-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

See commit: 99d055b4fd4b ("block: remove per-disk debugfs files in blk_unregister_queue")

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

