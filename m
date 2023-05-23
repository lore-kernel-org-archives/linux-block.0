Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5174FC7EE26
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjEWHzh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbjEWHyw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:54:52 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C773810DB
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:54:28 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1684828431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vCnegidkaXx+3j2cMu26zMM6pOUuxp3glwwDx2lCE0w=;
        b=OdhDmdSTYi1pT+F3MdPei5S7CBFuLHYFzJRMsfbFBDe7PFfuWr4SZT4a+tONCZp8ElYOex
        7Kb055IROOi/fNM1Db9KVioppEchRuy7knv3IT0+S5PFxGBLtoxD/lyKqlv1zio5b+gEUB
        NzEWLYDWvgNt4JBjptog7ITh2oUrdLk=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 10/10] block/rnbd: change device's name
Date:   Tue, 23 May 2023 15:53:31 +0800
Message-Id: <20230523075331.32250-11-guoqing.jiang@linux.dev>
In-Reply-To: <20230523075331.32250-1-guoqing.jiang@linux.dev>
References: <20230523075331.32250-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both rnbd-srv and rnbd-clt set it with 'clt', which is not
clear, let's change them to 'clt' and 'srv' accordingly.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index a0b49a0c0bdd..f6e2b075d2d5 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -652,7 +652,7 @@ int rnbd_clt_create_sysfs_files(void)
 
 	rnbd_dev = device_create_with_groups(rnbd_dev_class, NULL,
 					      MKDEV(0, 0), NULL,
-					      default_attr_groups, "ctl");
+					      default_attr_groups, "clt");
 	if (IS_ERR(rnbd_dev)) {
 		err = PTR_ERR(rnbd_dev);
 		goto cls_destroy;
diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 4962826e9639..f17a4085dfbb 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -219,7 +219,7 @@ int rnbd_srv_create_sysfs_files(void)
 		return PTR_ERR(rnbd_dev_class);
 
 	rnbd_dev = device_create(rnbd_dev_class, NULL,
-				  MKDEV(0, 0), NULL, "ctl");
+				  MKDEV(0, 0), NULL, "srv");
 	if (IS_ERR(rnbd_dev)) {
 		err = PTR_ERR(rnbd_dev);
 		goto cls_destroy;
-- 
2.35.3

