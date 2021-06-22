Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242FFC48BDF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D09E61164
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFVVJY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:09:24 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:51718 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFVVJX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 17:09:23 -0400
Received: by mail-pj1-f51.google.com with SMTP id k5so188354pjj.1;
        Tue, 22 Jun 2021 14:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0iF3ntSSNNKhG4jtipS972P1ucIxrjARKk0osGLruI=;
        b=EaDeiUC5mgEi8hWju9Mb4sSegNly63zi54olifzISBdqWAJRHxtJ6uKiHBtqMlhs/R
         xRwPdC76Uh4VIH2ATfXC/y4R/0E01JRqSVF63KtEfeKP49XDj+jRmTZoVbQi+Xj2itwv
         gZ9Wxh5U2bn6h+8qnPHrLx40I9CwK2oOw31jdpX0GGqFRSQSOUwonq0j8SpzYvMllRQc
         G+7Agu1ZqcOA4eT6f4pwL0fEW5B9koREeLwlfXjI0YUSu8V3gHkojCsmjWKPflVhQWY/
         4JGHwgx4yQSw/GNZrViVWGC0f2mWXxEx23uBgC75kt2Cp7xmd1HqI2GER84BSLkZ66EU
         Czwg==
X-Gm-Message-State: AOAM531hks19oR6PIrg/t3DTkJzfVAciOSfLoPm93wVKKxNHztbo53CT
        bz872P3imyv4sZ+c7uveNiYskgek7Q8=
X-Google-Smtp-Source: ABdhPJy34SU4Bd5QukOxXys8evC97YP66yzcrRplCMR4oU3Y0PuVwjTpOQnDx1PSGXx2F1MYKcbiFw==
X-Received: by 2002:a17:90a:9f81:: with SMTP id o1mr5785112pjp.96.1624396026843;
        Tue, 22 Jun 2021 14:07:06 -0700 (PDT)
Received: from localhost ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id y1sm7938704pgr.70.2021.06.22.14.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:07:05 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, minchan@kernel.org,
        mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/base/core: refcount kobject and bus on device attribute read / store
Date:   Tue, 22 Jun 2021 14:06:59 -0700
Message-Id: <20210622210659.3708231-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
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
 drivers/base/bus.c  |  4 ++--
 drivers/base/core.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 43 insertions(+), 6 deletions(-)

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
index 4a8bf8cda52b..109bbc5b6976 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2039,31 +2039,68 @@ EXPORT_SYMBOL(dev_driver_string);
 
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
+struct bus_type *bus_get(struct bus_type *bus);
+void bus_put(struct bus_type *bus);
+
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
2.27.0

