Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ud10.udmedia.de ([194.117.254.50]:44994 "EHLO
        mail.ud10.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938987AbdD2Fov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Apr 2017 01:44:51 -0400
Date: Sat, 29 Apr 2017 07:38:08 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
To: linux-block@vger.kernel.org
Subject: [PATCH cosmetic] Remove trailing newline in elevator switch error
 message
Message-ID: <20170429053808.GA293@x4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Trying to switch to a non-existing elevator currently results in garbled
dmesg output, e.g.:

 # echo "foo" > /sys/block/sda/queue/scheduler 

elevator: type foo not found
elevator: switch to foo
 failed

(note the unintended line break.)

Fix by stripping the trailing newline.

diff --git a/block/elevator.c b/block/elevator.c
index bf11e70f008b..4f13fcd3c626 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1112,6 +1112,7 @@ static inline bool elv_support_iosched(struct request_queue *q)
 ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 			  size_t count)
 {
+	char elevator_name[ELV_NAME_MAX];
 	int ret;
 
 	if (!(q->mq_ops || q->request_fn) || !elv_support_iosched(q))
@@ -1121,7 +1122,9 @@ ssize_t elv_iosched_store(struct request_queue *q, const char *name,
 	if (!ret)
 		return count;
 
-	printk(KERN_ERR "elevator: switch to %s failed\n", name);
+	strlcpy(elevator_name, name, sizeof(elevator_name));
+	strstrip(elevator_name);
+	printk(KERN_ERR "elevator: switch to %s failed\n", elevator_name);
 	return ret;
 }
 
-- 
Markus
