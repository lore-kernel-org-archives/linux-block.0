Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E79C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D87861157
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhI0WHS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbhI0WGk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:06:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FDCC05174D;
        Mon, 27 Sep 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O2n+QosG4NcLHWPhI10n1Un4YIYGB4Z9QYZNGyEZSGY=; b=O8rQaILiMrbWbrbg5w/jO20YE+
        Y5IW3ESvDmQ/7zWBtfBFm7SrUMelgJgum5IxyVWUuuFFWBOMOrgpByrcm0Rrp71bjCU3bgmkcg+Jc
        I54xZ9IP/hrGxVcIsoY2cPJsqrdz8suJivclCj7r17qDshiGloC1yxd11UNv0Yg6vmMpkPtiygxEr
        eeiSQpz2KZsNwxab0LRESbShEHs0VeB9rg02z3t0oBbr7KYFDEUCUgCK5j2yR8rwBOX9kvbmgJKMB
        uk4TIqt51ESv+/ZMBCeO11kd6ls1cptVOT9qBCQu/E5c/MMxP17lzm3oDJn86cLJcv36wNIC+syeq
        ruMzZcmw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyiF-004VIZ-Tu; Mon, 27 Sep 2021 22:03:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 10/14] swim: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:02:58 -0700
Message-Id: <20210927220302.1073499-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220302.1073499-1-mcgrof@kernel.org>
References: <20210927220302.1073499-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Since we have a caller to do our unwinding for the disk,
and this is already dealt with safely we can re-use our
existing error path goto label which already deals with
the cleanup.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/swim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index b3ee3dad5a8c..6f02941a3263 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -842,7 +842,9 @@ static int swim_floppy_init(struct swim_priv *swd)
 		swd->unit[drive].disk->events = DISK_EVENT_MEDIA_CHANGE;
 		swd->unit[drive].disk->private_data = &swd->unit[drive];
 		set_capacity(swd->unit[drive].disk, 2880);
-		add_disk(swd->unit[drive].disk);
+		err = add_disk(swd->unit[drive].disk);
+		if (err)
+			goto exit_put_disks;
 		swd->unit[drive].registered = true;
 	}
 
-- 
2.30.2

