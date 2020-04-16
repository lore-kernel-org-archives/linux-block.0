Return-Path: <SRS0=Ef4g=6A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0F3C2BB55
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 16:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C1E82222D
	for <linux-block@archiver.kernel.org>; Thu, 16 Apr 2020 16:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MRkoU7Gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbgDPQzN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731482AbgDPQzK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Apr 2020 12:55:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78F7C061A0C;
        Thu, 16 Apr 2020 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Z86jDlmSIQ080oDrLxgt4NOhiT8JXAcf1xtFh5m1UWk=; b=MRkoU7GlCL+8+PTVbLhjecwrtp
        sB+NvAFqkqafl7JSWnTUCAtRyhFWo3/y7CieAUCPcojN5omn6zUdE0u8G+VzAk9o81XLlv0gbu7IK
        ItjsTrHH/9EFClxTVa5K01IJu0auXET82tXPklO52KAmO4R6ZHIZO5S5vXN4b65J+uWTcLoEeS+cn
        EbjywnGmO86i2SxUEMNsb1FeeRcSAGFx/yigptuWwKgvlPBx7rHRlMdHMqHD8CJlOMj5QO7S6KJVN
        PS8TFNAoJzLTbhK6JFquTwg/M3bcLdHAkGZ+3Yc5xcRurSXO8vbJtm9Hi+ZQq5r0RoKSjKELxCW67
        sP37G47Q==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP7n7-0002Xq-MG; Thu, 16 Apr 2020 16:55:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz,
        bvanassche@acm.org, tytso@mit.edu, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] driver core: remove device_create_vargs
Date:   Thu, 16 Apr 2020 18:54:49 +0200
Message-Id: <20200416165453.1080463-5-hch@lst.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200416165453.1080463-1-hch@lst.de>
References: <20200416165453.1080463-1-hch@lst.de>
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
2.25.1

