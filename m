Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Mon, 4 Jun 2018 20:56:14 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	NeilBrown <neilb@suse.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
Message-ID: <20180605005614.GE30325@kmo-pixel>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
 <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
 <20180604182017.GA1351649@devbig577.frc2.facebook.com>
 <CA+55aFwOjtyPODy2U9vBQjxjXYq=veRzvMS2Uwdt8f1erRXe1A@mail.gmail.com>
 <f35436ab-bdac-5277-d0d2-b8432c620aff@kernel.dk>
 <20180604190428.GA30325@kmo-pixel>
 <CA+55aFyv5v7S_Qj0WwxE0foK69p+WVeDrq1ZKD9EJfP20sJboQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+55aFyv5v7S_Qj0WwxE0foK69p+WVeDrq1ZKD9EJfP20sJboQ@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 04, 2018 at 05:42:04PM -0700, Linus Torvalds wrote:
> On Mon, Jun 4, 2018 at 12:04 PM Kent Overstreet
> <kent.overstreet@gmail.com> wrote:
> >
> > However, that's not correct as is because mddev_delayed_put() calls
> > kobject_put(), and the kobject isn't initialized when the mddev is first
> > allocated, it's initialized when the gendisk is allocated... that isn't hard to
> > fix but that's getting into real refactoring that I'll need to put actual work
> > into testing.
> 
> Well, it also removes the bioset_exit() calls entirely.

Yeah, I realized that when I went back to finish that patch
> 
> How about just the attached?
> 
> It simply does it as two different cases, and adds the bioset_exit()
> calls to mddev_delayed_delete().

Oh right, just taking advantage of the fact that just the queue_work() needs to
be under the spinlock, not the actual free in the other case.

I like your patch for a less invasive version, but I did finish and test my
version, which deletes more code :)

I've already gone to the trouble of coming up with a VM smoketest, so I can test
yours too... I don't really have a strong opinion on which patch should go in.

 drivers/md/md.c | 53 ++++++++++++++++++-----------------------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc692b7128..22203eba1e 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -84,6 +84,8 @@ static void autostart_arrays(int part);
 static LIST_HEAD(pers_list);
 static DEFINE_SPINLOCK(pers_lock);
 
+static struct kobj_type md_ktype;
+
 struct md_cluster_operations *md_cluster_ops;
 EXPORT_SYMBOL(md_cluster_ops);
 struct module *md_cluster_mod;
@@ -510,11 +512,6 @@ static void mddev_delayed_delete(struct work_struct *ws);
 
 static void mddev_put(struct mddev *mddev)
 {
-	struct bio_set bs, sync_bs;
-
-	memset(&bs, 0, sizeof(bs));
-	memset(&sync_bs, 0, sizeof(sync_bs));
-
 	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
 	if (!mddev->raid_disks && list_empty(&mddev->disks) &&
@@ -522,30 +519,23 @@ static void mddev_put(struct mddev *mddev)
 		/* Array is not configured at all, and not held active,
 		 * so destroy it */
 		list_del_init(&mddev->all_mddevs);
-		bs = mddev->bio_set;
-		sync_bs = mddev->sync_set;
-		memset(&mddev->bio_set, 0, sizeof(mddev->bio_set));
-		memset(&mddev->sync_set, 0, sizeof(mddev->sync_set));
-		if (mddev->gendisk) {
-			/* We did a probe so need to clean up.  Call
-			 * queue_work inside the spinlock so that
-			 * flush_workqueue() after mddev_find will
-			 * succeed in waiting for the work to be done.
-			 */
-			INIT_WORK(&mddev->del_work, mddev_delayed_delete);
-			queue_work(md_misc_wq, &mddev->del_work);
-		} else
-			kfree(mddev);
+
+		/*
+		 * Call queue_work inside the spinlock so that
+		 * flush_workqueue() after mddev_find will succeed in waiting
+		 * for the work to be done.
+		 */
+		INIT_WORK(&mddev->del_work, mddev_delayed_delete);
+		queue_work(md_misc_wq, &mddev->del_work);
 	}
 	spin_unlock(&all_mddevs_lock);
-	bioset_exit(&bs);
-	bioset_exit(&sync_bs);
 }
 
 static void md_safemode_timeout(struct timer_list *t);
 
 void mddev_init(struct mddev *mddev)
 {
+	kobject_init(&mddev->kobj, &md_ktype);
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
 	mutex_init(&mddev->bitmap_info.mutex);
@@ -5215,6 +5205,8 @@ static void md_free(struct kobject *ko)
 		put_disk(mddev->gendisk);
 	percpu_ref_exit(&mddev->writes_pending);
 
+	bioset_exit(&mddev->bio_set);
+	bioset_exit(&mddev->sync_set);
 	kfree(mddev);
 }
 
@@ -5348,8 +5340,7 @@ static int md_alloc(dev_t dev, char *name)
 	mutex_lock(&mddev->open_mutex);
 	add_disk(disk);
 
-	error = kobject_init_and_add(&mddev->kobj, &md_ktype,
-				     &disk_to_dev(disk)->kobj, "%s", "md");
+	error = kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md");
 	if (error) {
 		/* This isn't possible, but as kobject_init_and_add is marked
 		 * __must_check, we must do something with the result
@@ -5506,7 +5497,7 @@ int md_run(struct mddev *mddev)
 	if (!bioset_initialized(&mddev->sync_set)) {
 		err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 		if (err)
-			goto abort;
+			return err;
 	}
 
 	spin_lock(&pers_lock);
@@ -5519,8 +5510,7 @@ int md_run(struct mddev *mddev)
 		else
 			pr_warn("md: personality for level %s is not loaded!\n",
 				mddev->clevel);
-		err = -EINVAL;
-		goto abort;
+		return -EINVAL;
 	}
 	spin_unlock(&pers_lock);
 	if (mddev->level != pers->level) {
@@ -5533,8 +5523,7 @@ int md_run(struct mddev *mddev)
 	    pers->start_reshape == NULL) {
 		/* This personality cannot handle reshaping... */
 		module_put(pers->owner);
-		err = -EINVAL;
-		goto abort;
+		return -EINVAL;
 	}
 
 	if (pers->sync_request) {
@@ -5603,7 +5592,7 @@ int md_run(struct mddev *mddev)
 		mddev->private = NULL;
 		module_put(pers->owner);
 		bitmap_destroy(mddev);
-		goto abort;
+		return err;
 	}
 	if (mddev->queue) {
 		bool nonrot = true;
@@ -5665,12 +5654,6 @@ int md_run(struct mddev *mddev)
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	sysfs_notify(&mddev->kobj, NULL, "degraded");
 	return 0;
-
-abort:
-	bioset_exit(&mddev->bio_set);
-	bioset_exit(&mddev->sync_set);
-
-	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
 
