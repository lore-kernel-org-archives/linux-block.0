Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77698C48BC2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57AC361153
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhFUKjP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFUKjM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:39:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C090C061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=aTNox3wMNhcRFzTHNUdRK30EdNvBg0L71qC11MFoIrA=; b=muT63QPOR0UAOjQNA3X4+kAUSD
        h2UIsx99QD/FSNIdBJajzxn4jg8PsKwJv2W0Q+XISC2dwWJOpowPiPoaTStNRziENuuIDHFxCyz0C
        m81+cOQ/kwDwnsWf+rRisAXP0elFmT5iNxx1oAdtS7aZfcbhsQ2vvOrrUb+b+5btmj2GS1sLBIUVg
        AlUAsst82R3Sei7z7FiMF9iJ4+WyDe7SODacpDd+QQF6FtHyt6HdTG8JzrzxPpBdO/RuHG+uinSEb
        je8zVHaeWIzz3A0fDkiCbmfQePA6UHmtqMjqYBfrp1tXHmB+TEYqblDEQRuooBDtj2eLvfxub41rV
        7v+FTYqQ==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvHHn-00CzWB-Nh; Mon, 21 Jun 2021 10:36:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 7/9] loop: don't allow deleting an unspecified loop device
Date:   Mon, 21 Jun 2021 12:15:45 +0200
Message-Id: <20210621101547.3764003-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Passing a negative index to loop_lookup while return any unbound device.
Doing that for a delete does not make much sense, so add check to
explicitly reject that case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 3f1e934a7f9e..54e2551e339c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2235,6 +2235,11 @@ static int loop_control_remove(int idx)
 {
 	struct loop_device *lo;
 	int ret;
+
+	if (idx < 0) {
+		pr_warn("deleting an unspecified loop device is not supported.\n");
+		return -EINVAL;
+	}
 		
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
-- 
2.30.2

