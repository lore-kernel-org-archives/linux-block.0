Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66CEC35280
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C268A2081B
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbfI3XBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:01:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41273 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:01:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id t10so4481193plr.8
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWtYqS7f+YXot9sryt5o/uWT1RslvHBfHCBGifGO1eM=;
        b=ZBM5KJmX2h/LkSzWlB3uXZZ1DAoei9qysI4fPyp9LklRHeStD3+6YmwpklAXBfO8IS
         zl7mo46orDOBmyV0j4nm9D5S4wi70SQXZeOqLpFrWeT36rxNK3op0ayagbEwLvY83Xfm
         Wbys9E6AxkMAOs4L4TnL5styaay/+Db8imfP0b6D0He7ax0lU4p7E8+oX0v8GN+2oIIt
         f6XQKssylnmhGXM2ct3cta7VN+embvG3TPIydb4kzynbS+IrS/y68lSxN+qPpN0VKz8h
         IssECmEg7tgnQxAEjkULSatwjXjmrkJB2YWryUJOd3ix+AlW/OPVsvUT4kyO2WYL1KC3
         DK+A==
X-Gm-Message-State: APjAAAX5T0BSqBY4E/SNEbW9qLzPVtFdhx7CbpUUEjMHu+dHlm+amZrW
        Nj2b9Db/V2CQdNV21rDyvpyjSWW4
X-Google-Smtp-Source: APXvYqyqNnRU+mG/wjgtZIucT90sSJRoTznTaPp0ZVumYr4n//u32tzNO/F4e/2q/LW+jujhAx32xQ==
X-Received: by 2002:a17:902:904b:: with SMTP id w11mr22655407plz.182.1569884466069;
        Mon, 30 Sep 2019 16:01:06 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:01:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 8/8] null_blk: Enable modifying 'submit_queues' after an instance has been configured
Date:   Mon, 30 Sep 2019 16:00:47 -0700
Message-Id: <20190930230047.44113-9-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
References: <20190930230047.44113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch makes it possible to test blk_mq_update_nr_hw_queues() from
inside a VM.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 75 +++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index f5747cfd806f..f5e0dffb4624 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -227,7 +227,7 @@ static ssize_t nullb_device_uint_attr_store(unsigned int *val,
 	int result;
 
 	result = kstrtouint(page, 0, &tmp);
-	if (result)
+	if (result < 0)
 		return result;
 
 	*val = tmp;
@@ -241,7 +241,7 @@ static ssize_t nullb_device_ulong_attr_store(unsigned long *val,
 	unsigned long tmp;
 
 	result = kstrtoul(page, 0, &tmp);
-	if (result)
+	if (result < 0)
 		return result;
 
 	*val = tmp;
@@ -255,7 +255,7 @@ static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
 	int result;
 
 	result = kstrtobool(page,  &tmp);
-	if (result)
+	if (result < 0)
 		return result;
 
 	*val = tmp;
@@ -263,7 +263,7 @@ static ssize_t nullb_device_bool_attr_store(bool *val, const char *page,
 }
 
 /* The following macro should only be used with TYPE = {uint, ulong, bool}. */
-#define NULLB_DEVICE_ATTR(NAME, TYPE)						\
+#define NULLB_DEVICE_ATTR(NAME, TYPE, APPLY)					\
 static ssize_t									\
 nullb_device_##NAME##_show(struct config_item *item, char *page)		\
 {										\
@@ -274,32 +274,57 @@ static ssize_t									\
 nullb_device_##NAME##_store(struct config_item *item, const char *page,		\
 			    size_t count)					\
 {										\
+	int (*apply_fn)(struct nullb_device *dev, TYPE new_value) = APPLY;	\
 	struct nullb_device *dev = to_nullb_device(item);			\
+	TYPE new_value;								\
+	int ret;								\
 										\
-	if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))			\
-		return -EBUSY;							\
-	return nullb_device_##TYPE##_attr_store(&dev->NAME, page, count);	\
+	ret = nullb_device_##TYPE##_attr_store(&new_value, page, count);	\
+	if (ret < 0)								\
+		return ret;							\
+	if (apply_fn)								\
+		ret = apply_fn(dev, new_value);					\
+	else if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags)) 		\
+		ret = -EBUSY;							\
+	if (ret < 0)								\
+		return ret;							\
+	dev->NAME = new_value;							\
+	return count;								\
 }										\
 CONFIGFS_ATTR(nullb_device_, NAME);
 
-NULLB_DEVICE_ATTR(size, ulong);
-NULLB_DEVICE_ATTR(completion_nsec, ulong);
-NULLB_DEVICE_ATTR(submit_queues, uint);
-NULLB_DEVICE_ATTR(home_node, uint);
-NULLB_DEVICE_ATTR(queue_mode, uint);
-NULLB_DEVICE_ATTR(blocksize, uint);
-NULLB_DEVICE_ATTR(irqmode, uint);
-NULLB_DEVICE_ATTR(hw_queue_depth, uint);
-NULLB_DEVICE_ATTR(index, uint);
-NULLB_DEVICE_ATTR(blocking, bool);
-NULLB_DEVICE_ATTR(use_per_node_hctx, bool);
-NULLB_DEVICE_ATTR(memory_backed, bool);
-NULLB_DEVICE_ATTR(discard, bool);
-NULLB_DEVICE_ATTR(mbps, uint);
-NULLB_DEVICE_ATTR(cache_size, ulong);
-NULLB_DEVICE_ATTR(zoned, bool);
-NULLB_DEVICE_ATTR(zone_size, ulong);
-NULLB_DEVICE_ATTR(zone_nr_conv, uint);
+static int nullb_apply_submit_queues(struct nullb_device *dev,
+				     unsigned int submit_queues)
+{
+	struct nullb *nullb = dev->nullb;
+	struct blk_mq_tag_set *set;
+
+	if (!nullb)
+		return 0;
+
+	set = nullb->tag_set;
+	blk_mq_update_nr_hw_queues(set, submit_queues);
+	return set->nr_hw_queues == submit_queues ? 0 : -ENOMEM;
+}
+
+NULLB_DEVICE_ATTR(size, ulong, NULL);
+NULLB_DEVICE_ATTR(completion_nsec, ulong, NULL);
+NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
+NULLB_DEVICE_ATTR(home_node, uint, NULL);
+NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
+NULLB_DEVICE_ATTR(blocksize, uint, NULL);
+NULLB_DEVICE_ATTR(irqmode, uint, NULL);
+NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
+NULLB_DEVICE_ATTR(index, uint, NULL);
+NULLB_DEVICE_ATTR(blocking, bool, NULL);
+NULLB_DEVICE_ATTR(use_per_node_hctx, bool, NULL);
+NULLB_DEVICE_ATTR(memory_backed, bool, NULL);
+NULLB_DEVICE_ATTR(discard, bool, NULL);
+NULLB_DEVICE_ATTR(mbps, uint, NULL);
+NULLB_DEVICE_ATTR(cache_size, ulong, NULL);
+NULLB_DEVICE_ATTR(zoned, bool, NULL);
+NULLB_DEVICE_ATTR(zone_size, ulong, NULL);
+NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
-- 
2.23.0.444.g18eeb5a265-goog

