Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD51C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 13:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2321473
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 13:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbfDBNOo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:14:44 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:7600 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1729732AbfDBNOn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 09:14:43 -0400
X-ASG-Debug-ID: 1554210876-0e40881d96e0580001-Cu09wu
Received: from BJEXMBX011.didichuxing.com (bjexmbx011.didichuxing.com [172.20.2.190]) by bsf01.didichuxing.com with ESMTP id QAie32dpQaxXBkuX; Tue, 02 Apr 2019 21:14:36 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Tue, 2 Apr
 2019 21:14:36 +0800
Date:   Tue, 2 Apr 2019 21:14:30 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>, <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v2] block: don't show io_timeout if driver has no timeout
 handler
Message-ID: <20190402131424.GA12935@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v2] block: don't show io_timeout if driver has no timeout
 handler
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org, hch@infradead.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS004.didichuxing.com (172.20.1.44) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexmbx011.didichuxing.com[172.20.2.190]
X-Barracuda-Start-Time: 1554210876
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2247
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0001 1.0000 -2.0204
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.69320
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the low level driver has no timeout handler, the
/sys/block/<disk>/queue/io_timeout will not be displayed.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
Changes since v1:
 * don't call sysfs_remove_group explicitly
 * also check q->mq_ops otherwise bug at md driver
[    2.094516]  internal_create_group+0xd8/0x3a0
[    2.095238]  blk_register_queue+0xb8/0x1e0
[    2.095912]  __device_add_disk+0x2b5/0x4a0
[    2.096573]  md_alloc+0x1ab/0x330

 block/blk-sysfs.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 422327089e0f..a16a02c52a85 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -728,7 +728,7 @@ static struct queue_sysfs_entry throtl_sample_time_entry = {
 };
 #endif
 
-static struct attribute *default_attrs[] = {
+static struct attribute *queue_attrs[] = {
 	&queue_requests_entry.attr,
 	&queue_ra_entry.attr,
 	&queue_max_hw_sectors_entry.attr,
@@ -770,6 +770,25 @@ static struct attribute *default_attrs[] = {
 	NULL,
 };
 
+static umode_t queue_attr_visible(struct kobject *kobj, struct attribute *attr,
+				int n)
+{
+	struct request_queue *q =
+		container_of(kobj, struct request_queue, kobj);
+
+	if (attr == &queue_io_timeout_entry.attr &&
+		(!q->mq_ops || !q->mq_ops->timeout))
+			return 0;
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
@@ -890,7 +909,6 @@ static const struct sysfs_ops queue_sysfs_ops = {
 
 struct kobj_type blk_queue_ktype = {
 	.sysfs_ops	= &queue_sysfs_ops,
-	.default_attrs	= default_attrs,
 	.release	= blk_release_queue,
 };
 
@@ -939,6 +957,14 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	ret = sysfs_create_group(&q->kobj, &queue_attr_group);
+	if (ret) {
+		blk_trace_remove_sysfs(dev);
+		kobject_del(&q->kobj);
+		kobject_put(&dev->kobj);
+		goto unlock;
+	}
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
-- 
2.14.1

