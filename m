Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5F0C04FF3
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97033613EC
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 21:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhEUVJo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 17:09:44 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:39466 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhEUVJo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 17:09:44 -0400
Received: by mail-pj1-f54.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so7990607pjp.4;
        Fri, 21 May 2021 14:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DiuiqhZx90sMRn03YO7FMtluH6Pc1l5WxGpg6FyEITc=;
        b=GeqTDoMPkIzMfGKYweVqOj9oe62HEzphKcq6zoQ5DDZ6Yaf4+wh7a5oQfAla8hO2L6
         +AsZYtoBxDffeIOa7mh4y2h1XNVNHHxJHaG4s2dYbpEHPpSfIWgehjD6dTCSmKvE2Tw9
         foPmhXmvFrbHC9NXU9ADeMjSsilf6Xw/4CcW6DaHZNBddnO0nIHc1e6wJOMWfYucnbhX
         n/GQ2maoziszOODN6VCZRCsI6xWU8UqvGk6FJ0ND1oUdTlHTyK96sab5pOrBIPYo4cxx
         EZRaTgGoTpYsb9IW6U+lSTIPuTFndTnfIMl8qODKewacwd5QKyLX9UGpJni9p0I90uyK
         M8mg==
X-Gm-Message-State: AOAM533nJlMJxaju2LradQoiJbw5CYgOuHsry8rIFpDABG5WB7hX5O6P
        KOlpzXs/DCtSByvBxX6jVMc=
X-Google-Smtp-Source: ABdhPJxMGAn/xHsICJ4helBfOYnEFy0M2UWafxuB552beK3SUBU7d3vCL2W+wbyQlJU9YxovOgbaOQ==
X-Received: by 2002:a17:90b:1244:: with SMTP id gx4mr13277182pjb.210.1621631299301;
        Fri, 21 May 2021 14:08:19 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id mt24sm4762565pjb.18.2021.05.21.14.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 14:08:17 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1CC95423A3; Fri, 21 May 2021 21:08:17 +0000 (UTC)
Date:   Fri, 21 May 2021 21:08:17 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Douglas Gilbert <dgilbert@interlog.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, axboe@kernel.dk,
        mbenes@suse.com, jpoimboe@redhat.com, tglx@linutronix.de,
        keescook@chromium.org, jikos@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] zram: fix few sysfs races
Message-ID: <20210521210817.GY4332@42.do-not-panic.com>
References: <20210423011108.11988-1-mcgrof@kernel.org>
 <YKVwZVcbZBNXUpKm@google.com>
 <20210519202023.GU4332@42.do-not-panic.com>
 <YKgRsCzwp2O2mYcp@kroah.com>
 <20210521201618.GX4332@42.do-not-panic.com>
 <YKgbzO0AkYN4J7Ye@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKgbzO0AkYN4J7Ye@kroah.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 21, 2021 at 10:45:00PM +0200, Greg Kroah-Hartman wrote:
> On Fri, May 21, 2021 at 08:16:18PM +0000, Luis Chamberlain wrote:
> > On Fri, May 21, 2021 at 10:01:52PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, May 19, 2021 at 08:20:23PM +0000, Luis Chamberlain wrote:
> > > > Greg,
> > > > 
> > > > your feedback would be appreciated here.
> > > 
> > > Appreciated where?  This is a zram patchset, what do I need to mess with
> > > it for?
> > 
> > This patchset has 2 issues which I noted in the last series that are
> > generic, and could best be dealt with on sysfs, and suggested
> > how this could actually be dealt with on sysfs / kernfs.
> > 
> > > > Greg, can you comment on technical levels why a general core fix is not
> > > > desirable upstream for those two issues?
> > > 
> > > What issues exactly?
> > 
> > When I suggested the generic way to fix this your main argument against
> > a generic solution was that we don't support module removal. Given that
> > argument did not seem to hold any water it begs the question if you
> > still would rather not see this fixed in sysfs / kernfs.
> > 
> > If you however are more open to it now, I can instead take that work, and
> > send a proper patch for review.
> 
> I looked at the last patch here and I really do not see the issue.
> 
> In order for the module to be removed, zram_exit() has to return, right?

Yes, but the race is for when a module removal is ongoing, in other
words, it has not yet completed, and at the same time we race touching
sysfs files.

> So how can a show/store function in zram_drv.c be called after
> destroy_devices() returns?

The issue can come up if we have something poke at the sysfs files *while* a
removal is happening.

> The changelog text in patch 4/4 is odd, destroy_devices() shouldn't be
> racing with anything as devices have reference counts in order to
> protect this type of thing from happening, right?

The race is beyond the scope of the driver in that the sysfs file can be
poked at while a removal is ongoing. After that consider the possible
races that can happen.

> How can a store
> function be called when a device is somehow removed from memory at the
> same time?  Don't we properly incremement/decrement the device
> structure's reference count?  If not, wouldn't that be the simplest
> solution here?

In this case the proper refcounting has to be down on the type of
device, and so bdgrab(dev_to_bdev(dev)), because otherwise the pointer
for the zram device is just not valid, so we can't do sanity checks
on the sysfs calls for the zram device as the pointer can be invalid.
To validate the pointer we must do refcounting below a layer. In this
case for a disk.

And so genericaly this would be:

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 4a8bf8cda52b..7c897e3f4135 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -29,6 +29,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sysfs.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
+#include <linux/blkdev.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -1988,11 +1989,20 @@ static inline int device_is_not_partition(struct device *dev)
 {
 	return !(dev->type == &part_type);
 }
+static inline bool device_is_disk(struct device *dev)
+{
+	return (dev->type == &disk_type);
+}
 #else
 static inline int device_is_not_partition(struct device *dev)
 {
 	return 1;
 }
+
+static inline bool device_is_disk(struct device *dev)
+{
+	return false;
+}
 #endif
 
 static int
@@ -2037,6 +2047,19 @@ const char *dev_driver_string(const struct device *dev)
 }
 EXPORT_SYMBOL(dev_driver_string);
 
+static int dev_type_get(struct device *dev)
+{
+	if (device_is_disk(dev))
+		return !!bdgrab(dev_to_bdev(dev));
+	return 1;
+}
+
+static void dev_type_put(struct device *dev)
+{
+	if (device_is_disk(dev))
+		bdput(dev_to_bdev(dev));
+}
+
 #define to_dev_attr(_attr) container_of(_attr, struct device_attribute, attr)
 
 static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
@@ -2046,12 +2069,20 @@ static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = kobj_to_dev(kobj);
 	ssize_t ret = -EIO;
 
+	if (!dev_type_get(dev))
+		return -ENODEV;
+
 	if (dev_attr->show)
 		ret = dev_attr->show(dev, dev_attr, buf);
 	if (ret >= (ssize_t)PAGE_SIZE) {
 		printk("dev_attr_show: %pS returned bad count\n",
 				dev_attr->show);
 	}
+
+	dev_type_put(dev);
+
+	put_device(dev);
+
 	return ret;
 }
 
@@ -2062,8 +2093,14 @@ static ssize_t dev_attr_store(struct kobject *kobj, struct attribute *attr,
 	struct device *dev = kobj_to_dev(kobj);
 	ssize_t ret = -EIO;
 
+	if (!dev_type_get(dev))
+		return -ENODEV;
+
 	if (dev_attr->store)
 		ret = dev_attr->store(dev, dev_attr, buf, count);
+
+	dev_type_put(dev);
+
 	return ret;
 }
 
> And who is ripping out zram drivers while the system is running anyway?

This race was spotted by Minchan as I explained the race in patch 3.
However he had a point and the above is a generic attempt to resolving
that issue. The patch 4 is a open coding it on the zram driver alone.

> What workflow causes this to happen so much so that the sysfs files need
> to be "protected"?  What tool/script/whatever is hammering on those
> sysfs files so much while someone wants to unload the module?

It is theoretical, however it is possible.

In the case of patch 3 though, the deadlock is possible and visible
while running an ltp script at the same time twice in a loop. I decided
to try to work on a generic solution as I was told a similar race was
known to have occurred when testing live patching code.

The generic approach to solving the race on patch 3 follows:

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf8deecc39ef..863d84353316 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1876,6 +1876,7 @@ static struct attribute *zram_disk_attrs[] = {
 
 static const struct attribute_group zram_disk_attr_group = {
 	.attrs = zram_disk_attrs,
+	.owner = THIS_MODULE,
 };
 
 static const struct attribute_group *zram_disk_attr_groups[] = {
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 7e0e62deab53..faedaaaed247 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/security.h>
 #include <linux/hash.h>
+#include <linux/module.h>
 
 #include "kernfs-internal.h"
 
@@ -415,9 +416,15 @@ struct kernfs_node *kernfs_get_active(struct kernfs_node *kn)
 	if (unlikely(!kn))
 		return NULL;
 
-	if (!atomic_inc_unless_negative(&kn->active))
+	if (unlikely(kn->owner && !try_module_get(kn->owner)))
 		return NULL;
 
+	if (!atomic_inc_unless_negative(&kn->active)) {
+		if (kn->owner)
+			module_put(kn->owner);
+		return NULL;
+	}
+
 	if (kernfs_lockdep(kn))
 		rwsem_acquire_read(&kn->dep_map, 0, 1, _RET_IP_);
 	return kn;
@@ -440,6 +447,8 @@ void kernfs_put_active(struct kernfs_node *kn)
 	if (kernfs_lockdep(kn))
 		rwsem_release(&kn->dep_map, _RET_IP_);
 	v = atomic_dec_return(&kn->active);
+	if (kn->owner)
+		module_put(kn->owner);
 	if (likely(v != KN_DEACTIVATED_BIAS))
 		return;
 
@@ -612,6 +621,7 @@ struct kernfs_node *kernfs_node_from_dentry(struct dentry *dentry)
 static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 					     struct kernfs_node *parent,
 					     const char *name, umode_t mode,
+					     struct module *owner,
 					     kuid_t uid, kgid_t gid,
 					     unsigned flags)
 {
@@ -647,6 +657,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
 	kn->name = name;
 	kn->mode = mode;
+	kn->owner = owner;
 	kn->flags = flags;
 
 	if (!uid_eq(uid, GLOBAL_ROOT_UID) || !gid_eq(gid, GLOBAL_ROOT_GID)) {
@@ -680,13 +691,14 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
+				    struct module *owner,
 				    kuid_t uid, kgid_t gid,
 				    unsigned flags)
 {
 	struct kernfs_node *kn;
 
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
-			       name, mode, uid, gid, flags);
+			       name, mode, owner, uid, gid, flags);
 	if (kn) {
 		kernfs_get(parent);
 		kn->parent = parent;
@@ -967,7 +979,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 		root->id_highbits = 1;
 
 	kn = __kernfs_new_node(root, NULL, "", S_IFDIR | S_IRUGO | S_IXUGO,
-			       GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+			       NULL, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 			       KERNFS_DIR);
 	if (!kn) {
 		idr_destroy(&root->ino_idr);
@@ -1006,6 +1018,7 @@ void kernfs_destroy_root(struct kernfs_root *root)
  * @parent: parent in which to create a new directory
  * @name: name of the new directory
  * @mode: mode of the new directory
+ * @owner: if set, the module owner of this directory
  * @uid: uid of the new directory
  * @gid: gid of the new directory
  * @priv: opaque data associated with the new directory
@@ -1015,6 +1028,7 @@ void kernfs_destroy_root(struct kernfs_root *root)
  */
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
+					 struct module *owner,
 					 kuid_t uid, kgid_t gid,
 					 void *priv, const void *ns)
 {
@@ -1023,7 +1037,7 @@ struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 
 	/* allocate */
 	kn = kernfs_new_node(parent, name, mode | S_IFDIR,
-			     uid, gid, KERNFS_DIR);
+			     owner, uid, gid, KERNFS_DIR);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
@@ -1055,7 +1069,7 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 
 	/* allocate */
 	kn = kernfs_new_node(parent, name, S_IRUGO|S_IXUGO|S_IFDIR,
-			     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR);
+			     NULL, GLOBAL_ROOT_UID, GLOBAL_ROOT_GID, KERNFS_DIR);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index c75719312147..69080869abfc 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -961,6 +961,7 @@ const struct file_operations kernfs_file_fops = {
  * @uid: uid of the file
  * @gid: gid of the file
  * @size: size of the file
+ * @owner: if set, the module owner of the file
  * @ops: kernfs operations for the file
  * @priv: private data for the file
  * @ns: optional namespace tag of the file
@@ -970,7 +971,9 @@ const struct file_operations kernfs_file_fops = {
  */
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 const char *name,
-					 umode_t mode, kuid_t uid, kgid_t gid,
+					 umode_t mode,
+					 struct module *owner,
+					 kuid_t uid, kgid_t gid,
 					 loff_t size,
 					 const struct kernfs_ops *ops,
 					 void *priv, const void *ns,
@@ -983,7 +986,7 @@ struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 	flags = KERNFS_FILE;
 
 	kn = kernfs_new_node(parent, name, (mode & S_IALLUGO) | S_IFREG,
-			     uid, gid, flags);
+			     owner, uid, gid, flags);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index ccc3b44f6306..5598c1127db7 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -112,6 +112,7 @@ void kernfs_put_active(struct kernfs_node *kn);
 int kernfs_add_one(struct kernfs_node *kn);
 struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 				    const char *name, umode_t mode,
+				    struct module *owner,
 				    kuid_t uid, kgid_t gid,
 				    unsigned flags);
 
diff --git a/fs/kernfs/symlink.c b/fs/kernfs/symlink.c
index 5432883d819f..8e130a411a9f 100644
--- a/fs/kernfs/symlink.c
+++ b/fs/kernfs/symlink.c
@@ -36,7 +36,8 @@ struct kernfs_node *kernfs_create_link(struct kernfs_node *parent,
 		gid = target->iattr->ia_gid;
 	}
 
-	kn = kernfs_new_node(parent, name, S_IFLNK|S_IRWXUGO, uid, gid,
+	kn = kernfs_new_node(parent, name, S_IFLNK|S_IRWXUGO,
+			     target->owner, uid, gid,
 			     KERNFS_LINK);
 	if (!kn)
 		return ERR_PTR(-ENOMEM);
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index 59dffd5ca517..5aff6ff07392 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -57,7 +57,8 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
 	kobject_get_ownership(kobj, &uid, &gid);
 
 	kn = kernfs_create_dir_ns(parent, kobject_name(kobj),
-				  S_IRWXU | S_IRUGO | S_IXUGO, uid, gid,
+				  S_IRWXU | S_IRUGO | S_IXUGO, NULL,
+				  uid, gid,
 				  kobj, ns);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 9aefa7779b29..acd0756199e1 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -314,8 +314,8 @@ int sysfs_add_file_mode_ns(struct kernfs_node *parent,
 		key = attr->key ?: (struct lock_class_key *)&attr->skey;
 #endif
 
-	kn = __kernfs_create_file(parent, attr->name, mode & 0777, uid, gid,
-				  size, ops, (void *)attr, ns, key);
+	kn = __kernfs_create_file(parent, attr->name, mode & 0777, attr->owner,
+				  uid, gid, size, ops, (void *)attr, ns, key);
 	if (IS_ERR(kn)) {
 		if (PTR_ERR(kn) == -EEXIST)
 			sysfs_warn_dup(parent, attr->name);
diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
index 64e6a6698935..010c2dade2d6 100644
--- a/fs/sysfs/group.c
+++ b/fs/sysfs/group.c
@@ -136,6 +136,7 @@ static int internal_create_group(struct kobject *kobj, int update,
 		} else {
 			kn = kernfs_create_dir_ns(kobj->sd, grp->name,
 						  S_IRWXU | S_IRUGO | S_IXUGO,
+						  grp->owner,
 						  uid, gid, kobj, NULL);
 			if (IS_ERR(kn)) {
 				if (PTR_ERR(kn) == -EEXIST)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 9e8ca8743c26..43abaed26735 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -155,6 +155,7 @@ struct kernfs_node {
 
 	unsigned short		flags;
 	umode_t			mode;
+	struct module           *owner;
 	struct kernfs_iattrs	*iattr;
 };
 
@@ -368,12 +369,14 @@ void kernfs_destroy_root(struct kernfs_root *root);
 
 struct kernfs_node *kernfs_create_dir_ns(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
+					 struct module *owner,
 					 kuid_t uid, kgid_t gid,
 					 void *priv, const void *ns);
 struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 					    const char *name);
 struct kernfs_node *__kernfs_create_file(struct kernfs_node *parent,
 					 const char *name, umode_t mode,
+					 struct module *owner,
 					 kuid_t uid, kgid_t gid,
 					 loff_t size,
 					 const struct kernfs_ops *ops,
@@ -465,13 +468,15 @@ static inline void kernfs_destroy_root(struct kernfs_root *root) { }
 
 static inline struct kernfs_node *
 kernfs_create_dir_ns(struct kernfs_node *parent, const char *name,
-		     umode_t mode, kuid_t uid, kgid_t gid,
+		     umode_t mode, struct module *owner,
+		     kuid_t uid, kgid_t gid,
 		     void *priv, const void *ns)
 { return ERR_PTR(-ENOSYS); }
 
 static inline struct kernfs_node *
 __kernfs_create_file(struct kernfs_node *parent, const char *name,
-		     umode_t mode, kuid_t uid, kgid_t gid,
+		     umode_t mode, struct module *owner,
+		     kuid_t uid, kgid_t gid,
 		     loff_t size, const struct kernfs_ops *ops,
 		     void *priv, const void *ns, struct lock_class_key *key)
 { return ERR_PTR(-ENOSYS); }
@@ -558,14 +563,15 @@ static inline struct kernfs_node *
 kernfs_create_dir(struct kernfs_node *parent, const char *name, umode_t mode,
 		  void *priv)
 {
-	return kernfs_create_dir_ns(parent, name, mode,
+	return kernfs_create_dir_ns(parent, name, mode, parent->owner,
 				    GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				    priv, NULL);
 }
 
 static inline struct kernfs_node *
 kernfs_create_file_ns(struct kernfs_node *parent, const char *name,
-		      umode_t mode, kuid_t uid, kgid_t gid,
+		      umode_t mode, struct module *owner,
+		      kuid_t uid, kgid_t gid,
 		      loff_t size, const struct kernfs_ops *ops,
 		      void *priv, const void *ns)
 {
@@ -574,15 +580,16 @@ kernfs_create_file_ns(struct kernfs_node *parent, const char *name,
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	key = (struct lock_class_key *)&ops->lockdep_key;
 #endif
-	return __kernfs_create_file(parent, name, mode, uid, gid,
+	return __kernfs_create_file(parent, name, mode, owner, uid, gid,
 				    size, ops, priv, ns, key);
 }
 
 static inline struct kernfs_node *
 kernfs_create_file(struct kernfs_node *parent, const char *name, umode_t mode,
+		   struct module *owner,
 		   loff_t size, const struct kernfs_ops *ops, void *priv)
 {
-	return kernfs_create_file_ns(parent, name, mode,
+	return kernfs_create_file_ns(parent, name, mode, owner,
 				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				     size, ops, priv, NULL);
 }
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index d76a1ddf83a3..6652504b860e 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -30,6 +30,7 @@ enum kobj_ns_type;
 struct attribute {
 	const char		*name;
 	umode_t			mode;
+	struct module           *owner;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	bool			ignore_lockdep:1;
 	struct lock_class_key	*key;
@@ -80,6 +81,7 @@ do {							\
  * @attrs:	Pointer to NULL terminated list of attributes.
  * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
  *		Either attrs or bin_attrs or both must be provided.
+ * @module:	If set, module responsible for this attribute group
  */
 struct attribute_group {
 	const char		*name;
@@ -89,6 +91,7 @@ struct attribute_group {
 						  struct bin_attribute *, int);
 	struct attribute	**attrs;
 	struct bin_attribute	**bin_attrs;
+	struct module           *owner;
 };
 
 /*
@@ -100,38 +103,52 @@ struct attribute_group {
 
 #define __ATTR(_name, _mode, _show, _store) {				\
 	.attr = {.name = __stringify(_name),				\
-		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+		 .mode = VERIFY_OCTAL_PERMISSIONS(_mode),               \
+	         .owner  = THIS_MODULE,                                 \
+         },                                                             \
 	.show	= _show,						\
 	.store	= _store,						\
 }
 
 #define __ATTR_PREALLOC(_name, _mode, _show, _store) {			\
 	.attr = {.name = __stringify(_name),				\
-		 .mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(_mode) },\
+		 .mode = SYSFS_PREALLOC | VERIFY_OCTAL_PERMISSIONS(_mode),\
+	         .owner  = THIS_MODULE,                                 \
+        },                                                              \
 	.show	= _show,						\
 	.store	= _store,						\
 }
 
 #define __ATTR_RO(_name) {						\
-	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
+	.attr	= { .name = __stringify(_name),                         \
+                    .mode = 0444,		                        \
+	            .owner  = THIS_MODULE,                              \
+                 },                                                     \
 	.show	= _name##_show,						\
 }
 
 #define __ATTR_RO_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
-		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode),            \
+	            .owner  = THIS_MODULE,                              \
+        },                                                              \
 	.show	= _name##_show,						\
 }
 
 #define __ATTR_RW_MODE(_name, _mode) {					\
 	.attr	= { .name = __stringify(_name),				\
-		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode) },		\
+		    .mode = VERIFY_OCTAL_PERMISSIONS(_mode),            \
+	            .owner  = THIS_MODULE,                              \
+        },                                                              \
 	.show	= _name##_show,						\
 	.store	= _name##_store,					\
 }
 
 #define __ATTR_WO(_name) {						\
-	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
+	.attr	= { .name = __stringify(_name),                         \
+                    .mode = 0200,                                       \
+	            .owner  = THIS_MODULE,                              \
+        },                                                              \
 	.store	= _name##_store,					\
 }
 
@@ -141,8 +158,11 @@ struct attribute_group {
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 #define __ATTR_IGNORE_LOCKDEP(_name, _mode, _show, _store) {	\
-	.attr = {.name = __stringify(_name), .mode = _mode,	\
-			.ignore_lockdep = true },		\
+	.attr = {.name = __stringify(_name),                    \
+                 .mode = _mode,                                 \
+                 .ignore_lockdep = true,                        \
+	         .owner  = THIS_MODULE,                         \
+        },		\
 	.show		= _show,				\
 	.store		= _store,				\
 }
@@ -159,6 +179,7 @@ static const struct attribute_group *_name##_groups[] = {	\
 #define ATTRIBUTE_GROUPS(_name)					\
 static const struct attribute_group _name##_group = {		\
 	.attrs = _name##_attrs,					\
+	.owner = THIS_MODULE,					\
 };								\
 __ATTRIBUTE_GROUPS(_name)
 
@@ -193,20 +214,29 @@ struct bin_attribute {
 
 /* macros to create static binary attributes easier */
 #define __BIN_ATTR(_name, _mode, _read, _write, _size) {		\
-	.attr = { .name = __stringify(_name), .mode = _mode },		\
+	.attr = { .name = __stringify(_name),                           \
+                   .mode = _mode,                                       \
+	           .owner = THIS_MODULE,                                \
+        },                                                              \
 	.read	= _read,						\
 	.write	= _write,						\
 	.size	= _size,						\
 }
 
 #define __BIN_ATTR_RO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0444 },		\
+	.attr	= { .name = __stringify(_name),                         \
+                    .mode = 0444,                                       \
+	            .owner = THIS_MODULE,                               \
+        },                                                              \
 	.read	= _name##_read,						\
 	.size	= _size,						\
 }
 
 #define __BIN_ATTR_WO(_name, _size) {					\
-	.attr	= { .name = __stringify(_name), .mode = 0200 },		\
+	.attr	= { .name = __stringify(_name),                         \
+                    .mode = 0200,                                       \
+	            .owner = THIS_MODULE,                               \
+        },                                                              \
 	.write	= _name##_write,					\
 	.size	= _size,						\
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index e049edd66776..7af508ae5348 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3833,7 +3833,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 	key = &cft->lockdep_key;
 #endif
 	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
-				  cgroup_file_mode(cft),
+				  cgroup_file_mode(cft), NULL,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				  0, cft->kf_ops, cft,
 				  NULL, key);
