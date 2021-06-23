Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3776C48BC2
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8F156113B
	for <linux-block@archiver.kernel.org>; Wed, 23 Jun 2021 15:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFWPEw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhFWPEv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jun 2021 11:04:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA35C061574
        for <linux-block@vger.kernel.org>; Wed, 23 Jun 2021 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gFVft+5X3dh0iXZ86Dq4ihNbVemSouJ+kgmT8VfIASI=; b=WT9ate+ectny58wjaOYNFd0CRQ
        z5dlE6wHuqsWzujXDdqjN59q+OzBobRumjOBJUOEKZX0m5Mm+PQIx1LtZ9TMcv+szWBcrjqIR3HEP
        y/k+ZiwWQaPjFU6tFNZyajhL+Li6Fsc3qV7NBVk3bEWToFvyuYTS2HC8tssuO4yqcTFF5Iz66+Xqo
        lQuDmWC/l6VceSOfHNuVS9LKHoBPDe6eKNF+R0KLYAHrtXlDIyzgRyVfXbKcfYmE/oImA64NfDIYw
        xkBF4tVOSUpbo5v2i8OQTpkhCGdxByBJ8efNda2C751SD2PYUIE3+FHo/tvoWYMOutvgvWH9iqNXy
        RKgqEuig==;
Received: from [2001:4bb8:188:3e21:6594:49:139:2b3f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lw4O7-00FXz2-8O; Wed, 23 Jun 2021 15:02:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 5/9] loop: split loop_control_ioctl
Date:   Wed, 23 Jun 2021 16:59:04 +0200
Message-Id: <20210623145908.92973-6-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210623145908.92973-1-hch@lst.de>
References: <20210623145908.92973-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Split loop_control_ioctl into a helper for each command.  This keeps the
code nicely separated for the upcoming locking changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
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

