Return-Path: <SRS0=Upb7=PP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479BDC43387
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 13:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119D72089F
	for <linux-block@archiver.kernel.org>; Mon,  7 Jan 2019 13:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfAGNL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:11:56 -0500
Received: from mx2.didichuxing.com ([36.110.17.22]:3314 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1727392AbfAGNIB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Jan 2019 08:08:01 -0500
X-ASG-Debug-ID: 1546865546-0e40881182836300001-Cu09wu
Received: from BJEXCAS03.didichuxing.com (bogon [172.20.36.245]) by bsf01.didichuxing.com with ESMTP id gYKRaKP6Z5tHluVa; Mon, 07 Jan 2019 20:52:26 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Mon, 7 Jan
 2019 20:52:26 +0800
Date:   Mon, 7 Jan 2019 20:52:21 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <bvanassche@acm.org>, <hch@infradead.org>,
        <linux-block@vger.kernel.org>
Subject: [PATCH] block: don't show io_timeout if driver has no timeout handler
Message-ID: <20190107125215.GA5039@192.168.3.9>
X-ASG-Orig-Subj: [PATCH] block: don't show io_timeout if driver has no timeout handler
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org, hch@infradead.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS002.didichuxing.com (172.20.1.42) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.245]
X-Barracuda-Start-Time: 1546865546
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2586
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0546 1.0000 -1.6707
X-Barracuda-Spam-Score: -1.67
X-Barracuda-Spam-Status: No, SCORE=-1.67 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.65269
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the low level driver has no timerout handler, the
/sys/block/<disk>/queue/io_timeout will not be displayed.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-sysfs.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0619c8922893..e9ee81c43d36 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -726,7 +726,7 @@ static struct queue_sysfs_entry throtl_sample_time_entry = {
 };
 #endif
 
-static struct attribute *default_attrs[] = {
+static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
@@ -768,6 +768,26 @@ static struct attribute *default_attrs[] = {
 	NULL,
 };
 
+static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
+				int n)
+{
+	struct request_queue *q =
+		container_of(kobj, struct request_queue, kobj);
+
+	if (attr == &queue_io_timeout_entry.attr) {
+		if (!q->mq_ops || !q->mq_ops->timeout)
+			return 0;
+	}
+
+	return attr->mode;
+}
+
+static struct attribute_group queue_attr_group = {
+	.attrs = queue_attrs,
+	.is_visible = queue_attr_visible,
+};
+
+
 #define to_queue(atr) container_of((atr), struct queue_sysfs_entry, attr)
 
 static ssize_t
@@ -893,7 +913,6 @@ static const struct sysfs_ops queue_sysfs_ops = {
 
 struct kobj_type blk_queue_ktype = {
 	.sysfs_ops	= &queue_sysfs_ops,
-	.default_attrs	= default_attrs,
 	.release	= blk_release_queue,
 };
 
@@ -942,6 +961,14 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	ret = sysfs_create_group(&q->kobj, &queue_attr_group);
+	if (ret) {
+		kobject_del(&q->kobj);
+		blk_trace_remove_sysfs(dev);
+		kobject_put(&dev->kobj);
+		goto unlock;
+	}
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
@@ -958,6 +985,7 @@ int blk_register_queue(struct gendisk *disk)
 		if (ret) {
 			mutex_unlock(&q->sysfs_lock);
 			kobject_uevent(&q->kobj, KOBJ_REMOVE);
+			sysfs_remove_group(&q->kobj, &queue_attr_group);
 			kobject_del(&q->kobj);
 			blk_trace_remove_sysfs(dev);
 			kobject_put(&dev->kobj);
@@ -1006,6 +1034,7 @@ void blk_unregister_queue(struct gendisk *disk)
 		blk_mq_unregister_dev(disk_to_dev(disk), q);
 	mutex_unlock(&q->sysfs_lock);
 
+	sysfs_remove_group(&q->kobj, &queue_attr_group);
 	kobject_uevent(&q->kobj, KOBJ_REMOVE);
 	kobject_del(&q->kobj);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
-- 
2.14.1

