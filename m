Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC62C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D8460F11
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhHRGej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238625AbhHRGei (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:34:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4095C061764
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=88fJaZvLS/1d1+mjgEcPaBtWRsEg53YKArLaR1qDjxg=; b=nZOQGYkxul7Mf7UNFdzMZG/AJn
        ph/duouV/GG0QGpLPSkRnG+rEkR807Fjbd67JS6dLixG8C8pbFTs0p9xn9E3XXwQw4dEaLOZGfXGz
        0q+kqIe+9iOX57r2w1oWl8QMU3/8NHwmH7veAl6UmLj1MIwcuYMxe3EC0KtVQPEIJjXcTZ+kA3Qd+
        eQMPW0jqYuNRo1kvQ1v8UYBVDut73fwq2FF00eyBLhexi+Syj5R1xLj6v3RJowhGZ6fD+Zv/5kcz7
        W0/Rp1wIXnfn+c/zz5pN2LdWMM4IU9S99YqMWoOdGGRkcy1rDmXItJ65QK+DvdDyjiKJHvA1NZC+K
        tCgkxkQw==;
Received: from 213-225-12-39.nat.highway.a1.net ([213.225.12.39] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGF7p-003RZb-RW; Wed, 18 Aug 2021 06:32:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 5/7] loop: remove the unused idx argument to loop_control_get_free
Date:   Wed, 18 Aug 2021 08:24:53 +0200
Message-Id: <20210818062455.211065-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818062455.211065-1-hch@lst.de>
References: <20210818062455.211065-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9176784d4fca..e93baff664c9 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2486,7 +2486,7 @@ static int loop_control_remove(int idx)
 	return ret;
 }
 
-static int loop_control_get_free(int idx)
+static int loop_control_get_free(void)
 {
 	struct loop_device *lo;
 	int id, ret;
@@ -2514,7 +2514,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 	case LOOP_CTL_REMOVE:
 		return loop_control_remove(parm);
 	case LOOP_CTL_GET_FREE:
-		return loop_control_get_free(parm);
+		return loop_control_get_free();
 	default:
 		return -ENOSYS;
 	}
-- 
2.30.2

