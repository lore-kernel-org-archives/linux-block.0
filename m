Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E680EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 03:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjF3D4Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Jun 2023 23:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3D4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Jun 2023 23:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17B626B6
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 20:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688097331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eV/OBlmrrpR5W87UubDVNpoENTPfzTnE6+btWIKYR6g=;
        b=ISX6es2S5nDoIC3gQxpH+qnbp9ojvveTZ9BORRPUKvCYkuGbZ0EB9MHdcYfx8ArTsnDw25
        HErqq7RiLgnjLHjlygP30xzhSat4KCpxDCK0eyc34mJ5yMtXIWoRYmwUqkYOXXDdRmzut+
        wNE2daVjCd5x/xr37Sm7IGKXiKjX+R8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-M0RbMBxzOgqnQylJuNmu7w-1; Thu, 29 Jun 2023 23:55:27 -0400
X-MC-Unique: M0RbMBxzOgqnQylJuNmu7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB7E51C05135;
        Fri, 30 Jun 2023 03:55:26 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5043515230A0;
        Fri, 30 Jun 2023 03:55:23 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     shinichiro.kawasaki@wdc.com, bvanassche@acm.org
Subject: [PATCH blktests] zbd/009: skip have_good_mkfs_btrfs when mkfs.btrfs not avaiable
Date:   Fri, 30 Jun 2023 20:00:28 +0800
Message-Id: <20230630120028.2980792-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

tests/zbd/009: line 24: mkfs.btrfs: command not found
zbd/009 (test gap zone support with BTRFS)                   [not run]
    driver btrfs is not available
    mkfs.btrfs is not available

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/zbd/009 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/zbd/009 b/tests/zbd/009
index c0ce1f2..6226d83 100755
--- a/tests/zbd/009
+++ b/tests/zbd/009
@@ -35,9 +35,8 @@ requires() {
 	_have_fio
 	_have_driver btrfs
 	_have_module_param scsi_debug zone_cap_mb
-	_have_program mkfs.btrfs
+	_have_program mkfs.btrfs && have_good_mkfs_btrfs
 	_have_module scsi_debug
-	have_good_mkfs_btrfs
 }
 
 test() {
-- 
2.34.3

