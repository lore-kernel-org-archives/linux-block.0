Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9DFC433E2
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 16:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244BD207DE
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 16:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HPIgxpiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgIHQky (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732058AbgIHQhS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 12:37:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47157C061A1E
        for <linux-block@vger.kernel.org>; Tue,  8 Sep 2020 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=B5DBS8AjjyhdBsuLM+GAWRwiiYnKP0qrHTOAUm6OMoE=; b=HPIgxpiqo0NmQw0+6MwgrYIP84
        NupV8murlkbAuicnDTKRpXHi2eeJ/XRbtBMhSsJp5vi7wukIpNNSUPHoD2oLVsE2wE7MxKmp+kA0P
        0Ue5oVeis3cD01SMApYyorzUE8qxWTSNOoyy2+hvjwpfMBXgX2PCy/0zeGPgFegVqC1PY8LWekwpD
        4NLE5MkEBvnBx5obHhF4zZ+4WwC5g5s8W+HSZh3daAH8Rez3kvZISGGg6QfrgjbUj+VxnmOojpKBy
        7Oao/buiHRlg4jda5zCN1j/PGW1FbE9U8llCOKhttKn12EmqxzKjAJVituUqyKxzf4V1LaLoq9wOA
        caBon0dQ==;
Received: from [2001:4bb8:184:af1:3dc3:9c83:fc6c:e0f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFeOq-0000t2-2G; Tue, 08 Sep 2020 14:15:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH] block: restore a specific error code in bdev_del_partition
Date:   Tue,  8 Sep 2020 16:15:06 +0200
Message-Id: <20200908141506.2894221-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

mdadm relies on the fact that deleting an invalid partition returns
-ENXIO or -ENOTTY to detect if a block device is a partition or a
whole device.

Fixes: 08fc1ab6d748 ("block: fix locking in bdev_del_partition")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5b4869c08fb380..722406b841dfc7 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -537,7 +537,7 @@ int bdev_del_partition(struct block_device *bdev, int partno)
 
 	bdevp = bdget_disk(bdev->bd_disk, partno);
 	if (!bdevp)
-		return -ENOMEM;
+		return -ENXIO;
 
 	mutex_lock(&bdevp->bd_mutex);
 	mutex_lock_nested(&bdev->bd_mutex, 1);
-- 
2.28.0

