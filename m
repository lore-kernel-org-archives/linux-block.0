Return-Path: <kent.overstreet@gmail.com>
Return-Path: <kent.overstreet@gmail.com>
Date: Mon, 4 Jun 2018 15:04:28 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	linux-block <linux-block@vger.kernel.org>,
	NeilBrown <neilb@suse.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] Block changes for 4.18-rc
Message-ID: <20180604190428.GA30325@kmo-pixel>
References: <11b01169-8e11-34ed-8137-aa5cd50a39c2@kernel.dk>
 <CA+55aFy6_+90WKyDAbhh0NcN22N11AyaCaJu0nrafmf49+h6tQ@mail.gmail.com>
 <52aaf207-ef5d-a886-66fe-566de9d9bbee@kernel.dk>
 <CA+55aFz_iLabbCcCEWY8j5KcKCDsC7074f4EDi8mxB7-FrBHwA@mail.gmail.com>
 <20180604182017.GA1351649@devbig577.frc2.facebook.com>
 <CA+55aFwOjtyPODy2U9vBQjxjXYq=veRzvMS2Uwdt8f1erRXe1A@mail.gmail.com>
 <f35436ab-bdac-5277-d0d2-b8432c620aff@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f35436ab-bdac-5277-d0d2-b8432c620aff@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 04, 2018 at 12:25:54PM -0600, Jens Axboe wrote:
> On 6/4/18 12:22 PM, Linus Torvalds wrote:
> > On Mon, Jun 4, 2018 at 11:20 AM Tejun Heo <tj@kernel.org> wrote:
> >>
> >>
> >> Looking at the code, the fundamental problem seems to be that it's
> >> weaving different parts of sync and async paths.  I don't understand
> >> why it'd punt the destructin of mddev but destroy biosets
> >> synchronously.  Can't it do sth like the following?
> > 
> > Yeah, that looks like the right thing to do.
> > 
> > Jens/Kent?
> 
> I agree with Tejun, we already discussed this offline.

I don't see any good reason for the exit path to have two or three variations,
depending on how you count. My preference would be for a patch that does this:


diff --git a/drivers/md/md.c b/drivers/md/md.c
index fc692b7128..f18d783785 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -510,36 +510,24 @@ static void mddev_delayed_delete(struct work_struct *ws);
 
 static void mddev_put(struct mddev *mddev)
 {
-	struct bio_set bs, sync_bs;
-
-	memset(&bs, 0, sizeof(bs));
-	memset(&sync_bs, 0, sizeof(sync_bs));
-
 	if (!atomic_dec_and_lock(&mddev->active, &all_mddevs_lock))
 		return;
+
 	if (!mddev->raid_disks && list_empty(&mddev->disks) &&
 	    mddev->ctime == 0 && !mddev->hold_active) {
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
+		/* We did a probe so need to clean up.  Call
+		 * queue_work inside the spinlock so that
+		 * flush_workqueue() after mddev_find will
+		 * succeed in waiting for the work to be done.
+		 */
+		INIT_WORK(&mddev->del_work, mddev_delayed_delete);
+		queue_work(md_misc_wq, &mddev->del_work);
 	}
 	spin_unlock(&all_mddevs_lock);
-	bioset_exit(&bs);
-	bioset_exit(&sync_bs);
 }
 
 static void md_safemode_timeout(struct timer_list *t);

However, that's not correct as is because mddev_delayed_put() calls
kobject_put(), and the kobject isn't initialized when the mddev is first
allocated, it's initialized when the gendisk is allocated... that isn't hard to
fix but that's getting into real refactoring that I'll need to put actual work
into testing.

However, I have looked at where mddev_put() is called from and I think the stack
usage is fine for now - unless I've missed something it's not called from e.g.
under generic_make_request() anywhere, it's just called from sysfs code and
ioctls and things like that, where the stack is going to be pretty much empty.
