Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D9C4338F
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CB261373
	for <linux-block@archiver.kernel.org>; Wed, 25 Aug 2021 07:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238926AbhHYH43 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Aug 2021 03:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhHYH4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Aug 2021 03:56:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AAAC061757
        for <linux-block@vger.kernel.org>; Wed, 25 Aug 2021 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=7XnRAgfKIy4n0doFy6p9ODUr6k0MkH2e7LiDEHLA+48=; b=q8XW/1/un4jrHL8CNqpYaKJiL9
        KZf43N0n2/KlXTQN9Q+2piAcb9VpF6MkRmnY5RIWLGsOdtGYdQiNvtt9c4/9vVBvEtT4aZnTvsAyN
        uxzjqJPbkVPW7xl67AttI4/GElNsEISNY1hLYyE1wn4+kJZaY+ACwfTXLFhDNL8ODEM/KnEVVrey/
        DL3uk6OahVqMKjuHfV8xiMxmob/aQ/bGw+Z4I8Us8yA/lVvrd0ONq4G68F3goy1VdUqNC1Wp+OV9F
        KSyfTksws7YCCnbsDM5lIZwZOXu3IC7yk3wOE/sPKiQGAUxSoqXBbdWiDUPMdhAH620eInneIStI3
        rFTujmgA==;
Received: from [2001:4bb8:193:fd10:ce54:74a1:df3f:e6a9] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mInk8-00C2sB-Sz; Wed, 25 Aug 2021 07:54:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        syzbot+f74aa89114a236643919@syzkaller.appspotmail.com
Subject: [PATCH] sg: pass the device name to blk_trace_setup
Date:   Wed, 25 Aug 2021 09:54:38 +0200
Message-Id: <20210825075438.1883687-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix a regression that passd a NULL device name to blk_trace_setup
accidentally.

Fixes: aebbb5831fbd ("sg: do not allocate a gendisk")
Reported-by: syzbot+f74aa89114a236643919@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 477267add49d..d5889b4f0fd4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1118,7 +1118,7 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		return put_user(max_sectors_bytes(sdp->device->request_queue),
 				ip);
 	case BLKTRACESETUP:
-		return blk_trace_setup(sdp->device->request_queue, NULL,
+		return blk_trace_setup(sdp->device->request_queue, sdp->name,
 				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
 				       NULL, p);
 	case BLKTRACESTART:
-- 
2.30.2

