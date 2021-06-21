Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27410C48BC2
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B178611BD
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 23:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbhFUXjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 19:39:12 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:39510 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhFUXjK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 19:39:10 -0400
Received: by mail-pf1-f169.google.com with SMTP id g192so7212844pfb.6;
        Mon, 21 Jun 2021 16:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6LKptqVooQ2yfJ0t1sAYDbvCb/8n4Fej4cQGySBTMc=;
        b=qz2gOk9fVr2cKbgWZOuhUADP7gPmViOhwm9rBNGAoNRQvhqLHt93Ik52uVlRFrWAII
         WhA08yxfrF1+oXGXaMxYF0vOzUpRzHDJAnOI8T3OA5oas4TdE+c77EiEoDyyulhYx8vw
         W60gyOdRw3k747HINIvTAb8y9Gv9+kn5a3/VaL6C4+cvvWUgZKtftNtzOzgjETysd7Bl
         tHkTvBoj1nk7rOOp+z9hmxtpA4iRXM9/ULrtpJV0E73AFBmZeHkfhXkPG9Gw49faOdau
         eacJU+II5ksvUmZrmIvCVH404z3uEfhwB+0xAQJ/o7/VpTS6uD1GH9rPQLoDHszTR0KZ
         0KMg==
X-Gm-Message-State: AOAM530tRWiiPUBwY+Lga8Dy41h/thh+anN0l1Pm3qrlRMbFSc3WaCxY
        0tG/XhjCk/uiDTJpWk5TFbmVmnlGXvY=
X-Google-Smtp-Source: ABdhPJwPIk5wp0sG9D+mVCMCRrCFN0XjFibocXhdhrqESbBVcH2RT5zKEiyLBJfAJkIdFdOVZ9Sm7Q==
X-Received: by 2002:a65:63ce:: with SMTP id n14mr872616pgv.273.1624318615122;
        Mon, 21 Jun 2021 16:36:55 -0700 (PDT)
Received: from localhost ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id a23sm15662370pff.43.2021.06.21.16.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 16:36:53 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, gregkh@linuxfoundation.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com
Cc:     mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] drivers/base/core: refcount kobject and bus on device attribute read / store
Date:   Mon, 21 Jun 2021 16:36:51 -0700
Message-Id: <20210621233651.597220-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621233013.562641-1-mcgrof@kernel.org>
References: <20210621233013.562641-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's possible today to have a device attribute read or store
race against device removal. When this happens there is a small
chance that the derefence for the private data area of the driver
is NULL.

Let's consider the zram driver as an example. Its possible to run into
a race where a sysfs knob is being used, we get preempted, and a zram
device is removed before we complete use of the sysfs knob. This can happen
for instance on block devices, where for instance the zram block devices
just part of the private data of the block device.

For instance this can happen in the following two situations
as examples to illustrate this better:

        CPU 1                            CPU 2
destroy_devices
...
                                 compact_store()
                                 zram = dev_to_zram(dev);
idr_for_each(zram_remove_cb
  zram_remove
  ...
  kfree(zram)
                                 down_read(&zram->init_lock);

        CPU 1                            CPU 2
hot_remove_store
                                 compact_store()
                                 zram = dev_to_zram(dev);
  zram_remove
    kfree(zram)
                                 down_read(&zram->init_lock);

To ensure the private data pointer is valid we could use bdget() / bdput()
in between access, however that would mean doing that in all sysfs
reads/stores on the driver. Instead a generic solution for all drivers
is to ensure the device kobject is still valid and also the bus, if
a bus is present.

This issue does not fix a known crash, however this race was
spotted by Minchan Kim through code inspection upon code review
of another zram patch.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/base.h |  2 ++
 drivers/base/bus.c  |  4 ++--
 drivers/base/core.c | 42 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index e5f9b7e656c3..3f95b125b667 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -127,6 +127,8 @@ static inline void auxiliary_bus_init(void) { }
 
 struct kobject *virtual_device_parent(struct device *dev);
 
+extern struct bus_type *bus_get(struct bus_type *bus);
+extern void bus_put(struct bus_type *bus);
 extern int bus_add_device(struct device *dev);
 extern void bus_probe_device(struct device *dev);
 extern void bus_remove_device(struct device *dev);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 36d0c654ea61..21c80d7d6433 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -39,7 +39,7 @@ static struct kset *system_kset;
 static int __must_check bus_rescan_devices_helper(struct device *dev,
 						void *data);
 
-static struct bus_type *bus_get(struct bus_type *bus)
+struct bus_type *bus_get(struct bus_type *bus)
 {
 	if (bus) {
 		kset_get(&bus->p->subsys);
@@ -48,7 +48,7 @@ static struct bus_type *bus_get(struct bus_type *bus)
 	return NULL;
 }
 
-static void bus_put(struct bus_type *bus)
+void bus_put(struct bus_type *bus)
 {
 	if (bus)
 		kset_put(&bus->p->subsys);
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4a8bf8cda52b..2fc52264b897 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2042,28 +2042,62 @@ EXPORT_SYMBOL(dev_driver_string);
 static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
 			     char *buf)
 {
-	struct device_attribute *dev_attr = to_dev_attr(attr);
-	struct device *dev = kobj_to_dev(kobj);
+	struct device_attribute *dev_attr;
+	struct device *dev;
+	struct bus_type *bus = NULL;
 	ssize_t ret = -EIO;
 
+	dev = get_device(kobj_to_dev(kobj));
+	if (!dev)
+		return ret;
+
+	if (dev->bus) {
+		bus = bus_get(dev->bus);
+		if (!bus)
+			goto out;
+	}
+
+	dev_attr = to_dev_attr(attr);
 	if (dev_attr->show)
 		ret = dev_attr->show(dev, dev_attr, buf);
 	if (ret >= (ssize_t)PAGE_SIZE) {
 		printk("dev_attr_show: %pS returned bad count\n",
 				dev_attr->show);
 	}
+
+	bus_put(bus);
+out:
+	put_device(dev);
+
 	return ret;
 }
 
 static ssize_t dev_attr_store(struct kobject *kobj, struct attribute *attr,
 			      const char *buf, size_t count)
 {
-	struct device_attribute *dev_attr = to_dev_attr(attr);
-	struct device *dev = kobj_to_dev(kobj);
+	struct device_attribute *dev_attr;
+	struct device *dev;
+	struct bus_type *bus = NULL;
 	ssize_t ret = -EIO;
 
+	dev = get_device(kobj_to_dev(kobj));
+	if (!dev)
+		return ret;
+
+	if (dev->bus) {
+		bus = bus_get(dev->bus);
+		if (!bus)
+			goto out;
+	}
+
+	dev_attr = to_dev_attr(attr);
 	if (dev_attr->store)
 		ret = dev_attr->store(dev, dev_attr, buf, count);
+
+	bus_put(bus);
+out:
+	put_device(dev);
+
 	return ret;
 }
 
-- 
2.30.2

