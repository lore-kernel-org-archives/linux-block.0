Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EEC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CC3820866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nqXpl8I7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfEAE3J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:29:09 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:63878 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEAE3J (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556685018; x=1588221018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AxvnrnMWZt3+7co/CejLHvVbYV6HhCtci4Bs7qccdNw=;
  b=nqXpl8I7pONX/xNdosP4gRuWwBhimWiG3jIoLpxS10jCaewXkw9J2Efv
   TzASbn7CCR7aPCVHTfybsLmwK+YMyw9FsTjZXg42z99cnw2m6USNJCLWq
   WjJqFkVjn4kGWEGemToK6BB4TtkCuMLJXX0YEN0MGipy93O35jQ4BqXvX
   NfKaEIzsBYcve4g7ca1xO6OoYxMOCa9rXFeUKAzRsO9bxoS1t0+xykppw
   mgIv6w+v75pVfEYU2YnKZsLK1wyxih6OxUZUKh0d7T8bCH4FLyrrvKwaL
   BChQUFHcmCSSSkl8ftC9SoiD7+J9zaepArY6066C1hCagqSzjOFRMO3Ga
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="206432282"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:30:18 +0800
IronPort-SDR: tEZrKutYaTQcZEQUv3R9pJ0DW4L4Nrn3EbPdBq7GDhRXrbsyQNJ9Qn+zpHqOJL8Pn3ZiNUILT6
 spFdDCAZdb0DSRr12mlbuAuA70nuWxDRr5czoZaOrAye4e2k0Is/lXmU5SeI0R2TicvNTtORcC
 sBW8M7cpHFki2DSeRw+zf+gwjXUAMrRzCUm/48CVeYjNy5sMBTUh+g8WrT25m+6+ksrF02pMqT
 II73cM8i9W8GBVuG1V0cmUwKS2yMQIiTrB84OpWQ0zc/1xF3yFoYT7QIEfN20ZE8JAJmh5JL9W
 mGZSnZ9V92LisHz/beiF0x7v
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:37 -0700
IronPort-SDR: 5NdlEb9eF7YwieRvrvA29ZkC+d1dA6T6YW8Mg4qQCvffv+Kz1NvTKovaFfXlttZnHHCk/z9cby
 G7gjqSeYgNoEekEH327g8oseHB6PxqUK2bOJMcMnzCgGuzFKEe27qUG29UrmVv0b5o3w9IHl+6
 o83mtaoBUgUHnUICA678m58lbb1hK0FNcyKZmp44JEHbGRPSm7yH5P+O+1XjAaVaxK/KRbZQcr
 Sui1/gVPni4MOx2sskmnlfutsty2MgwwStc+m+hN8RgorNLy/dqbd6LulAvDVtzpYDTXaW9B2b
 90M=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:29:09 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 08/18] blktrace: add sysfs ioprio mask
Date:   Tue, 30 Apr 2019 21:28:21 -0700
Message-Id: <20190501042831.5313-9-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the priority mask and tracking support added, here we add
priority mask in the sysfs. These are just place holders for now but
they are required for complete the RFC.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 90 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1b113ba284fe..84163fa6a61f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1867,6 +1867,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 
 static BLK_TRACE_DEVICE_ATTR(enable);
 static BLK_TRACE_DEVICE_ATTR(act_mask);
+static BLK_TRACE_DEVICE_ATTR(prio_mask);
 static BLK_TRACE_DEVICE_ATTR(pid);
 static BLK_TRACE_DEVICE_ATTR(start_lba);
 static BLK_TRACE_DEVICE_ATTR(end_lba);
@@ -1874,6 +1875,7 @@ static BLK_TRACE_DEVICE_ATTR(end_lba);
 static struct attribute *blk_trace_attrs[] = {
 	&dev_attr_enable.attr,
 	&dev_attr_act_mask.attr,
+	&dev_attr_prio_mask.attr,
 	&dev_attr_pid.attr,
 	&dev_attr_start_lba.attr,
 	&dev_attr_end_lba.attr,
@@ -1911,6 +1913,16 @@ static const struct {
 #endif /* CONFIG_BLKTRACE_EXT */
 };
 
+static const struct {
+	int prio_mask;
+	const char *str;
+} prio_mask_maps[] = {
+	{ IOPRIO_CLASS_NONE,	"none" },
+	{ IOPRIO_CLASS_RT,	"read" },
+	{ IOPRIO_CLASS_BE,	"best" },
+	{ IOPRIO_CLASS_IDLE,	"idle" },
+};
+
 static int blk_trace_str2mask(const char *str)
 {
 	int i;
@@ -1962,6 +1974,62 @@ static ssize_t blk_trace_mask2str(char *buf, int mask)
 	return p - buf;
 }
 
+#ifdef CONFIG_BLKTRACE_EXT
+static int blk_trace_str2priomask(const char *str)
+{
+	int i;
+	int mask = 0;
+	char *buf, *s, *token;
+
+	/* XXX: revisit this placeholder for now */
+	buf = kstrdup(str, GFP_KERNEL);
+	if (buf == NULL)
+		return -ENOMEM;
+	s = strstrip(buf);
+
+	while (1) {
+		token = strsep(&s, ",");
+		if (token == NULL)
+			break;
+
+		if (*token == '\0')
+			continue;
+
+		for (i = 0; i < ARRAY_SIZE(prio_mask_maps); i++) {
+			if (strcasecmp(token, prio_mask_maps[i].str) == 0) {
+				mask |= (1 << prio_mask_maps[i].prio_mask);
+				break;
+			}
+		}
+		if (i == ARRAY_SIZE(prio_mask_maps)) {
+			mask = -EINVAL;
+			break;
+		}
+	}
+	kfree(buf);
+
+	return mask;
+}
+
+static ssize_t blk_trace_prio_mask2str(char *buf, int mask)
+{
+	int i;
+	char *p = buf;
+
+	for (i = 0; i < ARRAY_SIZE(prio_mask_maps); i++) {
+		/* XXX: revisit this placeholder for now */
+		if (mask & (0xF & (1 << prio_mask_maps[i].prio_mask))) {
+			p += sprintf(p, "%s%s",
+				    (p == buf) ? "" : ",",
+				    prio_mask_maps[i].str);
+		}
+	}
+	*p++ = '\n';
+
+	return p - buf;
+}
+#endif /* CONFIG_BLKTRACE_EXT */
+
 static struct request_queue *blk_trace_get_queue(struct block_device *bdev)
 {
 	if (bdev->bd_disk == NULL)
@@ -1998,6 +2066,10 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 		ret = sprintf(buf, "disabled\n");
 	else if (attr == &dev_attr_act_mask)
 		ret = blk_trace_mask2str(buf, q->blk_trace->act_mask);
+#ifdef CONFIG_BLKTRACE_EXT
+	else if (attr == &dev_attr_prio_mask)
+		ret = blk_trace_prio_mask2str(buf, q->blk_trace->prio_mask);
+#endif /* CONFIG_BLKTRACE_EXT */
 	else if (attr == &dev_attr_pid)
 		ret = sprintf(buf, "%u\n", q->blk_trace->pid);
 	else if (attr == &dev_attr_start_lba)
@@ -2034,7 +2106,19 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 				goto out;
 			value = ret;
 		}
-	} else if (kstrtoull(buf, 0, &value))
+	}
+#ifdef CONFIG_BLKTRACE_EXT
+	else if (attr == &dev_attr_prio_mask) {
+		if (kstrtoull(buf, 0, &value)) {
+			/* Assume it is a list of trace category names */
+			ret = blk_trace_str2priomask(buf);
+			if (ret < 0)
+				goto out;
+			value = ret;
+		}
+	}
+#endif /* CONFIG_BLKTRACE_EXT */
+	else if (kstrtoull(buf, 0, &value))
 		goto out;
 
 	ret = -ENXIO;
@@ -2069,6 +2153,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 	if (ret == 0) {
 		if (attr == &dev_attr_act_mask)
 			q->blk_trace->act_mask = value;
+#ifdef CONFIG_BLKTRACE_EXT
+		else if (attr == &dev_attr_prio_mask)
+			q->blk_trace->prio_mask = value;
+#endif /* CONFIG_BLKTRACE_EXT */
 		else if (attr == &dev_attr_pid)
 			q->blk_trace->pid = value;
 		else if (attr == &dev_attr_start_lba)
-- 
2.19.1

