Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404DDC43217
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A35B61051
	for <linux-block@archiver.kernel.org>; Sat,  4 Sep 2021 01:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350889AbhIDBgm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Sep 2021 21:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350748AbhIDBgk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Sep 2021 21:36:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAF4C061764;
        Fri,  3 Sep 2021 18:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=O2n+QosG4NcLHWPhI10n1Un4YIYGB4Z9QYZNGyEZSGY=; b=XqypK0CA4Y2QR/riIq7uOdLY4y
        n7yt8kmOIGRTm+eIZc0M+d++64cF8ik/TX9fdemL5Ieoe/2WJThuN/LBebK1yvIc+7pHepzSPYI7O
        s6XcXQT/3jV11GTOOGCtVYuoLQiwPGnjuLDDJQFaVW7VKqijpQA5plPwDElkXyo3YiJBbdw6FndhK
        mxYnvF8jFCrsEQi38jVDdQVrXqVd35cioEZFr8TRgl04kNwPZOz1Q73o+Zdw9hmeOKcjTV96DjZQa
        tIUKAKb8VUvXFOUAVSNMIUlUE+KsKMkracW4B4znBaCvZpiTiOHT9hOKyHLT1QPyT1QOYLHyCcV/x
        ZPX9MCKw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMKan-00DLbL-ME; Sat, 04 Sep 2021 01:35:37 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, efremov@linux.com, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 10/14] swim: add error handling support for add_disk()
Date:   Fri,  3 Sep 2021 18:35:32 -0700
Message-Id: <20210904013536.3181237-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210904013536.3181237-1-mcgrof@kernel.org>
References: <20210904013536.3181237-1-mcgrof@kernel.org>
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

