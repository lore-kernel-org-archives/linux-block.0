Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF67C433EF
	for <linux-block@archiver.kernel.org>; Tue, 29 Mar 2022 15:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbiC2P4l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Mar 2022 11:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237925AbiC2P4k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Mar 2022 11:56:40 -0400
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 08:54:55 PDT
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn [163.53.93.243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE1333E02
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648568368;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=ExbH/1Mg/33VE9cb4EWJfjCuel9VvkxSQ11tAA2xglk=;
        b=SS7NJW4J/1LoolGPHZD8gVs9fYwb3V9DvtG+yji+QAAasFK3rjFNSULDzu0BlEB5
        jHjng6uB6Y8jBH1VvEoiOB43f7o2Br2W1tN7arUFmHs8XGjlfzIiDrgKycIBLMTg6iR
        TO+LNhmLzFj8HFdnE75pBLYolVPr791K3gHTiwpg=
Received: from localhost.localdomain (81.71.33.115 [81.71.33.115]) by mx.zoho.com.cn
        with SMTPS id 1648568365388769.7425638737615; Tue, 29 Mar 2022 23:39:25 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20220329153923.306795-1-cgxu519@mykernel.net>
Subject: [PATCH] block: fix misleading comment for major number of block device
Date:   Tue, 29 Mar 2022 23:39:23 +0800
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Actually the maximum dynamic major number of block device will
be BLKDEV_MAJOR_HASH_SIZE-1, so just fix the function comment
correctly.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index c9a4fc90d3e9..0965f10813da 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -231,7 +231,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
  *    then the function returns zero on success, or a negative error code
  *  - if any unused major number was requested with @major =3D 0 parameter
  *    then the return value is the allocated major number in range
- *    [1..BLKDEV_MAJOR_MAX-1] or a negative error code otherwise
+ *    [1..BLKDEV_MAJOR_HASH_SIZE-1] or a negative error code otherwise
  *
  * See Documentation/admin-guide/devices.txt for the list of allocated
  * major numbers.
--=20
2.27.0


