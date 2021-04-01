Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF10CC433B4
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 23:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789CD6112F
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 23:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235847AbhDAX72 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:59:28 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:41597 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbhDAX71 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Apr 2021 19:59:27 -0400
Received: by mail-pl1-f176.google.com with SMTP id g10so1772906plt.8;
        Thu, 01 Apr 2021 16:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hSySr0eT/kw1bRqpKFISetUDVlAppa/KB0U1dEXQLUI=;
        b=W+MS5NSaKMM7/YCl558GOxMiVPVPaIPl+7GeEBpX6RQGAFwhPFt3LJ6aem8aOQxDIY
         2SvBzne1oNzw6dT6ZuPLDO470RdzdFkNCtzcYcefIfbcKEuAOD1LQBlSS9NOcDDCPCLu
         CVxwb7OGKHeUo5ookUCVCZN2o+5iQgy7uUkqt3G8RidaemHgc3WrG0Xho1nY29S4eFci
         ynjZxwIuvpOHk9/tB6YWBosn2O3xM47x/Z4QF8GvJyUgcBO3j4Hv4pSnSEZRw1diahUS
         ElF3bEAw7I5trFPQwizg5Ftj6C3PVT/caSlvI5sfxffV9HPOJcA61DUuvurgi/FsIy4a
         APOQ==
X-Gm-Message-State: AOAM531DLS/yTT/dRCm8U9J6xWEr6wHCXDnENSGLqTAgXo1B/+W1+AKt
        S/SKRnYCHX3Afc+/13optewSOsVIg1iL7A==
X-Google-Smtp-Source: ABdhPJw5NfzzgYHKjMBLVzYQOjndKlwSGWAPzQ0bILJ+6p2GkqP9R071dS9BbSKhqATdPSLkx4zRRQ==
X-Received: by 2002:a17:90b:3449:: with SMTP id lj9mr11550498pjb.55.1617321567215;
        Thu, 01 Apr 2021 16:59:27 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n25sm6177608pff.154.2021.04.01.16.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 16:59:26 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6C6CF40317; Thu,  1 Apr 2021 23:59:25 +0000 (UTC)
Date:   Thu, 1 Apr 2021 23:59:25 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        gregkh@linuxfoundation.org
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <20210401235925.GR4332@42.do-not-panic.com>
References: <20210306022035.11266-2-mcgrof@kernel.org>
 <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFkWMZ0m9nKCT69T@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 22, 2021 at 03:12:01PM -0700, Minchan Kim wrote:
> On Mon, Mar 22, 2021 at 08:41:56PM +0000, Luis Chamberlain wrote:
> > 
> > I would not call it *every* syfs knob as not all deal with things which
> > are related to CPU hotplug multistate, right? Note that using just
> > try_module_get() alone (that is the second patch only, does not fix the
> > race I am describing above).
> 
> It wouldn't be CPU hotplug multistate issue but I'd like to call it
> as more "zram instance race" bug.
> What happens in this case?
> 
>         CPU 1                            CPU 2
> 
> destroy_devices
> ..
>                                  compact_store()
>                                  zram = dev_to_zram(dev);
> idr_for_each(zram_remove_cb
>   zram_remove
>   ..
>   kfree(zram)
>                                  down_read(&zram->init_lock);
> 
> 
>         CPU 1                            CPU 2
> 
> hot_remove_store
>                                  compact_store()
>                                  zram = dev_to_zram(dev);
>   zram_remove
>     kfree(zram)
>                                  down_read(&zram->init_lock);
>     				
> So, for me we need to close the zram instance create/removal
> with sysfs rather than focusing on CPU hotplug issue.

Sure, that's a good point.

The issue which I noted for the race which ends up in a deadlock is only
possible if a shared lock is used on removal but also on sysfs knobs.

At first glance, the issue you describe above *seems* to be just proper
care driver developers must take with structures used. It is certainly
yet another issue we need to address, and if we can generalize a
solution even better. I now recall I *think* I spotted that race a while
ago and mentioned it to Kees and David Howells but I didn't have a
solution for it yet. More on this below.

The issue you point out is real, however you cannot disregard the
CPU hoplug possible race as well, it is a design consideration which
the CPU hotplug multistate support warns for -- consider driver removal.
I agree that perhaps solving this "zram instance race" can fix he
hotplug race as well. If we can solves all 3 issues in one shot even
better. But let's evaluate that prospect...

> Maybe, we could reuse zram_index_mutex with modifying it with
> rw_semaphore. What do you think?

Although ideal given it would knock 3 birds with 1 stone, it ends up
actually making the sysfs attributes rather useless in light of the
requirements for each of the races. Namely, the sysfs deadlock race
*must* use a try lock approach, just as the try_module_get() case.
It must use this approach so to immediately just bail out if we have
our module being removed, and so on our __exit path. By trying to
repurpose zram_index_mutex we end up then just doing too much with it
and making the syfs attributes rather fragile for most uses:

Consider disksize_show(), that would have to become:

static ssize_t disksize_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	struct zram *zram = dev_to_zram(dev);
+	size_t disksize;

+	down_read(&zram_index_rwlock);
+	disksize = zram->disksize;
+	up_read(&zram_index_rwlock);
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", disksize);
}

What's wrong with this?

It can block during a write, yes, but there is a type of write which
will make this crash after the read lock is acquired. When the instance
is removed. What if we try down_read_trylock()?

static ssize_t disksize_show(struct device *dev, struct device_attribute *attr, char *buf)
{
	struct zram *zram = dev_to_zram(dev);
+	size_t disksize;

+	if (!down_read_trylock(&zram_index_rwlock))
+		return -ENODEV;
+
+	disksize = zram->disksize;
+	up_read(&zram_index_rwlock);
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", zram->disksize);
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", disksize);
}

What's wrong with this?

If it got the lock, it should be OK as it is preventing writes from
taking the lock for a bit. But then this just becomes pretty fragile,
it will fail whenever another read or write is happening, triggering
perhaps quite a bit of regressions on tests.

And if we use write_trylock() we end up with the same fragile nature
of failing the read with ENODEV for any silly thing going on with the
driver.

And come to think of it the last patch I had sent with a new
DECLARE_RWSEM(zram_unload) also has this same issue making most
sysfs attributes rather fragile.

So, I still believe we should split this up into two separate patches then
as I had originally proposed. I looked into the race you described as well
and I believe I have a generic solution for that as well.

As for the syfs deadlock possible with drivers, this fixes it in a generic way:

commit fac43d8025727a74f80a183cc5eb74ed902a5d14
Author: Luis Chamberlain <mcgrof@kernel.org>
Date:   Sat Mar 27 14:58:15 2021 +0000

    sysfs: add optional module_owner to attribute
    
    This is needed as otherwise the owner of the attribute
    or group read/store might have a shared lock used on driver removal,
    and deadlock if we race with driver removal.
    
    Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b44cd8ee2eb7..494695ff227e 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1899,6 +1899,7 @@ static struct attribute *zram_disk_attrs[] = {
 
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
index 9153b20e5cc6..c3b650748029 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3820,7 +3820,7 @@ static int cgroup_add_file(struct cgroup_subsys_state *css, struct cgroup *cgrp,
 	key = &cft->lockdep_key;
 #endif
 	kn = __kernfs_create_file(cgrp->kn, cgroup_file_name(cgrp, cft, name),
-				  cgroup_file_mode(cft),
+				  cgroup_file_mode(cft), NULL,
 				  GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				  0, cft->kf_ops, cft,
 				  NULL, key);

As for the race you described, I think this might resolve it:

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f29839382f81..5e3f65ab8148 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -29,6 +29,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sysfs.h>
 #include <linux/dma-map-ops.h> /* for dma_default_coherent */
+#include <linux/blkdev.h>
 
 #include "base.h"
 #include "power/power.h"
@@ -1911,11 +1912,20 @@ static inline int device_is_not_partition(struct device *dev)
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
@@ -1960,6 +1970,19 @@ const char *dev_driver_string(const struct device *dev)
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
@@ -1969,12 +1992,20 @@ static ssize_t dev_attr_show(struct kobject *kobj, struct attribute *attr,
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
 
@@ -1985,8 +2016,14 @@ static ssize_t dev_attr_store(struct kobject *kobj, struct attribute *attr,
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
 
