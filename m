Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C059AC43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890F22086B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:05:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890F22086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeK2DHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:07:20 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:25167 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1728181AbeK2DHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:07:20 -0500
X-ASG-Debug-ID: 1543421085-0e40881e31c2f40001-Cu09wu
Received: from BJEXCAS006.didichuxing.com (bjexcas006.didichuxing.com [172.20.2.189]) by bsf01.didichuxing.com with ESMTP id P9wMAcZYHAPAh69C; Thu, 29 Nov 2018 00:04:45 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Thu, 29 Nov
 2018 00:04:45 +0800
Date:   Thu, 29 Nov 2018 00:04:39 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v3] block: add io timeout to sysfs
Message-ID: <20181128160433.GA35371@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v3] block: add io timeout to sysfs
Mail-Followup-To: axboe@kernel.dk, linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS002.didichuxing.com (172.20.1.42) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexcas006.didichuxing.com[172.20.2.189]
X-Barracuda-Start-Time: 1543421085
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1867
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0147 1.0000 -1.9251
X-Barracuda-Spam-Score: -1.43
X-Barracuda-Spam-Status: No, SCORE=-1.43 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.62616
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Give a interface to adjust io timeout(ms) by device.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---

Changes since v2:
* use msecs_to_jiffies and jiffies_to_msecs

Changes since v1:
* make sure timeout > 0

 block/blk-sysfs.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 80eef48fddc8..9f0cb370b39b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -417,6 +417,26 @@ static ssize_t queue_poll_store(struct request_queue *q, const char *page,
 	return ret;
 }
 
+static ssize_t queue_io_timeout_show(struct request_queue *q, char *page)
+{
+	return sprintf(page, "%u\n", jiffies_to_msecs(q->rq_timeout));
+}
+
+static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
+				  size_t count)
+{
+	unsigned int val;
+	int err;
+
+	err = kstrtou32(page, 10, &val);
+	if (err || val == 0)
+		return -EINVAL;
+
+	blk_queue_rq_timeout(q, msecs_to_jiffies(val));
+
+	return count;
+}
+
 static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
 {
 	if (!wbt_rq_qos(q))
@@ -685,6 +705,12 @@ static struct queue_sysfs_entry queue_dax_entry = {
 	.show = queue_dax_show,
 };
 
+static struct queue_sysfs_entry queue_io_timeout_entry = {
+	.attr = {.name = "io_timeout", .mode = 0644 },
+	.show = queue_io_timeout_show,
+	.store = queue_io_timeout_store,
+};
+
 static struct queue_sysfs_entry queue_wb_lat_entry = {
 	.attr = {.name = "wbt_lat_usec", .mode = 0644 },
 	.show = queue_wb_lat_show,
@@ -734,6 +760,7 @@ static struct attribute *default_attrs[] = {
 	&queue_dax_entry.attr,
 	&queue_wb_lat_entry.attr,
 	&queue_poll_delay_entry.attr,
+	&queue_io_timeout_entry.attr,
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&throtl_sample_time_entry.attr,
 #endif
-- 
2.14.1

