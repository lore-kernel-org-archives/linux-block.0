Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C16C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A653361108
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 10:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhFUKeC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFUKeC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 06:34:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E530FC061574
        for <linux-block@vger.kernel.org>; Mon, 21 Jun 2021 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gmw8EF9WxTiSU6waFXCb72REy/9/eBVGjz7nBq2+Bpw=; b=mT5bSDzXKhheOgAC3BZgVFOxFp
        KrjIUzS2Jcu3RMrvFG2ApI/F02m+bB9wmlObXsqQrTJE6aPkCzooQ4rv0uQAtEDqO4aB1J4pDbAam
        c64lseuaYlEnT4wpfWW5lkglFylXk8ntm/y/oWZy4oeATwJ5H5XQyDWRO6/7sXEyuydq53Zb7jjIn
        jmi4K2dHYMymp1Tsc4otBO2GNSAkDIlDD+lzd679oxBMaj/hVcnBwvXvPICrO27/IU1eWHwjuHHs6
        y2u7evQnz//1Mx+LbCH18lgITaYKP0aqZsp0yqEBZENlu8q5RbbOAmi0kABS1ppkysaaFFWJr7Tbj
        JocjwKBg==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvHDB-00CzLC-0A; Mon, 21 Jun 2021 10:31:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org
Subject: [PATCH 5/9] loop: split loop_control_ioctl
Date:   Mon, 21 Jun 2021 12:15:43 +0200
Message-Id: <20210621101547.3764003-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621101547.3764003-1-hch@lst.de>
References: <20210621101547.3764003-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split loop_control_ioctl into a helper for each command.  This keeps the
code nicely separated for the upcoming locking changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 93 ++++++++++++++++++++++++++++----------------
 1 file changed, 60 insertions(+), 33 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index b1e7e420563b..d55526c355e1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2228,8 +2228,51 @@ static void loop_probe(dev_t dev)
 	mutex_unlock(&loop_ctl_mutex);
 }
 
-static long loop_control_ioctl(struct file *file, unsigned int cmd,
-			       unsigned long parm)
+static int loop_control_add(int idx)
+{
+	int ret;
+		
+	ret = mutex_lock_killable(&loop_ctl_mutex);
+	if (ret)
+		return ret;
+	ret = loop_add(idx);
+	mutex_unlock(&loop_ctl_mutex);
+	return ret;
+}
+
+static int loop_control_remove(int idx)
+{
+	struct loop_device *lo;
+	int ret;
+		
+	ret = mutex_lock_killable(&loop_ctl_mutex);
+	if (ret)
+		return ret;
+
+	ret = loop_lookup(&lo, idx);
+	if (ret < 0)
+		goto out_unlock_ctrl;
+
+	ret = mutex_lock_killable(&lo->lo_mutex);
+	if (ret)
+		goto out_unlock_ctrl;
+	if (lo->lo_state != Lo_unbound ||
+	    atomic_read(&lo->lo_refcnt) > 0) {
+		mutex_unlock(&lo->lo_mutex);
+		ret = -EBUSY;
+		goto out_unlock_ctrl;
+	}
+	lo->lo_state = Lo_deleting;
+	mutex_unlock(&lo->lo_mutex);
+
+	idr_remove(&loop_index_idr, lo->lo_number);
+	loop_remove(lo);
+out_unlock_ctrl:
+	mutex_unlock(&loop_ctl_mutex);
+	return ret;
+}
+
+static int loop_control_get_free(int idx)
 {
 	struct loop_device *lo;
 	int ret;
@@ -2237,43 +2280,27 @@ static long loop_control_ioctl(struct file *file, unsigned int cmd,
 	ret = mutex_lock_killable(&loop_ctl_mutex);
 	if (ret)
 		return ret;
+	ret = loop_lookup(&lo, -1);
+	if (ret < 0)
+		ret = loop_add(-1);
+	mutex_unlock(&loop_ctl_mutex);
+
+	return ret;
+}
 
-	ret = -ENOSYS;
+static long loop_control_ioctl(struct file *file, unsigned int cmd,
+			       unsigned long parm)
+{
 	switch (cmd) {
 	case LOOP_CTL_ADD:
-		ret = loop_add(parm);
-		break;
+		return loop_control_add(parm);
 	case LOOP_CTL_REMOVE:
-		ret = loop_lookup(&lo, parm);
-		if (ret < 0)
-			break;
-		ret = mutex_lock_killable(&lo->lo_mutex);
-		if (ret)
-			break;
-		if (lo->lo_state != Lo_unbound) {
-			ret = -EBUSY;
-			mutex_unlock(&lo->lo_mutex);
-			break;
-		}
-		if (atomic_read(&lo->lo_refcnt) > 0) {
-			ret = -EBUSY;
-			mutex_unlock(&lo->lo_mutex);
-			break;
-		}
-		lo->lo_state = Lo_deleting;
-		mutex_unlock(&lo->lo_mutex);
-		idr_remove(&loop_index_idr, lo->lo_number);
-		loop_remove(lo);
-		break;
+		return loop_control_remove(parm);
 	case LOOP_CTL_GET_FREE:
-		ret = loop_lookup(&lo, -1);
-		if (ret >= 0)
-			break;
-		ret = loop_add(-1);
+		return loop_control_get_free(parm);
+	default:
+		return -ENOSYS;
 	}
-	mutex_unlock(&loop_ctl_mutex);
-
-	return ret;
 }
 
 static const struct file_operations loop_ctl_fops = {
-- 
2.30.2

