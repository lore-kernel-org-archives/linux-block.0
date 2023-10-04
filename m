Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF33E7B5E2
	for <linux-block@archiver.kernel.org>; Wed,  4 Oct 2023 09:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjJDJvc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Oct 2023 05:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjJDJvY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Oct 2023 05:51:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE7DAC
        for <linux-block@vger.kernel.org>; Wed,  4 Oct 2023 02:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696413081; x=1727949081;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=01QXsAGUEjG6dEmqg2DEBK1KsrNMrZu9rgjT5hvcHqs=;
  b=BL2JCTAE+H2do/P1H0rzNym+H/lvKmZS+XcOsn9n7F6uFkKaQCoTouo3
   t/RE8Mmkz+U3AbRxMqfpAnXMzOvmlytozL/27M9af3Y2T1qsRJhaI3kmn
   OVh9RMtacsu54x8QYo2sgliX9tT5VHi/mOK0REtzpr9lGD8/MBMfOkJo0
   fxLx8aR91jk6TMRs4EHKvx/xbCz+0wv7OL4hoaKNsVnocMOAS98YqfmeC
   w8h2HZymGtTmQukEy9z54x/66W9v8SevVD7plhBu9lbqTbgeTaMupE7M+
   nu243PXSykPcXp56joiFHrW06doI5eMNeyYH67+TTjlQ3DScui1B5OMHb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385940962"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="385940962"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:51:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="925048467"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="925048467"
Received: from unknown (HELO fedora.bj.intel.com) ([10.238.154.52])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2023 02:50:17 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com, axboe@kernel.dk,
        linux-block@vger.kernel.org
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] block/rnbd: Add error handler of rnbd_clt_get_dev
Date:   Wed,  4 Oct 2023 05:50:23 -0400
Message-Id: <20231004095023.3740845-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

When dev->refcount is zero, it is not necessary to do others, exit
directly.

Acked-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/block/rnbd/rnbd-clt.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index b0550b68645d..84ddc79fad64 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -463,7 +463,12 @@ static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id,
 	msg.hdr.type	= cpu_to_le16(RNBD_MSG_CLOSE);
 	msg.device_id	= cpu_to_le32(device_id);
 
-	WARN_ON(!rnbd_clt_get_dev(dev));
+	if (WARN_ON(!rnbd_clt_get_dev(dev))) {
+		rnbd_put_iu(sess, iu);
+		err = -ENODEV;
+		goto exit;
+	}
+
 	err = send_usr_msg(sess->rtrs, WRITE, iu, &vec, 0, NULL, 0,
 			   msg_close_conf, &errno, wait);
 	if (err) {
@@ -472,7 +477,7 @@ static int send_msg_close(struct rnbd_clt_dev *dev, u32 device_id,
 	} else {
 		err = errno;
 	}
-
+exit:
 	rnbd_put_iu(sess, iu);
 	return err;
 }
@@ -558,7 +563,13 @@ static int send_msg_open(struct rnbd_clt_dev *dev, enum wait_type wait)
 	msg.access_mode	= dev->access_mode;
 	strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
 
-	WARN_ON(!rnbd_clt_get_dev(dev));
+	if (WARN_ON(!rnbd_clt_get_dev(dev))) {
+		rnbd_put_iu(sess, iu);
+		kfree(rsp);
+		err = -ENODEV;
+		goto exit;
+	}
+
 	err = send_usr_msg(sess->rtrs, READ, iu,
 			   &vec, sizeof(*rsp), iu->sgt.sgl, 1,
 			   msg_open_conf, &errno, wait);
@@ -569,7 +580,7 @@ static int send_msg_open(struct rnbd_clt_dev *dev, enum wait_type wait)
 	} else {
 		err = errno;
 	}
-
+exit:
 	rnbd_put_iu(sess, iu);
 	return err;
 }
@@ -1597,7 +1608,12 @@ struct rnbd_clt_dev *rnbd_clt_map_device(const char *sessname,
 	msg.access_mode = dev->access_mode;
 	strscpy(msg.dev_name, dev->pathname, sizeof(msg.dev_name));
 
-	WARN_ON(!rnbd_clt_get_dev(dev));
+	if (WARN_ON(!rnbd_clt_get_dev(dev))) {
+		rnbd_put_iu(sess, iu);
+		ret = -ENODEV;
+		goto put_iu;
+	}
+
 	ret = send_usr_msg(sess->rtrs, READ, iu,
 			   &vec, sizeof(*rsp), iu->sgt.sgl, 1,
 			   msg_open_conf, &errno, RTRS_PERMIT_WAIT);
-- 
2.40.1

