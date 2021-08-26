Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD01C432BE
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE3060E73
	for <linux-block@archiver.kernel.org>; Thu, 26 Aug 2021 13:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242714AbhHZNnf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242681AbhHZNne (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Aug 2021 09:43:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB819C0613C1
        for <linux-block@vger.kernel.org>; Thu, 26 Aug 2021 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=l/vvH8ep7Cg6Uc2JSBAfZPqD1n4+BOKWz+reen01+Eg=; b=JnQf/kzv3xyllmaZta0TePoE8R
        qPWY+ghwODEypcUmCeml9iexAbOTOOsQVHzR6ORSm6rnZR6yvGGs3O4h/pVo6F5RSmziCRm3YMi1/
        b3bpu5Hm5J8FclhoeDp4NoesRYk5XoPNBI33iqWvv+w6AGEVjvLMOCYwBmQZy85oAQ1uUVADzQL9V
        DHNjTW+hx0OquYZuTLKoMTW3qRGThYI0G/vts5trZVvU6hVjV73UXh2MJ6s5IqVCFEac9aX1q45BZ
        QS2MYtIriPAVGb7krmajtObx9mrp5aj+cS5V66sF6/Zh49JZYT8KmSb9hbSU5B9mZZQesjk97/WiH
        ZhBZxt4g==;
Received: from [2001:4bb8:193:fd10:d9d9:6c15:481b:99c4] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJFcl-00DLFR-GM; Thu, 26 Aug 2021 13:41:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Hillf Danton <hdanton@sina.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Reviewed-by : Tyler Hicks" <tyhicks@linux.microsoft.com>,
        linux-block@vger.kernel.org
Subject: [PATCH 2/8] loop: remove the unused idx argument to loop_control_get_free
Date:   Thu, 26 Aug 2021 15:38:04 +0200
Message-Id: <20210826133810.3700-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826133810.3700-1-hch@lst.de>
References: <20210826133810.3700-1-hch@lst.de>
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
index fa1c298a8cfb..35d8b30d1f25 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2466,7 +2466,7 @@ static int loop_control_remove(int idx)
 	return ret;
 }
 
-static int loop_control_get_free(int idx)
+static int loop_control_get_free(void)
 {
 	struct loop_device *lo;
 	int id, ret;
@@ -2494,7 +2494,7 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
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

