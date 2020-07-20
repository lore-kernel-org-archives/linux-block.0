Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75249C433E5
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 07:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A39821775
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 07:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XAXygMpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgGTHwJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGTHwE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 03:52:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A163C0619D2;
        Mon, 20 Jul 2020 00:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=DP8fGyU8x8aj+q3+p8UbqlahCkFpP7eR5QGK+Cdd8Uc=; b=XAXygMpK+JQ52rLAvNJKGgcswf
        pyvv2uabK80nhnlZYqh/947WwKF8CKwMEqSZr3eIR6omGV1LyoChcCeOZqOS5bFSI80bQva3toPPD
        ZnwA4mxzKEMGUFl1XLSVFfBjKjT8oswm80ZW9rNAYn/O6AgNltNOeckp9GsYioz5rn13xyNHbRELp
        /My/sEmvFG4u/IuMHK/90sAF1/LRYYkUqja2xnuBTd1VEjngeaqIJUqapKiYhyNXqU4TBPTMpUKw2
        KGejWTaqN6yw89SlDZgBLLUWJftuHOr4Wc6XfcFA2IagkC1SmDPv+hB0JDnWy9GIWJZDmMKEszWqm
        gDFbb/8A==;
Received: from [2001:4bb8:105:4a81:5185:88fc:94bb:f8bf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxQaW-0003zp-Vt; Mon, 20 Jul 2020 07:51:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH 02/14] drbd: remove dead code in device_to_statistics
Date:   Mon, 20 Jul 2020 09:51:36 +0200
Message-Id: <20200720075148.172156-3-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720075148.172156-1-hch@lst.de>
References: <20200720075148.172156-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ever since the switch to blk-mq, a lower device not use by VM
writeback will not be marked congested, so the check will never
trigger.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_nl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index d0d9a549b58388..650372ee2c7822 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -3370,7 +3370,6 @@ static void device_to_statistics(struct device_statistics *s,
 	if (get_ldev(device)) {
 		struct drbd_md *md = &device->ldev->md;
 		u64 *history_uuids = (u64 *)s->history_uuids;
-		struct request_queue *q;
 		int n;
 
 		spin_lock_irq(&md->uuid_lock);
@@ -3384,11 +3383,6 @@ static void device_to_statistics(struct device_statistics *s,
 		spin_unlock_irq(&md->uuid_lock);
 
 		s->dev_disk_flags = md->flags;
-		q = bdev_get_queue(device->ldev->backing_bdev);
-		s->dev_lower_blocked =
-			bdi_congested(q->backing_dev_info,
-				      (1 << WB_async_congested) |
-				      (1 << WB_sync_congested));
 		put_ldev(device);
 	}
 	s->dev_size = drbd_get_capacity(device->this_bdev);
-- 
2.27.0

