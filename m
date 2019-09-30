Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E8FC35280
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1BA2053B
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfI3XBB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:01:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37995 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XBB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:01:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so8217880pgi.5
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:01:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cpnD1+tX5VRBCS1iyxcyXpZHn9kRH7EGBCyKlQavOT0=;
        b=W4O8DQkWGTMckilPuSycEsp5lBPMC6KfeAEQAXiCKS+n8gSYAXTc/2JWC5t9WQEqoO
         iCj2a2qF1DkmBAp4tnfSIr7xxAlTn/PAKToC1CZVLNVd8kVce1IZtL2IFCWKV81gVK19
         xWx8GAo5dSk0bce0QzAPdLWcIpOCy68UZ80hRLyRetgWEWg6v9pJIq6f4NpRjpmvU2g1
         KMJcncKctjzm7Ja0jszJTwAYXuvRcOU5gkSO4HFUMnb0yB5VUya/HMK3ZdETNAet32gX
         ohyoCJFpr4UB7dW0L05bZBHl384r0EeJNPI2jfdzYp8RZHIkBs5Pz8f1W0lcDxZx+ma7
         8tjA==
X-Gm-Message-State: APjAAAXgXHhXKwTxfGIEARB+P83CZqWsGDG3ZyZiieq1jRq+/Rm70Gis
        oxqWLpI7/SvhwzvzmRGOZtI=
X-Google-Smtp-Source: APXvYqyUObdwodPOgTiaOS2wxGb8ISr7TmfEqiJujp1+nqmyZgjf3DPoTAPW7yCc1PfagHDsE3kdrA==
X-Received: by 2002:a62:e918:: with SMTP id j24mr23595850pfh.219.1569884460698;
        Mon, 30 Sep 2019 16:01:00 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:00:59 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 4/8] block: Remove "dying" checks from sysfs callbacks
Date:   Mon, 30 Sep 2019 16:00:43 -0700
Message-Id: <20190930230047.44113-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
References: <20190930230047.44113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Block drivers must call del_gendisk() before blk_cleanup_queue().
del_gendisk() calls kobject_del() and kobject_del() waits until any
ongoing sysfs callback functions have finished. In other words, the
sysfs callback functions won't be called for a queue in the dying
state. Hence remove the "dying" checks from the sysfs callback
functions.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-core.c     |  2 ++
 block/blk-mq-sysfs.c | 16 ++++------------
 block/blk-sysfs.c    |  8 --------
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d5e668ec751b..8b51d9ec8ae3 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -336,6 +336,8 @@ EXPORT_SYMBOL_GPL(blk_set_queue_dying);
  */
 void blk_cleanup_queue(struct request_queue *q)
 {
+	WARN_ON_ONCE(blk_queue_registered(q));
+
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
 	mutex_lock(&q->sysfs_lock);
 	blk_set_queue_dying(q);
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index a0d3ce30fa08..81a273b43329 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -74,10 +74,8 @@ static ssize_t blk_mq_sysfs_show(struct kobject *kobj, struct attribute *attr,
 	if (!entry->show)
 		return -EIO;
 
-	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->show(ctx, page);
+	res = entry->show(ctx, page);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
@@ -97,10 +95,8 @@ static ssize_t blk_mq_sysfs_store(struct kobject *kobj, struct attribute *attr,
 	if (!entry->store)
 		return -EIO;
 
-	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->store(ctx, page, length);
+	res = entry->store(ctx, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
@@ -120,10 +116,8 @@ static ssize_t blk_mq_hw_sysfs_show(struct kobject *kobj,
 	if (!entry->show)
 		return -EIO;
 
-	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->show(hctx, page);
+	res = entry->show(hctx, page);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
@@ -144,10 +138,8 @@ static ssize_t blk_mq_hw_sysfs_store(struct kobject *kobj,
 	if (!entry->store)
 		return -EIO;
 
-	res = -ENOENT;
 	mutex_lock(&q->sysfs_lock);
-	if (!blk_queue_dying(q))
-		res = entry->store(hctx, page, length);
+	res = entry->store(hctx, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
 }
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index b82736c781c5..80df16be9f52 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -802,10 +802,6 @@ queue_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 	if (!entry->show)
 		return -EIO;
 	mutex_lock(&q->sysfs_lock);
-	if (blk_queue_dying(q)) {
-		mutex_unlock(&q->sysfs_lock);
-		return -ENOENT;
-	}
 	res = entry->show(q, page);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
@@ -824,10 +820,6 @@ queue_attr_store(struct kobject *kobj, struct attribute *attr,
 
 	q = container_of(kobj, struct request_queue, kobj);
 	mutex_lock(&q->sysfs_lock);
-	if (blk_queue_dying(q)) {
-		mutex_unlock(&q->sysfs_lock);
-		return -ENOENT;
-	}
 	res = entry->store(q, page, length);
 	mutex_unlock(&q->sysfs_lock);
 	return res;
-- 
2.23.0.444.g18eeb5a265-goog

