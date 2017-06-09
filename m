Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:40478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbdFIIlm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2017 04:41:42 -0400
Subject: patch "pktcdvd: use class_groups instead of class_attrs" added to driver-core-testing
To: gregkh@linuxfoundation.org, Bart.VanAssche@sandisk.com,
        axboe@fb.com, hare@suse.com, jack@suse.cz,
        linux-block@vger.kernel.org, mchristi@redhat.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 09 Jun 2017 10:41:18 +0200
Message-ID: <149699767815633@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    pktcdvd: use class_groups instead of class_attrs

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


>From dc307f921f5c4c0cc64675203065c9b6a94f0bcb Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 8 Jun 2017 10:12:41 +0200
Subject: pktcdvd: use class_groups instead of class_attrs

The class_attrs pointer is long depreciated, and is about to be finally
removed, so move to use the class_groups pointer instead.

Cc: <linux-block@vger.kernel.org>
Acked-by: Jens Axboe <axboe@fb.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Bart Van Assche <Bart.VanAssche@sandisk.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/block/pktcdvd.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 205b865ebeb9..98939ee97476 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -348,9 +348,9 @@ static void class_pktcdvd_release(struct class *cls)
 {
 	kfree(cls);
 }
-static ssize_t class_pktcdvd_show_map(struct class *c,
-					struct class_attribute *attr,
-					char *data)
+
+static ssize_t device_map_show(struct class *c, struct class_attribute *attr,
+			       char *data)
 {
 	int n = 0;
 	int idx;
@@ -368,11 +368,10 @@ static ssize_t class_pktcdvd_show_map(struct class *c,
 	mutex_unlock(&ctl_mutex);
 	return n;
 }
+static CLASS_ATTR_RO(device_map);
 
-static ssize_t class_pktcdvd_store_add(struct class *c,
-					struct class_attribute *attr,
-					const char *buf,
-					size_t count)
+static ssize_t add_store(struct class *c, struct class_attribute *attr,
+			 const char *buf, size_t count)
 {
 	unsigned int major, minor;
 
@@ -390,11 +389,10 @@ static ssize_t class_pktcdvd_store_add(struct class *c,
 
 	return -EINVAL;
 }
+static CLASS_ATTR_WO(add);
 
-static ssize_t class_pktcdvd_store_remove(struct class *c,
-					  struct class_attribute *attr,
-					  const char *buf,
-					size_t count)
+static ssize_t remove_store(struct class *c, struct class_attribute *attr,
+			    const char *buf, size_t count)
 {
 	unsigned int major, minor;
 	if (sscanf(buf, "%u:%u", &major, &minor) == 2) {
@@ -403,14 +401,15 @@ static ssize_t class_pktcdvd_store_remove(struct class *c,
 	}
 	return -EINVAL;
 }
+static CLASS_ATTR_WO(remove);
 
-static struct class_attribute class_pktcdvd_attrs[] = {
- __ATTR(add,            0200, NULL, class_pktcdvd_store_add),
- __ATTR(remove,         0200, NULL, class_pktcdvd_store_remove),
- __ATTR(device_map,     0444, class_pktcdvd_show_map, NULL),
- __ATTR_NULL
+static struct attribute *class_pktcdvd_attrs[] = {
+	&class_attr_add.attr,
+	&class_attr_remove.attr,
+	&class_attr_device_map.attr,
+	NULL,
 };
-
+ATTRIBUTE_GROUPS(class_pktcdvd);
 
 static int pkt_sysfs_init(void)
 {
@@ -426,7 +425,7 @@ static int pkt_sysfs_init(void)
 	class_pktcdvd->name = DRIVER_NAME;
 	class_pktcdvd->owner = THIS_MODULE;
 	class_pktcdvd->class_release = class_pktcdvd_release;
-	class_pktcdvd->class_attrs = class_pktcdvd_attrs;
+	class_pktcdvd->class_groups = class_pktcdvd_groups;
 	ret = class_register(class_pktcdvd);
 	if (ret) {
 		kfree(class_pktcdvd);
-- 
2.13.1
