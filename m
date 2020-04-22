Return-Path: <SRS0=ObBg=6G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C59C5518B
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CE7206A2
	for <linux-block@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kNU+GWHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgDVHjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726460AbgDVHjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3252BC03C1A7;
        Wed, 22 Apr 2020 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tl24jbK01VcWDeSM5XZYo5Ozo10BjY5kMhXVrnAnvw0=; b=kNU+GWHquJienGdEaUtSMtLURh
        mNt0uGXnuXdhp5fs3iVAfuprAZIDAUSeEW1aybokcVQI6R0qcURGPtUCfY2pK9jTUTx5I1ldz4Ns3
        MJHKThYCGShZ1EKj6Guhr1DZqn6XmE8a9EQzZgn4qVZn89g2QPup28EDWEBNqle/19TtW+5Fe93XQ
        FLT8dnc2obbi7ageYAhlcwcBP8XMIAD/QtvayhV+Wg9DqokdQL1tcQT/lw0hLvwdEXeiSLuaaOziw
        ySUDXjbdbBTVTEayl5ITqjyqcQX0UpaI7zU/Sj7zKD2pT955WcxA+O6jbsuskl929qihwfmw2hNTQ
        1RnCuAqA==;
Received: from [2001:4bb8:191:e12c:c70:4a89:bc61:3] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jR9yL-0000B7-LW; Wed, 22 Apr 2020 07:39:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] driver core: remove device_create_vargs
Date:   Wed, 22 Apr 2020 09:38:47 +0200
Message-Id: <20200422073851.303714-6-hch@lst.de>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200422073851.303714-1-hch@lst.de>
References: <20200422073851.303714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All external users of device_create_vargs are gone, so remove it and
open code it in the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/core.c    | 37 ++-----------------------------------
 include/linux/device.h |  4 ----
 2 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 139cdf7e7327..fb8ae248e5aa 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3188,40 +3188,6 @@ device_create_groups_vargs(struct class *class, struct device *parent,
 	return ERR_PTR(retval);
 }
 
-/**
- * device_create_vargs - creates a device and registers it with sysfs
- * @class: pointer to the struct class that this device should be registered to
- * @parent: pointer to the parent struct device of this new device, if any
- * @devt: the dev_t for the char device to be added
- * @drvdata: the data to be added to the device for callbacks
- * @fmt: string for the device's name
- * @args: va_list for the device's name
- *
- * This function can be used by char device classes.  A struct device
- * will be created in sysfs, registered to the specified class.
- *
- * A "dev" file will be created, showing the dev_t for the device, if
- * the dev_t is not 0,0.
- * If a pointer to a parent struct device is passed in, the newly created
- * struct device will be a child of that device in sysfs.
- * The pointer to the struct device will be returned from the call.
- * Any further sysfs files that might be required can be created using this
- * pointer.
- *
- * Returns &struct device pointer on success, or ERR_PTR() on error.
- *
- * Note: the struct class passed to this function must have previously
- * been created with a call to class_create().
- */
-struct device *device_create_vargs(struct class *class, struct device *parent,
-				   dev_t devt, void *drvdata, const char *fmt,
-				   va_list args)
-{
-	return device_create_groups_vargs(class, parent, devt, drvdata, NULL,
-					  fmt, args);
-}
-EXPORT_SYMBOL_GPL(device_create_vargs);
-
 /**
  * device_create - creates a device and registers it with sysfs
  * @class: pointer to the struct class that this device should be registered to
@@ -3253,7 +3219,8 @@ struct device *device_create(struct class *class, struct device *parent,
 	struct device *dev;
 
 	va_start(vargs, fmt);
-	dev = device_create_vargs(class, parent, devt, drvdata, fmt, vargs);
+	dev = device_create_groups_vargs(class, parent, devt, drvdata, NULL,
+					  fmt, vargs);
 	va_end(vargs);
 	return dev;
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index ac8e37cd716a..15460a5ac024 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -884,10 +884,6 @@ extern bool device_is_bound(struct device *dev);
 /*
  * Easy functions for dynamically creating devices on the fly
  */
-extern __printf(5, 0)
-struct device *device_create_vargs(struct class *cls, struct device *parent,
-				   dev_t devt, void *drvdata,
-				   const char *fmt, va_list vargs);
 extern __printf(5, 6)
 struct device *device_create(struct class *cls, struct device *parent,
 			     dev_t devt, void *drvdata,
-- 
2.26.1

