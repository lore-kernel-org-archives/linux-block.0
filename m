Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D889DC3A5A1
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A34B023401
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 00:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GRvMu4vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfHWAPe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 20:15:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:30877 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbfHWAPd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 20:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566519333; x=1598055333;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xpjoteqg3rDc7BlHZJQG638MpFm6XqRL/OCljAsusB4=;
  b=GRvMu4vT2vhQwk2CbJIv/bNY8n/Ozezmrp41x9cR78I6UKgn+NEIsJtR
   JKEpjdfWKG7rYStQYPIg85DTdL2Jy2Id1Mcqib8JQesvfERQpcFErC+ax
   Se1lmxeQUBUUGHuf9sKw8MnnONtCGZS7gD7dB8ORCI0IP3BlvTbyrqoe+
   7bTj+puNTk8IM50C8TomRALQ0JcNN1vlCijZg63BUhHszX0p0U9/ymIvQ
   o3D6VOGITFGzqJMPEwRsZo+TUea2zUCOLZUodTaNonDfRltHgp8HiFnX8
   UnXCWzLuSxE9/y3PJn83nuSvQTVsdLpDpKNw7aVW2OaYFBkCYiRDGJuFI
   A==;
IronPort-SDR: KNMRoCz4kjZ87KiB9+O3s7/qP96y/ixTNKOz7k5PATFxTNFYc//qDSyKfb0waVUOwOD5NPdj0r
 xoS4A8LZU+cufo2wLlqC6Nk0hVG+yBtSzhGXOHrz28jvJCXJS+uEjHSNtPEwGCBjS6oVcB1jMs
 gnfn1ocA0TJ9Qv4Lgi8+XHOWKxKBz25WP2GBnkRnjZJlV1WxWWjpYpgaCulzSzbxljQUrstv0y
 ilYgaB0OIVc5YNhmKDyIHM8FSJd8TxjSDma+i9aLQXquz/Ku2K/CfZ90Gmei+5gCWF03gxyqMo
 Bt4=
X-IronPort-AV: E=Sophos;i="5.64,419,1559491200"; 
   d="scan'208";a="121063668"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 08:15:32 +0800
IronPort-SDR: GIn6QCuSSMUPbBZ8Dk7NHPVyzbK3zwNOeR0npD7KRecCRMWaCwJsHpQ60H8sfoeTjtIDJXIGrn
 g9+JSkU4Xpv0/KD2ATJ+0JEuX99xG0ykyNbsqaB4V2AOMe6D3Xkty38N8eZLB2K7lk5OJtGiLE
 gWLFX7zLp1YQYrBDmmZQnvczv17xOatvWhxFkck6apzCZ/UmccdC49/r9gESLqKlMw9qbp5C++
 7CfZjqCmJsVxXP0XkA6E8G2znENbAfP+EZc9q7C1GVMNA9v2TGLWtYKR+KPKsvo2T74iN7SLMz
 NBut19dcxreMqF+UfMlodPuP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 17:12:51 -0700
IronPort-SDR: tCR9RB17Vo/gKnSBUdkLW8vSeM5eVCeKWn/cPD/a8LoBQohTQf5PENs3clxJOUuE9F9c4EFku/
 s9jp2KtKfEWZQX2qljftwANldJCYtWUQUvZJo3UgZiwbF8OjZ4YId3KRm1LYnAP6sa0gjmVA3v
 oFsA66FZuCAaA7W3tb81b556uo64Wzq/UdnIy0T3O1o8eis4bepN27ErSIrxPS7xk06JSK3sC/
 yZYmZa4Fm21PStL+axY+lcj1dAkazBKMmT9PROjZ0CDLOpMu8NRTKuX1HIMnpB9QAdtIL2Alm2
 UCg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Aug 2019 17:15:32 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/7] block: Introduce elevator features
Date:   Fri, 23 Aug 2019 09:15:25 +0900
Message-Id: <20190823001528.5673-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190823001528.5673-1-damien.lemoal@wdc.com>
References: <20190823001528.5673-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce the elevator_features bitfield in the elevator_type structure
to allow an elevator to advertize special features that it supports.
Examples of such features are IO priorities, write hints, and zoned
block devices sequential write constraint support (aka zone write
locking).

The required_elevator_features field is added to the request_queue
structure to allow a device driver to specify features that an elevator
must support for the correct operation of the device. An example of a
typical required elevator feature is zone write locking for zoned block
devices. The helper function blk_queue_required_elevator_features() is
defined for setting this new new field.

With these two new information in place, the elevator functions
elevator_match() and elevator_find() are modified to allow a user to set
only an elevator with a set of features that satisfies the device
requirements. Elevators not matching the device requirements are not
listed in the device sysfs queue/scheduler file to prevent their use.

The "none" elevator can always be selected as before.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 block/blk-settings.c     | 15 ++++++++++++
 block/elevator.c         | 49 +++++++++++++++++++++++++++++++---------
 include/linux/blkdev.h   |  4 ++++
 include/linux/elevator.h |  1 +
 4 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2c1831207a8f..16471bf18810 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -832,6 +832,21 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
 }
 EXPORT_SYMBOL_GPL(blk_queue_write_cache);
 
+/**
+ * blk_queue_required_elevator_features - Set queue's elevator required features
+ * @q:		the request queue for the device
+ * @features:	Required elevator features OR'ed together
+ *
+ * Tell the block layer that the device controlled through @q that the
+ * queue elevator must support all the features specified by @features.
+ */
+void blk_queue_required_elevator_features(struct request_queue *q,
+					  unsigned long features)
+{
+	q->required_elevator_features = features;
+}
+EXPORT_SYMBOL_GPL(blk_queue_required_elevator_features);
+
 static int __init blk_settings_init(void)
 {
 	blk_max_low_pfn = max_low_pfn - 1;
diff --git a/block/elevator.c b/block/elevator.c
index 6208ddc334ef..de11beb32893 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -83,8 +83,26 @@ bool elv_bio_merge_ok(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(elv_bio_merge_ok);
 
-static bool elevator_match(const struct elevator_type *e, const char *name)
+static inline bool elv_support_features(unsigned long elv_features,
+					unsigned long required_features)
 {
+	return (required_features & elv_features) == required_features;
+}
+
+/**
+ * elevator_match - Test an elevator name and features
+ * @e: Scheduler to test
+ * @name: Elevator name to test
+ * @required_features: Features that the elevator must provide
+ *
+ * Return true is the elevator @e name matches @name and if @e provides all the
+ * the feratures spcified by @required_features.
+ */
+static bool elevator_match(const struct elevator_type *e, const char *name,
+			   unsigned long required_features)
+{
+	if (!elv_support_features(e->elevator_features, required_features))
+		return false;
 	if (!strcmp(e->elevator_name, name))
 		return true;
 	if (e->elevator_alias && !strcmp(e->elevator_alias, name))
@@ -93,15 +111,21 @@ static bool elevator_match(const struct elevator_type *e, const char *name)
 	return false;
 }
 
-/*
- * Return scheduler with name 'name'
+/**
+ * elevator_find - Find an elevator
+ * @name: Name of the elevator to find
+ * @required_features: Features that the elevator must provide
+ *
+ * Return the first registered scheduler with name @name and supporting the
+ * features @required_features and NULL otherwise.
  */
-static struct elevator_type *elevator_find(const char *name)
+static struct elevator_type *elevator_find(const char *name,
+					   unsigned long required_features)
 {
 	struct elevator_type *e;
 
 	list_for_each_entry(e, &elv_list, list) {
-		if (elevator_match(e, name))
+		if (elevator_match(e, name, required_features))
 			return e;
 	}
 
@@ -120,12 +144,12 @@ static struct elevator_type *elevator_get(struct request_queue *q,
 
 	spin_lock(&elv_list_lock);
 
-	e = elevator_find(name);
+	e = elevator_find(name, q->required_elevator_features);
 	if (!e && try_loading) {
 		spin_unlock(&elv_list_lock);
 		request_module("%s-iosched", name);
 		spin_lock(&elv_list_lock);
-		e = elevator_find(name);
+		e = elevator_find(name, q->required_elevator_features);
 	}
 
 	if (e && !try_module_get(e->elevator_owner))
@@ -526,7 +550,7 @@ int elv_register(struct elevator_type *e)
 
 	/* register, don't allow duplicate names */
 	spin_lock(&elv_list_lock);
-	if (elevator_find(e->elevator_name)) {
+	if (elevator_find(e->elevator_name, 0)) {
 		spin_unlock(&elv_list_lock);
 		kmem_cache_destroy(e->icq_cache);
 		return -EBUSY;
@@ -682,7 +706,8 @@ static int __elevator_change(struct request_queue *q, const char *name)
 	if (!e)
 		return -EINVAL;
 
-	if (q->elevator && elevator_match(q->elevator->type, elevator_name)) {
+	if (q->elevator &&
+	    elevator_match(q->elevator->type, elevator_name, 0)) {
 		elevator_put(e);
 		return 0;
 	}
@@ -722,11 +747,13 @@ ssize_t elv_iosched_show(struct request_queue *q, char *name)
 
 	spin_lock(&elv_list_lock);
 	list_for_each_entry(__e, &elv_list, list) {
-		if (elv && elevator_match(elv, __e->elevator_name)) {
+		if (elv && elevator_match(elv, __e->elevator_name, 0)) {
 			len += sprintf(name+len, "[%s] ", elv->elevator_name);
 			continue;
 		}
-		if (elv_support_iosched(q))
+		if (elv_support_iosched(q) &&
+		    elevator_match(__e, __e->elevator_name,
+				   q->required_elevator_features))
 			len += sprintf(name+len, "%s ", __e->elevator_name);
 	}
 	spin_unlock(&elv_list_lock);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4798bb25f1ee..1e173273511e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -492,6 +492,8 @@ struct request_queue {
 
 	struct queue_limits	limits;
 
+	unsigned long		required_elevator_features;
+
 #ifdef CONFIG_BLK_DEV_ZONED
 	/*
 	 * Zoned block device information for request dispatch control.
@@ -1084,6 +1086,8 @@ extern void blk_queue_dma_alignment(struct request_queue *, int);
 extern void blk_queue_update_dma_alignment(struct request_queue *, int);
 extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
 extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
+extern void blk_queue_required_elevator_features(struct request_queue *q,
+						 unsigned long features);
 
 /*
  * Number of physical segments as sent to the device.
diff --git a/include/linux/elevator.h b/include/linux/elevator.h
index 1dd014c9c87b..a99ca9979d71 100644
--- a/include/linux/elevator.h
+++ b/include/linux/elevator.h
@@ -76,6 +76,7 @@ struct elevator_type
 	struct elv_fs_entry *elevator_attrs;
 	const char *elevator_name;
 	const char *elevator_alias;
+	const unsigned long elevator_features;
 	struct module *elevator_owner;
 #ifdef CONFIG_BLK_DEBUG_FS
 	const struct blk_mq_debugfs_attr *queue_debugfs_attrs;
-- 
2.21.0

